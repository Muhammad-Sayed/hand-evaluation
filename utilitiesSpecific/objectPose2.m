function pose = objectPose2(object, T)

R = [ T(1:3,1:3) zeros(3,1); 0 0 0 1 ];
        
% Apply transform
if isfield(object, 'contactMesh') % Check if a contactMesh is present
    % Apply transform to vertices and normals
    pose.contactMesh.vertices = (h2e( T * e2h(object.contactMesh.vertices.') ))';
    pose.contactMesh.normals  = (h2e( R * e2h(object.contactMesh.normals.') ))';
    % Add faces
    pose.contactMesh.faces = object.contactMesh.faces;
   
    if isfield(object, 'collisionMesh') % Check if a collisionMesh is present
        % Apply transform to vertices and normals
        pose.collisionMesh.vertices = (h2e( T * e2h(object.collisionMesh.vertices.') ))';
        pose.collisionMesh.normals  = (h2e( R * e2h(object.collisionMesh.normals.') ))';
        % Add faces
        pose.collisionMesh.faces = object.collisionMesh.faces;
    end
    
    if isfield(object, 'visualMesh') % Check if a visualMesh is present
        % Apply transform to vertices and normals
        pose.visualMesh.vertices = (h2e( T * e2h(object.visualMesh.vertices.') ))';
        pose.visualMesh.normals  = (h2e( R * e2h(object.visualMesh.normals.') ))';
        % Add faces
        pose.visualMesh.faces = object.visualMesh.faces;
    end
else % The object itself is the mesh
    % Apply transform to vertices and normals
    pose.vertices = (h2e( T * e2h(object.vertices.') ))';
    pose.normals  = (h2e( R * e2h(object.normals.') ))';
    % Add faces
    pose.faces = object.faces;
end

end