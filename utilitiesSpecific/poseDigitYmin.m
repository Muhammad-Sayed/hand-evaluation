function Ymin = poseDigitYmin( handPose, digitNo )
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here

[~, m] = size(handPose.digits(digitNo).links); % get number of links in the digit
Ymin = min(handPose.digits(digitNo).links(1).contactMesh.vertices(:,2));
for j = 2:m % loop through links
    Ymin = min(Ymin,min(handPose.digits(digitNo).links(j).contactMesh.vertices(:,2)));
end


end

