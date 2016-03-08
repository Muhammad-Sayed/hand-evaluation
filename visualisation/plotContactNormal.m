function plotContactNormal( normal, point, length )
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here

mArrow3(point, point+(normal*length), 'color', 'y');

end

