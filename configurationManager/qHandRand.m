function q = qHandRand( hand )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

q = hand.qHome;

[m,~] = size(q);
for i = 1:m
    [~,n] = size(q{i});
    for j = 1:n
        q{i}(1,j) = randsample(hand.qRange{i}(j,1):hand.qRange{i}(j,2), 1);
    end
end

end

