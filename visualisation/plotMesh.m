function plotMesh( mesh, t, c )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

trisurf(mesh.faces, mesh.vertices(:,1),mesh.vertices(:,2),mesh.vertices(:,3),'FaceAlpha', t, 'FaceColor', c);

end

