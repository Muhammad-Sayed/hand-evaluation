function posture = handObservablePosture(hand, q)
% Analyse a given hand at a given configuration
%   # Define palmar planes and calculate angles between them
%   # Obtain "observable" fingers' separation flexion angles
%   # Obtain thumb's posture;
%       Opposition, palmar and radial abduction
%
% Muhammad Sayed
% muhammad.b.h.sayed@gmail.com
% July 10, 2015

[~, n] = size(hand.digits); % get number of digits, should be 4 or 5
% Define "metacarpal vectors"
for j = 1:n
    metacarpalPose{j} = hand.digits(j).base;
    for i = 1:hand.joints(j,1)-1
        metacarpalPose{j} = metacarpalPose{j} * hand.digits(j).links(i).A(q{j}(i)); % DONE - TODO :: NEED TO ADD ACTUAL ANGLE VARIABLE
    end
    [~,metacarpalVector{j}] = tr2rt(metacarpalPose{j});
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
% Solve for angles between plamar planes, useful for thumb opposition and
% palm arching, first value for thumb, second and third for Ring and Small
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
% Define "proximal vectors" of all digits
for j = 1:n
    proximalPose{j} = hand.digits(j).base;
    % First solve forward kinematics of all leading links to account for rotations
    for i = 1:hand.joints(j,2)-1
        proximalPose{j} = proximalPose{j} * hand.digits(j).links(i).A(q{j}(i)); % DONE - TODO :: NEED TO ADD ACTUAL ANGLE VARIABLE
    end
    % Then extract vector from origin to end of proximal phalanx
    [~,tempTotalVector{j}] = tr2rt(proximalPose{j});
    % Finally subtract metacarpalVector from tempTotalVector to obtain proximalVector
    proximalVector{j} = tempTotalVector{j} - metacarpalVector{j};
end
% Solve for orthogonal projections of proximal vectors on palmar planes
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
% Solve for figers proximal joint flexion angles
%  using formula :: angle = atan2(norm(cross(a,b)), dot(a,b))
% Source :: http://www.mathworks.com/matlabcentral/answers/16243-angle-between-two-vectors-in-3d
% TODO :: NEED TO ACCOUNT FOR THUMB RETROPOSITIONING AND FINGERS HYPEREXTENSION
proximalFlexion = zeros(1,n-1);
for j = 2:n
    proximalFlexion(j-1) = atan2(norm(cross(proximalProjection{j},proximalVector{j})), dot(proximalProjection{j},proximalVector{j}));
end

thumbPosture = zeros(1,4); % Value to store thumb's axial rotation, palmar and radial abduction, and distal flexion
% Solve for thumb palmar and radial abduciton
thumbPosture(2) = atan2(norm(cross(proximalProjection{1},proximalVector{1})), dot(proximalProjection{1},proximalVector{1}));

% Solve for separtion between fingers
%  using same formula
%  note that first value is for the separation between index and middle, and so on
% TODO :: NEED TO ACCOUNT FOR CROSSOVER ( -VE SEPARATION )
fingerSeparation = zeros(1,n-2); % Number of finger "pairs" is number of planes - 1 (fingerSepration does not include thumb)
for j = 2:n-1 % Number of planes is n-1
    if hand.isRight == 1
        aux = cross(proximalProjection{j},proximalProjection{j+1});
    else
        aux = cross(proximalProjection{j+1},proximalProjection{j});
    end
    fingerSeparation(j-1) = atan2(norm(aux), dot(proximalProjection{j},proximalProjection{j+1}));
    % To detect angle sign, claculate the angle between the cross product
    % of two proximal projections and the normal to the palmar palne, these
    % should be in the same direction, otherwise fingers are overcrossed 
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
    middlePose{j} = hand.digits(j).base;
    % First solve forward kinematics of all leading links to account for rotations
    for i = 1:hand.joints(j,3)-1
        middlePose{j} = middlePose{j} * hand.digits(j).links(i).A(q{j}(i)); % DONE - TODO :: NEED TO ADD ACTUAL ANGLE VARIABLE
    end
    % Then extract vector from origin to end of middle phalanx
    [~,tempTotalVector2{j}] = tr2rt(middlePose{j});
    % Finally subtract earlier tempTotalVector from new tempTotalVector2 to obtain middleVector
    middleVector{j} = tempTotalVector2{j} - tempTotalVector{j};
end
% Solve for figers PIP flexion angles
%  using formula :: angle = atan2(norm(cross(a,b)), dot(a,b))
% Source :: http://www.mathworks.com/matlabcentral/answers/16243-angle-between-two-vectors-in-3d
middleFlexion = zeros(1,n-1);
for j = 2:n
    middleFlexion(j-1) = atan2(norm(cross(proximalVector{j},middleVector{j})), dot(proximalVector{j},middleVector{j}));
end
% Define "distal victors" of all digits
for j = 1:n
    % First solve forward kinematics of the serialLink to account for rotations
    distalPose{j} = hand.digits(j).fkine(q{j}); % DONE - TODO :: NEED TO ADD ACTUAL ANGLE VARIABLE
    % Then extract vector from origin to end of distal phalanx
    [~,tempTotalVector3{j}] = tr2rt(distalPose{j});
    % Don't forget to populate tempTotalVector2 for the thumb
    tempTotalVector2{1} = tempTotalVector{1};
    % Finally subtract earlier tempTotalVector2 from new tempTotalVector3 to obtain distalVector
    distalVector{j} = tempTotalVector3{j} - tempTotalVector2{j};
end
% Solve for distal joint flexion angles of all digits
%  using formula :: angle = atan2(norm(cross(a,b)), dot(a,b))
% Source :: http://www.mathworks.com/matlabcentral/answers/16243-angle-between-two-vectors-in-3d
distalFlexion = zeros(1,n-1);
distalFlexion(1) = atan2(norm(cross(proximalVector{1},distalVector{1})), dot(proximalVector{1},distalVector{1}));
for j = 2:n
    distalFlexion(j-1) = atan2(norm(cross(middleVector{j},distalVector{j})), dot(middleVector{j},distalVector{j}));
end

posture = { palmarAngles, fingerSeparation, proximalFlexion, middleFlexion, distalFlexion };