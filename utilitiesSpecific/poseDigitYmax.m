function Ymax = poseDigitYmax( handPose, digitNo )
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here

[~, m] = size(handPose.digits(digitNo).links); % get number of links in the digit
Ymax = max(handPose.digits(digitNo).links(1).contactMesh.vertices(:,2));
for j = 2:m % loop through links
    Ymax = max(Ymax,max(handPose.digits(digitNo).links(j).contactMesh.vertices(:,2)));
end


end