function pose = InMoovDigitPose(hand, digit, q)
% This is simplified version of "handPose2" that can applies to single
% digits of the InMoov hand for computation efficience
% This function only moves collision and contact meshes

pose = hand;

% Palm links
if (digit == 1) || (digit == 4) || (digit == 5)
    if digit == 1
        j = 1; % index of thumb metacarpal in the palm links
    else
        j = digit - 2; % index of ring or small finger metacarpal
    end
    % Calculate transfomrs, all InMoov joints rotate about the y axis only
    baseRotation = eye(4) * [ hand.palm.joints(1:3,1:3,j) [0; 0; 0] ; [0 0 0 1] ] * troty(deg2rad(q(1)));
    baseTransform = eye(4) * hand.palm.joints(:,:,j) * troty(deg2rad(q(1)));
    % contactMesh
    % Apply transform to vertices and normals
    pose.palm.links(j).contactMesh.vertices = (h2e( baseTransform * e2h(hand.palm.links(j).contactMesh.vertices.') ))';
    pose.palm.links(j).contactMesh.normals = (h2e( baseRotation * e2h(hand.palm.links(j).contactMesh.normals.') ))';
    % Add faces
    pose.palm.links(j).contactMesh.faces = hand.palm.links(j).contactMesh.faces;
    % collisionMesh
    if isfield(hand.palm.links(j), 'collisionMesh') % Check if a collisionMesh is present
        % Apply transform to vertices and normals
        pose.palm.links(j).collisionMesh.vertices = (h2e( baseTransform * e2h(hand.palm.links(j).collisionMesh.vertices.') ))';
        pose.palm.links(j).collisionMesh.normals = (h2e( baseRotation * e2h(hand.palm.links(j).collisionMesh.normals.') ))';
        % Add faces
        pose.palm.links(j).collisionMesh.faces = hand.palm.links(j).collisionMesh.faces;
    end
end

% Digit
[~, m] = size(hand.digits(digit).links); % get number of links in the digit
if (isfield(hand.digits(digit), 'base') && (hand.digits(digit).base ~= 0)) % Check if the digit's base is movable
    R = baseRotation; % Use the above base transforms
    T = baseTransform;
else
    R = eye(4); % 4x4 identity matrix to store transforms
    T = eye(4);
end

for j = 1:m % loop through links
    if (digit == 1) || (digit == 4) || (digit == 5) % Check if there are movable parts in the palm
        k = j + 1; % Because first element in configuration "q" corresponds to palm joints
    else
        k = j;
    end
    % Calculate transform
    R = R * [ hand.digits(digit).joints(1:3,1:3,j) [0; 0; 0] ; [0 0 0 1] ] * troty(deg2rad(q(k)));
    T = T * hand.digits(digit).joints(:,:,j) * troty(deg2rad(q(k)));
    % contactMesh
    % Apply transform to vertices and normals
    pose.digits(digit).links(j).contactMesh.vertices = (h2e( T * e2h(hand.digits(digit).links(j).contactMesh.vertices.') ))';
    pose.digits(digit).links(j).contactMesh.normals = (h2e( R * e2h(hand.digits(digit).links(j).contactMesh.normals.') ))';
    % Add faces
    pose.digits(digit).links(j).contactMesh.faces = hand.digits(digit).links(j).contactMesh.faces;
    % collisionMesh
    if isfield(hand.palm.links(j), 'collisionMesh') % Check if a collisionMesh is present
        % Apply transform to vertices and normals
        pose.digits(digit).links(j).collisionMesh.vertices = (h2e( T * e2h(hand.digits(digit).links(j).collisionMesh.vertices.') ))';
        pose.digits(digit).links(j).collisionMesh.normals = (h2e( R * e2h(hand.digits(digit).links(j).collisionMesh.normals.') ))';
        % Add faces
        pose.digits(digit).links(j).collisionMesh.faces = hand.digits(digit).links(j).collisionMesh.faces;
    end
end

end