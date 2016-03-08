function [ S ] = getS( C , O )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

%   S(r) = [    0   -r_z  r_y 
%               r_z  0   -r_x 
%              -r_y  r_x  0   ]

S = [   0               -(C(3)-O(3))    (C(2)-O(2)) ;
        (C(3)-O(3))     0               -(C(1)-O(1));
        -(C(2)-O(2))    (C(1)-O(1))     0           ];

end

