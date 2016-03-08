function plotHandMesh6(hand,t,c)

%figure;
% Palm
if isfield(hand.palm.root, 'visualMesh') % Check if a visualMesh is present
    %plot_mesh(hand.palm.root.visualMesh.vertices, hand.palm.root.visualMesh.faces);
    %trisurf(hand.palm.root.visualMesh.faces, hand.palm.root.visualMesh.vertices(:,1),hand.palm.root.visualMesh.vertices(:,2),hand.palm.root.visualMesh.vertices(:,3),'FaceAlpha', t, 'FaceColor', c);
    plotMesh(hand.palm.root.visualMesh, t, c);
else % If no visualMesh, then plot collisionMesh instead
    %trisurf(hand.palm.root.collisionMesh.faces, hand.palm.root.collisionMesh.vertices(:,1),hand.palm.root.collisionMesh.vertices(:,2),hand.palm.root.collisionMesh.vertices(:,3),'FaceAlpha', t, 'FaceColor', c);
    plotMesh(hand.palm.root.collisionMesh, t, c);
end
hold on;
% Palm links
if isfield(hand.palm, 'links') % Check if there are moveable parts in the palm
    [~, m] = size(hand.palm.links); % get number of links in the palm
    for j = 1:m % loop through links
        if isfield(hand.palm.links(j), 'visualMesh') % Check if a visualMesh is present
            trisurf(hand.palm.links(j).visualMesh.faces, hand.palm.links(j).visualMesh.vertices(:,1),hand.palm.links(j).visualMesh.vertices(:,2),hand.palm.links(j).visualMesh.vertices(:,3),'FaceAlpha', t, 'FaceColor', c);
        else % If no visualMesh, then plot collisionMesh instead
            trisurf(hand.palm.links(j).collisionMesh.faces, hand.palm.links(j).collisionMesh.vertices(:,1),hand.palm.links(j).collisionMesh.vertices(:,2),hand.palm.links(j).collisionMesh.vertices(:,3),'FaceAlpha', t, 'FaceColor', c);
        end
    end
end
% Digits
[~, n] = size(hand.digits); % get number of digits, should be 4 or 5
for i = 1:n % loop through digits
    [~, m] = size(hand.digits(i).links); % get number of links in the digit
    for j = 1:m % loop through links
        % Plot link mesh
        %plot_mesh(hand.digits(i).links(j).mesh.vertices, hand.digits(i).links(j).mesh.faces);
        if isfield(hand.digits(i).links(j), 'visualMesh') % Check if a visualMesh is present
            trisurf(hand.digits(i).links(j).visualMesh.faces, hand.digits(i).links(j).visualMesh.vertices(:,1),hand.digits(i).links(j).visualMesh.vertices(:,2),hand.digits(i).links(j).visualMesh.vertices(:,3),'FaceAlpha', t, 'FaceColor', c);
        else % If no visualMesh, then plot collisionMesh instead
            trisurf(hand.digits(i).links(j).collisionMesh.faces, hand.digits(i).links(j).collisionMesh.vertices(:,1),hand.digits(i).links(j).collisionMesh.vertices(:,2),hand.digits(i).links(j).collisionMesh.vertices(:,3),'FaceAlpha', t, 'FaceColor', c);
        end
    end
end
hold off;
axis auto;
axis equal;
%axis equal tight;
view([-90 90]);
axis off;
end