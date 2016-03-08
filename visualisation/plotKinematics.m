function plotKinematics( hand )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

hold on;

% Plot a frame at the origin
plotFrameOrigin( eye(4), 15 );

% Load a cylinder to be ploted at the joints
[cylinder.faces, cylinder.vertices, cylinder.normals] = stlread('cylinder.stl');
% Add verticesNormals ( to avoid errors from other codes )
cylinder.verticesNormals = vertexNormal(cylinder.vertices, cylinder.faces);


% ##### ##### ##### ##### Palm ##### ##### ##### ##### #####
if isfield(hand.palm, 'joints') % Check if there are movable parts in the palm
    [~, ~, m] = size(hand.palm.joints); % get number of joints in the palm
    for j = 1:m
        if hand.palm.jointParent(j) > 0
            n = hand.palm.jointParent(j);
            mArrow3(hand.Tp(1:3,4,n), hand.Tp(1:3,4,j), 'color', 'k');
        else
            mArrow3([0 0 0], hand.Tp(1:3,4,j), 'color', 'k');
        end
        % load a cylinder with its longtiudnal axis along joint axis and at the joint pose
        if hand.palm.jointAxes(j,1) ~= 0
            T = hand.Tp(:,:,j) * troty(deg2rad(90));
        elseif hand.palm.jointAxes(j,2) ~= 0
            T = hand.Tp(:,:,j) * trotx(deg2rad(90));
        else % longitudanal axis is already the cylinder z-axis
            T = hand.Tp(:,:,j);
        end 
        mesh = objectPose2(cylinder, T);
        % plot the cylinder 
        plotMesh( mesh, 1, 'b' );
    end
end

% ##### ##### ##### ##### Digits ##### ##### ##### ##### #####
[~, n] = size(hand.digits); % get number of digits, should be 4 or 5
for i = 1:n
    [~, ~, m] = size(hand.digits(i).joints); % get number of joints in the digit
    % The first joint
    j = 1;
    Tdo{i}(:,:,j) = hand.Td{i}(:,:,j);
    if hand.digits(i).base > 0
        n = hand.digits(i).base;
        mArrow3(hand.Tp(1:3,4,n), hand.Td{i}(1:3,4,j), 'color', 'k');
    else
        mArrow3([0 0 0], hand.Td{i}(1:3,4,j), 'color', 'k');
    end
    % load a cylinder with its longtiudnal axis along joint axis and at the joint pose
    T = hand.Td{i}(:,:,j) * trotx(hand.digits(i).jointAxes(j,2)*deg2rad(90)) * troty(hand.digits(i).jointAxes(j,1)*deg2rad(90));
    mesh = objectPose2(cylinder, T);
    % plot the cylinder 
    plotMesh( mesh, 1, 'b' );
    % The remaining joints
    for j = 2:m
        mArrow3(hand.Td{i}(1:3,4,j-1), hand.Td{i}(1:3,4,j), 'color', 'k');
        % load a cylinder with its longtiudnal axis along joint axis and at the joint pose
        if hand.digits(i).jointAxes(j,1) ~= 0
            T = hand.Td{i}(:,:,j) * troty(deg2rad(90));
        elseif hand.digits(i).jointAxes(j,2) ~= 0
            T = hand.Td{i}(:,:,j) * trotx(deg2rad(90));
        else % longitudanal axis is already the cylinder z-axis
            T = hand.Td{i}(:,:,j);
        end 
        mesh = objectPose2(cylinder, T);
        % plot the cylinder 
        plotMesh( mesh, 1, 'b' );
    end
    % The digit tip
    tip = hand.Td{i}(:,:,m) * hand.digits(i).tip;
    mArrow3(hand.Td{i}(1:3,4,m), tip(1:3,4), 'color', 'k');
    % plot a frame at the tip
    plotFrameOrigin( hand.Td{i}(:,:,m) * hand.digits(i).tip, 15 );
end


end

