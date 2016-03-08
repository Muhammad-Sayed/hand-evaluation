function [ posture ] = handObservablePosture3(hand)
% Analyse a given hand posture at its current configuration
%   # Define palmar planes and calculate angles between them
%   # Obtain fingers' separation and flexion angles
%   # Obtain thumb's opposition, palmar and radial abduction, and flexion
%
% Muhammad Sayed
% muhammad.b.h.sayed@gmail.com

[~, n] = size(hand.digits); % get number of digits, should be 4 or 5

% Define "metacarpal vectors": the position of the MCP joint
for i = 1:n
    % Isolate the position part of the transform
    [~,metacarpalVector{i}] = tr2rt(hand.Td{i}(:,:,hand.joints(i,1)));
end

% Define normals to "palmar planes" along the palm +ve z-axis
for j = 1:n-1 % one plane between each two bones
    a = metacarpalVector{j}/norm(metacarpalVector{j}); % convert to unit vectors
    b = metacarpalVector{j+1}/norm(metacarpalVector{j+1});
    if hand.isRight == 1
        palmarPlane{j} = cross(a,b);
    else
        palmarPlane{j} = cross(b,a);
    end
    palmarPlane{j} = palmarPlane{j}/norm(palmarPlane{j}); % convert to unit vectors
end

thumbPosture = zeros(1,5); % Variable to store thumb's opposition, palmar and radial abduction, and proximal and distal flexion

% Solve for dihydral angles between plamar planes (thumb opposition and
% palm arching) using formula: angle = acos(dot(a,b)/(norm(a)*norm(b)))
% First variable for thumb, second and third for Ring and Small fingers
palmarAngles = zeros(1,n-2);
for j = 1:n-2 % one angle between each two planes
    a = palmarPlane{j};
    b = palmarPlane{j+1};
    palmarAngles(j) = acos(dot(a,b)/(norm(a)*norm(b)));
    % To detect angle sign, claculate the angle between the cross product
    % of two normals and the metacarpal vector between them. If they're in
    % the same direction: angle is +ve for the thumb (opposition) and -ve
    % for the lower fingers (palm "opening out")
    if hand.isRight == 1
        a = cross(palmarPlane{j},palmarPlane{j+1});
    else
        a = cross(palmarPlane{j+1},palmarPlane{j});
    end
    b = metacarpalVector{j+1};
    aux = acos(dot(a,b)/(norm(a)*norm(b)));
    if aux > deg2rad(90) % % If opposite to each other
        if j == 1 % thumb palmar palne angle is negative (retroposition)
            palmarAngles(j) = -palmarAngles(j);
        end
    else % If in the same direction
        if j > 1 % lower palmar planes angles are negative
            palmarAngles(j) = -palmarAngles(j);
        end
    end
end

% Thumb opposition is represented by palmarAngles(1)
thumbPosture(1) = palmarAngles(1);

% Define "proximal vectors" of all digits
for i = 1:n
    % Get pose of PIP joint (vector from origin to end of proximal phalanx)
    [~,PIP_Vector{i}] = tr2rt(hand.Td{i}(:,:,hand.joints(i,2)));
    % Subtract metacarpalVector from PIP_Vector to obtain proximalVector
    proximalVector{i} = PIP_Vector{i} - metacarpalVector{i};
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
% Convert to unit vectors
for j = 1:n
    proximalProjection{j} = proximalProjection{j}/norm(proximalProjection{j}); 
end

% Solve for proximal joint flexion angles of the FINGERS
% TODO :: NEED TO ACCOUNT FOR THUMB RETROPOSITIONING AND FINGERS HYPEREXTENSION
proximalFlexion = zeros(1,4);
for j = 2:n
    a = proximalProjection{j};
    b = proximalVector{j};
    proximalFlexion(j-1) = acos(dot(a,b)/(norm(a)*norm(b)));
end

