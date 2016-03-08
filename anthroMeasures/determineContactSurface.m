function [ type ] = determineContactSurface( mesh, intersection )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

% Get the indices of faces in intersection
[faces,~] = find(intersection);
% Remove duplicated faces
faces = unique(faces);

% Get number of faces
[m,~] = size(faces);
sum = zeros(1,3);
% Add up the normals to each face
for i = 1:m
    sum = sum + mesh.normals(faces(i),:);
end
% Divide sum by number of faces
resultant = sum / m;
% Normalise the resultant
resultant = resultant/norm(resultant);

% Solve for orthogonal projections of the resultant on the transvere plane, defined by point (0,0,0) and normal (1,0,0)
% The projection of a point q = (x, y, z) onto a plane given by a point p = (a, b, c) and a normal n = (d, e, f) is
%  q_proj = q - dot(q - p, n) * n
% This calculation assumes that n is a unit vector
% Source :: http://stackoverflow.com/questions/8942950/how-do-i-find-the-orthogonal-projection-of-a-point-onto-a-plane
projection = resultant - dot(resultant, [1 0 0]) * [1 0 0];

% Solve for the angle between the Z-axis and the projection
angle = acos(dot(projection,[0 0 1])/(norm(projection)*norm([0 0 1])));

% If the angle is less than approximately 45 dgrees, the contact is on the
% palmar side (1) of the segment, if it is between 45 and 135, it is on a
% lateral side (2), if it is more than 135, it is on the dorsal side (3)
if rad2deg(angle) < 45
    type = 1;
elseif (rad2deg(angle) > 45) && (rad2deg(angle) < 135)
    type = 2;
else
    type = 3;
end

end

