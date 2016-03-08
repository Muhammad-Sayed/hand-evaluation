function [ outputMesh ] = smallerMesh( inputMesh, delta )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% Get normals to vertices of original mesh
%normals = vertexNormals(inputMesh);
% Generate new mesh with vertices moving "delta" units along negative direction of their normals
outputMesh.verticesNormals  = inputMesh.verticesNormals;
outputMesh.vertices         = inputMesh.vertices - ( delta * inputMesh.verticesNormals );
outputMesh.faces            = inputMesh.faces;
outputMesh.normals          = inputMesh.normals;

end

