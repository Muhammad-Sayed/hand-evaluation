function plotMeshNormals( mesh )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here

% Calculate faces' centroids
X = mean([mesh.vertices(mesh.faces(:,1),1) mesh.vertices(mesh.faces(:,2),1) mesh.vertices(mesh.faces(:,3),1)].')';
Y = mean([mesh.vertices(mesh.faces(:,1),2) mesh.vertices(mesh.faces(:,2),2) mesh.vertices(mesh.faces(:,3),2)].')';
Z = mean([mesh.vertices(mesh.faces(:,1),3) mesh.vertices(mesh.faces(:,2),3) mesh.vertices(mesh.faces(:,3),3)].')';
        
% Plot normals
quiver3(X, Y, Z, mesh.normals(:,1), mesh.normals(:,2), mesh.normals(:,3));

end

