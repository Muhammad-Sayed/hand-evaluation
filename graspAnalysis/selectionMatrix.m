function H = selectionMatrix( contactTypes )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

% contactTypes valuse MUST be 1, 2, or 3
%   1 :: Point-contact-without-Friction (PwoF)
%   2 :: Hard-Finger (HF)
%   3 :: Soft-Finger (SF)
%
% The selection matrix is l*6n matrix, where l = total number of components
% transfered through all contacts ( for PwoF is 1, HF;3, SF;4) and n is the
% total number of contact points

% Get number of contacts of each type
%n_PwoF = length(find(contactTypes==1));
%n_HF = length(find(contactTypes==2));
%n_SF = length(find(contactTypes==3));
% Get total number of tranferable components
%l = n_PwoF + (3*n_HF) + (4*n_SF);
% Get total number of contacts
n = length(contactTypes);
% Preallocate l*6n matrix for H
%H = zeros(l, 6*n);

% Define the selection matrix for each type
H_PwoF =  [ 1 0 0 0 0 0 ];
H_HF =    [ 1 0 0 0 0 0 ;
            0 1 0 0 0 0 ;
            0 0 1 0 0 0 ];
H_SF =    [ 1 0 0 0 0 0 ;
            0 1 0 0 0 0 ;
            0 0 1 0 0 0 ;
            0 0 0 1 0 0 ];

% Generate selection matrix, THIS IS PROPABLY VERY INEFFICIENT
if contactTypes(1) == 1
    H = H_PwoF;
elseif contactTypes(1) == 2
    H = H_HF;
elseif contactTypes(1) == 3
    H = H_SF;
end

for i = 2:n
    if contactTypes(i) == 1
        H = blkdiag(H, H_PwoF);
    elseif contactTypes(i) == 2
        H = blkdiag(H, H_HF);
    elseif contactTypes(i) == 3
        H = blkdiag(H, H_SF);
    end
end

end

