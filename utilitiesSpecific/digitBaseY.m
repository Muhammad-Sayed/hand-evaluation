function posY = digitBaseY( hand, digitNo )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Get position of base joint
if hand.digits(digitNo).base > 0
    pose = hand.palm.joints(:,:,hand.digits(digitNo).base) * hand.digits(digitNo).joints(:,:,1);
else
    pose = hand.digits(digitNo).joints(:,:,1);
end
posY = pose(2,4);

end

