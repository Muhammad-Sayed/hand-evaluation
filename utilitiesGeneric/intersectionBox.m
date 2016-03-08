function [ box ] = intersectionBox( mesh1, mesh2 )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

x1_max = max(mesh1.vertices(:,1));
x1_min = min(mesh1.vertices(:,1));
y1_max = max(mesh1.vertices(:,2));
y1_min = min(mesh1.vertices(:,2));
z1_max = max(mesh1.vertices(:,3));
z1_min = min(mesh1.vertices(:,3));

x2_max = max(mesh2.vertices(:,1));
x2_min = min(mesh2.vertices(:,1));
y2_max = max(mesh2.vertices(:,2));
y2_min = min(mesh2.vertices(:,2));
z2_max = max(mesh2.vertices(:,3));
z2_min = min(mesh2.vertices(:,3));

xMax = min(x1_max, x2_max);
xMin = max(x1_min, x2_min);
yMax = min(y1_max, y2_max);
yMin = max(y1_min, y2_min);
zMax = min(z1_max, z2_max);
zMin = max(z1_min, z2_min);

% Check if any min value > mmx value => no itersection
if (xMin > xMax) || (yMin > yMax) || ( zMin > zMax )
    box.flag = 0;
else
    box.flag = 1;
    box.xMax = xMax;
    box.xMin = xMin;
    box.yMax = yMax;
    box.yMin = yMin;
    box.zMax = zMax;
    box.zMin = zMin;
end

end

