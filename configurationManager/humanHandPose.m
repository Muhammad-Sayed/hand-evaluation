function hand = humanHandPose( hand, q )
% This function takes as input a hand model and a kinematic configruation
% and returns the hand in the new configuration

% Human hand model contains a bone (collision) mesh for each segment and a
% contineous skin (contact) mesh for the entire hand

% Unlike robot hand models, the human hand model's segments are already
% transformed to their location, to perform any transform (inc rotation),
% we must this take into consideration

% Bones

% We need to "remove" alignment transform, return the segment to origin,
% apply the rotation (about z-axis), return the segment to its new
% position, then reapply the alignment transform



% Remove the alignment transform
T = inv(hand.aT);
R = [ T(:,1:3) [0; 0; 0; 1] ];
for i = 1:5
    if i == 1
        m = 3;
    else
        m = 4;
    end
    for j = 1:m
        hand.digits(i).links(j).collisionMesh.vertices = (h2e( T * e2h(hand.digits(i).links(j).collisionMesh.vertices.') ))';
        hand.digits(i).links(j).collisionMesh.verticesNormals = (h2e( R * e2h(hand.digits(i).links(j).collisionMesh.verticesNormals.') ))';
    end
end

% Return segments to original pose

% Thumb
% MC
T = hand.digits(1).joints(:,:,1) * trotz(hand.qCurrent{1}(1)) * hand.digits(1).joints(:,:,2) * trotz(hand.qCurrent{1}(2)) * hand.digits(1).links(1).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(1).links(1).collisionMesh.vertices = (h2e( inv(T) * e2h(hand.digits(1).links(1).collisionMesh.vertices.') ))';
hand.digits(1).links(1).collisionMesh.verticesNormals = (h2e( inv(R) * e2h(hand.digits(1).links(1).collisionMesh.verticesNormals.') ))';
% PP
T = T * hand.digits(1).joints(:,:,3) * trotz(hand.qCurrent{1}(3)) * hand.digits(1).joints(:,:,4) * trotz(hand.qCurrent{1}(4)) * hand.digits(1).links(2).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(1).links(2).collisionMesh.vertices = (h2e( inv(T) * e2h(hand.digits(1).links(2).collisionMesh.vertices.') ))';
hand.digits(1).links(2).collisionMesh.verticesNormals = (h2e( inv(R) * e2h(hand.digits(1).links(2).collisionMesh.verticesNormals.') ))';
% DP
T = T * hand.digits(1).joints(:,:,5) * trotz(hand.qCurrent{1}(5)) * hand.digits(1).links(3).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(1).links(3).collisionMesh.vertices = (h2e( inv(T) * e2h(hand.digits(1).links(3).collisionMesh.vertices.') ))';
hand.digits(1).links(3).collisionMesh.verticesNormals = (h2e( inv(R) * e2h(hand.digits(1).links(3).collisionMesh.verticesNormals.') ))';

% Index finger
% MC
%   N/A
% PP
T = hand.digits(2).joints(:,:,1) * trotz(hand.qCurrent{2}(1)) * hand.digits(2).joints(:,:,2) * trotz(hand.qCurrent{2}(2)) * hand.digits(2).links(2).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(2).links(2).collisionMesh.vertices = (h2e( inv(T) * e2h(hand.digits(2).links(2).collisionMesh.vertices.') ))';
hand.digits(2).links(2).collisionMesh.verticesNormals = (h2e( inv(R) * e2h(hand.digits(2).links(2).collisionMesh.verticesNormals.') ))';
% MP
T = T * hand.digits(2).joints(:,:,3) * trotz(hand.qCurrent{2}(3)) * hand.digits(2).links(3).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(2).links(3).collisionMesh.vertices = (h2e( inv(T) * e2h(hand.digits(2).links(3).collisionMesh.vertices.') ))';
hand.digits(2).links(3).collisionMesh.verticesNormals = (h2e( inv(R) * e2h(hand.digits(2).links(3).collisionMesh.verticesNormals.') ))';
% DP
T = T * hand.digits(2).joints(:,:,4) * trotz(hand.qCurrent{2}(4)) * hand.digits(2).links(4).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(2).links(4).collisionMesh.vertices = (h2e( inv(T) * e2h(hand.digits(2).links(4).collisionMesh.vertices.') ))';
hand.digits(2).links(4).collisionMesh.verticesNormals = (h2e( inv(R) * e2h(hand.digits(2).links(4).collisionMesh.verticesNormals.') ))';

% Middle finger
% MC
Tm = hand.digits(3).joints(:,:,1) * trotz(hand.qCurrent{3}(1)) * hand.digits(3).links(1).pose;
R = [ Tm(:,1:3) [0; 0; 0; 1] ];
hand.digits(3).links(1).collisionMesh.vertices = (h2e( inv(Tm) * e2h(hand.digits(3).links(1).collisionMesh.vertices.') ))';
hand.digits(3).links(1).collisionMesh.verticesNormals = (h2e( inv(R) * e2h(hand.digits(3).links(1).collisionMesh.verticesNormals.') ))';
% PP
T = Tm * hand.digits(3).joints(:,:,2) * trotz(hand.qCurrent{3}(2)) * hand.digits(3).joints(:,:,3) * trotz(hand.qCurrent{3}(3)) * hand.digits(3).links(2).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(3).links(2).collisionMesh.vertices = (h2e( inv(T) * e2h(hand.digits(3).links(2).collisionMesh.vertices.') ))';
hand.digits(3).links(2).collisionMesh.verticesNormals = (h2e( inv(R) * e2h(hand.digits(3).links(2).collisionMesh.verticesNormals.') ))';
% MP
T = T * hand.digits(3).joints(:,:,4) * trotz(hand.qCurrent{3}(4)) * hand.digits(3).links(3).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(3).links(3).collisionMesh.vertices = (h2e( inv(T) * e2h(hand.digits(3).links(3).collisionMesh.vertices.') ))';
hand.digits(3).links(3).collisionMesh.verticesNormals = (h2e( inv(R) * e2h(hand.digits(3).links(3).collisionMesh.verticesNormals.') ))';
% DP
T = T * hand.digits(3).joints(:,:,5) * trotz(hand.qCurrent{3}(5)) * hand.digits(3).links(4).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(3).links(4).collisionMesh.vertices = (h2e( inv(T) * e2h(hand.digits(3).links(4).collisionMesh.vertices.') ))';
hand.digits(3).links(4).collisionMesh.verticesNormals = (h2e( inv(R) * e2h(hand.digits(3).links(4).collisionMesh.verticesNormals.') ))';

% Ring finger
% MC (IMC4 is affected by IMC3 and MC3)
Tr = Tm * hand.digits(4).joints(:,:,1) * trotz(hand.qCurrent{4}(1)) * hand.digits(4).links(1).pose;
R = [ Tr(:,1:3) [0; 0; 0; 1] ];
hand.digits(4).links(1).collisionMesh.vertices = (h2e( inv(Tr) * e2h(hand.digits(4).links(1).collisionMesh.vertices.') ))';
hand.digits(4).links(1).collisionMesh.verticesNormals = (h2e( inv(R) * e2h(hand.digits(4).links(1).collisionMesh.verticesNormals.') ))';
% PP
T = Tr * hand.digits(4).joints(:,:,2) * trotz(hand.qCurrent{4}(2)) * hand.digits(4).joints(:,:,3) * trotz(hand.qCurrent{4}(3)) * hand.digits(4).links(2).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(4).links(2).collisionMesh.vertices = (h2e( inv(T) * e2h(hand.digits(4).links(2).collisionMesh.vertices.') ))';
hand.digits(4).links(2).collisionMesh.verticesNormals = (h2e( inv(R) * e2h(hand.digits(4).links(2).collisionMesh.verticesNormals.') ))';
% MP
T = T * hand.digits(4).joints(:,:,4) * trotz(hand.qCurrent{4}(4)) * hand.digits(4).links(3).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(4).links(3).collisionMesh.vertices = (h2e( inv(T) * e2h(hand.digits(4).links(3).collisionMesh.vertices.') ))';
hand.digits(4).links(3).collisionMesh.verticesNormals = (h2e( inv(R) * e2h(hand.digits(4).links(3).collisionMesh.verticesNormals.') ))';
% DP
T = T * hand.digits(4).joints(:,:,5) * trotz(hand.qCurrent{4}(5)) * hand.digits(4).links(4).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(4).links(4).collisionMesh.vertices = (h2e( inv(T) * e2h(hand.digits(4).links(4).collisionMesh.vertices.') ))';
hand.digits(4).links(4).collisionMesh.verticesNormals = (h2e( inv(R) * e2h(hand.digits(4).links(4).collisionMesh.verticesNormals.') ))';

% Small finger
% MC (IMC5 is affected by IMC4 and MC4)
T = Tr * hand.digits(5).joints(:,:,1) * trotz(hand.qCurrent{5}(1)) * hand.digits(5).links(1).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(5).links(1).collisionMesh.vertices = (h2e( inv(T) * e2h(hand.digits(5).links(1).collisionMesh.vertices.') ))';
hand.digits(5).links(1).collisionMesh.verticesNormals = (h2e( inv(R) * e2h(hand.digits(5).links(1).collisionMesh.verticesNormals.') ))';
% PP
T = T * hand.digits(5).joints(:,:,2) * trotz(hand.qCurrent{5}(2)) * hand.digits(5).joints(:,:,3) * trotz(hand.qCurrent{5}(3)) * hand.digits(5).links(2).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(5).links(2).collisionMesh.vertices = (h2e( inv(T) * e2h(hand.digits(5).links(2).collisionMesh.vertices.') ))';
hand.digits(5).links(2).collisionMesh.verticesNormals = (h2e( inv(R) * e2h(hand.digits(5).links(2).collisionMesh.verticesNormals.') ))';
% MP
T = T * hand.digits(5).joints(:,:,4) * trotz(hand.qCurrent{5}(4)) * hand.digits(5).links(3).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(5).links(3).collisionMesh.vertices = (h2e( inv(T) * e2h(hand.digits(5).links(3).collisionMesh.vertices.') ))';
hand.digits(5).links(3).collisionMesh.verticesNormals = (h2e( inv(R) * e2h(hand.digits(5).links(3).collisionMesh.verticesNormals.') ))';
% DP
T = T * hand.digits(5).joints(:,:,5) * trotz(hand.qCurrent{5}(5)) * hand.digits(5).links(4).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(5).links(4).collisionMesh.vertices = (h2e( inv(T) * e2h(hand.digits(5).links(4).collisionMesh.vertices.') ))';
hand.digits(5).links(4).collisionMesh.verticesNormals = (h2e( inv(R) * e2h(hand.digits(5).links(4).collisionMesh.verticesNormals.') ))';

% Apply new transform

% Thumb
% MC
T = hand.digits(1).joints(:,:,1) * trotz(q{1}(1)) * hand.digits(1).joints(:,:,2) * trotz(q{1}(2)) * hand.digits(1).links(1).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(1).links(1).collisionMesh.vertices = (h2e( T * e2h(hand.digits(1).links(1).collisionMesh.vertices.') ))';
hand.digits(1).links(1).collisionMesh.verticesNormals = (h2e( R * e2h(hand.digits(1).links(1).collisionMesh.verticesNormals.') ))';
% PP
T = T * hand.digits(1).joints(:,:,3) * trotz(q{1}(3)) * hand.digits(1).joints(:,:,4) * trotz(q{1}(4)) * hand.digits(1).links(2).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(1).links(2).collisionMesh.vertices = (h2e( T * e2h(hand.digits(1).links(2).collisionMesh.vertices.') ))';
hand.digits(1).links(2).collisionMesh.verticesNormals = (h2e( R * e2h(hand.digits(1).links(2).collisionMesh.verticesNormals.') ))';
% DP
T = T * hand.digits(1).joints(:,:,5) * trotz(q{1}(5)) * hand.digits(1).links(3).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(1).links(3).collisionMesh.vertices = (h2e( T * e2h(hand.digits(1).links(3).collisionMesh.vertices.') ))';
hand.digits(1).links(3).collisionMesh.verticesNormals = (h2e( R * e2h(hand.digits(1).links(3).collisionMesh.verticesNormals.') ))';

% Index finger
% MC
%   N/A
% PP
T = hand.digits(2).joints(:,:,1) * trotz(q{2}(1)) * hand.digits(2).joints(:,:,2) * trotz(q{2}(2)) * hand.digits(2).links(2).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(2).links(2).collisionMesh.vertices = (h2e( T * e2h(hand.digits(2).links(2).collisionMesh.vertices.') ))';
hand.digits(2).links(2).collisionMesh.verticesNormals = (h2e( R * e2h(hand.digits(2).links(2).collisionMesh.verticesNormals.') ))';
% MP
T = T * hand.digits(2).joints(:,:,3) * trotz(q{2}(3)) * hand.digits(2).links(3).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(2).links(3).collisionMesh.vertices = (h2e( T * e2h(hand.digits(2).links(3).collisionMesh.vertices.') ))';
hand.digits(2).links(3).collisionMesh.verticesNormals = (h2e( R * e2h(hand.digits(2).links(3).collisionMesh.verticesNormals.') ))';
% DP
T = T * hand.digits(2).joints(:,:,4) * trotz(q{2}(4)) * hand.digits(2).links(4).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(2).links(4).collisionMesh.vertices = (h2e( T * e2h(hand.digits(2).links(4).collisionMesh.vertices.') ))';
hand.digits(2).links(4).collisionMesh.verticesNormals = (h2e( R * e2h(hand.digits(2).links(4).collisionMesh.verticesNormals.') ))';

% Middle finger
% MC
Tm = hand.digits(3).joints(:,:,1) * trotz(q{3}(1)) * hand.digits(3).links(1).pose;
R = [ Tm(:,1:3) [0; 0; 0; 1] ];
hand.digits(3).links(1).collisionMesh.vertices = (h2e( Tm * e2h(hand.digits(3).links(1).collisionMesh.vertices.') ))';
hand.digits(3).links(1).collisionMesh.verticesNormals = (h2e( R * e2h(hand.digits(3).links(1).collisionMesh.verticesNormals.') ))';
% PP
T = Tm * hand.digits(3).joints(:,:,2) * trotz(q{3}(2)) * hand.digits(3).joints(:,:,3) * trotz(q{3}(3)) * hand.digits(3).links(2).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(3).links(2).collisionMesh.vertices = (h2e( T * e2h(hand.digits(3).links(2).collisionMesh.vertices.') ))';
hand.digits(3).links(2).collisionMesh.verticesNormals = (h2e( R * e2h(hand.digits(3).links(2).collisionMesh.verticesNormals.') ))';
% MP
T = T * hand.digits(3).joints(:,:,4) * trotz(q{3}(4)) * hand.digits(3).links(3).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(3).links(3).collisionMesh.vertices = (h2e( T * e2h(hand.digits(3).links(3).collisionMesh.vertices.') ))';
hand.digits(3).links(3).collisionMesh.verticesNormals = (h2e( R * e2h(hand.digits(3).links(3).collisionMesh.verticesNormals.') ))';
% DP
T = T * hand.digits(3).joints(:,:,5) * trotz(q{3}(5)) * hand.digits(3).links(4).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(3).links(4).collisionMesh.vertices = (h2e( T * e2h(hand.digits(3).links(4).collisionMesh.vertices.') ))';
hand.digits(3).links(4).collisionMesh.verticesNormals = (h2e( R * e2h(hand.digits(3).links(4).collisionMesh.verticesNormals.') ))';

% Ring finger
% MC (IMC4 is affected by IMC3 and MC3)
Tr = Tm * hand.digits(4).joints(:,:,1) * trotz(q{4}(1)) * hand.digits(4).links(1).pose;
R = [ Tr(:,1:3) [0; 0; 0; 1] ];
hand.digits(4).links(1).collisionMesh.vertices = (h2e( Tr * e2h(hand.digits(4).links(1).collisionMesh.vertices.') ))';
hand.digits(4).links(1).collisionMesh.verticesNormals = (h2e( R * e2h(hand.digits(4).links(1).collisionMesh.verticesNormals.') ))';
% PP
T = Tr * hand.digits(4).joints(:,:,2) * trotz(q{4}(2)) * hand.digits(4).joints(:,:,3) * trotz(q{4}(3)) * hand.digits(4).links(2).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(4).links(2).collisionMesh.vertices = (h2e( T * e2h(hand.digits(4).links(2).collisionMesh.vertices.') ))';
hand.digits(4).links(2).collisionMesh.verticesNormals = (h2e( R * e2h(hand.digits(4).links(2).collisionMesh.verticesNormals.') ))';
% MP
T = T * hand.digits(4).joints(:,:,4) * trotz(q{4}(4)) * hand.digits(4).links(3).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(4).links(3).collisionMesh.vertices = (h2e( T * e2h(hand.digits(4).links(3).collisionMesh.vertices.') ))';
hand.digits(4).links(3).collisionMesh.verticesNormals = (h2e( R * e2h(hand.digits(4).links(3).collisionMesh.verticesNormals.') ))';
% DP
T = T * hand.digits(4).joints(:,:,5) * trotz(q{4}(5)) * hand.digits(4).links(4).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(4).links(4).collisionMesh.vertices = (h2e( T * e2h(hand.digits(4).links(4).collisionMesh.vertices.') ))';
hand.digits(4).links(4).collisionMesh.verticesNormals = (h2e( R * e2h(hand.digits(4).links(4).collisionMesh.verticesNormals.') ))';

% Small finger
% MC (IMC5 is affected by IMC4 and MC4)
T = Tr * hand.digits(5).joints(:,:,1) * trotz(q{5}(1)) * hand.digits(5).links(1).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(5).links(1).collisionMesh.vertices = (h2e( T * e2h(hand.digits(5).links(1).collisionMesh.vertices.') ))';
hand.digits(5).links(1).collisionMesh.verticesNormals = (h2e( R * e2h(hand.digits(5).links(1).collisionMesh.verticesNormals.') ))';
% PP
T = T * hand.digits(5).joints(:,:,2) * trotz(q{5}(2)) * hand.digits(5).joints(:,:,3) * trotz(q{5}(3)) * hand.digits(5).links(2).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(5).links(2).collisionMesh.vertices = (h2e( T * e2h(hand.digits(5).links(2).collisionMesh.vertices.') ))';
hand.digits(5).links(2).collisionMesh.verticesNormals = (h2e( R * e2h(hand.digits(5).links(2).collisionMesh.verticesNormals.') ))';
% MP
T = T * hand.digits(5).joints(:,:,4) * trotz(q{5}(4)) * hand.digits(5).links(3).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(5).links(3).collisionMesh.vertices = (h2e( T * e2h(hand.digits(5).links(3).collisionMesh.vertices.') ))';
hand.digits(5).links(3).collisionMesh.verticesNormals = (h2e( R * e2h(hand.digits(5).links(3).collisionMesh.verticesNormals.') ))';
% DP
T = T * hand.digits(5).joints(:,:,5) * trotz(q{5}(5)) * hand.digits(5).links(4).pose;
R = [ T(:,1:3) [0; 0; 0; 1] ];
hand.digits(5).links(4).collisionMesh.vertices = (h2e( T * e2h(hand.digits(5).links(4).collisionMesh.vertices.') ))';
hand.digits(5).links(4).collisionMesh.verticesNormals = (h2e( R * e2h(hand.digits(5).links(4).collisionMesh.verticesNormals.') ))';

% Apply alignment transform to bones
R = [ hand.aT(:,1:3) [0; 0; 0; 1] ];
for i = 1:5
    if i == 1
        m = 3;
    else
        m = 4;
    end
    for j = 1:m
        hand.digits(i).links(j).collisionMesh.vertices = (h2e( hand.aT * e2h(hand.digits(i).links(j).collisionMesh.vertices.') ))';
        hand.digits(i).links(j).collisionMesh.verticesNormals = (h2e( R * e2h(hand.digits(i).links(j).collisionMesh.verticesNormals.') ))';
    end
end


end

