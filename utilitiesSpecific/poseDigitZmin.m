function Zmin = poseDigitZmin( handPose, digitNo )
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here

[~, m] = size(handPose.digits(digitNo).links); % get number of links in the digit
Zmin = min(handPose.digits(digitNo).links(1).contactMesh.vertices(:,3));
for j = 2:m % loop through links
    Zmin = min(Zmin,min(handPose.digits(digitNo).links(j).contactMesh.vertices(:,3)));
end


end

