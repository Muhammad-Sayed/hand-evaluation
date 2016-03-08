function Xmin = poseDigitXmin( handPose, digitNo )
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here

[~, m] = size(handPose.digits(digitNo).links); % get number of links in the digit
Xmin = min(handPose.digits(digitNo).links(1).contactMesh.vertices(:,1));
for j = 2:m % loop through links
    Xmin = min(Xmin,min(handPose.digits(digitNo).links(j).contactMesh.vertices(:,1)));
end


end

