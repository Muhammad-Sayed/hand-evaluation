function output = calculateUniformRange( range )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%delta = range(:,2) - range(:,1);
%transStepSize = max(delta(1:3))/min(delta(1:3));

tX = range(1,1):2.5:range(1,2);
tY = range(2,1):2.5:range(2,2);
tZ = range(3,1):0.5:range(3,2);
rX = range(4,1):2.5:range(4,2);
rY = range(5,1):2.5:range(5,2);
rZ = range(6,1):2.5:range(6,2);

output = setprod(tX, tY, tZ, rX, rY, rZ);

end

