function fullMesh = allHandBonesOneMesh( hand )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here


C = 0;
for i = 1:5
    if i == 1
        m = 3;
    else
        m = 4;
    end
    for j = 1:m
        A = hand.digits(i).links(j).collisionMesh.vertices;
        B = hand.digits(i).links(j).collisionMesh.faces + (52*C);
        if C == 0
            fullMesh.vertices = A;
            fullMesh.faces = B;
        else
            if (i > 4) || ((i == 4) && (j>2))
                B = B - 1;
            end
            fullMesh.vertices = [ fullMesh.vertices; A ];
            fullMesh.faces = [ fullMesh.faces; B ];
        end
        C = C + 1;
    end
end

end

