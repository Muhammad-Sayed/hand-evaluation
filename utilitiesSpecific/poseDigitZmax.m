function Zmax = poseDigitZmax( handPose, digitNo )
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here

[~, m] = size(handPose.digits(digitNo).links); % get number of links in the digit
Zmax = max(handPose.digits(digitNo).links(1).contactMesh.vertices(:,3));
for j = 2:m % loop through links
    Zmax = max(Zmax,max(handPose.digits(digitNo).links(j).contactMesh.vertices(:,3)));
end


end