function plotBoxMesh( box )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

if box.flag ~= 0

    boxMesh.vertices = [    box.xMin box.yMin box.zMin;
                            box.xMax box.yMin box.zMin;
                            box.xMax box.yMax box.zMin;
                            box.xMin box.yMax box.zMin;
                            box.xMin box.yMin box.zMax;
                            box.xMax box.yMin box.zMax;
                            box.xMax box.yMax box.zMax;
                            box.xMin box.yMax box.zMax ];

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

    plot_mesh(boxMesh.vertices, boxMesh.faces);

end

end

