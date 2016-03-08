function hand = InMoovRightHand2()
% Returns a model of the InMoov right hand
%
% Muhammad Sayed
% muhammad.b.h.sayed@gmail.com
% October 30, 2015

%if nargin < 1
  isRight = 1;      % Default, make right hand (LEFT HAND IS NOT YET IMPLEMENTED)
%end

% hand joints
hand.digits(1).joints(:,:,1)    = transl(38.6,-22.9,0) * trotx(0) * troty(0) * trotz(isRight*-1.639);
hand.digits(1).joints(:,:,2)    = transl(27.4,16.1,0) * trotz(0.704) * trotx(-0.26);
hand.digits(1).joints(:,:,3)    = transl(35.7,0,0) * trotx(0) * troty(0) * trotz(0);
%thumb.tip       = transl(32.55,0,0) * trotx(0) * troty(0) * trotz(0);

hand.digits(2).joints(:,:,1)    = transl(101,-26.25,0) * trotx(0) * troty(0) * trotz(-0.098);
hand.digits(2).joints(:,:,2)    = transl(36.1,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(2).joints(:,:,3)    = transl(24.2,0,0) * trotx(0) * troty(0) * trotz(0);
%index.tip       = transl(30.69,0,0) * trotx(0) * troty(0) * trotz(0);

hand.digits(3).joints(:,:,1)    = transl(105.2,1,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(3).joints(:,:,2)    = transl(38.7,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(3).joints(:,:,3)    = transl(25.9,0,0) * trotx(0) * troty(0) * trotz(0);
%middle.tip       = transl(32.86,0,0) * trotx(0) * troty(0) * trotz(0);

hand.digits(4).joints(:,:,1)    = transl(60.5,13.6,0) * trotz(isRight*0.919);
hand.digits(4).joints(:,:,2)    = transl(35.2,-18.1,0) * trotx(0) * troty(0) * trotz(-0.821);
hand.digits(4).joints(:,:,3)    = transl(34,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(4).joints(:,:,4)    = transl(23,0,0) * trotx(0) * troty(0) * trotz(0);
%ring.tip       = transl(29.13,0,0) * trotx(0) * troty(0) * trotz(0);

hand.digits(5).joints(:,:,1)    = transl(36.3,33.1,0) * trotz(isRight*0.846);
hand.digits(5).joints(:,:,2)    = transl(46.7,-21.5,0) * trotx(0) * troty(0) * trotz(-0.651);
hand.digits(5).joints(:,:,3)    = transl(30.9,0,0) * trotx(0) * troty(0) * trotz(0);
hand.digits(5).joints(:,:,4)    = transl(20.8,0,0) * trotx(0) * troty(0) * trotz(0);
%small.tip       = transl(26.19,0,0) * trotx(0) * troty(0) * trotz(0);

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
%hand.joints = [ 4   5   0;  % Thumb
%                1   2   3;  % Index
%                1   2   3;  % Middle
%                3   4   5;  % Ring
%                3   4   5]; % Small

% Define the flag determining whether this is a right or left hand ( right == 1 | left == -1 )
hand.isRight = 1;

% Define flat ( or home ) posture configuration
hand.qHome = {[0 0 0; 0 0 0; 0 0 0], [0 0 0; 0 0 0; 0 0 0], [0 0 0; 0 0 0; 0 0 0], [0 0 0; 0 0 0; 0 0 0; 0 0 0], [0 0 0; 0 0 0; 0 0 0; 0 0 0]};

% ##### ##### ##### ##### ##### Import Mesh ##### ##### ##### ##### #####
% Palm
[hand.palm.mesh.faces, hand.palm.mesh.vertices, hand.palm.mesh.normals] = stlread('\meshes\r_palm.stl');
% Thumb
[hand.digits(1).links(1).mesh.faces, hand.digits(1).links(1).mesh.vertices, hand.digits(1).links(1).mesh.normals] = stlread('\meshes\r_thumb_metacarpal_simple.stl');
[hand.digits(1).links(2).mesh.faces, hand.digits(1).links(2).mesh.vertices, hand.digits(1).links(2).mesh.normals] = stlread('\meshes\thumb_proximal_simple.stl');
[hand.digits(1).links(3).mesh.faces, hand.digits(1).links(3).mesh.vertices, hand.digits(1).links(3).mesh.normals] = stlread('\meshes\thumb_distal_simple.stl');
% Index finger
[hand.digits(2).links(1).mesh.faces, hand.digits(2).links(1).mesh.vertices, hand.digits(2).links(1).mesh.normals] = stlread('\meshes\index_proximal_simple.stl');
[hand.digits(2).links(2).mesh.faces, hand.digits(2).links(2).mesh.vertices, hand.digits(2).links(2).mesh.normals] = stlread('\meshes\index_intermediate_simple.stl');
[hand.digits(2).links(3).mesh.faces, hand.digits(2).links(3).mesh.vertices, hand.digits(2).links(3).mesh.normals] = stlread('\meshes\index_distal_simple.stl');
% Middle finger
[hand.digits(3).links(1).mesh.faces, hand.digits(3).links(1).mesh.vertices, hand.digits(3).links(1).mesh.normals] = stlread('\meshes\middle_proximal_simple.stl');
[hand.digits(3).links(2).mesh.faces, hand.digits(3).links(2).mesh.vertices, hand.digits(3).links(2).mesh.normals] = stlread('\meshes\middle_intermediate_simple.stl');
[hand.digits(3).links(3).mesh.faces, hand.digits(3).links(3).mesh.vertices, hand.digits(3).links(3).mesh.normals] = stlread('\meshes\middle_distal_simple.stl');
% Ring finger
[hand.digits(4).links(1).mesh.faces, hand.digits(4).links(1).mesh.vertices, hand.digits(4).links(1).mesh.normals] = stlread('\meshes\r_ring_metacarpal_simple.stl');
[hand.digits(4).links(2).mesh.faces, hand.digits(4).links(2).mesh.vertices, hand.digits(4).links(2).mesh.normals] = stlread('\meshes\ring_proximal_simple.stl');
[hand.digits(4).links(3).mesh.faces, hand.digits(4).links(3).mesh.vertices, hand.digits(4).links(3).mesh.normals] = stlread('\meshes\ring_intermediate_simple.stl');
[hand.digits(4).links(4).mesh.faces, hand.digits(4).links(4).mesh.vertices, hand.digits(4).links(4).mesh.normals] = stlread('\meshes\ring_distal_simple.stl');
% Small finger
[hand.digits(5).links(1).mesh.faces, hand.digits(5).links(1).mesh.vertices, hand.digits(5).links(1).mesh.normals] = stlread('\meshes\r_auriculaire_metacarpal_simple.stl');
[hand.digits(5).links(2).mesh.faces, hand.digits(5).links(2).mesh.vertices, hand.digits(5).links(2).mesh.normals] = stlread('\meshes\auriculaire_proximal_simple.stl');
[hand.digits(5).links(3).mesh.faces, hand.digits(5).links(3).mesh.vertices, hand.digits(5).links(3).mesh.normals] = stlread('\meshes\auriculaire_intermediate_simple.stl');
[hand.digits(5).links(4).mesh.faces, hand.digits(5).links(4).mesh.vertices, hand.digits(5).links(4).mesh.normals] = stlread('\meshes\auriculaire_distal_simple.stl');

% STL files are not indexed meshes, use "patchslim" to unify replicated vertices
[hand.palm.mesh.vertices, hand.palm.mesh.faces] = patchslim(hand.palm.mesh.vertices, hand.palm.mesh.faces);
for i = 1:5 % loop through digits
    [~, m] = size(hand.digits(i).links); % get number of links in the digit
    for j = 1:m % loop through links
        [hand.digits(i).links(j).mesh.vertices, hand.digits(i).links(j).mesh.faces] = patchslim(hand.digits(i).links(j).mesh.vertices, hand.digits(i).links(j).mesh.faces);
    end
end

% Apply initial transforms
% Thumb
%for i = 1:5 % loop through digits
%    [~, m] = size(hand.digits(i).links); % get number of links in the digit
%    T = eye(4); % a 4x4 identity matrix to store transforms
%    for j = 1:m % loop through links
%        T = T * hand.digits(i).joints(:,:,j);
%        hand.digits(i).links(j).mesh.vertices = (h2e( T * e2h(hand.digits(i).links(j).mesh.vertices.') ))';
%    end
%end

end

