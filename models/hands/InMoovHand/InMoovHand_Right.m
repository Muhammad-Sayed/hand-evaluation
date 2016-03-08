function hand = InMoovHand_Right()
% Returns a model of the InMoov right hand
%
%   A hand model describes the hand's kinematic and dynamic parameters as
%   well as its surface geometry and physical properties
%
% Muhammad Sayed
% muhammad.b.h.sayed@gmail.com

%if nargin < 1
  isRight = 1;      % Default, make right hand (LEFT HAND IS NOT YET IMPLEMENTED)
%end

% define how many joints (DoFs) in the hand
hand.DoF = 17;

% hand joints
hand.palm.joints(:,:,1)    = transl(38.6,-22.9,0) * trotx(0) * troty(0) * trotz(isRight*-1.639);
hand.palm.joints(:,:,2)    = transl(60.5,13.6,0) * trotz(isRight*0.919);
hand.palm.joints(:,:,3)    = transl(36.3,33.1,0) * trotz(isRight*0.846);

hand.palm.chains = 3; % Variable to store the number of serial link chains in the palm

hand.digits(1).base = 1;
hand.digits(1).joints(:,:,1)    = transl(27.4,16.1,0) * trotz(0.704) * trotx(-0.26);
hand.digits(1).joints(:,:,2)    = transl(35.7,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(1).tip       = transl(32.55,0,0) * trotx(0) * troty(0) * trotz(0);

hand.digits(2).base = 0;
hand.digits(2).joints(:,:,1)    = transl(101,-26.25,0) * trotx(0) * troty(0) * trotz(-0.098);
hand.digits(2).joints(:,:,2)    = transl(36.1,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(2).joints(:,:,3)    = transl(24.2,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(2).tip       = transl(30.69,0,0) * trotx(0) * troty(0) * trotz(0);

hand.digits(3).base = 0;
hand.digits(3).joints(:,:,1)    = transl(105.2,1,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(3).joints(:,:,2)    = transl(38.7,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(3).joints(:,:,3)    = transl(25.9,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(3).tip       = transl(32.86,0,0) * trotx(0) * troty(0) * trotz(0);

hand.digits(4).base = 2;
hand.digits(4).joints(:,:,1)    = transl(35.2,-18.1,0) * trotx(0) * troty(0) * trotz(-0.821);
hand.digits(4).joints(:,:,2)    = transl(34,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(4).joints(:,:,3)    = transl(23,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(4).tip       = transl(29.13,0,0) * trotx(0) * troty(0) * trotz(0);

hand.digits(5).base = 3;
hand.digits(5).joints(:,:,1)    = transl(46.7,-21.5,0) * trotx(0) * troty(0) * trotz(-0.651);
hand.digits(5).joints(:,:,2)    = transl(30.9,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(5).joints(:,:,3)    = transl(20.8,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(5).tip       = transl(26.19,0,0) * trotx(0) * troty(0) * trotz(0);

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

% Define the flag determining whether this is a right or left hand ( right == 1 | left == -1 )
hand.isRight = 1;

% Define open ( or home ) posture configuration
hand.qHome = {[0 0 0; 0 0 0; 0 0 0], [0 0 0; 0 0 0], [0 0 0; 0 0 0; 0 0 0], [0 0 0; 0 0 0; 0 0 0], [0 0 0; 0 0 0; 0 0 0], [0 0 0; 0 0 0; 0 0 0]};

% Import contact meshes
% Palm main part (root)
[hand.palm.root.contactMesh.faces, hand.palm.root.contactMesh.vertices, hand.palm.root.contactMesh.normals] = stlread('\meshes\contact_0_0.stl');
% Palm segments
for j = 1:3
    [hand.palm.links(j).contactMesh.faces, hand.palm.links(j).contactMesh.vertices, hand.palm.links(j).contactMesh.normals] = stlread(sprintf('\\meshes\\contact_0_%d.stl', j));
end
% Digits
for i = 1:5
    if i == 1   % For the thumb
        n = 2;
    else        % For all fingers
        n = 3;
    end
    
    for j = 1:n
        [hand.digits(i).links(j).contactMesh.faces, hand.digits(i).links(j).contactMesh.vertices, hand.digits(i).links(j).contactMesh.normals] = stlread(sprintf('\\meshes\\contact_%d_%d.stl', i, j));
    end
end

% STL files are not indexed meshes, use "patchslim" to unify replicated vertices
[hand.palm.root.contactMesh.vertices, hand.palm.root.contactMesh.faces] = patchslim(hand.palm.root.contactMesh.vertices, hand.palm.root.contactMesh.faces);
% Palm segments
for j = 1:3
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
for j = 1:3
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


end