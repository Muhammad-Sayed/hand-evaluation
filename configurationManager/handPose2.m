function pose = handPose2(hand, q)
% This function takes as input a hand model and a kinematic configruation
% and returns the hand in the new configuration

% Make sure all information in "hand" are pased into "pose"
pose = hand;

% Palm root needs no transform
pose.palm.root.contactMesh = hand.palm.root.contactMesh;
if isfield(hand.palm.root, 'collisionMesh') % Check if a collisionMesh is present
    pose.palm.root.collisionMesh = hand.palm.root.collisionMesh;
end
if isfield(hand.palm.root, 'visualMesh') % Check if a visualMesh is present
    pose.palm.root.visualMesh = hand.palm.root.visualMesh;
end
% Palm links
if isfield(hand.palm, 'links') % Check if there are movable parts in the palm
    [~, m] = size(hand.palm.links); % get number of joints/links in the palm
    %n = hand.palm.chains; % Get number of independent chains in the palm
    % Create m 4x4 identity matrices to store transforms
    baseRotation = zeros(4,4,m);
    baseTransform = zeros(4,4,m);
    for j = 1:m % loop through links, THIS DOES NOT SUPPORT CHAINS
        baseRotation(:,:,j) = eye(4) * [ hand.palm.joints(1:3,1:3,j) [0; 0; 0] ; [0 0 0 1] ] * trotx(deg2rad(q{1}(j,1))) * troty(deg2rad(q{1}(j,2))) * trotz(deg2rad(q{1}(j,3)));
        baseTransform(:,:,j) = eye(4) * hand.palm.joints(:,:,j) * trotx(deg2rad(q{1}(j,1))) * troty(deg2rad(q{1}(j,2))) * trotz(deg2rad(q{1}(j,3)));
        % contactMesh
        % Apply transform to vertices, normals and joint axes
        pose.palm.links(j).contactMesh.vertices = (h2e( baseTransform(:,:,j) * e2h(hand.palm.links(j).contactMesh.vertices.') ))';
        pose.palm.links(j).contactMesh.normals = (h2e( baseRotation(:,:,j) * e2h(hand.palm.links(j).contactMesh.normals.') ))';
        pose.palm.jointAxes(j,:) = (h2e( baseRotation(:,:,j) * e2h(hand.palm.jointAxes(j,:)') ))';
        % Add faces
        pose.palm.links(j).contactMesh.faces = hand.palm.links(j).contactMesh.faces;
        % collisionMesh
        if isfield(hand.palm.links(j), 'collisionMesh') % Check if a collisionMesh is present
            % Apply transform to vertices and normals
            pose.palm.links(j).collisionMesh.vertices = (h2e( baseTransform(:,:,j) * e2h(hand.palm.links(j).collisionMesh.vertices.') ))';
            pose.palm.links(j).collisionMesh.normals = (h2e( baseRotation(:,:,j) * e2h(hand.palm.links(j).collisionMesh.normals.') ))';
            % Add faces
            pose.palm.links(j).collisionMesh.faces = hand.palm.links(j).collisionMesh.faces;
        end
        % visualMesh
        if isfield(hand.palm.links(j), 'visualMesh') % Check if a visualMesh is present
            % Apply transform to vertices and normals
            pose.palm.links(j).visualMesh.vertices = (h2e( baseTransform(:,:,j) * e2h(hand.palm.links(j).visualMesh.vertices.') ))';
            pose.palm.links(j).visualMesh.normals = (h2e( baseRotation(:,:,j) * e2h(hand.palm.links(j).visualMesh.normals.') ))';
            % Add faces
            pose.palm.links(j).visualMesh.faces = hand.palm.links(j).visualMesh.faces;
        end
    end
end

[~, n] = size(hand.digits); % get number of digits, should be 4 or 5
for i = 1:n % loop through digits
    [~, m] = size(hand.digits(i).links); % get number of links in the digit
    
    if (isfield(hand.digits(i), 'base') && (hand.digits(i).base ~= 0)) % Check if the digit's base is movable
        base = hand.digits(i).base;
        R = baseRotation(:,:,base); % Load base transforms
        T = baseTransform(:,:,base);
    else
        R = eye(4); % 4x4 identity matrix to store transforms
        T = eye(4);
    end
    
    for j = 1:m % loop through links
        if isfield(hand.palm, 'joints') % Check if there are movable parts in the palm
            k = i + 1; % Because first element in configuration "q" corresponds to palm joints
        else
            k = i;
        end
        % Calculate transform
        R = R * [ hand.digits(i).joints(1:3,1:3,j) [0; 0; 0] ; [0 0 0 1] ] * trotx(deg2rad(q{k}(j,1))) * troty(deg2rad(q{k}(j,2))) * trotz(deg2rad(q{k}(j,3)));
        T = T * hand.digits(i).joints(:,:,j) * trotx(deg2rad(q{k}(j,1))) * troty(deg2rad(q{k}(j,2))) * trotz(deg2rad(q{k}(j,3)));
        % contactMesh
        % Apply transform to vertices, normals and joint axes
        pose.digits(i).links(j).contactMesh.vertices = (h2e( T * e2h(hand.digits(i).links(j).contactMesh.vertices.') ))';
        pose.digits(i).links(j).contactMesh.normals = (h2e( R * e2h(hand.digits(i).links(j).contactMesh.normals.') ))';
        pose.digits(i).jointAxes(j,:) = (h2e( R * e2h(hand.digits(i).jointAxes(j,:)') ))';
        % Add faces
        pose.digits(i).links(j).contactMesh.faces = hand.digits(i).links(j).contactMesh.faces;
        % collisionMesh
        if isfield(hand.digits(i).links(j), 'collisionMesh') % Check if a collisionMesh is present
            % Apply transform to vertices and normals
            pose.digits(i).links(j).collisionMesh.vertices = (h2e( T * e2h(hand.digits(i).links(j).collisionMesh.vertices.') ))';
            pose.digits(i).links(j).collisionMesh.normals = (h2e( R * e2h(hand.digits(i).links(j).collisionMesh.normals.') ))';
            % Add faces
            pose.digits(i).links(j).collisionMesh.faces = hand.digits(i).links(j).collisionMesh.faces;
        end
        % visualMesh
        if isfield(hand.digits(i).links(j), 'visualMesh') % Check if a visualMesh is present
            % Apply transform to vertices and normals
            pose.digits(i).links(j).visualMesh.vertices = (h2e( T * e2h(hand.digits(i).links(j).visualMesh.vertices.') ))';
            pose.digits(i).links(j).visualMesh.normals = (h2e( R * e2h(hand.digits(i).links(j).visualMesh.normals.') ))';
            % Add faces
            pose.digits(i).links(j).visualMesh.faces = hand.digits(i).links(j).visualMesh.faces;
        end
    end
end

end