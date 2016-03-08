function posX = digitBaseX( hand, digitNo )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Get position of base joint
if hand.digits(digitNo).base > 0
    pose = hand.palm.joints(:,:,hand.digits(digitNo).base) * hand.digits(digitNo).joints(:,:,1);
else
    pose = hand.digits(digitNo).joints(:,:,1);
end
posX = pose(1,4);

end