% Thumb palmar abduction: angle between the thumb's proximal vector and its projection on the hand's main refernce palmar plane
ThProjection = proximalVector{1} - dot(proximalVector{1} - metacarpalVector{2}, palmarPlane{2}) * palmarPlane{2};
a = ThProjection;
b = proximalVector{1};
thumbPosture(2) = acos(dot(a,b)/(norm(a)*norm(b)));
% Thumb radial abduction: angle between the projections of the thumb's proximal vector and the thumb-index web on the main refernce palmar plane
ThInWeb = metacarpalVector{2} - metacarpalVector{1};
b = ThInWeb - dot(ThInWeb - metacarpalVector{2}, palmarPlane{2}) * palmarPlane{2}; % ThIn web projection
thumbPosture(3) = acos(dot(a,b)/(norm(a)*norm(b)));
% Thumb MCP flexion: angle between the thumb's proximal vector and its projection on the thumb palmar plane
a = proximalProjection{1};
b = proximalVector{1};
thumbPosture(4) = acos(dot(a,b)/(norm(a)*norm(b)));

% Solve for angle of separtion between fingers, that first value is for the separation between index and middle, and so on
fingerSeparation = zeros(1,n-2); % Number of digit "pairs" is number of planes - 1, but fingerSepration does not include thumb
for j = 2:n-1 % Number of planes is n-1
    a = proximalProjection{j};
    b = proximalProjection{j+1};
    fingerSeparation(j-1) = acos(dot(a,b)/(norm(a)*norm(b)));
    % To detect angle sign, i.e to differentiate between seperation and
    % crossover, claculate the angle between the cross product of two
    % proximal projections and the normal to the palmar palne. They should
    % be in the same direction, otherwise fingers are crossing
    if hand.isRight == 1
        a = cross(proximalProjection{j}, proximalProjection{j+1});
    else
        a = cross(proximalProjection{j+1}, proximalProjection{j});
    end
    b = palmarPlane{j};
    aux = acos(dot(a,b)/(norm(a)*norm(b)));
    if aux > deg2rad(90) % if opposite direction, angle is negative
        fingerSeparation(j-1) = -fingerSeparation(j-1);
    end
end

% Define "middle vectors" of fingers and thumb distalVector
for i = 1:n
    if hand.joints(i,3) ~= 0 % Check if there is a DIP joint in this finger
        % Get the position of the DIP joint
        [~,DIP_Vector{i}] = tr2rt(hand.Td{i}(:,:,hand.joints(i,3)));
    else % If there is no DIP, get the position of the tip
        [~,DIP_Vector{i}] = tr2rt(hand.Td{i}(:,:,hand.joints(i,2)) * hand.digits(i).tip);
        distalVector{i} = DIP_Vector{i} - PIP_Vector{i};
    end
    % Subtract earlier PIP_Vector from new DIP_Vector
    middleVector{i} = DIP_Vector{i} - PIP_Vector{i};
end

% Solve for fingers PIP flexion angles
middleFlexion = zeros(1,4);
for j = 2:n
    a = proximalVector{j};
    b = middleVector{j};
    middleFlexion(j-1) = acos(dot(a,b)/(norm(a)*norm(b)));
end

% Thumb IP flexion is the angle between its proximal and distal vectors
a = proximalVector{1};
b = distalVector{1};
thumbPosture(5) = acos(dot(a,b)/(norm(a)*norm(b)));

% Define "distal vectors" of fingers
for j = 2:n
    if hand.joints(j,3) ~= 0 % Check there is a DIP joint in this finger
        % First get the position of the tip
        [~,tip_Vector{j}] = tr2rt(hand.Td{j}(:,:,hand.joints(j,3)) * hand.digits(j).tip);
        % Then subtract earlier DIP_Vector from new tip_Vector
        distalVector{j} = tip_Vector{j} - DIP_Vector{j};
    end
end

% Solve for distal joint flexion angles of all digits
distalFlexion = zeros(1,4);
for j = 2:n
    if hand.joints(j,3) ~= 0 % Check there is a DIP joint in this finger
        a = middleVector{j};
        b = distalVector{j};
        distalFlexion(j-1) = acos(dot(a,b)/(norm(a)*norm(b)));
    end
end

fingerPosture = zeros(4,3);
for i = 1:4
    fingerPosture(i,:) = [ proximalFlexion(i) middleFlexion(i) distalFlexion(i) ];
end

posture = [ fingerSeparation fingerPosture(1,:) fingerPosture(2,:) fingerPosture(3,:) fingerPosture(4,:) thumbPosture ];
posture = rad2deg(posture);