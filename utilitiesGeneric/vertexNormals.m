function normals = vertexNormals(mesh)
%VERTEXNORMAL Compute normals to a mesh vertices
% Compute normal of each vertex as sum of normals to each connected face
% ONLY WORKS FOR INDEXED MESHES

[n, ~] = size(mesh.vertices);
normals = zeros(n,3);
for i = 1:n
    % Find the (indices of) all faces sharing the vertex
    connectedFaces = find( (mesh.faces(:,1) == i) | (mesh.faces(:,2) == i) | (mesh.faces(:,3) == i) );
    % Sum the normals of all connected faces
    m = size(connectedFaces);
    sum = zeros(1,3);
    for j = 1:m
        sum = sum + mesh.normals(connectedFaces(j),:);
    end
    % Normalise the sum and store it in "normals"
    normals(i,:) = sum/norm(sum);
end

end