function plotHumanHand( handPose, t, c )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%figure
hold on

for i = 1:5
    if i == 1
        m = 3;
    else
        m = 4;
    end
    for j = 1:m
        plotMesh( handPose.digits(i).links(j).collisionMesh, t, c );
    end
end

axis equal
axis tight

end

