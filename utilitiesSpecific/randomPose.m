function output = randomPose( range, varargin )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

% resT ( translation resolution ) and resR ( rotation resolution ) are
% constants to determine the sampling resolution, default is one
if isempty(varargin)
    resT = 1;
    resR = 1;
else
    resT = varargin{1};
    resR = varargin{2};
end

% range must be in the following format
% range = [ tXmin tXmax ;
%           tYmin tYmax ;
%           tZmin tZmax ;
%           rXmin rXmax ;
%           rYmin rYmax ;
%           rZmin rZmax ];
tXmin = range(1,1)/resT;
tXmax = range(1,2)/resT;
tYmin = range(2,1)/resT;
tYmax = range(2,2)/resT;
tZmin = range(3,1)/resT;
tZmax = range(3,2)/resT;

rXmin = range(4,1)/resR;
rXmax = range(4,2)/resR;
rYmin = range(5,1)/resR;
rYmax = range(5,2)/resR;
rZmin = range(6,1)/resR;
rZmax = range(6,2)/resR;

if ((tXmax - tXmin) > 0)
    tX = randsample(tXmin:tXmax,1)*resT;
else
    tX = 0;
end

if ((tYmax - tYmin) > 0)
    tY = randsample(tYmin:tYmax,1)*resT;
else
    tY = 0;
end

if ((tZmax - tZmin) > 0)
    tZ = randsample(tZmin:tZmax,1)*resT;
else
    tZ = 0;
end

if ((rXmax - rXmin) > 0)
    rX = randsample(rXmin:rXmax,1)*resR;
else
    rX = 0;
end

if ((rYmax - rYmin) > 0)
    rY = randsample(rYmin:rYmax,1)*resR;
else
    rY = 0;
end

if ((rZmax - rZmin) > 0)
    rZ = randsample(rZmin:rZmax,1)*resR;
else
    rZ = 0;
end

output = transl(tX,tY,tZ) * trotx(deg2rad(rX)) * troty(deg2rad(rY)) * trotz(deg2rad(rZ));

end