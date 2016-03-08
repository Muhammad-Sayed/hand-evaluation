function longestDigit = longestDigitLength( hand )
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here

% This function only works with the hand models with contact mesh

%handPose = handPose2(hand, hand.qHome);

% Digits
[~, n] = size(hand.digits); % get number of digits, should be 4 or 5
length = zeros(n,1);
for i = 1:n % loop through digits
    [~, m] = size(hand.digits(i).links); % get number of links in the digit
    for j = 1:m
        length(i) = length(i) + max(hand.digits(i).links(j).contactMesh.vertices(:,1));
    end
end

longestDigit = max(length);

end