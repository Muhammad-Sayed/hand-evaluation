function contactScore = compareContacts( handContacts, contactReference )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

contactScore = 0;

% "reference" fields can have one of four values
%   0 : the segment should not be in contact
%   1 : the segment contact is irrelevant
%   2 : the segment contact is redundunt ( contact should be on at least one redundunt segment in the digit )
%   3 : the segment should be in contact
%
% "reference" has six row and two col, rows correspond to palm, thumb,
% index, middle, ring and small, col correspond to proximal and distal
% (for digit segments only, both col have same value for palm)
%
% "output" is average of all scores
%
% score is 0 if a contact occurs on a "no contact" segment or a contact is
% missing from segments that should be in contact
% score is 1 if "no contact" segments is not in contact or contact occurs
% where it should be

totalContacts = 11; % palm and two for each digit
score = zeros(6,2);

% check palm
if contactReference(1,1) == 0 % if should not be in contact
    if nnz(handContacts.flags.palm) == 0 % check if there is no contact on this segment
        score(1,1) = 1;
    end
elseif contactReference(1,1) == 1 % if irrelevant
    totalContacts = totalContacts - 1; % don't take into consideration
elseif contactReference(1,1) == 2 % if redundunt ( not applicable for palm, consider as "required" )
    if nnz(handContacts.flags.palm) > 0
        score(1,1) = 1;
    end
else % consider any other value as "required"
    if nnz(handContacts.flags.palm) > 0
        score(1,1) = 1;
    end
end

% check digits
% define redunduncy flag, used if redundunt requirements are met at first test
redunduncyFlag = false;
% get number of digits
[~,m] = size(handContacts.flags.digits);
for i = 1:m
    % get number of links in digit
    [~,n] = size(handContacts.flags.digits(i).links);
    % last linke is considered distal, all leading links are proximal
    % proximal link(s)
    if contactReference(i+1,1) == 0 % if proximal link(s) should not be in contact
        if nnz(handContacts.flags.digits(i).links(1:n-1)) == 0 % check if there is no contact on segment(s)
            score(i+1,1) = 1;
        end
    elseif contactReference(i+1,1) == 1 % if irrelevant
        totalContacts = totalContacts - 1; % don't take into consideration
    elseif contactReference(i+1,1) == 2 % if redundunt
        % avoid double counting of redundunt segments
        totalContacts = totalContacts - 1;
        if nnz(handContacts.flags.digits(i).links(1:n-1)) > 0
            score(i+1,1) = 1;
            % set redunduncy flag
            redunduncyFlag = true;
        end
    else % consider any other value as "required"
        if nnz(handContacts.flags.digits(i).links(1:n-1)) > 0
            score(i+1,1) = 1;
        end
    end
    % distal link
    if contactReference(i+1,2) == 0 % if proximal link(s) should not be in contact
        if handContacts.flags.digits(i).links(n) == 0 % check if there is no contact on segment(s)
            score(i+1,2) = 1;
        end
    elseif contactReference(i+1,2) == 1 % if irrelevant
        totalContacts = totalContacts - 1; % don't take into consideration
    elseif contactReference(i+1,2) == 2 % if redundunt
        if ~redunduncyFlag % make sure redunduncy not already satisfied
            if handContacts.flags.digits(i).links(n) == 1
                score(i+1,2) = 1;
            end
        end
    else % consider any other value as "required"
        if handContacts.flags.digits(i).links(n) == 1
            score(i+1,2) = 1;
        end
    end
    % reset redunduncy flag
    redunduncyFlag = false;
end
      
contactScore = sum(sum(score)) / totalContacts;

if isnan(contactScore)
    contactScore = 0;
end

end

