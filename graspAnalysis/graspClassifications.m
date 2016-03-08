function output = graspClassifications( J, G )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

Redundant     = ~isempty(null(J));
Indeterminate = ~isempty(null(G'));
Graspable     = ~isempty(null(G));
Defective     = ~isempty(null(J'));
Hyperstatic   = ~isempty(null([null(J'), null(G)]));

output = [ Redundant Indeterminate Graspable Defective Hyperstatic ];

end

