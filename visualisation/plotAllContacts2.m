function plotAllContacts2( contactPoints, contactNormals, length )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

hold on;
R = 15;
N = 7;

% Get number of contact points
%   contactPoints is a 4x4xn matrix, each 4x4 matrix is a homogenous
%   transform descriping the pose of contact i at the global frame
[~, ~, n] = size(contactPoints);

for i = 1:n;
    contactPoint = contactPoints(1:3,4,i)';
    contactNormal = contactNormals(i,:);
    plotContactNormal( contactNormal, contactPoint, length );
    plotContactCone( R, N, length, contactNormal, contactPoint, 0.3, 'g' );
end

end

