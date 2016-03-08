function [ boxMesh ] = intersectionBoxMesh( mesh1, mesh2 )
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

boxMesh.vertices = [    xMin yMin zMin;
                        xMax yMin zMin;
                        xMax yMax zMin;
                        xMin yMax zMin;
                        xMin yMin zMax;
                        xMax yMin zMax;
                        xMax yMax zMax;
                        xMin yMax zMax ];

% draw the first face connecting points 1, 2, 3 and 4
% draw the second face connecting points 5, 6, 7 and 8
% draw the third face connecting points 2, 6, 7 and 3
% draw the fourth face connecting points 2, 6, 5 and 1
% draw the fifth face connecting points 4, 8, 7 and 3
% draw the sixth face connecting points 4, 8, 5 and 1
boxMesh.faces = [   1 2 3;
                    1 3 4;
                    5 6 7;
                    5 7 8;
                    2 6 7;
                    2 7 3;
                    2 5 1;
                    2 5 6;
                    4 7 8;
                    4 7 3;
                    4 5 1;
                    4 5 8 ];
                    



% if abs(x1_min) < abs(x2_min)
%     box.xMin = x1_min;
% else
%     box.xMin = x2_min;
% end
% 
% if abs(y1_min) < abs(y2_min)
%     box.yMin = y1_min;
% else
%     box.yMin = y2_min;
% end
% 
% if abs(z1_min) < abs(z2_min)
%     box.zMin = z1_min;
% else
%     box.zMin = z2_min;
% end
% 
% if abs(x1_max) < abs(x2_max)
%     box.xMax = x1_max;
% else
%     box.xMax = x2_max;
% end
% 
% if abs(y1_max) < abs(y2_max)
%     box.yMax = y1_max;
% else
%     box.yMax = y2_max;
% end
% 
% if abs(z1_max) < abs(z2_max)
%     box.zMax = z1_max;
% else
%     box.zMax = z2_max;
% end

end



