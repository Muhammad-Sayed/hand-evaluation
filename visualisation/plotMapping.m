function plotMapping( hand )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


[~, n] = size(hand.digits); % get number of digits, should be 4 or 5

for i = 1:n
    % metacarpal vectors
    [~,metacarpalVector{i}] = tr2rt(hand.Td{i}(:,:,hand.joints(i,1)));
    mArrow3([0 0 0], metacarpalVector{i}, 'color', 'k');
    % proximal vectors
    [~,proximalVector{i}]   = tr2rt(hand.Td{i}(:,:,hand.joints(i,2)));
    mArrow3(metacarpalVector{i}, proximalVector{i}, 'color', 'r');
    if hand.joints(i,3) ~= 0 % Check if there is a DIP joint in this finger
        [~,middleVector{i}] = tr2rt(hand.Td{i}(:,:,hand.joints(i,3)));
        mArrow3(proximalVector{i}, middleVector{i}, 'color', 'r');
        [~,distalVector{i}] = tr2rt(hand.Td{i}(:,:,hand.joints(i,3)) * hand.digits(i).tip);
        mArrow3(middleVector{i}, distalVector{i}, 'color', 'r');
    else % If there is no DIP, get the position of the tip
        [~,distalVector{i}] = tr2rt(hand.Td{i}(:,:,hand.joints(i,2)) * hand.digits(i).tip);
        mArrow3(proximalVector{i}, distalVector{i}, 'color', 'r');
    end
end

for i = 1:n-1 % one plane between each two bones
    mArrow3(metacarpalVector{i}, metacarpalVector{i+1}, 'color', 'y');
end

end

