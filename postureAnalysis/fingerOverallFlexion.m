function fingerStats = fingerOverallFlexion(finger)
% Evaluation of overall flexion stats of a finger
%
% Output "stats" contents ::
%   # Stage; a value to determine the overall extension/flexion of the finger
%       range = -2 => 6 (TODO allow easy difinition of different range)
%       -ve => hyper-extension, 0 => extended, +ve => flexion
%   FLAGS::
%   # IsUniform; indicates that all joints exsitib relatively similar flexion
%   # IsSharp; indicates that the finger is sharply flexed at part, N/A (0) if IsUniform
%   # IsProximal; indicates that the flexion of the finger is mainly at the
%   proximal joints, N/A (0) if IsUniform
%
%   # Compact; a compact form of all content; [Stage IsUniform IsSharp IsProximal]
%
% Muhammad Sayed
% muhammad.b.h.sayed@gmail.com
% June 16, 2015

% Set default values
fingerStats.Stage = 0;
fingerStats.IsUniform = 0;
fingerStats.IsSharp = 0;
fingerStats.IsProximal = 0;

a = finger.prox - finger.midd;
b = finger.midd - finger.dist;

if all([0<=a, a<=1, 0<=b, b<=1])
    fingerStats.IsUniform = 1;
    fingerStats.Stage = finger.prox;
end





fingerStats.Compact = [ fingerStats.Stage fingerStats.IsUniform fingerStats.IsSharp fingerStats.IsProximal ];