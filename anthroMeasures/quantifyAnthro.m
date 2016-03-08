function Q = quantifyAnthro( handPose, handContacts, anthroReference )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here

Q = 0;

% Q = w1 * oppositionType + w2 * thumbPosition + w3 * VirtualFingers + w4 * contactScore

% Define weights, should sum to 1
w = [ 0.125 0.125 0.25 0.5 ];

oppositionType = evaluateOpposition( handContacts );
position = thumbPosition( handPose );
[ VF1, VF2 ] = determineVirtualFingers( handContacts );
contactScore = compareContacts( handContacts, anthroReference.contacts );

if oppositionType == anthroReference.oppositionType
    oppositionType = 1;
else
    oppositionType = 0;
end

if position == anthroReference.thumbPosition
    position = 1;
else
    position = 0;
end

if VF1 == anthroReference.VF1
    VirtualFingers = 0.5; % the second half is VF2
else
    VirtualFingers = 0;
end

if VF2 == anthroReference.VF2 % chech if VF2 is exactly what we need
    VirtualFingers = VirtualFingers + 0.5;
elseif VF2 >= 0
    %VirtualFingers = VirtualFingers;
    % VF2 is quantified through a one to one comparison of each finger,
    % score is computed as a full value for each correct finger in contact
    % minus a quarter value for each missing or extra contact divided by
    % twice the maximum possible +ve value ( thus maximum total is 0.5 )
    VirtualFingers = VirtualFingers + ( (nnz(de2bi(VF2,4) & de2bi(anthroReference.VF2,4)) - ( 0.25 * nnz(xor(de2bi(VF2,4), de2bi(anthroReference.VF2,4))))) / ( 2 * nnz(de2bi(anthroReference.VF2,4))) );
end

Q = (w(1) * oppositionType) + (w(2) * position) + (w(3) * VirtualFingers) + (w(4) * contactScore);

end

