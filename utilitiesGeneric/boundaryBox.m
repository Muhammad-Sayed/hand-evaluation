function [ box ] = boundaryBox( mesh )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

box.xMax = max(mesh.vertices(:,1));
box.xMin = min(mesh.vertices(:,1));
box.yMax = max(mesh.vertices(:,2));
box.yMin = min(mesh.vertices(:,2));
box.zMax = max(mesh.vertices(:,3));
box.zMin = min(mesh.vertices(:,3));

end

