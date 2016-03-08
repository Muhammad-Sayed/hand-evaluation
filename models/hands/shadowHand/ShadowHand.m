function hand = ShadowHand()
% Returns a model of the Shadow Dexterous Hand (right hand)
%
%   A hand model describes the hand's kinematic and dynamic parameters as
%   well as its surface geometry and physical properties
%
% Muhammad Sayed
% muhammad.b.h.sayed@gmail.com

% define how many joints (DoFs) in the hand
hand.DoF = 22;

% hand joints
hand.palm.joints(:,:,1)    = transl(29,-34,11) * troty(0) * trotz(deg2rad(-45)) * trotx(deg2rad(-90));
hand.palm.joints(:,:,2)    = transl(43.95,16.36,0) * trotz(deg2rad(55));

hand.palm.chains = 2; % Variable to store the number of serial link chains in the palm

hand.digits(1).base = 1;
hand.digits(1).joints(:,:,1)    = transl(38,0,0) * trotz(0) * trotx(0);
hand.digits(1).joints(:,:,2)    = transl(32,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(1).tip              = transl(27.5,0,0) * trotx(0) * troty(0) * trotz(0);

hand.digits(2).base = 0; 
hand.digits(2).joints(:,:,1)    = transl(95,-33,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(2).joints(:,:,2)    = transl(0,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(2).joints(:,:,3)    = transl(45,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(2).joints(:,:,4)    = transl(25,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(2).tip              = transl(26,0,0) * trotx(0) * troty(0) * trotz(0);

hand.digits(3).base = 0;
hand.digits(3).joints(:,:,1)    = transl(99,-11,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(3).joints(:,:,2)    = transl(0,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(3).joints(:,:,3)    = transl(45,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(3).joints(:,:,4)    = transl(25,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(3).tip              = transl(26,0,0) * trotx(0) * troty(0) * trotz(0);

hand.digits(4).base = 0;
hand.digits(4).joints(:,:,1)    = transl(95,11,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(4).joints(:,:,2)    = transl(0,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(4).joints(:,:,3)    = transl(45,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(4).joints(:,:,4)    = transl(25,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(4).tip              = transl(26,0,0) * trotx(0) * troty(0) * trotz(0);

hand.digits(5).base = 2;
hand.digits(5).joints(:,:,1)    = trotz(deg2rad(-55)) * transl(42.65,16.64,0);
hand.digits(5).joints(:,:,2)    = transl(0,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(5).joints(:,:,3)    = transl(45,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(5).joints(:,:,4)    = transl(25,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(5).tip              = transl(26,0,0) * trotx(0) * troty(0) * trotz(0);

% Joint axes (because we need it for Jacobian, so might as well store it from the begining)
%   All InMoov right hand joints rotate about the local -ve Y-axis
%   NOTE THAT WE NEED TO UPDATE THIS IN THE HAND POSE CODE
%   ALSO THIS IS NOT COMPATIBLE WITH ASSUMING ALL JOINTS HAVE 3 DOF <= FIX THIS
hand.palm.jointAxes = [ zeros(3,1) -ones(3,1) zeros(3,1) ];
hand.digits(1).jointAxes = [ zeros(2,1) -ones(2,1) zeros(2,1) ];
hand.digits(2).jointAxes = [ zeros(4,1) -ones(4,1) zeros(4,1) ];
hand.digits(3).jointAxes = [ zeros(4,1) -ones(4,1) zeros(4,1) ];
hand.digits(4).jointAxes = [ zeros(4,1) -ones(4,1) zeros(4,1) ];
hand.digits(5).jointAxes = [ zeros(4,1) -ones(4,1) zeros(4,1) ];

% define anthropomorphic equivelance, which DoF is associated with the joints
%             MCP (P)IP DIP
hand.joints = [ 1   2   0;  % Thumb
                1   3   4;  % Index
                1   3   4;  % Middle
                1   3   4;  % Ring
                1   3   4]; % Small

% Define the flag determining whether this is a right or left hand ( right == 1 | left == -1 )
hand.isRight = 1;

% Define flat ( or home ) posture configuration
%hand.qHome = {[0 0 0], [0 0 0], [0 0 0 0], [0 0 0 0], [0 0 0 0], [0 0 0 0]};
hand.qHome = {[0 0 0; 0 0 0], [0 0 0; 0 0 0], [0 0 0; 0 0 0; 0 0 0; 0 0 0], [0 0 0; 0 0 0; 0 0 0; 0 0 0], [0 0 0; 0 0 0; 0 0 0; 0 0 0], [0 0 0; 0 0 0; 0 0 0; 0 0 0]};

% Import contact meshes
% Palm main part (root)
[hand.palm.root.contactMesh.faces, hand.palm.root.contactMesh.vertices, hand.palm.root.contactMesh.normals] = stlread('\meshes\Palm.stl');
hand.palm.root.contactMesh.vertices = hand.palm.root.contactMesh.vertices / 39.375; % a mystery scale value
% Palm segments
[hand.palm.links(1).contactMesh.faces, hand.palm.links(1).contactMesh.vertices, hand.palm.links(1).contactMesh.normals] = stlread('\meshes\MC1.stl');
hand.palm.links(1).contactMesh.vertices = hand.palm.links(1).contactMesh.vertices / 39.375;
[hand.palm.links(2).contactMesh.faces, hand.palm.links(2).contactMesh.vertices, hand.palm.links(2).contactMesh.normals] = stlread('\meshes\MC5.stl');
hand.palm.links(2).contactMesh.vertices = hand.palm.links(2).contactMesh.vertices / 39.375;

% Digits
% Thumb
[hand.digits(1).links(1).contactMesh.faces, hand.digits(1).links(1).contactMesh.vertices, hand.digits(1).links(1).contactMesh.normals] = stlread('\meshes\PP1.stl');
hand.digits(1).links(1).contactMesh.vertices = hand.digits(1).links(1).contactMesh.vertices / 39.375;
[hand.digits(1).links(2).contactMesh.faces, hand.digits(1).links(2).contactMesh.vertices, hand.digits(1).links(2).contactMesh.normals] = stlread('\meshes\DP1.stl');
hand.digits(1).links(2).contactMesh.vertices = hand.digits(1).links(2).contactMesh.vertices / 39.375;
% Fingers
for i = 2:5
    % Fingers MCP joint is included as a link
    [hand.digits(i).links(1).contactMesh.faces, hand.digits(i).links(1).contactMesh.vertices, hand.digits(i).links(1).contactMesh.normals] = stlread('\meshes\MCP.stl');
    [hand.digits(i).links(2).contactMesh.faces, hand.digits(i).links(2).contactMesh.vertices, hand.digits(i).links(2).contactMesh.normals] = stlread('\meshes\PP.stl');
    [hand.digits(i).links(3).contactMesh.faces, hand.digits(i).links(3).contactMesh.vertices, hand.digits(i).links(3).contactMesh.normals] = stlread('\meshes\MP.stl');
    [hand.digits(i).links(4).contactMesh.faces, hand.digits(i).links(4).contactMesh.vertices, hand.digits(i).links(4).contactMesh.normals] = stlread('\meshes\DP.stl');
    hand.digits(i).links(1).contactMesh.vertices = hand.digits(i).links(1).contactMesh.vertices / 39.375;
    hand.digits(i).links(2).contactMesh.vertices = hand.digits(i).links(2).contactMesh.vertices / 39.375;
    hand.digits(i).links(3).contactMesh.vertices = hand.digits(i).links(3).contactMesh.vertices / 39.375;
    hand.digits(i).links(4).contactMesh.vertices = hand.digits(i).links(4).contactMesh.vertices / 39.375;
end

% STL files are not indexed meshes, use "patchslim" to unify replicated vertices
[hand.palm.root.contactMesh.vertices, hand.palm.root.contactMesh.faces] = patchslim(hand.palm.root.contactMesh.vertices, hand.palm.root.contactMesh.faces);
% Palm segments
for j = 1:2
    [hand.palm.links(j).contactMesh.vertices, hand.palm.links(j).contactMesh.faces] = patchslim(hand.palm.links(j).contactMesh.vertices, hand.palm.links(j).contactMesh.faces);
end
for i = 1:5 % loop through digits
    [~, m] = size(hand.digits(i).links); % get number of links in the digit
    for j = 1:m % loop through links
        [hand.digits(i).links(j).contactMesh.vertices, hand.digits(i).links(j).contactMesh.faces] = patchslim(hand.digits(i).links(j).contactMesh.vertices, hand.digits(i).links(j).contactMesh.faces);
    end
end

% Generate collision meshes; in this model, contact mesh is rigid plastic.
% Therefore we generate a sollision mesh that is only smaller than contact
% mesh by a small tollerance value
contactTollerance = 1;
% Palm root link
hand.palm.root.collisionMesh = smallerMesh( hand.palm.root.contactMesh, contactTollerance );
% Palm segments
for j = 1:2
    hand.palm.links(j).collisionMesh = smallerMesh( hand.palm.links(j).contactMesh, contactTollerance );
end
for i = 1:5 % loop through digits
    [~, m] = size(hand.digits(i).links); % get number of links in the digit
    for j = 1:m % loop through links
        hand.digits(i).links(j).collisionMesh = smallerMesh( hand.digits(i).links(j).contactMesh, contactTollerance );
    end
end

% Define contact types (contact model)
%   1 :: PCwF
%   2 :: HF
%   3 :: SF
% For InMoov hand, we assume palm and tips are covered with a silicon
% cover, thus we use SF model, but other links are not, so we use HF
hand.palm.root.contactType = 2;
for j = 1:2
    hand.palm.links(j).contactType = 2;
end
for i = 1:5 % loop through digits
    [~, m] = size(hand.digits(i).links); % get number of links in the digit
    for j = 1:m-1 % loop through links
        hand.digits(i).links(j).contactType = 2;
    end
    hand.digits(i).links(m).contactType = 3;
end


end