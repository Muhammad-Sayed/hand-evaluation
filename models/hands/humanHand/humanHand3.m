function hand = humanHand3()
% Returns a model of a huaman right hand
%
%   A hand model that describes the hand's kinematic parameters and
%   geometry (meshes of bones and skin)
%
%   Updates 01/03/2016  # made mostly compatible with robot hand modelling
%                           (except joints' frame orientaion)
%                       # added jointParent and links.parent variables
%
% Muhammad Sayed
% muhammad.b.h.sayed@gmail.com

% Define how many DoFs in the hand
hand.DoF = 24;

% Define the flag determining whether this is a right or left hand ( right == 1 | left == -1 )
hand.isRight = 1;

% Load original bone meshes
meshes = load('matlab_mesh.mat');% scaled from m (in source) to mm

% Load original model parameters #### NOT SCALED ####
% don't forget to scale pose ( m => mm ), also angles are in rads
% ##### ##### ##### ##### Palm  ##### ##### ##### ##### #####
T_CMC1a     = transl( 0.01950111*1000,  0.02695073*1000,  0.00443441*1000) * trotx( 2.48727972) * troty(-0.14754712) * trotz( 0.42888542);
T_CMC1b     = transl(-0.01737179*1000, -0.00971473*1000,  0.00000009*1000) * trotx(-1.38515604) * troty(-0.50255759) * trotz( 0.65691919);
T_MC1       = transl( 0.03354848*1000, -0.01248297*1000,  0.01216455*1000) * trotx(-2.86224591) * troty( 0.85165352) * trotz( 1.94658162);
T_IMC3      = transl( 0.00027300*1000,  0.01967667*1000, -0.00381503*1000) * trotx( 1.77115361) * troty(-0.08468856) * trotz( 0.10358527);
T_MC3       = transl(-0.00495342*1000, -0.00967755*1000,  0.01997446*1000) * trotx(-1.55662924) * troty( 0.07360124) * trotz( 0.02460249);
T_IMC4      = transl( 0.00060402*1000,  0.02840978*1000, -0.00801060*1000) * trotx( 1.27408673) * troty(-0.19279634) * trotz( 0.14286132);
T_MC4       = transl( 0.00303550*1000, -0.01287090*1000,  0.02243187*1000) * trotx(-1.14607211) * troty( 0.08117748) * trotz( 0.23798861);
T_IMC5      = transl( 0.00133314*1000,  0.02238944*1000, -0.00555069*1000) * trotx( 1.42155170) * troty(-0.03266849) * trotz( 0.02812425);
T_MC5       = transl( 0.00258619*1000, -0.01433440*1000,  0.01765157*1000) * trotx(-1.28525283) * troty( 0.01422445) * trotz( 0.05413693);

Troot       = transl( 50, 0, 0) * trotz(deg2rad(90)) * troty(deg2rad(-90));

% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
% ##### ##### ##### ##### Palm  ##### ##### ##### ##### #####
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
% CMC1a.parent_body = 'ground' ==> 'IMC3'
hand.palm.jointParent(2)            = 1;
hand.palm.joints(:,:,2)             = inv(T_IMC3)* T_CMC1a;
% CMC1b.parent_body = 'CMC1a';
hand.palm.jointParent(3)            = 2;
hand.palm.joints(:,:,3)             = T_CMC1b;
% MC1.parent_body = 'CMC1b';
hand.palm.links(1).pose             = T_MC1;
hand.palm.links(1).parent           = 3;
hand.palm.links(1).collisionMesh    = meshes.bone1_1;
% Apply link transform
T = hand.palm.links(1).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.palm.links(1).collisionMesh.vertices           = (h2e( T * e2h(hand.palm.links(1).collisionMesh.vertices.') ))';
hand.palm.links(1).collisionMesh.verticesNormals    = (h2e( R * e2h(hand.palm.links(1).collisionMesh.verticesNormals.') ))';
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
%MC2.parent_body = 'ground' ==> 'IMC3'
hand.palm.links(2).pose             = inv(T_IMC3);
hand.palm.links(2).parent           = 1;
hand.palm.links(2).collisionMesh    = meshes.bone2_1;
% Apply link transform
T = hand.palm.links(2).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.palm.links(2).collisionMesh.vertices           = (h2e( T * e2h(hand.palm.links(2).collisionMesh.vertices.') ))';
hand.palm.links(2).collisionMesh.verticesNormals    = (h2e( R * e2h(hand.palm.links(2).collisionMesh.verticesNormals.') ))';
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
%IMC3.parent_body = 'ground' ==> 'MC3' 
hand.palm.jointParent(1)            = 0;
hand.palm.joints(:,:,1)             = Troot * inv(T_MC3);
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
%MC3.parent_body = 'IMC3' ==> 'ground'
hand.palm.root.collisionMesh        = meshes.bone3_1;
% Apply link transform
T = Troot;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.palm.root.collisionMesh.vertices           = (h2e( T * e2h(hand.palm.root.collisionMesh.vertices.') ))';
hand.palm.root.collisionMesh.verticesNormals    = (h2e( R * e2h(hand.palm.root.collisionMesh.verticesNormals.') ))';
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
%IMC4.parent_body = 'MC3'
hand.palm.jointParent(4)            = 0;
hand.palm.joints(:,:,4)             = Troot * T_IMC4;
%MC4.parent_body = 'IMC4';
hand.palm.links(3).pose             = T_MC4;
hand.palm.links(3).parent           = 4;
hand.palm.links(3).collisionMesh    = meshes.bone4_1;
% Apply link transform
T = hand.palm.links(3).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.palm.links(3).collisionMesh.vertices           = (h2e( T * e2h(hand.palm.links(3).collisionMesh.vertices.') ))';
hand.palm.links(3).collisionMesh.verticesNormals    = (h2e( R * e2h(hand.palm.links(3).collisionMesh.verticesNormals.') ))';
%IMC5.parent_body = 'MC4';
hand.palm.jointParent(5)            = 4; % this is parent joint, but this joint is originally defined w.r.t MC4 bone segment
hand.palm.joints(:,:,5)             = hand.palm.links(3).pose * T_IMC5;
%MC5.parent_body = 'IMC5';
hand.palm.links(4).pose             = T_MC5;
hand.palm.links(4).parent           = 5;
hand.palm.links(4).collisionMesh    = meshes.bone5_1;
% Apply link transform
T = hand.palm.links(4).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.palm.links(4).collisionMesh.vertices           = (h2e( T * e2h(hand.palm.links(4).collisionMesh.vertices.') ))';
hand.palm.links(4).collisionMesh.verticesNormals    = (h2e( R * e2h(hand.palm.links(4).collisionMesh.verticesNormals.') ))';
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
% ##### ##### ##### ##### Thumb ##### ##### ##### ##### #####
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
%MCP1a.parent_body = 'MC1';
MCP1a.pose                              = [ 0.00137157  -0.01779916 -0.00084812 3.05390316  -0.00793818 0.18044569 ];
hand.digits(1).base                     = 3; % this is parent palm joint, but this joint is originally defined w.r.t MC1 bone segment
hand.digits(1).joints(:,:,1)            = hand.palm.links(1).pose * transl(MCP1a.pose(1) * 1000, MCP1a.pose(2) * 1000, MCP1a.pose(3) * 1000) * trotx(MCP1a.pose(4)) * troty(MCP1a.pose(5)) * trotz(MCP1a.pose(6));
%MCP1b.parent_body = 'MCP1a';
MCP1b.pose                              = [ 0.00000000  0.00000000  -0.00000000 1.57074835  -1.50023702 -1.40701890 ];
hand.digits(1).joints(:,:,2)            = transl(MCP1b.pose(1) * 1000,MCP1b.pose(2) * 1000,MCP1b.pose(3) * 1000) * trotx(MCP1b.pose(4)) * troty(MCP1b.pose(5)) * trotz(MCP1b.pose(6));
%PP1.parent_body = 'MCP1b';
PP1.pose                                = [ -0.00881935 -0.01471952 -0.01733277 1.57582205  1.03341365  -0.70904904 ];
hand.digits(1).links(1).pose            = transl(PP1.pose(1) * 1000,PP1.pose(2) * 1000,PP1.pose(3) * 1000) * trotx(PP1.pose(4)) * troty(PP1.pose(5)) * trotz(PP1.pose(6));
hand.digits(1).links(1).parent          = 2;
hand.digits(1).links(1).collisionMesh   = meshes.bone1_2;
% Apply link transform
T = hand.digits(1).links(1).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(1).links(1).collisionMesh.vertices           = (h2e( T * e2h(hand.digits(1).links(1).collisionMesh.vertices.') ))';
hand.digits(1).links(1).collisionMesh.verticesNormals    = (h2e( R * e2h(hand.digits(1).links(1).collisionMesh.verticesNormals.') ))';
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
%IP1.parent_body = 'PP1';
IP1.pose                                = [ 0.00191091  -0.01363910 0.00135957  3.12122280  -0.27341430 2.99378307 ];
hand.digits(1).joints(:,:,3)            = hand.digits(1).links(1).pose * transl(IP1.pose(1) * 1000,IP1.pose(2) * 1000,IP1.pose(3) * 1000) * trotx(IP1.pose(4)) * troty(IP1.pose(5)) * trotz(IP1.pose(6));
%PD1.parent_body = 'IP1';
PD1.pose                                = [ -0.00766590 -0.01410628 0.00128191  -3.09546303 -0.14637353 -2.76067713 ];
hand.digits(1).links(2).pose            = transl(PD1.pose(1) * 1000,PD1.pose(2) * 1000,PD1.pose(3) * 1000) * trotx(PD1.pose(4)) * troty(PD1.pose(5)) * trotz(PD1.pose(6));
hand.digits(1).links(2).parent          = 3;
hand.digits(1).links(2).collisionMesh   = meshes.bone1_3;
% Apply link transform
T = hand.digits(1).links(2).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(1).links(2).collisionMesh.vertices           = (h2e( T * e2h(hand.digits(1).links(2).collisionMesh.vertices.') ))';
hand.digits(1).links(2).collisionMesh.verticesNormals    = (h2e( R * e2h(hand.digits(1).links(2).collisionMesh.verticesNormals.') ))';
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
hand.digits(1).tip                      = hand.digits(1).links(2).pose * transl(0,-23.7250/2,0) * trotz(deg2rad(-90)) * trotx(deg2rad(-90));
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
% ##### ##### ##### ##### Index ##### ##### ##### ##### #####
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
%MCP2a.parent_body = 'MC2';
MCP2a.pose                              = [ 0.00112756  -0.02894003 -0.00258697 -2.97153179 0.17373322  1.59226478 ];
hand.digits(2).base                     = 1;
hand.digits(2).joints(:,:,1)            = inv(T_IMC3) * transl(MCP2a.pose(1) * 1000, MCP2a.pose(2) * 1000, MCP2a.pose(3) * 1000) * trotx(MCP2a.pose(4)) * troty(MCP2a.pose(5)) * trotz(MCP2a.pose(6));
%MCP2b.parent_body = 'MCP2a';
MCP2b.pose                              = [ 0.00000000  0.00000000  0.00000000  -1.57079550 -0.03952681 1.84401960 ];
hand.digits(2).joints(:,:,2)            = transl(MCP2b.pose(1) * 1000 ,MCP2b.pose(2) * 1000, MCP2b.pose(3) * 1000) * trotx(MCP2b.pose(4)) * troty(MCP2b.pose(5)) * trotz(MCP2b.pose(6));
%PP2.parent_body = 'MCP2b';
PP2.pose                                = [ -0.01266949 -0.01784861 -0.02001128 2.38942248  1.09476415  -1.49732892 ];
hand.digits(2).links(1).pose            = transl(PP2.pose(1) * 1000, PP2.pose(2) * 1000, PP2.pose(3) * 1000) * trotx(PP2.pose(4)) * troty(PP2.pose(5)) * trotz(PP2.pose(6));
hand.digits(2).links(1).parent          = 2;
hand.digits(2).links(1).collisionMesh   = meshes.bone2_2;
% Apply link transform
T = hand.digits(2).links(1).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(2).links(1).collisionMesh.vertices           = (h2e( T * e2h(hand.digits(2).links(1).collisionMesh.vertices.') ))';
hand.digits(2).links(1).collisionMesh.verticesNormals    = (h2e( R * e2h(hand.digits(2).links(1).collisionMesh.verticesNormals.') ))';
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
%PIP2.parent_body = 'PP2';
PIP2.pose                               = [ 0.00266634  -0.01770148 0.00149144  3.02407870  0.32603526  -2.45465167 ];
hand.digits(2).joints(:,:,3)            = hand.digits(2).links(1).pose * transl(PIP2.pose(1) * 1000,PIP2.pose(2) * 1000,PIP2.pose(3) * 1000) * trotx(PIP2.pose(4)) * troty(PIP2.pose(5)) * trotz(PIP2.pose(6));
%PM2.parent_body = 'PIP2';
PM2.pose                                = [ -0.01430452 -0.00863928 0.00285207  2.84756957  0.01994079  -2.10444362 ];
hand.digits(2).links(2).pose            = transl(PM2.pose(1) * 1000,PM2.pose(2) * 1000,PM2.pose(3) * 1000) * trotx(PM2.pose(4)) * troty(PM2.pose(5)) * trotz(PM2.pose(6));
hand.digits(2).links(2).parent          = 3;
hand.digits(2).links(2).collisionMesh   = meshes.bone2_3;
% Apply link transform
T = hand.digits(2).links(2).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(2).links(2).collisionMesh.vertices           = (h2e( T * e2h(hand.digits(2).links(2).collisionMesh.vertices.') ))';
hand.digits(2).links(2).collisionMesh.verticesNormals    = (h2e( R * e2h(hand.digits(2).links(2).collisionMesh.verticesNormals.') ))';
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
%DIP2.parent_body = 'PM2';
DIP2.pose                               = [ 0.00114957  -0.01167801 0.00171634  3.10919338  0.05910672  -2.13892284 ];
hand.digits(2).joints(:,:,4)            = hand.digits(2).links(2).pose * transl(DIP2.pose(1) * 1000,DIP2.pose(2) * 1000,DIP2.pose(3) * 1000) * trotx(DIP2.pose(4)) * troty(DIP2.pose(5)) * trotz(DIP2.pose(6));
%PD2.parent_body = 'DIP2';
PD2.pose                                = [ -0.01085286 -0.00165782 0.00180878  -3.12872874 -0.05112821 -1.84226152 ];
hand.digits(2).links(3).pose            = transl(PD2.pose(1) * 1000,PD2.pose(2) * 1000,PD2.pose(3) * 1000) * trotx(PD2.pose(4)) * troty(PD2.pose(5)) * trotz(PD2.pose(6));
hand.digits(2).links(3).parent          = 4;
hand.digits(2).links(3).collisionMesh   = meshes.bone2_4;
% Apply link transform
T = hand.digits(2).links(3).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(2).links(3).collisionMesh.vertices           = (h2e( T * e2h(hand.digits(2).links(3).collisionMesh.vertices.') ))';
hand.digits(2).links(3).collisionMesh.verticesNormals    = (h2e( R * e2h(hand.digits(2).links(3).collisionMesh.verticesNormals.') ))';
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
hand.digits(2).tip                      = hand.digits(2).links(3).pose * transl(0,-17.5810/2,0) * trotz(deg2rad(-90)) * trotx(deg2rad(-90));
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
% ##### ##### ##### ##### Middle #### ##### ##### ##### #####
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
%MCP3a.parent_body = 'MC3';
MCP3a.pose                              = [ 0.00248792  -0.02788517 0.00056535  -3.06481638 0.18119135  2.34161826 ];
hand.digits(3).base                     = 0;
hand.digits(3).joints(:,:,1)            = Troot * transl(MCP3a.pose(1) * 1000,MCP3a.pose(2) * 1000,MCP3a.pose(3) * 1000) * trotx(MCP3a.pose(4)) * troty(MCP3a.pose(5)) * trotz(MCP3a.pose(6));
%MCP3b.parent_body = 'MCP3a';
MCP3b.pose                              = [ 0.00000000  0.00000000  0.00000000  -1.57079566 0.73740682  1.70278058 ];
hand.digits(3).joints(:,:,2)            = transl(MCP3b.pose(1) * 1000,MCP3b.pose(2) * 1000,MCP3b.pose(3) * 1000) * trotx(MCP3b.pose(4)) * troty(MCP3b.pose(5)) * trotz(MCP3b.pose(6));
%PP3.parent_body = 'MCP3b';
PP3.pose                                = [ -0.00585579 -0.02263291 -0.02216632 2.83024779  1.38722461  -2.01567947 ];
hand.digits(3).links(1).pose            = transl(PP3.pose(1) * 1000,PP3.pose(2) * 1000,PP3.pose(3) * 1000) * trotx(PP3.pose(4)) * troty(PP3.pose(5)) * trotz(PP3.pose(6));
hand.digits(3).links(1).parent          = 2;
hand.digits(3).links(1).collisionMesh   = meshes.bone3_2;
% Apply link transform
T = hand.digits(3).links(1).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(3).links(1).collisionMesh.vertices           = (h2e( T * e2h(hand.digits(3).links(1).collisionMesh.vertices.') ))';
hand.digits(3).links(1).collisionMesh.verticesNormals    = (h2e( R * e2h(hand.digits(3).links(1).collisionMesh.verticesNormals.') ))';
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
%PIP3.parent_body = 'PP3';
PIP3.pose                               = [ 0.00297529  -0.01983706 0.00041341  -3.10128167 0.05160920  1.81548014 ];
hand.digits(3).joints(:,:,3)            = hand.digits(3).links(1).pose * transl(PIP3.pose(1) * 1000,PIP3.pose(2) * 1000,PIP3.pose(3) * 1000) * trotx(PIP3.pose(4)) * troty(PIP3.pose(5)) * trotz(PIP3.pose(6));
%PM3.parent_body = 'PIP3';
PM3.pose                                = [ 0.01280160  -0.01464960 0.00044222  -3.10704455 -0.03576496 2.41416195 ];
hand.digits(3).links(2).pose            = transl(PM3.pose(1) * 1000,PM3.pose(2) * 1000,PM3.pose(3) * 1000) * trotx(PM3.pose(4)) * troty(PM3.pose(5)) * trotz(PM3.pose(6));
hand.digits(3).links(2).parent          = 3;
hand.digits(3).links(2).collisionMesh   = meshes.bone3_3;
% Apply link transform
T = hand.digits(3).links(2).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(3).links(2).collisionMesh.vertices           = (h2e( T * e2h(hand.digits(3).links(2).collisionMesh.vertices.') ))';
hand.digits(3).links(2).collisionMesh.verticesNormals    = (h2e( R * e2h(hand.digits(3).links(2).collisionMesh.verticesNormals.') ))';
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
%DIP3.parent_body = 'PM3';
DIP3.pose                               = [ 0.00011917  -0.01368763 -0.00012773 -3.06294799 0.29509605  2.62405259 ];
hand.digits(3).joints(:,:,4)            = hand.digits(3).links(2).pose * transl(DIP3.pose(1) * 1000,DIP3.pose(2) * 1000,DIP3.pose(3) * 1000) * trotx(DIP3.pose(4)) * troty(DIP3.pose(5)) * trotz(DIP3.pose(6));
%PD3.parent_body = 'DIP3';
PD3.pose                                = [ 0.00232482  -0.01259866 0.00071799  3.05394581  -0.27222667 2.95387451 ];
hand.digits(3).links(3).pose            = transl(PD3.pose(1) * 1000,PD3.pose(2) * 1000,PD3.pose(3) * 1000) * trotx(PD3.pose(4)) * troty(PD3.pose(5)) * trotz(PD3.pose(6));
hand.digits(3).links(3).parent          = 4;
hand.digits(3).links(3).collisionMesh   = meshes.bone3_4;
% Apply link transform
T = hand.digits(3).links(3).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(3).links(3).collisionMesh.vertices           = (h2e( T * e2h(hand.digits(3).links(3).collisionMesh.vertices.') ))';
hand.digits(3).links(3).collisionMesh.verticesNormals    = (h2e( R * e2h(hand.digits(3).links(3).collisionMesh.verticesNormals.') ))';
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
hand.digits(3).tip                      = hand.digits(3).links(3).pose * transl(0,-19.6450/2,0) * trotz(deg2rad(-90)) * trotx(deg2rad(-90));
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
% ##### ##### ##### ##### Ring  ##### ##### ##### ##### #####
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
%MCP4a.parent_body = 'MC4';
MCP4a.pose                              = [ 0.00073153  -0.02481215 -0.00146137 -3.02998578 0.00639050  0.11427495 ];
hand.digits(4).base                     = 4; % this is parent palm joint, but this joint is originally defined w.r.t MC4 bone segment
hand.digits(4).joints(:,:,1)            = hand.palm.links(3).pose * transl(MCP4a.pose(1) * 1000,MCP4a.pose(2) * 1000,MCP4a.pose(3) * 1000) * trotx(MCP4a.pose(4)) * troty(MCP4a.pose(5)) * trotz(MCP4a.pose(6));
%MCP4b.parent_body = 'MCP4a';
MCP4b.pose                              = [ 0.00000000  0.00000000  0.00000000  1.57079839  -1.09804202 -0.88958452 ];
hand.digits(4).joints(:,:,2)            = transl(MCP4b.pose(1) * 1000,MCP4b.pose(2) * 1000,MCP4b.pose(3) * 1000) * trotx(MCP4b.pose(4)) * troty(MCP4b.pose(5)) * trotz(MCP4b.pose(6));
%PP4.parent_body = 'MCP4b';
PP4.pose                                = [ -0.00768566 -0.01508707 -0.02405368 1.46950823  1.04700602  -0.52205631 ];
hand.digits(4).links(1).pose            = transl(PP4.pose(1) * 1000,PP4.pose(2) * 1000,PP4.pose(3) * 1000) * trotx(PP4.pose(4)) * troty(PP4.pose(5)) * trotz(PP4.pose(6));
hand.digits(4).links(1).parent          = 2;
hand.digits(4).links(1).collisionMesh   = meshes.bone4_2;
% Apply link transform
T = hand.digits(4).links(1).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(4).links(1).collisionMesh.vertices           = (h2e( T * e2h(hand.digits(4).links(1).collisionMesh.vertices.') ))';
hand.digits(4).links(1).collisionMesh.verticesNormals    = (h2e( R * e2h(hand.digits(4).links(1).collisionMesh.verticesNormals.') ))';
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
%PIP4.parent_body = 'PP4';
PIP4.pose                               = [ 0.00013924  -0.01885876 -0.00029457 3.14059037  0.01510742  -3.00910220 ];
hand.digits(4).joints(:,:,3)            = hand.digits(4).links(1).pose * transl(PIP4.pose(1) * 1000,PIP4.pose(2) * 1000,PIP4.pose(3) * 1000) * trotx(PIP4.pose(4)) * troty(PIP4.pose(5)) * trotz(PIP4.pose(6));
%PM4.parent_body = 'PIP4';
PM4.pose                                = [ -0.01195950 -0.01470671 -0.00124534 -3.06599860 0.08018364  -2.41479747 ];
hand.digits(4).links(2).pose            = transl(PM4.pose(1) * 1000,PM4.pose(2) * 1000,PM4.pose(3) * 1000) * trotx(PM4.pose(4)) * troty(PM4.pose(5)) * trotz(PM4.pose(6));
hand.digits(4).links(2).parent          = 3;
hand.digits(4).links(2).collisionMesh   = meshes.bone4_3;
% Apply link transform
T = hand.digits(4).links(2).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(4).links(2).collisionMesh.vertices           = (h2e( T * e2h(hand.digits(4).links(2).collisionMesh.vertices.') ))';
hand.digits(4).links(2).collisionMesh.verticesNormals    = (h2e( R * e2h(hand.digits(4).links(2).collisionMesh.verticesNormals.') ))';
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
%DIP4.parent_body = 'PM4';
DIP4.pose                               = [ 0.00020388  -0.01304283 0.00054321  -3.13801870 -0.03828433 -2.95544903 ];
hand.digits(4).joints(:,:,4)            = hand.digits(4).links(2).pose * transl(DIP4.pose(1) * 1000,DIP4.pose(2) * 1000,DIP4.pose(3) * 1000) * trotx(DIP4.pose(4)) * troty(DIP4.pose(5)) * trotz(DIP4.pose(6));
%PD4.parent_body = 'DIP4';
PD4.pose                                = [ -0.00880145 -0.00893865 -0.00069371 -3.09415564 0.05304218  -2.43282788 ];
hand.digits(4).links(3).pose            = transl(PD4.pose(1) * 1000,PD4.pose(2) * 1000,PD4.pose(3) * 1000) * trotx(PD4.pose(4)) * troty(PD4.pose(5)) * trotz(PD4.pose(6));
hand.digits(4).links(3).parent          = 4;
hand.digits(4).links(3).collisionMesh   = meshes.bone4_4;
% Apply link transform
T = hand.digits(4).links(3).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(4).links(3).collisionMesh.vertices           = (h2e( T * e2h(hand.digits(4).links(3).collisionMesh.vertices.') ))';
hand.digits(4).links(3).collisionMesh.verticesNormals    = (h2e( R * e2h(hand.digits(4).links(3).collisionMesh.verticesNormals.') ))';
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
hand.digits(4).tip                      = hand.digits(4).links(3).pose * transl(0,-19.3350/2,0) * trotz(deg2rad(-90)) * trotx(deg2rad(-90));
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
% ##### ##### ##### ##### Small ##### ##### ##### ##### #####
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
%MCP5a.parent_body = 'MC5';
MCP5a.pose                              = [ 0.00175437  -0.02346684 0.00120119  -1.59299831 -1.08353920 -1.10326000 ];
hand.digits(5).base                     = 5; % this is parent palm joint, but this joint is originally defined w.r.t MC5 bone segment
hand.digits(5).joints(:,:,1)            = hand.palm.links(4).pose * transl(MCP5a.pose(1) * 1000,MCP5a.pose(2) * 1000,MCP5a.pose(3) * 1000) * trotx(MCP5a.pose(4)) * troty(MCP5a.pose(5)) * trotz(MCP5a.pose(6));
%MCP5b.parent_body = 'MCP5a';
MCP5b.pose                              = [ 0.00000000  0.00000000  0.00000000  -1.57079298 -1.17960216 1.84234675 ];
hand.digits(5).joints(:,:,2)            = transl(MCP5b.pose(1) * 1000,MCP5b.pose(2) * 1000,MCP5b.pose(3) * 1000) * trotx(MCP5b.pose(4)) * troty(MCP5b.pose(5)) * trotz(MCP5b.pose(6));
%PP5.parent_body = 'MCP5b';
PP5.pose                                = [ 0.01915435  0.01451382  -0.00058784 3.06603282  -0.02226447 0.98785062 ];
hand.digits(5).links(1).pose            = transl(PP5.pose(1) * 1000,PP5.pose(2) * 1000,PP5.pose(3) * 1000) * trotx(PP5.pose(4)) * troty(PP5.pose(5)) * trotz(PP5.pose(6));
hand.digits(5).links(1).parent          = 2;
hand.digits(5).links(1).collisionMesh   = meshes.bone5_2;
% Apply link transform
T = hand.digits(5).links(1).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(5).links(1).collisionMesh.vertices           = (h2e( T * e2h(hand.digits(5).links(1).collisionMesh.vertices.') ))';
hand.digits(5).links(1).collisionMesh.verticesNormals    = (h2e( R * e2h(hand.digits(5).links(1).collisionMesh.verticesNormals.') ))';
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
%PIP5.parent_body = 'PP5';
PIP5.pose                               = [ 0.00101144  -0.01550217 -0.00049949 -3.09076509 0.22127951  2.69171742 ];
hand.digits(5).joints(:,:,3)            = hand.digits(5).links(1).pose * transl(PIP5.pose(1) * 1000,PIP5.pose(2) * 1000,PIP5.pose(3) * 1000) * trotx(PIP5.pose(4)) * troty(PIP5.pose(5)) * trotz(PIP5.pose(6));
%PM5.parent_body = 'PIP5';
PM5.pose                                = [ 0.00633628  -0.01348262 -0.00081588 -3.08756063 -0.02893475 2.67523487 ];
hand.digits(5).links(2).pose            = transl(PM5.pose(1) * 1000,PM5.pose(2) * 1000,PM5.pose(3) * 1000) * trotx(PM5.pose(4)) * troty(PM5.pose(5)) * trotz(PM5.pose(6));
hand.digits(5).links(2).parent          = 3;
hand.digits(5).links(2).collisionMesh   = meshes.bone5_3;
% Apply link transform
T = hand.digits(5).links(2).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(5).links(2).collisionMesh.vertices           = (h2e( T * e2h(hand.digits(5).links(2).collisionMesh.vertices.') ))';
hand.digits(5).links(2).collisionMesh.verticesNormals    = (h2e( R * e2h(hand.digits(5).links(2).collisionMesh.verticesNormals.') ))';
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
%DIP5.parent_body = 'PM5';
DIP5.pose                               = [ 0.00018060  -0.01005921 -0.00268002 3.11811207  -0.07074845 2.50091568 ];
hand.digits(5).joints(:,:,4)            = hand.digits(5).links(2).pose * transl(DIP5.pose(1) * 1000,DIP5.pose(2) * 1000,DIP5.pose(3) * 1000) * trotx(DIP5.pose(4)) * troty(DIP5.pose(5)) * trotz(DIP5.pose(6));
%PD5.parent_body = 'DIP5';
PD5.pose                                = [ 0.00488881  -0.01017181 -0.00487303 -2.93711186 0.01507082  2.62733466 ];
hand.digits(5).links(3).pose            = transl(PD5.pose(1) * 1000,PD5.pose(2) * 1000,PD5.pose(3) * 1000) * trotx(PD5.pose(4)) * troty(PD5.pose(5)) * trotz(PD5.pose(6));
hand.digits(5).links(3).parent          = 4;
hand.digits(5).links(3).collisionMesh   = meshes.bone5_4;
% Apply link transform
T = hand.digits(5).links(3).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(5).links(3).collisionMesh.vertices           = (h2e( T * e2h(hand.digits(5).links(3).collisionMesh.vertices.') ))';
hand.digits(5).links(3).collisionMesh.verticesNormals    = (h2e( R * e2h(hand.digits(5).links(3).collisionMesh.verticesNormals.') ))';
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
hand.digits(5).tip                      = hand.digits(5).links(3).pose * transl(0,-17.3530/2,-6) * trotz(deg2rad(-90)) * trotx(deg2rad(-90));
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

% Add face normals to all meshes

hand.palm.root.collisionMesh.normals    = faceNormal(hand.palm.root.collisionMesh.vertices, hand.palm.root.collisionMesh.faces);
for j = 1:4
    hand.palm.links(j).collisionMesh.normals    = faceNormal(hand.palm.links(j).collisionMesh.vertices, hand.palm.links(j).collisionMesh.faces);
end
for i = 1:5
    if i == 1
        m = 2;
    else
        m = 3;
    end
    for j = 1:m
        hand.digits(i).links(j).collisionMesh.normals    = faceNormal(hand.digits(i).links(j).collisionMesh.vertices, hand.digits(i).links(j).collisionMesh.faces);
    end
end

% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

CMC1a.qHome = 0.03490659;   CMC1a.range = [ -0.92900000 0.27000000 ];
CMC1b.qHome = 0.18598837;   CMC1b.range = [ -0.67500000 0.18600000 ];
MCP1a.qHome = 0.64577182;   MCP1a.range = [ -0.36100000 1.25400000 ]; 
MCP1b.qHome = 0.10471976;   MCP1b.range = [ -0.39200000 0.79900000 ];
IP1.qHome   = 0.57595865;   IP1.range   = [ -0.79000000 1.00300000 ];

MCP2a.qHome = 0.85521133;   MCP2a.range = [ -0.55000000 1.37300000 ]; 
MCP2b.qHome = 0.31415927;   MCP2b.range = [ -0.32300000 0.87100000 ]; 
PIP2.qHome  = 0.40142573;   PIP2.range  = [ -1.63800000 0.54100000 ]; 
DIP2.qHome  = 0.31415927;   DIP2.range  = [ -1.06600000 1.12900000 ];

IMC3.qHome  = -0.06981317;  IMC3.range  = [ -0.07600000 0.27000000 ]; 
MCP3a.qHome = 0.73303829;   MCP3a.range = [ -0.69100000 1.36500000 ]; 
MCP3b.qHome = 0.26179939;   MCP3b.range = [ -0.36100000 0.37900000 ];
PIP3.qHome  = 0.57595865;   PIP3.range  = [ -1.41900000 0.80300000 ];
DIP3.qHome  = 0.33161256;   DIP3.range  = [ -1.20600000 0.69800000 ];

IMC4.qHome  = -0.06981317;  IMC4.range  = [ -0.08500000 0.27600000 ];
MCP4a.qHome = 0.41887902;   MCP4a.range = [ -1.05200000 1.18000000 ];
MCP4b.qHome = 0.10471976;   MCP4b.range = [ -0.47800000 0.29900000 ];
PIP4.qHome  = 0.62831853;   PIP4.range  = [ -1.37900000 0.90200000 ];
DIP4.qHome  = 0.57595865;   DIP4.range  = [ -0.96500000 0.98700000 ];

IMC5.qHome  = -0.26179939;  IMC5.range  = [ -0.26500000 0.13500000 ];
MCP5a.qHome = 0.10471976;   MCP5a.range = [ -0.65000000 0.30500000 ];
MCP5b.qHome = 0.29670597;   MCP5b.range = [ -1.47200000 1.21300000 ];
PIP5.qHome  = 0.00000000;   PIP5.range  = [ -1.84600000 0.25300000 ];
DIP5.qHome  = 0.08726646;   DIP5.range  = [ -1.43900000 0.36900000 ];

% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

hand.qHome  = { [CMC1a.qHome CMC1b.qHome IMC3.qHome IMC4.qHome IMC5.qHome],
                [MCP1a.qHome MCP1b.qHome IP1.qHome],
                [MCP2a.qHome MCP2b.qHome PIP2.qHome DIP2.qHome],
                [MCP3a.qHome MCP3b.qHome PIP3.qHome DIP3.qHome],
                [MCP4a.qHome MCP4b.qHome PIP4.qHome DIP4.qHome],
                [MCP5a.qHome MCP5b.qHome PIP5.qHome DIP5.qHome]};

% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

hand.qRange = { [CMC1a.range; CMC1b.range; IMC3.range; IMC4.range; IMC5.range],
                [MCP1a.range; MCP1b.range; IP1.range],
                [MCP2a.range; MCP2b.range; PIP2.range; DIP2.range], 
                [MCP3a.range; MCP3b.range; PIP3.range; DIP3.range],
                [MCP4a.range; MCP4b.range; PIP4.range; DIP4.range],
                [MCP5a.range; MCP5b.range; PIP5.range; DIP5.range]};

% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

%   All hand joints rotate about the local Z-axis
hand.palm.jointAxes         = [ zeros(5,1) zeros(5,1) ones(5,1) ];
hand.digits(1).jointAxes    = [ zeros(3,1) zeros(3,1) ones(3,1) ];
hand.digits(2).jointAxes    = [ zeros(4,1) zeros(4,1) ones(4,1) ];
hand.digits(3).jointAxes    = [ zeros(4,1) zeros(4,1) ones(4,1) ];
hand.digits(4).jointAxes    = [ zeros(4,1) zeros(4,1) ones(4,1) ];
hand.digits(5).jointAxes    = [ zeros(4,1) zeros(4,1) ones(4,1) ];

% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

% Apply initial transform

% ##### ##### ##### ##### Palm ##### ##### ##### ##### #####
% Calculate transform for all joints
hand.Tp = zeros(4,4,5); % preallocate variables
Rp = zeros(4,4,5);
for i = 1:5
    if hand.palm.jointParent(i) > 0
        n = hand.palm.jointParent(i);
        hand.Tp(:,:,i) = hand.Tp(:,:,n) * hand.palm.joints(:,:,i) * trotz(hand.qHome{1}(i));
    else
        hand.Tp(:,:,i) = hand.palm.joints(:,:,i) * trotz(hand.qHome{1}(i));
    end
    Rp(:,:,i) = [ hand.Tp(:,1:3,i) [0; 0; 0; 1] ];
end

% Apply transform to all links
for i = 1:4
    n = hand.palm.links(i).parent;
    hand.palm.links(i).collisionMesh.vertices           = (h2e( hand.Tp(:,:,n) * e2h(hand.palm.links(i).collisionMesh.vertices.') ))';
    hand.palm.links(i).collisionMesh.verticesNormals    = (h2e( Rp(:,:,n) * e2h(hand.palm.links(i).collisionMesh.verticesNormals.') ))';
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
    hand.Td{i}(:,:,j) = hand.Td{i}(:,:,j) * hand.digits(i).joints(:,:,j) * trotz(hand.qHome{i+1}(j));
    Rd{i}(:,:,j) = [ hand.Td{i}(:,1:3,j) [0; 0; 0; 1] ];
    % then loop through the remaining joints
    for j = 2:m
        hand.Td{i}(:,:,j) = hand.Td{i}(:,:,j-1) * hand.digits(i).joints(:,:,j) * trotz(hand.qHome{i+1}(j));
        Rd{i}(:,:,j) = [ hand.Td{i}(:,1:3,j) [0; 0; 0; 1] ];
    end
    % Apply transform to all links
    [~, m] = size(hand.digits(i).links); % get number of links in the digit
    for j = 1:m
        n = hand.digits(i).links(j).parent;
        hand.digits(i).links(j).collisionMesh.vertices          = (h2e( hand.Td{i}(:,:,n) * e2h(hand.digits(i).links(j).collisionMesh.vertices.') ))';
        hand.digits(i).links(j).collisionMesh.verticesNormals   = (h2e( Rd{i}(:,:,n) * e2h(hand.digits(i).links(j).collisionMesh.verticesNormals.') ))';
    end
end

% hand.Tt{1} = transl(23.7250/2,0,0) * hand.Td{1}(:,:,3) * hand.digits(1).links(2).pose * trotz(deg2rad(-90)) * trotx(deg2rad(-90));
% hand.Tt{2} = transl(17.5810/2,0,0) * hand.Td{2}(:,:,4) * hand.digits(2).links(3).pose * trotz(deg2rad(-90)) * trotx(deg2rad(-90));
% hand.Tt{3} = transl(19.6450/2,0,0) * hand.Td{3}(:,:,4) * hand.digits(3).links(3).pose * trotz(deg2rad(-90)) * trotx(deg2rad(-90));
% hand.Tt{4} = transl(19.3350/2,0,0) * hand.Td{4}(:,:,4) * hand.digits(4).links(3).pose * trotz(deg2rad(-90)) * trotx(deg2rad(-90));
% hand.Tt{5} = transl(17.3530/2,0,0) * hand.Td{5}(:,:,4) * hand.digits(5).links(3).pose * trotz(deg2rad(-90)) * trotx(deg2rad(-90));

% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

% Define anthropomorphic equivelance: which DoF is associated with a joint?
%             MCP (P)IP DIP
hand.joints = [ 1   3   0;  % Thumb
                1   3   4;  % Index
                1   3   4;  % Middle
                1   3   4;  % Ring
                1   3   4]; % Small

% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
% ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

% Convert qHome and qRange to degrees
for i = 1:6
    hand.qHome{i}   = rad2deg(hand.qHome{i});
    hand.qRange{i}  = rad2deg(hand.qRange{i});
end

% Store current configuration
hand.qCurrent = hand.qHome;

end

