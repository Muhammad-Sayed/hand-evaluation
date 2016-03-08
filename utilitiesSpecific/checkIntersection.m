function checkIntersection( intersection )

%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

segments.number = 0;

% Check if palm is in contact
[segments.palm, ~] = size(intersection.palm.surf.vertices);
if segments.palm > 0
    fprintf('Intersection on palm\n');
    segments.number = segments.number + 1;
else
    fprintf('NO intersection on palm\n');
end

[~, n] = size(intersection.digits); % get number of digits, should be 4 or 5
for i = 1:n % loop through digits
    [~, m] = size(intersection.digits(i).links); % get number of links in the digit
    for j = 1:m % loop through links
        % Check if link is in contact
        [segments.digits(i).links(j), ~] = size(intersection.digits(i).links(j).surf.vertices);
        if segments.digits(i).links(j) > 0
            fprintf('Intersection on Segment %d of Digit %d\n', j, i)
            segments.number = segments.number + 1;
        else
            fprintf('NO intersection on Segment %d of Digit %d\n', j, i)
        end
    end
end


end



