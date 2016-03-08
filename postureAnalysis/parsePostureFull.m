function [ postureEnc ] = parsePostureFull( posture )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

postureEnc = [ 2 2 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 1 1 ]; % default posture; hand is open

remain = posture;

while true
    [str, remain] = strtok(remain, '.');
    if isempty(str),  break;  end
    postureEnc = parsePosturePart( str, postureEnc );
end

end

