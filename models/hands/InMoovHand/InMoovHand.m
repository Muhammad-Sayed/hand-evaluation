function hand = InMoovHand()
% Returns a model of the InMoov right hand
%
%   A hand model describes the hand's kinematic and dynamic parameters as
%   well as its surface geometry and physical properties
%
% Muhammad Sayed
% muhammad.b.h.sayed@gmail.com

% Define how many joints (DoFs) in the hand
hand.DoF = 17;

% Define a flag indicating if this is a right (1) or left (-1) hand
hand.isRight = 1;      % LEFT HAND IS NOT YET IMPLEMENTED

% ##### ##### ##### ##### Palm  ##### ##### ##### ##### #####
hand.palm.jointParent           = zeros(3,1);
hand.palm.joints(:,:,1)         = transl(38.6,-22.9,0) * trotz(hand.isRight*-1.639);
hand.palm.links(1).parent       = 1;
hand.palm.joints(:,:,2)         = transl(60.5, 13.6,0) * trotz(hand.isRight* 0.919);
hand.palm.links(2).parent       = 2;
hand.palm.joints(:,:,3)         = transl(36.3, 33.1,0) * trotz(hand.isRight* 0.846);
hand.palm.links(3).parent       = 3;
% ##### ##### ##### ##### Thumb ##### ##### ##### ##### #####
hand.digits(1).base             = 1;
hand.digits(1).joints(:,:,1)    = transl(27.4,16.1,0) * trotz(0.704) * trotx(-0.26);
hand.digits(1).links(1).parent  = 1;
hand.digits(1).joints(:,:,2)    = transl(35.7,0,0);
hand.digits(1).links(2).parent  = 2;
hand.digits(1).tip              = transl(32.55,0,0);
% ##### ##### ##### ##### Index ##### ##### ##### ##### #####
hand.digits(2).base             = 0;
hand.digits(2).joints(:,:,1)    = transl(101,-26.25,0) * trotz(-0.098);
hand.digits(2).links(1).parent  = 1;
hand.digits(2).joints(:,:,2)    = transl(36.1,0,0);
hand.digits(2).links(2).parent  = 2;
hand.digits(2).joints(:,:,3)    = transl(24.2,0,0);
hand.digits(2).links(3).parent  = 3;
hand.digits(2).tip              = transl(30.69,0,0);
% ##### ##### ##### ##### Middle #### ##### ##### ##### #####
hand.digits(3).base             = 0;
hand.digits(3).joints(:,:,1)    = transl(105.2,1,0);
hand.digits(3).links(1).parent  = 1;
hand.digits(3).joints(:,:,2)    = transl(38.7,0,0);
hand.digits(3).links(2).parent  = 2;
hand.digits(3).joints(:,:,3)    = transl(25.9,0,0);
hand.digits(3).links(3).parent  = 3;
hand.digits(3).tip              = transl(32.86,0,0);
% ##### ##### ##### ##### Ring  ##### ##### ##### ##### #####
hand.digits(4).base             = 2;
hand.digits(4).joints(:,:,1)    = transl(35.2,-18.1,0) * trotz(-0.821);
hand.digits(4).links(1).parent  = 1;
hand.digits(4).joints(:,:,2)    = transl(34,0,0);
hand.digits(4).links(2).parent  = 2;
hand.digits(4).joints(:,:,3)    = transl(23,0,0);
hand.digits(4).links(3).parent  = 3;
hand.digits(4).tip              = transl(29.13,0,0);
% ##### ##### ##### ##### Small ##### ##### ##### ##### #####
hand.digits(5).base             = 3;
hand.digits(5).joints(:,:,1)    = transl(46.7,-21.5,0) * trotz(-0.651);
hand.digits(5).links(1).parent  = 1;
hand.digits(5).joints(:,:,2)    = transl(30.9,0,0);
hand.digits(5).links(2).parent  = 2;
hand.digits(5).joints(:,:,3)    = transl(20.8,0,0);
hand.digits(5).links(3).parent  = 3;
hand.digits(5).tip              = transl(26.19,0,0);

% Joint axes ( because we need it for Jacobian, so might as well store it from the begining)
%   All InMoov right hand joints rotate about the local -ve Y-axis
%   NOTE THAT WE NEED TO UPDATE THIS IN THE HAND POSE CODE
%   ALSO THIS IS NOT COMPATIBLE WITH ASSUMING ALL JOINTS HAVE 3 DOF <= FIX THIS
hand.palm.jointAxes = [ zeros(3,1) -ones(3,1) zeros(3,1) ];
hand.digits(1).jointAxes = [ zeros(2,1) -ones(2,1) zeros(2,1) ];
hand.digits(2).jointAxes = [ zeros(3,1) -ones(3,1) zeros(3,1) ];
hand.digits(3).jointAxes = [ zeros(3,1) -ones(3,1) zeros(3,1) ];
hand.digits(4).jointAxes = [ zeros(3,1) -ones(3,1) zeros(3,1) ];
hand.digits(5).jointAxes = [ zeros(3,1) -ones(3,1) zeros(3,1) ];


