    function hand = InMoovRightHand()
% Returns a model of the InMoov hand
%
% Muhammad Sayed
% muhammad.b.h.sayed@gmail.com
% August 14, 2015

%if nargin < 1
  isRight = 1;      % Default, make right hand (LEFT HAND IS NOT YET IMPLEMENTED)
%end

% Define a transform from the base of the wrist to the base of each digit
%  link chain, add rotation about x to counter the toolbox's tendency to
%  place first joint's axis along the z-axis
hand.digitBase.Th = transl(41.17,0,0) * trotz(deg2rad(isRight*-93.9)) * transl(41.17,0,0) * trotx(deg2rad(-90));
hand.digitBase.In = transl(8,0,0) * trotz(deg2rad(isRight*-16.26)) * transl(97.46,0,0)  * trotz(deg2rad(isRight*10.72)) * trotx(deg2rad(-90));
hand.digitBase.Mi = transl(106.15,0,0) * trotx(deg2rad(-90));
hand.digitBase.Ri = transl(51.02,0,0) * trotz(deg2rad(isRight*52.64)) * transl(17.09,0,0) * trotx(deg2rad(-90));
hand.digitBase.Sm = transl(8,0,0) * trotz(deg2rad(isRight*48.45)) * transl(43.87,0,0) * trotx(deg2rad(-90));

% Dimension variables to avoid the bug with passing numbers to DHFactor
% Variable names must start with "L" to avoid DHFactor crashing
LTH1 = 8.24;
LTH2 = 24.49;
LTH3 = 35.68;
LTH4 = 32.55;

LIN1 = 36.10;
LIN2 = 24.15;
LIN3 = 30.69;

LMI1 = 38.67;
LMI2 = 25.92;
LMI3 = 32.86;

LRI1 = 18.37;
LRI2 = 24.70;
LRI3 = 34.04;
LRI4 = 22.97;
LRI5 = 29.13;

LSM1 = 15.77;
LSM2 = 37.61;
LSM3 = 30.92;
LSM4 = 20.82;
LSM5 = 26.19;


A(1) = Link([0 0        8.24    -1.571 ]);
A(2) = Link([0 0        0       1.571  0 deg2rad(isRight*40.35)]);
A(3) = Link([0 24.49    0       -1.571 0 deg2rad(isRight*75)]);
A(4) = Link([0 0        35.68   0      0 -1.571]);
A(5) = Link([0 0        32.55   1.571]);

thumb = SerialLink(A, 'name', 'Thumb');

%thumb = 'Ry(q1).Tx(LTH1).Rz(q2).Tx(LTH2).Rx(q3).Ry(q4).Tx(LTH3).Ry(q5).Tx(LTH4)';
%hand.digitsDH.Th= DHFactor(thumb);
%thumb = eval(hand.digitsDH.Th.command('Thumb'));
thumb.base = hand.digitBase.Th;
%thumb.links(2).offset = deg2rad(isRight*40.35);
%thumb.links(3).offset = deg2rad(isRight*-15);

index = 'Ry(q1).Tx(LIN1).Ry(q2).Tx(LIN2).Ry(q3).Tx(LIN3)';
hand.digitsDH.In = DHFactor(index);
index = eval(hand.digitsDH.In.command('Index'));
index.base = hand.digitBase.In;

middle = 'Ry(q1).Tx(LMI1).Ry(q2).Tx(LMI2).Ry(q3).Tx(LMI3)';
hand.digitsDH.Mi = DHFactor(middle);
middle = eval(hand.digitsDH.Mi.command('Middle'));
middle.base = hand.digitBase.Mi;

ring = 'Ry(q1).Tx(LRI1).Rz(q2).Tx(LRI2).Ry(q3).Tx(LRI3).Ry(q4).Tx(LRI4).Ry(q5).Tx(LRI5)';
hand.digitsDH.Ri = DHFactor(ring);
ring = eval(hand.digitsDH.Ri.command('Ring'));
ring.base = hand.digitBase.Ri;
ring.links(2).offset = deg2rad(isRight*-47.08);

small = 'Ry(q1).Tx(LSM1).Rz(q2).Tx(LSM2).Ry(q3).Tx(LSM3).Ry(q4).Tx(LSM4).Ry(q5).Tx(LSM5)';
hand.digitsDH.Sm = DHFactor(small);
small = eval(hand.digitsDH.Sm.command('Small'));
small.base = hand.digitBase.Sm;
small.links(2).offset = deg2rad(isRight*-34.71);

hand.digits = [thumb, index, middle, ring, small];

% define anthropomorphic equivelance, which DoF is associated with the joints
%             MCP (P)IP DIP
hand.joints = [ 4   5   0;  % Thumb
                1   2   3;  % Index
                1   2   3;  % Middle
                3   4   5;  % Ring
                3   4   5]; % Small

% Define the flag determining whether this is a right or left hand ( right == 1 | left == -1 )
hand.isRight = 1;

