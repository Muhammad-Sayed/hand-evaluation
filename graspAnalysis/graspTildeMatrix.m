function G = graspTildeMatrix( contactPoints, objectCoM )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%   Source:
%   D. Prattichizzo, J. Trinkle. Chapter 28 on Grasping. 
%   In Handbook on Robotics, B. Siciliano, O. Kathib (eds.), Pages 671-700, 2008.
%
%   ~G' = [ G_1'
%           ...
%           ...
%           G_n' ]   where n is number of contact points
%   
%   ~G_i' = barR_i' * P_i'   where; barR_i = [  R_i     0
%                                               0       R_i ]
%                                   P_i   = [   I       0
%                                               S(c_i-p) I]
%                           where;  c_i is position of contact point
%                                   p   is position of object CoM
%   S(r) = [    0   -r_z  r_y 
%               r_z  0   -r_x 
%              -r_y  r_x  0   ]

% Get number of contact points
%   contactPoints is a 4x4xn matrix, each 4x4 matrix is a homogenous
%   transform descriping the pose of contact i at the global frame
[~, ~, n] = size(contactPoints);

% G is a 6x(6*n) matrix, prealocate
G = zeros(6,(6*n));

% Get position of object CoM
O = objectCoM(1:3,4);
for i = 1:n
    % get position of contact point
    C = contactPoints(1:3,4,i);
    S = getS(C,O);
    %P = [   eye(3)  zeros(3);
    %        S       eye(3)  ];
    % get orintation of contact point
    R_i = contactPoints(1:3,1:3,i);
    %R = blkdiag(R_i,R_i);
    
    m1 = ((i-1)*6)+1;
    m2 = m1 + 5;
    
    %G(:,m1:m2) = R * P;
    G(:,m1:m2) = [  R_i     zeros(3);
                    S       R_i     ];
end


end