%hand.palm = [ringBase, smallBase];
%hand.digits = [index, middle, ring, small];

% Dimension variables
%TH1 = 8.24;
%TH2 = 24.49;
%TH3 = 35.68;
%TH4 = 32.55;

%IN1 = 36.10;
%IN2 = 24.15;
%IN3 = 30.69;

%MI1 = 38.67;
%MI2 = 25.92;
%MI3 = 32.86;

%RI1 = 18.37;
%RI2 = 24.70;
%RI3 = 34.04;
%RI4 = 22.97;
%RI5 = 29.13;

%SM1 = 15.77;
%SM2 = 37.61;
%SM3 = 30.92;
%SM4 = 20.82;
%SM5 = 26.19;

% define anthropomorphic equivelance, which DoF is associated with the joints
%             MCP (P)IP DIP
hand.joints = [ 1   2   0;  % Thumb
                1   2   3;  % Index
                1   2   3;  % Middle
                1   2   3;  % Ring
                1   2   3]; % Small



% Define open ( or home ) posture configuration
hand.qHome = {  [0  0   0],
                [0  0],
                [0  0   0],
                [0  0   0],
                [0  0   0],
                [0  0   0]};

% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

hand.qRange = { [ 0 90; 0 15; 0 20 ],
                [ 0 85; 0 90 ],
                [ 0 85; 0 90; 0 65 ], 
                [ 0 85; 0 90; 0 65 ],
                [ 0 85; 0 90; 0 65 ],
                [ 0 85; 0 90; 0 65 ]};

% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

% Import contact meshes
% Palm main part (root)
[hand.palm.root.contactMesh.faces, hand.palm.root.contactMesh.vertices, hand.palm.root.contactMesh.normals] = stlread('\meshes\contact_0_0.stl');
% STL files are not indexed meshes, use "patchslim" to unify replicated vertices
[hand.palm.root.contactMesh.vertices, hand.palm.root.contactMesh.faces] = patchslim(hand.palm.root.contactMesh.vertices, hand.palm.root.contactMesh.faces);
% Add verticesNormals ( used to make smaller meshes and in other codes )
hand.palm.root.contactMesh.verticesNormals = vertexNormal(hand.palm.root.contactMesh.vertices, hand.palm.root.contactMesh.faces);
% Generate collision meshes; in this model, contact mesh is rigid plastic.
% Therefore we generate a sollision mesh that is only smaller than contact
% mesh by a small tollerance value
contactTollerance = 1;
% Palm root link
hand.palm.root.collisionMesh = smallerMesh( hand.palm.root.contactMesh, contactTollerance );
% Palm segments
for j = 1:3
    [hand.palm.links(j).contactMesh.faces, hand.palm.links(j).contactMesh.vertices, hand.palm.links(j).contactMesh.normals] = stlread(sprintf('\\meshes\\contact_0_%d.stl', j));
    [hand.palm.links(j).contactMesh.vertices, hand.palm.links(j).contactMesh.faces] = patchslim(hand.palm.links(j).contactMesh.vertices, hand.palm.links(j).contactMesh.faces);
    hand.palm.links(j).contactMesh.verticesNormals = vertexNormal(hand.palm.links(j).contactMesh.vertices, hand.palm.links(j).contactMesh.faces);
    hand.palm.links(j).collisionMesh = smallerMesh( hand.palm.links(j).contactMesh, contactTollerance );
end
% Digits
for i = 1:5
    [~, m] = size(hand.digits(i).links); % get number of links in the digit
    for j = 1:m
        [hand.digits(i).links(j).contactMesh.faces, hand.digits(i).links(j).contactMesh.vertices, hand.digits(i).links(j).contactMesh.normals] = stlread(sprintf('\\meshes\\contact_%d_%d.stl', i, j));
        [hand.digits(i).links(j).contactMesh.vertices, hand.digits(i).links(j).contactMesh.faces] = patchslim(hand.digits(i).links(j).contactMesh.vertices, hand.digits(i).links(j).contactMesh.faces);
        hand.digits(i).links(j).contactMesh.verticesNormals = vertexNormal(hand.digits(i).links(j).contactMesh.vertices, hand.digits(i).links(j).contactMesh.faces);
        hand.digits(i).links(j).collisionMesh = smallerMesh( hand.digits(i).links(j).contactMesh, contactTollerance );
    end
end