% Define flat ( or home ) posture configuration; THIS IS NOT OFFSET
hand.qHome = {[0 0 0 0 0], [0 0 0], [0 0 0], [0 0 0 0 0], [0 0 0 0 0]};

% ##### ##### ##### ##### ##### Import Mesh ##### ##### ##### ##### #####
% Palm
[hand.mesh.palm.faces, hand.mesh.palm.vertices, hand.mesh.palm.normals] = stlread('\meshes\r_hand_palm.stl');
% Thumb
[hand.mesh.digits(1).links(1).faces, hand.mesh.digits(1).links(1).vertices, hand.mesh.digits(1).links(1).normals] = stlread('\meshes\r_thumb_metacarpal.stl');
hand.mesh.digits(1).links(1).parentLink = 3;
[hand.mesh.digits(1).links(2).faces, hand.mesh.digits(1).links(2).vertices, hand.mesh.digits(1).links(2).normals] = stlread('\meshes\r_thumb_proximal.stl');
hand.mesh.digits(1).links(2).parentLink = 4;
[hand.mesh.digits(1).links(3).faces, hand.mesh.digits(1).links(3).vertices, hand.mesh.digits(1).links(3).normals] = stlread('\meshes\r_thumb_distal.stl');
hand.mesh.digits(1).links(3).parentLink = 5;
% Index finger
[hand.mesh.digits(2).links(1).faces, hand.mesh.digits(2).links(1).vertices, hand.mesh.digits(2).links(1).normals] = stlread('\meshes\index_proximal.stl');
hand.mesh.digits(2).links(1).parentLink = 1;
[hand.mesh.digits(2).links(2).faces, hand.mesh.digits(2).links(2).vertices, hand.mesh.digits(2).links(2).normals] = stlread('\meshes\index_intermediate.stl');
hand.mesh.digits(2).links(2).parentLink = 2;
[hand.mesh.digits(2).links(3).faces, hand.mesh.digits(2).links(3).vertices, hand.mesh.digits(2).links(3).normals] = stlread('\meshes\index_distal.stl');
hand.mesh.digits(2).links(3).parentLink = 3;
% Middle finger
[hand.mesh.digits(3).links(1).faces, hand.mesh.digits(3).links(1).vertices, hand.mesh.digits(3).links(1).normals] = stlread('\meshes\middle_proximal.stl');
hand.mesh.digits(3).links(1).parentLink = 1;
[hand.mesh.digits(3).links(2).faces, hand.mesh.digits(3).links(2).vertices, hand.mesh.digits(3).links(2).normals] = stlread('\meshes\middle_intermediate.stl');
hand.mesh.digits(3).links(2).parentLink = 2;
[hand.mesh.digits(3).links(3).faces, hand.mesh.digits(3).links(3).vertices, hand.mesh.digits(3).links(3).normals] = stlread('\meshes\middle_distal.stl');
hand.mesh.digits(3).links(3).parentLink = 3;
% Ring finger
[hand.mesh.digits(4).links(1).faces, hand.mesh.digits(4).links(1).vertices, hand.mesh.digits(4).links(1).normals] = stlread('\meshes\r_ring_metacarpal.stl');
hand.mesh.digits(4).links(1).parentLink = 1;
[hand.mesh.digits(4).links(2).faces, hand.mesh.digits(4).links(2).vertices, hand.mesh.digits(4).links(2).normals] = stlread('\meshes\ring_proximal.stl');
hand.mesh.digits(4).links(2).parentLink = 3;
[hand.mesh.digits(4).links(3).faces, hand.mesh.digits(4).links(3).vertices, hand.mesh.digits(4).links(3).normals] = stlread('\meshes\ring_intermediate.stl');
hand.mesh.digits(4).links(3).parentLink = 4;
[hand.mesh.digits(4).links(4).faces, hand.mesh.digits(4).links(4).vertices, hand.mesh.digits(4).links(4).normals] = stlread('\meshes\ring_distal.stl');
hand.mesh.digits(4).links(4).parentLink = 5;
% Small finger
[hand.mesh.digits(5).links(1).faces, hand.mesh.digits(5).links(1).vertices, hand.mesh.digits(5).links(1).normals] = stlread('\meshes\r_auriculaire_metacarpal.stl');
hand.mesh.digits(5).links(1).parentLink = 1;
[hand.mesh.digits(5).links(2).faces, hand.mesh.digits(5).links(2).vertices, hand.mesh.digits(5).links(2).normals] = stlread('\meshes\auriculaire_proximal.stl');
hand.mesh.digits(5).links(2).parentLink = 3;
[hand.mesh.digits(5).links(3).faces, hand.mesh.digits(5).links(3).vertices, hand.mesh.digits(5).links(3).normals] = stlread('\meshes\auriculaire_intermediate.stl');
hand.mesh.digits(5).links(3).parentLink = 4;
[hand.mesh.digits(5).links(4).faces, hand.mesh.digits(5).links(4).vertices, hand.mesh.digits(5).links(4).normals] = stlread('\meshes\auriculaire_distal.stl');
hand.mesh.digits(5).links(4).parentLink = 5;

















