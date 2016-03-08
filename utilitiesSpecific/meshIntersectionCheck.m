function [ intersecting ] = meshIntersectionCheck( mesh1, mesh2 )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

intersecting = false;

% Check if there is an intersection between the boundary boxes
box = intersectionBox(mesh1, mesh2);
% If true, check if the meshes intersect
if box.flag ~= 0
    [intersect] = SurfaceIntersection(mesh1, mesh2);
    if nnz(intersect) ~= 0 % If any intersection detected, set "intersecting" to true
        intersecting = true;
    end
end

end

