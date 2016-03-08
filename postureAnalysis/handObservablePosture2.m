function [ posture ] = handObservablePosture2(hand, q)
% Analyse a given hand at a given configuration
%   # Define palmar planes and calculate angles between them
%   # Obtain fingers' separation and flexion angles
%   # Obtain thumb's opposition, palmar and radial abduction, and flexion
%
% Muhammad Sayed
% muhammad.b.h.sayed@gmail.com
% Jan 24th, 2016

% Palm joints
if isfield(hand.palm, 'links') % Check if there are movable parts in the palm
    [~, m] = size(hand.palm.links); % get number of joints/links in the palm
    % Create m 4x4 identity matrices to store transforms
    baseTransform = zeros(4,4,m);
    for j = 1:m % loop through links, THIS DOES NOT SUPPORT CHAINS
        baseTransform(:,:,j) = eye(4) * hand.palm.joints(:,:,j) * trotx(deg2rad(q{1}(j,1))) * troty(deg2rad(q{1}(j,2))) * trotz(deg2rad(q{1}(j,3)));
    end
end

[~, n] = size(hand.digits); % get number of digits, should be 4 or 5

% Define "metacarpal vectors"
for j = 1:n
    %metacarpalPose{j} = hand.digits(j).base;
    if (isfield(hand.digits(j), 'base') && (hand.digits(j).base ~= 0)) % Check if the digit's base is movable
        base = hand.digits(j).base;
        MCP_Pose{j} = baseTransform(:,:,base);
    else
        MCP_Pose{j} = eye(4);
    end
    % Apply transform of MCP
    if isfield(hand.palm, 'joints') % Check if there are movable parts in the palm
        k = j + 1; % Because first element in configuration "q" corresponds to palm joints
    else
        k = j;
    end
    MCP_Pose{j} = MCP_Pose{j} * hand.digits(j).joints(:,:,1) * trotx(deg2rad(q{k}(1,1))) * troty(deg2rad(q{k}(1,2))) * trotz(deg2rad(q{k}(1,3)));
    % Isolate the position part of the transform
    [~,metacarpalVector{j}] = tr2rt(MCP_Pose{j});
end

% Define normals to "palmar planes"
if hand.isRight == 1 % Check if this is a right hand, used to define the direction of normal along the +ve z-axis
    for j = 1:n-1 % one plane between each two bones
        t1 = metacarpalVector{j}/norm(metacarpalVector{j}); % convert to unit vectors
        t2 = metacarpalVector{j+1}/norm(metacarpalVector{j+1});
        palmarPlane{j} = cross(t1,t2);
        palmarPlane{j} = palmarPlane{j}/norm(palmarPlane{j}); % convert to unit vectors
    end
else %if rightHand == 0
    for j = 1:n-1 % one plane between each two bones
        t1 = metacarpalVector{j}/norm(metacarpalVector{j}); % convert to unit vectors
        t2 = metacarpalVector{j+1}/norm(metacarpalVector{j+1});
        palmarPlane{j} = cross(t2,t1);
        palmarPlane{j} = palmarPlane{j}/norm(palmarPlane{j}); % convert to unit vectors
    end
end

thumbPosture = zeros(1,5); % Variable to store thumb's opposition, palmar and radial abduction, and proximal and distal flexion

% Solve for dihydral angles between plamar planes, useful for thumb opposition and palm arching, first value for thumb, second and third for Ring and Small
%  using formula :: angle = atan2(norm(cross(a,b)), dot(a,b))
% Source :: http://www.mathworks.com/matlabcentral/answers/16243-angle-between-two-vectors-in-3d
% Alternative :: acos(dot(a,b)/(norm(a)*norm(b)))
palmarAngles = zeros(1,n-2);
for j = 1:n-2 % one angle between each two planes
    palmarAngles(j) = atan2(norm(cross(palmarPlane{j},palmarPlane{j+1})), dot(palmarPlane{j},palmarPlane{j+1}));
    % To detect angle sign, claculate the angle between the cross product
    % of the normals to the two planes and the metacarpal vector between
    % them, if they're in the same direction; angle is +ve for the thumb
    % (opposition) and -ve otherwise (palm "opening out")
    if hand.isRight == 1
        aux = cross(palmarPlane{j},palmarPlane{j+1});
    else
        aux = cross(palmarPlane{j+1},palmarPlane{j});
    end
    aux2 = atan2(norm(cross(aux,metacarpalVector{j+1})), dot(aux,metacarpalVector{j+1}));
    if aux2 > deg2rad(90) % A tolerant threshold, it should be close to 0 or 180
        if j == 1 % If opposite to each other, thumb is -ve (retroposition)
            palmarAngles(j) = -palmarAngles(j);
        end
    else    % If in the same direction, lower palmar planes are negative
        if j > 1
            palmarAngles(j) = -palmarAngles(j);
        end
    end
