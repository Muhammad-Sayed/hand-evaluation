function [ inCollision ] = handObjectCollision( hand, object )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Define a default true value for any premature termination
inCollision = true;

% Check if the object has a collisionMesh, otherwise the object itself is the collision mesh
if isfield(object, 'collisionMesh')
    objectMesh = object.collisionMesh;
else
    objectMesh = object;
end

% Palm
% Check if there is an intersection between the boundary boxs
box = intersectionBox(hand.palm.root.collisionMesh, objectMesh);
% If true, check if the meshes intersect
if box.flag ~= 0
    [intersect] = SurfaceIntersection(hand.palm.root.collisionMesh, objectMesh);
    if nnz(intersect) ~= 0 % If any intersection (collision) detected, terminate the function
        %fprintf('Palm in collision with object\n');
        return
    end
end

% Palm links
if isfield(hand.palm, 'links') % Check if there are movable parts in the palm
    [~, m] = size(hand.palm.links); % get number of joints/links in the palm
    for j = 1:m % loop through links, THIS DOES NOT SUPPORT CHAINS
        % Check if there is an intersection between the boundary boxs
        box = intersectionBox(hand.palm.links(j).collisionMesh, objectMesh);
        % If true, check if the meshes intersect
        if box.flag ~= 0
            [intersect] = SurfaceIntersection(hand.palm.links(j).collisionMesh, objectMesh);
            if nnz(intersect) ~= 0 % If any intersection (collision) detected, terminate the function
                %fprintf('Palm segment %d in collision with object\n', j);
                return
            end
        end
    end
end

% Digits
[~, n] = size(hand.digits); % get number of digits, should be 4 or 5
for i = 1:n % loop through digits
    [~, m] = size(hand.digits(i).links); % get number of links in the digit
    for j = 1:m % loop through links
        box = intersectionBox(hand.digits(i).links(j).collisionMesh, objectMesh);
        if box.flag ~= 0
            % Check intersection for each link link mesh
            [intersect] = SurfaceIntersection(hand.digits(i).links(j).collisionMesh, objectMesh);
            if nnz(intersect) ~= 0 % If any intersection (collision) detected, terminate the function
                %fprintf('Digit %d Segment %d in collision with object\n', i, j);
                return
            end
        end
    end
end

% If no collision detected, return false
inCollision = false;

end