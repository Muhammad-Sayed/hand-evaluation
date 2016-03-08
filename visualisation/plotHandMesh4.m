function plotHandMesh4(hand,t,c)

%figure;
%plot_mesh(hand.palm.mesh.vertices, hand.palm.mesh.faces);
trisurf(hand.palm.mesh.faces, hand.palm.mesh.vertices(:,1),hand.palm.mesh.vertices(:,2),hand.palm.mesh.vertices(:,3),'FaceAlpha', t, 'FaceColor', c);
[~, n] = size(hand.digits); % get number of digits, should be 4 or 5
hold on;

for i = 1:n % loop through digits
    [~, m] = size(hand.digits(i).links); % get number of links in the digit
    for j = 1:m % loop through links
        % Plot link mesh
        %plot_mesh(hand.digits(i).links(j).mesh.vertices, hand.digits(i).links(j).mesh.faces);
        trisurf(hand.digits(i).links(j).mesh.faces, hand.digits(i).links(j).mesh.vertices(:,1),hand.digits(i).links(j).mesh.vertices(:,2),hand.digits(i).links(j).mesh.vertices(:,3),'FaceAlpha', t, 'FaceColor', c);
    end
end

axis auto;
axis equal;
%axis equal tight;
view([-90 90]);
axis off;
end