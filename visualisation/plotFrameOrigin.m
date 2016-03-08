function plotFrameOrigin( T, length )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

point   = T(1:3,4)';
normalX = (T(1:3,1:3) * [ 1 0 0 ]')';
normalY = (T(1:3,1:3) * [ 0 1 0 ]')';
normalZ = (T(1:3,1:3) * [ 0 0 1 ]')';


%(h2e( T(:,:,n) * e2h(hand.digits(i).links(j).collisionMesh.normals.') ))';

mArrow3(point, point+(normalX*length), 'color', 'r');
mArrow3(point, point+(normalY*length), 'color', 'g');
mArrow3(point, point+(normalZ*length), 'color', 'b');

end

