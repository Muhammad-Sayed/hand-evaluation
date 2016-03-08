function [ R ] = angleAxis2rotationMatrix( theta, W )
%UNTITLED19 Summary of this function goes here
%   Detailed explanation goes here

% From Springer Handbook of Robotics:
%   Equivalent rotation matrices for angle-axis ?w:
%   R = [   w(x)*w(x)*(1?cos?)+cos?         w(x)*w(y)*(1?cos?)-w(z)*sin?    w(x)*w(z)*(1?cos?)+w(y)*sin? ;
%           w(x)*w(y)*(1?cos?)+w(z)*sin?    w(y)*w(y)*(1?cos?)+cos?         w(y)*w(z)*(1?cos?)-w(x)*sin? ;
%           w(x)*w(z)*(1?cos?)-w(y)*sin?    w(y)*w(z)*(1?cos?)+w(x)*sin?    w(z)*w(z)*(1?cos?)+cos?      ]


C = cos(theta);
V = 1 - C;
S = sin(theta);

R = [   (W(1)*W(1)*V)+(C)       (W(1)*W(2)*V)-(W(3)*S)  (W(1)*W(3)*V)+(W(2)*S)  ;
        (W(1)*W(2)*V)+(W(3)*S)  (W(2)*W(2)*V)+(C)       (W(2)*W(3)*V)-(W(1)*S)  ;
        (W(1)*W(3)*V)-(W(2)*S)  (W(2)*W(3)*V)+(W(1)*S)  (W(3)*W(3)*V)+(C)       ];

end