end

% Thumb opposition is represented by palmarAngles(1)
thumbPosture(1) = palmarAngles(1);

% Define "proximal vectors" of all digits
for j = 1:n
    % Get the pose of the PIP joint
    PIP_Pose{j} = MCP_Pose{j};
    % Solve forward kinematics of all leading joints to account for rotations
    for i = 2:hand.joints(j,2) % MCP is 1, PIP could be 2 or 3
        if isfield(hand.palm, 'joints') % Check if there are movable parts in the palm
            k = j + 1; % Because first element in configuration "q" corresponds to palm joints
        else
            k = j;
        end
        PIP_Pose{j} = PIP_Pose{j} * hand.digits(j).joints(:,:,i) * trotx(deg2rad(q{k}(i,1))) * troty(deg2rad(q{k}(i,2))) * trotz(deg2rad(q{k}(i,3)));
    end
    % Then extract vector from origin to end of proximal phalanx
    [~,tempTotalVector{j}] = tr2rt(PIP_Pose{j});
    % Finally subtract metacarpalVector from tempTotalVector to obtain proximalVector
    proximalVector{j} = tempTotalVector{j} - metacarpalVector{j};
end

% Solve for orthogonal projections of proximal vectors on local palmar planes
% The projection of a point q = (x, y, z) onto a plane given by a point p = (a, b, c) and a normal n = (d, e, f) is
%  q_proj = q - dot(q - p, n) * n
%  This calculation assumes that n is a unit vector.
% Source :: http://stackoverflow.com/questions/8942950/how-do-i-find-the-orthogonal-projection-of-a-point-onto-a-plane
proximalProjection{1} = proximalVector{1} - dot(proximalVector{1} - metacarpalVector{1}, palmarPlane{1}) * palmarPlane{1};
proximalProjection{2} = proximalVector{2} - dot(proximalVector{2} - metacarpalVector{2}, palmarPlane{2}) * palmarPlane{2};
proximalProjection{3} = proximalVector{3} - dot(proximalVector{3} - metacarpalVector{3}, palmarPlane{2}) * palmarPlane{2};
proximalProjection{4} = proximalVector{4} - dot(proximalVector{4} - metacarpalVector{4}, palmarPlane{3}) * palmarPlane{3};
if n == 5
    proximalProjection{5} = proximalVector{5} - dot(proximalVector{5} - metacarpalVector{5}, palmarPlane{4}) * palmarPlane{4};
end
for j = 1:n
    proximalProjection{j} = proximalProjection{j}/norm(proximalProjection{j}); % convert to unit vectors
end

% Solve for proximal joint flexion angles, using formula :: angle = atan2(norm(cross(a,b)), dot(a,b))
% Source :: http://www.mathworks.com/matlabcentral/answers/16243-angle-between-two-vectors-in-3d
% TODO :: NEED TO ACCOUNT FOR THUMB RETROPOSITIONING AND FINGERS HYPEREXTENSION
proximalFlexion = zeros(1,4);
for j = 2:n
    proximalFlexion(j-1) = atan2(norm(cross(proximalProjection{j},proximalVector{j})), dot(proximalProjection{j},proximalVector{j}));
end

% Thumb palmar abduction; angle between the thumb's proximal vector and its projection on the hand's main refernce palmar plane
ThProjection = proximalVector{1} - dot(proximalVector{1} - metacarpalVector{2}, palmarPlane{2}) * palmarPlane{2};
thumbPosture(2) = atan2(norm(cross(ThProjection,proximalVector{1})), dot(ThProjection,proximalVector{1}));
% Thumb radial abduction; angle between the projections of the thumb's proximal vector and the thumb-index web on the main refernce palmar plane
ThInWeb = metacarpalVector{2} - metacarpalVector{1};
ThInWebProjection = ThInWeb - dot(ThInWeb - metacarpalVector{2}, palmarPlane{2}) * palmarPlane{2};
thumbPosture(3) = atan2(norm(cross(ThProjection,ThInWebProjection)), dot(ThProjection,ThInWebProjection));
% Thumb MCP flexion
thumbPosture(4) = atan2(norm(cross(proximalProjection{1},proximalVector{1})), dot(proximalProjection{1},proximalVector{1}));

