function plotContactCone( R, N, height, contactNormal, contactPoint, t, c )
%UNTITLED17 Summary of this function goes here
%   Plot N sides cone at point "origin"

% Assuming a cone is a set of mesh triangles with a common vertix
% Generate coordinates of a unit cone with N sides and radius R at origin
[X, Y, ~] = cylinder([0 R], N);
% X Y and Z are 2x(N+1) vectors specifying the coordinates of the first and
% last points of each triangle's sides
% All first rows are zeros, all elements of second row of Z are 1s
% First and last points in X and Y have same coordinates

% Generate mesh
% Total number of vertices in the cone is N + 1
% All faces have a common origin vertix [ 0 0 0 ]
% Generate vertices
cone.vertices = zeros(N+1, 3); 
cone.vertices(1,:) = [ 0 0 0 ];
for i = 2:N+1
    cone.vertices(i,:) = [ X(2,i) Y(2,i) height ];
end
% Generate faces
cone.faces = zeros(N, 3); 
for i = 1:N-1
    cone.faces(i,:) = [ 1 i+1 i+2 ];
end
cone.faces(N,:) = [ 1 N+1 2 ];

% Scale mesh
%cone.vertices = cone.vertices * scale;

% Transfer ( and orient ) cone mesh to contact point
% Get angle-axis rotation between the two normals
angleOfRotation = acos(dot([0 0 1],contactNormal)/(norm([0 0 1])*norm(contactNormal)));
axisOfRotation = cross([0 0 1],contactNormal);
% Get rotation matrix for the angle-axis rotation
rotation = angleAxis2rotationMatrix(angleOfRotation, axisOfRotation);
% Calculate full transform
T = [ rotation contactPoint' ; [0 0 0 1] ];
% Apply transform to vertices
cone.vertices = (h2e( T * e2h(cone.vertices.') ))';

% Plot cone
trisurf(cone.faces, cone.vertices(:,1),cone.vertices(:,2),cone.vertices(:,3),'FaceAlpha', t, 'FaceColor', c);

end

