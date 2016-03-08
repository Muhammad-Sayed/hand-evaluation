function length = digitLength( hand, digitNo )
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here

% This function only works with the hand models with contact mesh
length = 0;
[~, m] = size(hand.digits(digitNo).links); % get number of links in the digit
for j = 1:m
    length = length + max(hand.digits(digitNo).links(j).contactMesh.vertices(:,1));
end

end