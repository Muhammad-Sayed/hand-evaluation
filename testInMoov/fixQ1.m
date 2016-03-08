function [ q_out ] = fixQ1( q_in )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% TEMP utility to convert q from the fromat
% q = [ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ];
% to
% q = {[0 0 0; 0 0 0; 0 0 0], [0 0 0; 0 0 0], [0 0 0; 0 0 0; 0 0 0], [0 0 0; 0 0 0; 0 0 0], [0 0 0; 0 0 0; 0 0 0], [0 0 0; 0 0 0; 0 0 0]};

% For right hand; q_out = -ve q_in
% also subsequent code expect degrees (this is ineffecient, because it will convert it back to rad)

q_out = {[0 -rad2deg(q_in(1)) 0; 0 -rad2deg(q_in(10)) 0; 0 -rad2deg(q_in(14)) 0],
        [0 -rad2deg(q_in(2)) 0; 0 -rad2deg(q_in(3)) 0],
        [0 -rad2deg(q_in(4)) 0; 0 -rad2deg(q_in(5)) 0; 0 -rad2deg(q_in(6)) 0],
        [0 -rad2deg(q_in(7)) 0; 0 -rad2deg(q_in(8)) 0; 0 -rad2deg(q_in(9)) 0],
        [0 -rad2deg(q_in(11)) 0; 0 -rad2deg(q_in(12)) 0; 0 -rad2deg(q_in(13)) 0],
        [0 -rad2deg(q_in(15)) 0; 0 -rad2deg(q_in(16)) 0; 0 -rad2deg(q_in(17)) 0]};


end