% Solve for separtion between fingers using same formula, note that first value is for the separation between index and middle, and so on
% TODO :: NEED TO ACCOUNT FOR CROSSOVER ( -VE SEPARATION )
fingerSeparation = zeros(1,3); % Number of finger "pairs" is number of planes - 1, but fingerSepration does not include thumb
for j = 2:n-1 % Number of planes is n-1
    if hand.isRight == 1
        aux = cross(proximalProjection{j},proximalProjection{j+1});
    else
        aux = cross(proximalProjection{j+1},proximalProjection{j});
    end
    fingerSeparation(j-1) = atan2(norm(aux), dot(proximalProjection{j},proximalProjection{j+1}));
    % To detect angle sign, claculate the angle between the cross product of two proximal projections and the normal to the palmar palne, these should be in the same direction, otherwise fingers are crossing 
    if j == 2 % Note that the palmar palne for the thumb and index is j, while it's j-1 for middle and lower fingers
        aux2 = atan2(norm(cross(aux,palmarPlane{j})), dot(aux,palmarPlane{j}));
    else
        aux2 = atan2(norm(cross(aux,palmarPlane{j-1})), dot(aux,palmarPlane{j-1}));
    end
    if aux2 > deg2rad(90) % A tolerant threshold, it should be close to 0 or 180
        fingerSeparation(j-1) = -fingerSeparation(j-1);
    end
end

% Define "middle victors" of fingers
for j = 2:n
    % Get the pose of the DIP joint
    DIP_Pose{j} = PIP_Pose{j};
    if hand.joints(j,3) ~= 0 % Check there is a DIP joint in this finger
        % Solve forward kinematics of all leading joints to account for rotations
        for i = hand.joints(j,2)+1:hand.joints(j,3)
            if isfield(hand.palm, 'joints') % Check if there are movable parts in the palm
                k = j + 1; % Because first element in configuration "q" corresponds to palm joints
            else
                k = j;
            end
            DIP_Pose{j} = DIP_Pose{j} * hand.digits(j).joints(:,:,i) * trotx(deg2rad(q{k}(i,1))) * troty(deg2rad(q{k}(i,2))) * trotz(deg2rad(q{k}(i,3)));
        end
    else % If there is not DIP, get the distance to tip
        DIP_Pose{j} = DIP_Pose{j} * hand.digits(j).tip;
    end
    % Then extract vector from origin to end of middle phalanx
    [~,tempTotalVector2{j}] = tr2rt(DIP_Pose{j});
    % Finally subtract earlier tempTotalVector from new tempTotalVector2 to obtain middleVector
    middleVector{j} = tempTotalVector2{j} - tempTotalVector{j};
end
% Solve for fingers PIP flexion angles
%  using formula :: angle = atan2(norm(cross(a,b)), dot(a,b))
% Source :: http://www.mathworks.com/matlabcentral/answers/16243-angle-between-two-vectors-in-3d
middleFlexion = zeros(1,4);
for j = 2:n
    middleFlexion(j-1) = atan2(norm(cross(proximalVector{j},middleVector{j})), dot(proximalVector{j},middleVector{j}));
end

% Define thumb "distal vector"
% First get the pose of the tip
tip_Pose{1} = PIP_Pose{1} * hand.digits(1).tip;
% Then extract vector from origin to end of distal phalanx
[~,tempTotalVector2{1}] = tr2rt(tip_Pose{1});
% Finally subtract earlier tempTotalVector2 from new tempTotalVector3 to obtain distalVector
distalVector{1} = tempTotalVector2{1} - tempTotalVector{1};
% Thumb IP flexion is the angle between its proximal and distal vectors
thumbPosture(5) = atan2(norm(cross(proximalVector{1},distalVector{1})), dot(proximalVector{1},distalVector{1}));

% Define "distal vectors" of fingers
for j = 2:n
    if hand.joints(j,3) ~= 0 % Check there is a DIP joint in this finger
        % First get the pose of the tip
        tip_Pose{j} = DIP_Pose{j} * hand.digits(j).tip;
        % Then extract vector from origin to end of distal phalanx
        [~,tempTotalVector3{j}] = tr2rt(tip_Pose{j});
        % Finally subtract earlier tempTotalVector2 from new tempTotalVector3 to obtain distalVector
        distalVector{j} = tempTotalVector3{j} - tempTotalVector2{j};
    end
end
% Solve for distal joint flexion angles of all digits, using formula :: angle = atan2(norm(cross(a,b)), dot(a,b))
% Source :: http://www.mathworks.com/matlabcentral/answers/16243-angle-between-two-vectors-in-3d
distalFlexion = zeros(1,4);
for j = 2:n
    if hand.joints(j,3) ~= 0 % Check there is a DIP joint in this finger
        distalFlexion(j-1) = atan2(norm(cross(middleVector{j},distalVector{j})), dot(middleVector{j},distalVector{j}));
    end
end

fingerPosture = zeros(4,3);
for i = 1:4
    fingerPosture(i,:) = [ proximalFlexion(i) middleFlexion(i) distalFlexion(i) ];
end

%posture = { palmarAngles, fingerSeparation, proximalFlexion, middleFlexion, distalFlexion };
posture = [ fingerSeparation fingerPosture(1,:) fingerPosture(2,:) fingerPosture(3,:) fingerPosture(4,:) thumbPosture ];
posture = rad2deg(posture);

