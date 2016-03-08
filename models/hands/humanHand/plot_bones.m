% scale the meshes
bone1_1.vertices = bone1_1.vertices * 1000;
bone1_2.vertices = bone1_2.vertices * 1000;
bone1_3.vertices = bone1_3.vertices * 1000;
bone2_1.vertices = bone2_1.vertices * 1000;
bone2_2.vertices = bone2_2.vertices * 1000;
bone2_3.vertices = bone2_3.vertices * 1000;
bone2_4.vertices = bone2_4.vertices * 1000;
bone3_1.vertices = bone3_1.vertices * 1000;
bone3_2.vertices = bone3_2.vertices * 1000;
bone3_3.vertices = bone3_3.vertices * 1000;
bone3_4.vertices = bone3_4.vertices * 1000;
bone4_1.vertices = bone4_1.vertices * 1000;
bone4_2.vertices = bone4_2.vertices * 1000;
bone4_3.vertices = bone4_3.vertices * 1000;
bone4_4.vertices = bone4_4.vertices * 1000;
bone5_1.vertices = bone5_1.vertices * 1000;
bone5_2.vertices = bone5_2.vertices * 1000;
bone5_3.vertices = bone5_3.vertices * 1000;
bone5_4.vertices = bone5_4.vertices * 1000;

% apply transforms to each bone
% thumb
% MC
T1 = transl(19.50111, 26.95073, 4.43441) * trotx(2.48727972) * troty(-0.14754712) * trotz(0.42888542+0.03490659);
T2 = transl(-17.37179, -9.71473, 0.00009) * trotx(-1.38515604) * troty(-0.50255759) * trotz(0.65691919+0.18598837);
T3 = transl(33.54848, -12.48297, 12.16455) * trotx(-2.86224591) * troty(0.85165352) * trotz(1.94658162);
T = T1 * T2 * T3;
R = [ T(:,1:3) [0; 0; 0; 1] ];
bone1_1.vertices = (h2e( T * e2h(bone1_1.vertices.') ))';
bone1_1.verticesNormals = (h2e( R * e2h(bone1_1.verticesNormals.') ))';
% PP
T1 = transl(1.37157, -17.79916, -0.84812) * trotx(3.05390316) * troty(-0.00793818) * trotz(0.18044569+0.64577182);
T2 = transl(0.00000, 0.00000, 0.00000) * trotx(1.57074835) * troty(-1.50023702) * trotz(-1.40701890+0.10471976);
T3 = transl(-8.81935, -14.71952, -17.33277) * trotx(1.57582205) * troty(1.03341365) * trotz(-0.70904904);
T = T * T1 * T2 * T3;
R = [ T(:,1:3) [0; 0; 0; 1] ];
bone1_2.vertices = (h2e( T * e2h(bone1_2.vertices.') ))';
bone1_2.verticesNormals = (h2e( R * e2h(bone1_2.verticesNormals.') ))';
% PP
T1 = transl(1.91091, -13.63910, 1.35957) * trotx(3.12122280) * troty(-0.27341430) * trotz(2.99378307+0.57595865);
T2 = transl(-7.66590, -14.10628, 1.28191) * trotx(-3.09546303) * troty(-0.14637353) * trotz(-2.76067713);
T = T * T1 * T2;
R = [ T(:,1:3) [0; 0; 0; 1] ];
bone1_3.vertices = (h2e( T * e2h(bone1_3.vertices.') ))';
bone1_3.verticesNormals = (h2e( R * e2h(bone1_3.verticesNormals.') ))';
% Index
% MC
%   N/A
% PP
T1 = transl(1.12756, -28.94003, -2.58697) * trotx(-2.97153179) * troty(0.173733222) * trotz(1.59226478+0.85521133);
T2 = transl(0.00000, 0.00000, 0.00000) * trotx(-1.57079550) * troty(-0.03952681) * trotz(1.84401960+0.31415927);
T3 = transl(-12.66949, -17.84861, -20.01128) * trotx(2.38942248) * troty(1.09476415) * trotz(-1.49732892);
T = T1 * T2 * T3;
R = [ T(:,1:3) [0; 0; 0; 1] ];
bone2_2.vertices = (h2e( T * e2h(bone2_2.vertices.') ))';
bone2_2.verticesNormals = (h2e( R * e2h(bone2_2.verticesNormals.') ))';
% MP
T1 = transl(2.66634, -17.70148, 1.49144) * trotx(3.02407870) * troty(0.32603526) * trotz(-2.45465167+0.40142573);
T2 = transl(-14.30452, -8.63928, 2.85207) * trotx(2.84756957) * troty(0.01994079) * trotz(-2.10444362);
T = T * T1 * T2;
R = [ T(:,1:3) [0; 0; 0; 1] ];
bone2_3.vertices = (h2e( T * e2h(bone2_3.vertices.') ))';
bone2_3.verticesNormals = (h2e( R * e2h(bone2_3.verticesNormals.') ))';
% DP
T1 = transl(1.14957, -11.67801, 1.71634) * trotx(3.109193380) * troty(0.05910672) * trotz(-2.13892284+0.31415927);
T2 = transl(-10.85286, -1.65782, 1.80878) * trotx(-3.12872874) * troty(-0.05112821) * trotz(-1.84226152);
T = T * T1 * T2;
R = [ T(:,1:3) [0; 0; 0; 1] ];
bone2_4.vertices = (h2e( T * e2h(bone2_4.vertices.') ))';
bone2_4.verticesNormals = (h2e( R * e2h(bone2_4.verticesNormals.') ))';







% plot
plotMesh( bone1_1, 0.4, 'b' );
hold on
axis equal
plotMesh( bone1_2, 0.4, 'b' );
plotMesh( bone1_3, 0.4, 'b' );
plotMesh( bone2_1, 0.4, 'b' );
plotMesh( bone2_2, 0.4, 'b' );
plotMesh( bone2_3, 0.4, 'b' );
plotMesh( bone2_4, 0.4, 'b' );

