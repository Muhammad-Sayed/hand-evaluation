function [ contactNormal, contactPoint ] = getContactNormal( intersection, mesh1, mesh2 )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here

% Get the indices of faces in intersection
[mesh1faces,mesh2faces] = find(intersection);
% Remove duplicated faces
mesh1faces = unique(mesh1faces);
mesh2faces = unique(mesh2faces);

% Get number of faces in mesh 1
[m,~] = size(mesh1faces);
sum = zeros(1,3);
% Add up the normals to each face
for i = 1:m
    sum = sum + mesh1.normals(mesh1faces(i),:);
end
% Divide sum by number of faces
resultant1 = sum / m;
% Normalise resultant
resultant1 = resultant1/norm(resultant1);

% Repeat for second mesh
% Get number of faces in mesh 2
[m,~] = size(mesh2faces);
sum = zeros(1,3);
% Add up the normals to each face
for i = 1:m
    sum = sum + mesh2.normals(mesh2faces(i),:);
end
% Divide sum by number of faces
resultant2 = sum / m;
% Normalise resultant
resultant2 = resultant2/norm(resultant2);

% Assuming mesh1 is the hand segment and mesh2 is the object, we calculate 
% the contactNormal to be in the same direction as the normal to the
% hand segment, i.e in the opposite direction to the normal to the object

% Get the resultant between -resultant1 and resultant2
sum = resultant1 - resultant2;
contactNormal = sum/2;
% Normalise the contactNormal
contactNormal = contactNormal/norm(contactNormal);

% Calculate contact point
% Calculate mesh1 faces' centroids
X1 = mean([mesh1.vertices(mesh1.faces(mesh1faces,1),1) mesh1.vertices(mesh1.faces(mesh1faces,2),1) mesh1.vertices(mesh1.faces(mesh1faces,3),1)].')';
Y1 = mean([mesh1.vertices(mesh1.faces(mesh1faces,1),2) mesh1.vertices(mesh1.faces(mesh1faces,2),2) mesh1.vertices(mesh1.faces(mesh1faces,3),2)].')';
Z1 = mean([mesh1.vertices(mesh1.faces(mesh1faces,1),3) mesh1.vertices(mesh1.faces(mesh1faces,2),3) mesh1.vertices(mesh1.faces(mesh1faces,3),3)].')';
% Calculate mesh2 faces' centroids
%X2 = mean([mesh2.vertices(mesh2.faces(mesh2faces,1),1) mesh2.vertices(mesh2.faces(mesh2faces,2),1) mesh2.vertices(mesh2.faces(mesh2faces,3),1)].')';
%Y2 = mean([mesh2.vertices(mesh2.faces(mesh2faces,1),2) mesh2.vertices(mesh2.faces(mesh2faces,2),2) mesh2.vertices(mesh2.faces(mesh2faces,3),2)].')';
%Z2 = mean([mesh2.vertices(mesh2.faces(mesh2faces,1),3) mesh2.vertices(mesh2.faces(mesh2faces,2),3) mesh2.vertices(mesh2.faces(mesh2faces,3),3)].')';

% Calculate the contact centroid
contactPoint = zeros(1,3);
%contactPoint(1) = (mean(X1) + mean(X2)) / 2;
%contactPoint(2) = (mean(Y1) + mean(Y2)) / 2;
%contactPoint(3) = (mean(Z1) + mean(Z2)) / 2;
% USE HAND CENTROIDS ONLY BECAUSE SOME OBJECTS (SUCH AS CYLINDERS) HAVE VERY FAR CENTROIDS
contactPoint(1) = mean(X1);
contactPoint(2) = mean(Y1);
contactPoint(3) = mean(Z1);

end

