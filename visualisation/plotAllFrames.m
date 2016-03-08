function plotAllFrames( hand )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Origin
plotFrameOrigin( eye(4), 15 );

% Palm
if isfield(hand.palm, 'joints') % Check if there are moveable parts in the palm
    [~, ~, m] = size(hand.palm.joints); % get number of links in the palm
    for j = 1:m % loop through links
        plotFrameOrigin( hand.Tp(:,:,j), 15 );
    end
end
% Digits
[~, n] = size(hand.digits); % get number of digits, should be 4 or 5
for i = 1:n % loop through digits
    [~, ~, m] = size(hand.digits(i).joints); % get number of links in the digit
    for j = 1:m % loop through links
        plotFrameOrigin( hand.Td{i}(:,:,j), 15 );
    end
    plotFrameOrigin( hand.Td{i}(:,:,m) * hand.digits(i).tip, 15 );
end

end