% Define contact types (contact model)
%   1 :: PCwF
%   2 :: HF
%   3 :: SF
% For InMoov hand, we assume palm and tips are covered with the silicon
% covers, thus we use SF model, but other links are not, so we use HF
hand.palm.root.contactType = 3;
for j = 1:3
    hand.palm.links(j).contactType = 3;
end
for i = 1:5 % loop through digits
    [~, m] = size(hand.digits(i).links); % get number of links in the digit
    for j = 1:m-1 % loop through links
        hand.digits(i).links(j).contactType = 2;
    end
    hand.digits(i).links(m).contactType = 3;
end


% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

% Apply initial transform

% ##### ##### ##### ##### Palm ##### ##### ##### ##### #####
% Calculate transform for all joints
hand.Tp = zeros(4,4,5); % preallocate variables
Rp      = zeros(4,4,5);
for i = 1:3
    hand.Tp(:,:,i)  = hand.palm.joints(:,:,i);
    Rp(:,:,i)       = [ hand.Tp(:,1:3,i) [0; 0; 0; 1] ];
end
% Apply transform to all links
for i = 1:3
    n = hand.palm.links(i).parent;
    hand.palm.links(i).contactMesh.vertices             = (h2e( hand.Tp(:,:,n) * e2h(hand.palm.links(i).contactMesh.vertices.') ))';
    %hand.palm.links(i).contactMesh.verticesNormals      = (h2e( Rp(:,:,n) * e2h(hand.palm.links(i).contactMesh.verticesNormals.') ))';
    hand.palm.links(i).contactMesh.normals              = (h2e( Rp(:,:,n) * e2h(hand.palm.links(i).contactMesh.normals.') ))';
    hand.palm.links(i).collisionMesh.vertices           = (h2e( hand.Tp(:,:,n) * e2h(hand.palm.links(i).collisionMesh.vertices.') ))';
    %hand.palm.links(i).collisionMesh.verticesNormals    = (h2e( Rp(:,:,n) * e2h(hand.palm.links(i).collisionMesh.verticesNormals.') ))';
    hand.palm.links(i).collisionMesh.normals            = (h2e( Rp(:,:,n) * e2h(hand.palm.links(i).collisionMesh.normals.') ))';
end
% ##### ##### ##### ##### Digits ##### ##### ##### ##### #####
for i = 1:5
    % Calculate transform for all joints
    [~, ~, m] = size(hand.digits(i).joints); % get number of joints in the digit
    hand.Td{i} = zeros(4,4,m); % preallocate variables
    Rd{i} = zeros(4,4,m);
    % first solve the first joint
    j = 1;
    if hand.digits(i).base > 0
        hand.Td{i}(:,:,j) = hand.Tp(:,:,hand.digits(i).base);
    else
        hand.Td{i}(:,:,j) = eye(4,4);
    end
    hand.Td{i}(:,:,j) = hand.Td{i}(:,:,j) * hand.digits(i).joints(:,:,j);
    Rd{i}(:,:,j) = [ hand.Td{i}(:,1:3,j) [0; 0; 0; 1] ];
    % then loop through the remaining joints
    for j = 2:m
        hand.Td{i}(:,:,j) = hand.Td{i}(:,:,j-1) * hand.digits(i).joints(:,:,j);
        Rd{i}(:,:,j) = [ hand.Td{i}(:,1:3,j) [0; 0; 0; 1] ];
    end
    % Apply transform to all links
    [~, m] = size(hand.digits(i).links); % get number of links in the digit
    for j = 1:m
        n = hand.digits(i).links(j).parent;
        hand.digits(i).links(j).contactMesh.vertices            = (h2e( hand.Td{i}(:,:,n) * e2h(hand.digits(i).links(j).contactMesh.vertices.') ))';
        %hand.digits(i).links(j).contactMesh.verticesNormals     = (h2e( Rd{i}(:,:,n) * e2h(hand.digits(i).links(j).contactMesh.verticesNormals.') ))';
        hand.digits(i).links(j).contactMesh.normals             = (h2e( Rd{i}(:,:,n) * e2h(hand.digits(i).links(j).contactMesh.normals.') ))';
        hand.digits(i).links(j).collisionMesh.vertices          = (h2e( hand.Td{i}(:,:,n) * e2h(hand.digits(i).links(j).collisionMesh.vertices.') ))';
        %hand.digits(i).links(j).collisionMesh.verticesNormals   = (h2e( Rd{i}(:,:,n) * e2h(hand.digits(i).links(j).collisionMesh.verticesNormals.') ))';
        hand.digits(i).links(j).collisionMesh.normals           = (h2e( Rd{i}(:,:,n) * e2h(hand.digits(i).links(j).collisionMesh.normals.') ))';
    end
end

% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####


end