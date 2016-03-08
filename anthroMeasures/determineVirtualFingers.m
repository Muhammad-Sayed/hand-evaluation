function [ VF1, VF2 ] = determineVirtualFingers( handContacts )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

% We determine potential Virtual Fingers solely through avilable contacts;
%   VF1; if palm is in contact, then VF1 is palm (0), else; if thumb is in
%   contat, then VF1 is thumb (1), else; if index is in contact, then VF1
%   is index (2), else; VF1 is invalid (-1)
%
%   VF2; if VF1 is palm or thumb, then VF2 is all fingers in contact, if
%   VF1 is index, then VF2 is all other fingers in contact, else, VF2 is
%   invalid (-1)
%
%   VF3: if VF1 is palm, VF3 can be thumb, however we do not implement this

if nnz(handContacts.flags.palm) > 0 % check if there is contact on palm
    VF1 = 0;
elseif nnz(handContacts.flags.digits(1).links) > 0
    VF1 = 1;
elseif nnz(handContacts.flags.digits(2).links) > 0
    VF1 = 2;
else
    VF1 = -1;
end

% VF2 can be any combination of up to 4 fingers, therefore we propose to
% use a 4 bit binary code to encode the fingers in contact
VF2 = [ 0 0 0 0 ]; % index, middle, ring, small
if (VF1 == 0) || (VF1 == 1) % check if palm or thumb are VF1
    [~, n] = size(handContacts.digits); % get number of digits, should be 4 or 5
    for i = 2:n % loop through fingers
        if nnz(handContacts.flags.digits(i).links) > 0
            VF2(i-1) = 1;
        end
    end
    VF2 = bi2de(VF2);
elseif VF1 == 2 % if the index is VF1, dont count it in VF2
    [~, n] = size(handContacts.digits); % get number of digits, should be 4 or 5
    for i = 3:n % loop through fingers
        if nnz(handContacts.flags.digits(i).links) > 0
            VF2(i-1) = 1;
        end
    end
    VF2 = bi2de(VF2);
else
    VF2 = -1;
end

end