function oppositionType = evaluateOpposition( handContacts )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

% Opposition can be 1) "palm", 2) "pad", 3) "side"
% If there is a contact with the palm, then opposition is "palm"
if nnz(handContacts.flags.palm) > 0
    oppositionType = 1;
    return
else
    % If there is a contact on the lateral side of index or middle fingers, then opposition is "side"
    for i = 2:3
        % Get number of links in finger
        [~,m] = size(handContacts.flags.digits(i).links);
        for j = 1:m
            if handContacts.direction.digits(i).links(j) == 2
                oppositionType = 3;
                return
            end
        end
    end
    % if we reached this point, then opposition is niether "palm" nor "side",
    % we assume it is "pad", not that this does not account for dorsal contact
    oppositionType = 2;
end


end

