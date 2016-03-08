function hand = handPosture2( hand, q )
% This function takes as input a hand model and a kinematic configruation
% and returns the hand in the new configuration

% Make sure q lies within joint limits
[a, ~] = size(q);
for i = 1:a
    q{i} = max(q{i},hand.qRange{i}(:,1)');
    q{i} = min(q{i},hand.qRange{i}(:,2)');
end

% ##### ##### ##### ##### Palm ##### ##### ##### ##### #####
if isfield(hand.palm, 'links') % Check if there are movable parts in the palm
    % Calculate transform for all joints and load current ones
    [~, ~, m] = size(hand.palm.joints); % get number of joints in the palm
    Tpo = zeros(4,4,m); % preallocate variables: (T)ransform (p)alm (o)ld
    Rpo = zeros(4,4,m);
    Tpn = zeros(4,4,m); % (T)ransform (p)alm (n)ew
    Rpn = zeros(4,4,m);
    for i = 1:m
        Tpo(:,:,i) = hand.Tp(:,:,i);
        if hand.palm.jointParent(i) > 0
            n = hand.palm.jointParent(i);
            %Tpo(:,:,i) = Tpo(:,:,n) * hand.palm.joints(:,:,i) * trotx(hand.palm.jointAxes(i,1)*deg2rad(hand.qCurrent{1}(i))) * troty(hand.palm.jointAxes(i,2)*deg2rad(hand.qCurrent{1}(i))) * trotz(hand.palm.jointAxes(i,3)*deg2rad(hand.qCurrent{1}(i)));
            Tpn(:,:,i) = Tpn(:,:,n) * hand.palm.joints(:,:,i) * trotx(hand.palm.jointAxes(i,1)*deg2rad(q{1}(i)))             * troty(hand.palm.jointAxes(i,2)*deg2rad(q{1}(i)))             * trotz(hand.palm.jointAxes(i,3)*deg2rad(q{1}(i)));
        else
            %Tpo(:,:,i) = hand.palm.joints(:,:,i) * trotx(hand.palm.jointAxes(i,1)*deg2rad(hand.qCurrent{1}(i))) * troty(hand.palm.jointAxes(i,2)*deg2rad(hand.qCurrent{1}(i))) * trotz(hand.palm.jointAxes(i,3)*deg2rad(hand.qCurrent{1}(i)));
            Tpn(:,:,i) = hand.palm.joints(:,:,i) * trotx(hand.palm.jointAxes(i,1)*deg2rad(q{1}(i)))             * troty(hand.palm.jointAxes(i,2)*deg2rad(q{1}(i)))             * trotz(hand.palm.jointAxes(i,3)*deg2rad(q{1}(i)));
        end
        Rpo(:,:,i) = [ Tpo(:,1:3,i) [0; 0; 0; 1] ];
        Rpn(:,:,i) = [ Tpn(:,1:3,i) [0; 0; 0; 1] ];
    end
    % Apply transform to all links
    [~, m] = size(hand.palm.links); % get number of links in the palm
    for i = 1:m
        n = hand.palm.links(i).parent;
        if isfield(hand.palm.links(i), 'contactMesh')   % Check if a contactMesh is present
            % remove old transform
            hand.palm.links(i).contactMesh.vertices             = (h2e( inv(Tpo(:,:,n)) * e2h(hand.palm.links(i).contactMesh.vertices.') ))';
            hand.palm.links(i).contactMesh.verticesNormals      = (h2e( inv(Rpo(:,:,n)) * e2h(hand.palm.links(i).contactMesh.verticesNormals.') ))';
            hand.palm.links(i).contactMesh.normals              = (h2e( inv(Rpo(:,:,n)) * e2h(hand.palm.links(i).contactMesh.normals.') ))';
            % apply new transform
            hand.palm.links(i).contactMesh.vertices             = (h2e( Tpn(:,:,n) * e2h(hand.palm.links(i).contactMesh.vertices.') ))';
            hand.palm.links(i).contactMesh.verticesNormals      = (h2e( Rpn(:,:,n) * e2h(hand.palm.links(i).contactMesh.verticesNormals.') ))';
            hand.palm.links(i).contactMesh.normals              = (h2e( Rpn(:,:,n) * e2h(hand.palm.links(i).contactMesh.normals.') ))';
        end
        if isfield(hand.palm.links(i), 'collisionMesh') % Check if a collisionMesh is present
            % remove old transform
            hand.palm.links(i).collisionMesh.vertices           = (h2e( inv(Tpo(:,:,n)) * e2h(hand.palm.links(i).collisionMesh.vertices.') ))';
            hand.palm.links(i).collisionMesh.verticesNormals    = (h2e( inv(Rpo(:,:,n)) * e2h(hand.palm.links(i).collisionMesh.verticesNormals.') ))';
            hand.palm.links(i).collisionMesh.normals            = (h2e( inv(Rpo(:,:,n)) * e2h(hand.palm.links(i).collisionMesh.normals.') ))';
            % apply new transform
            hand.palm.links(i).collisionMesh.vertices           = (h2e( Tpn(:,:,n) * e2h(hand.palm.links(i).collisionMesh.vertices.') ))';
            hand.palm.links(i).collisionMesh.verticesNormals    = (h2e( Rpn(:,:,n) * e2h(hand.palm.links(i).collisionMesh.verticesNormals.') ))';
            hand.palm.links(i).collisionMesh.normals            = (h2e( Rpn(:,:,n) * e2h(hand.palm.links(i).collisionMesh.normals.') ))';
        end
        if isfield(hand.palm.links(i), 'visualMesh') % Check if a visualMesh is present
            % remove old transform
            hand.palm.links(i).visualMesh.vertices              = (h2e( inv(Tpo(:,:,n)) * e2h(hand.palm.links(i).visualMesh.vertices.') ))';
            hand.palm.links(i).visualMesh.verticesNormals       = (h2e( inv(Rpo(:,:,n)) * e2h(hand.palm.links(i).visualMesh.verticesNormals.') ))';
            hand.palm.links(i).visualMesh.normals               = (h2e( inv(Rpo(:,:,n)) * e2h(hand.palm.links(i).visualMesh.normals.') ))';
            % apply new transform
            hand.palm.links(i).visualMesh.vertices              = (h2e( Tpn(:,:,n) * e2h(hand.palm.links(i).visualMesh.vertices.') ))';
            hand.palm.links(i).visualMesh.verticesNormals       = (h2e( Rpn(:,:,n) * e2h(hand.palm.links(i).visualMesh.verticesNormals.') ))';
            hand.palm.links(i).visualMesh.normals               = (h2e( Rpn(:,:,n) * e2h(hand.palm.links(i).visualMesh.normals.') ))';
        end
    end
end

% ##### ##### ##### ##### Digits ##### ##### ##### ##### #####
[~, n] = size(hand.digits); % get number of digits, should be 4 or 5
for i = 1:n
    % Calculate transform for all joints
    [~, ~, m] = size(hand.digits(i).joints); % get number of joints in the digit
    Tdo{i} = zeros(4,4,m); % preallocate variables: (T)ransform (d)igit (o)ld
    Rdo{i} = zeros(4,4,m);
    Tdn{i} = zeros(4,4,m); % (T)ransform (d)igit (n)ew
    Rdn{i} = zeros(4,4,m);
    % first solve the first joint
    j = 1;
    Tdo{i}(:,:,j) = hand.Td{i}(:,:,j);
    if hand.digits(i).base > 0
        n = hand.digits(i).base;
        %Tdo{i}(:,:,j) = Tpo(:,:,n);
        Tdn{i}(:,:,j) = Tpn(:,:,n);
    else
        %Tdo{i}(:,:,j) = eye(4,4);
        Tdn{i}(:,:,j) = eye(4,4);
    end
    %Tdo{i}(:,:,j) = Tdo{i}(:,:,j) * hand.digits(i).joints(:,:,j) * trotx(hand.digits(i).jointAxes(j,1)*deg2rad(hand.qCurrent{i+1}(j))) * troty(hand.digits(i).jointAxes(j,2)*deg2rad(hand.qCurrent{i+1}(j))) * trotz(hand.digits(i).jointAxes(j,3)*deg2rad(hand.qCurrent{i+1}(j)));
    Tdn{i}(:,:,j) = Tdn{i}(:,:,j) * hand.digits(i).joints(:,:,j) * trotx(hand.digits(i).jointAxes(j,1)*deg2rad(q{i+1}(j))) * troty(hand.digits(i).jointAxes(j,2)*deg2rad(q{i+1}(j))) * trotz(hand.digits(i).jointAxes(j,3)*deg2rad(q{i+1}(j)));
    Rdo{i}(:,:,j) = [ Tdo{i}(:,1:3,j) [0; 0; 0; 1] ];
    Rdn{i}(:,:,j) = [ Tdo{i}(:,1:3,j) [0; 0; 0; 1] ];
    % then loop through the remaining joints
    for j = 2:m
        Tdo{i}(:,:,j) = hand.Td{i}(:,:,j);
        %Tdo{i}(:,:,j) = Tdo{i}(:,:,j-1) * hand.digits(i).joints(:,:,j) * trotx(hand.digits(i).jointAxes(j,1)*deg2rad(hand.qCurrent{i+1}(j))) * troty(hand.digits(i).jointAxes(j,2)*deg2rad(hand.qCurrent{i+1}(j))) * trotz(hand.digits(i).jointAxes(j,3)*deg2rad(hand.qCurrent{i+1}(j)));
        Tdn{i}(:,:,j) = Tdn{i}(:,:,j-1) * hand.digits(i).joints(:,:,j) * trotx(hand.digits(i).jointAxes(j,1)*deg2rad(q{i+1}(j)))             * troty(hand.digits(i).jointAxes(j,2)*deg2rad(q{i+1}(j)))             * trotz(hand.digits(i).jointAxes(j,3)*deg2rad(q{i+1}(j)));
        Rdo{i}(:,:,j) = [ Tdo{i}(:,1:3,j) [0; 0; 0; 1] ];
        Rdn{i}(:,:,j) = [ Tdo{i}(:,1:3,j) [0; 0; 0; 1] ];
    end
    % Apply transform to all links
    [~, m] = size(hand.digits(i).links); % get number of links in the digit
    for j = 1:m
        n = hand.digits(i).links(j).parent;
        if isfield(hand.digits(i).links(j), 'contactMesh')   % Check if a contactMesh is present
            % remove old transform
            hand.digits(i).links(j).contactMesh.vertices            = (h2e( inv(Tdo{i}(:,:,n)) * e2h(hand.digits(i).links(j).contactMesh.vertices.') ))';
            hand.digits(i).links(j).contactMesh.verticesNormals     = (h2e( inv(Rdo{i}(:,:,n)) * e2h(hand.digits(i).links(j).contactMesh.verticesNormals.') ))';
            hand.digits(i).links(j).contactMesh.normals             = (h2e( inv(Rdo{i}(:,:,n)) * e2h(hand.digits(i).links(j).contactMesh.normals.') ))';
            % apply new transform
            hand.digits(i).links(j).contactMesh.vertices            = (h2e( Tdn{i}(:,:,n) * e2h(hand.digits(i).links(j).contactMesh.vertices.') ))';
            hand.digits(i).links(j).contactMesh.verticesNormals     = (h2e( Rdn{i}(:,:,n) * e2h(hand.digits(i).links(j).contactMesh.verticesNormals.') ))';
            hand.digits(i).links(j).contactMesh.normals             = (h2e( Rdn{i}(:,:,n) * e2h(hand.digits(i).links(j).contactMesh.normals.') ))';
        end
        if isfield(hand.digits(i).links(j), 'collisionMesh') % Check if a collisionMesh is present
            % remove old transform
            hand.digits(i).links(j).collisionMesh.vertices          = (h2e( inv(Tdo{i}(:,:,n)) * e2h(hand.digits(i).links(j).collisionMesh.vertices.') ))';
            hand.digits(i).links(j).collisionMesh.verticesNormals   = (h2e( inv(Rdo{i}(:,:,n)) * e2h(hand.digits(i).links(j).collisionMesh.verticesNormals.') ))';
            hand.digits(i).links(j).collisionMesh.normals           = (h2e( inv(Rdo{i}(:,:,n)) * e2h(hand.digits(i).links(j).collisionMesh.normals.') ))';
            % apply new transform
            hand.digits(i).links(j).collisionMesh.vertices          = (h2e( Tdn{i}(:,:,n) * e2h(hand.digits(i).links(j).collisionMesh.vertices.') ))';
            hand.digits(i).links(j).collisionMesh.verticesNormals   = (h2e( Rdn{i}(:,:,n) * e2h(hand.digits(i).links(j).collisionMesh.verticesNormals.') ))';
            hand.digits(i).links(j).collisionMesh.normals           = (h2e( Rdn{i}(:,:,n) * e2h(hand.digits(i).links(j).collisionMesh.normals.') ))';
        end
        if isfield(hand.digits(i).links(j), 'visualMesh') % Check if a visualMesh is present
            % remove old transform
            hand.digits(i).links(j).visualMesh.vertices             = (h2e( inv(Tdo{i}(:,:,n)) * e2h(hand.digits(i).links(j).visualMesh.vertices.') ))';
            hand.digits(i).links(j).visualMesh.verticesNormals      = (h2e( inv(Rdo{i}(:,:,n)) * e2h(hand.digits(i).links(j).visualMesh.verticesNormals.') ))';
            hand.digits(i).links(j).visualMesh.normals              = (h2e( inv(Rdo{i}(:,:,n)) * e2h(hand.digits(i).links(j).visualMesh.normals.') ))';
            % apply new transform
            hand.digits(i).links(j).visualMesh.vertices             = (h2e( Tdn{i}(:,:,n) * e2h(hand.digits(i).links(j).visualMesh.vertices.') ))';
            hand.digits(i).links(j).visualMesh.verticesNormals      = (h2e( Rdn{i}(:,:,n) * e2h(hand.digits(i).links(j).visualMesh.verticesNormals.') ))';
            hand.digits(i).links(j).visualMesh.normals              = (h2e( Rdn{i}(:,:,n) * e2h(hand.digits(i).links(j).visualMesh.normals.') ))';
        end
    end
end





% ##### ##### ##### ##### Palm ##### ##### ##### ##### #####
if isfield(hand.palm, 'links') % Check if there are movable parts in the palm
    [~, ~, m] = size(hand.palm.joints); % get number of joints in the palm
    for i = 1:m
        hand.Tp(:,:,i) = Tpn(:,:,i);
    end
end

% ##### ##### ##### ##### Digits ##### ##### ##### ##### #####
[~, n] = size(hand.digits); % get number of digits, should be 4 or 5
for i = 1:n
    [~, ~, m] = size(hand.digits(i).joints); % get number of joints in the digit
    for j = 1:m
        hand.Td{i}(:,:,j) = Tdn{i}(:,:,j);
    end
end

hand.qCurrent = q;

end