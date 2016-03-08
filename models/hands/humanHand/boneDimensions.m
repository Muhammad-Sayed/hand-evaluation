% Load original bone{ meshes
meshes = load('matlab_mesh.mat');
% Scale the meshes ( m => mm )
meshes.bone{1}(1).vertices = meshes.bone1_1.vertices;
meshes.bone{1}(2).vertices = meshes.bone1_2.vertices;
meshes.bone{1}(3).vertices = meshes.bone1_3.vertices;
meshes.bone{2}(1).vertices = meshes.bone2_1.vertices;
meshes.bone{2}(2).vertices = meshes.bone2_2.vertices;
meshes.bone{2}(3).vertices = meshes.bone2_3.vertices;
meshes.bone{2}(4).vertices = meshes.bone2_4.vertices;
meshes.bone{3}(1).vertices = meshes.bone3_1.vertices;
meshes.bone{3}(2).vertices = meshes.bone3_2.vertices;
meshes.bone{3}(3).vertices = meshes.bone3_3.vertices;
meshes.bone{3}(4).vertices = meshes.bone3_4.vertices;
meshes.bone{4}(1).vertices = meshes.bone4_1.vertices;
meshes.bone{4}(2).vertices = meshes.bone4_2.vertices;
meshes.bone{4}(3).vertices = meshes.bone4_3.vertices;
meshes.bone{4}(4).vertices = meshes.bone4_4.vertices;
meshes.bone{5}(1).vertices = meshes.bone5_1.vertices;
meshes.bone{5}(2).vertices = meshes.bone5_2.vertices;
meshes.bone{5}(3).vertices = meshes.bone5_3.vertices;
meshes.bone{5}(4).vertices = meshes.bone5_4.vertices;

length  = { [zeros(3,1)], [zeros(4,1)], [zeros(4,1)], [zeros(4,1)], [zeros(4,1)] };
width   = { [zeros(3,1)], [zeros(4,1)], [zeros(4,1)], [zeros(4,1)], [zeros(4,1)] };
hight   = { [zeros(3,1)], [zeros(4,1)], [zeros(4,1)], [zeros(4,1)], [zeros(4,1)] };

for i = 1:5
    if i == 1
        m = 3;
    else
        m = 4;
    end
    for j = 1:m
        length{i}(j)= max(meshes.bone{i}(j).vertices(:,2)) - min(meshes.bone{i}(j).vertices(:,2));
        width{i}(j) = max(meshes.bone{i}(j).vertices(:,3)) - min(meshes.bone{i}(j).vertices(:,3));
        hight{i}(j) = max(meshes.bone{i}(j).vertices(:,1)) - min(meshes.bone{i}(j).vertices(:,1));
    end
end

clear i;
clear j;
clear m;