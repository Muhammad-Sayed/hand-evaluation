function  plotBox( box )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

if box ~= 0

    p1 = [box.xMin box.yMin box.zMin];
    p2 = [box.xMax box.yMin box.zMin];
    p3 = [box.xMax box.yMax box.zMin];
    p4 = [box.xMin box.yMax box.zMin];
    p5 = [box.xMin box.yMin box.zMax];
    p6 = [box.xMax box.yMin box.zMax];
    p7 = [box.xMax box.yMax box.zMax];
    p8 = [box.xMin box.yMax box.zMax];

    % draw the first face connecting points 1, 2, 3 and 4
    x = [p1(1) p2(1) p3(1) p4(1)];
    y = [p1(2) p2(2) p3(2) p4(2)];
    z = [p1(3) p2(3) p3(3) p4(3)];
    fill3(x, y, z, 1);

    hold on

    % draw the second face connecting points 5, 6, 7 and 8
    x = [p5(1) p6(1) p7(1) p8(1)];
    y = [p5(2) p6(2) p7(2) p8(2)];
    z = [p5(3) p6(3) p7(3) p8(3)];
    fill3(x, y, z, 2);

    % draw the third face connecting points 2, 6, 7 and 3
    x = [p2(1) p6(1) p7(1) p3(1)];
    y = [p2(2) p6(2) p7(2) p3(2)];
    z = [p2(3) p6(3) p7(3) p3(3)];
    fill3(x, y, z, 3);

    % draw the fourth face connecting points 2, 6, 5 and 1
    x = [p2(1) p6(1) p5(1) p1(1)];
    y = [p2(2) p6(2) p5(2) p1(2)];
    z = [p2(3) p6(3) p5(3) p1(3)];
    fill3(x, y, z, 4);

    % draw the fifth face connecting points 4, 8, 7 and 3
    x = [p4(1) p8(1) p7(1) p3(1)];
    y = [p4(2) p8(2) p7(2) p3(2)];
    z = [p4(3) p8(3) p7(3) p3(3)];
    fill3(x, y, z, 5);

    % draw the sixth face connecting points 4, 8, 5 and 1
    x = [p4(1) p8(1) p5(1) p1(1)];
    y = [p4(2) p8(2) p5(2) p1(2)];
    z = [p4(3) p8(3) p5(3) p1(3)];
    fill3(x, y, z, 6);

end

end

