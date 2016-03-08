function plotHandMesh3(hand)

figure;
plot_mesh(hand.palm.mesh.vertices, hand.palm.mesh.faces);
[~, n] = size(hand.digits); % get number of digits, should be 4 or 5
hold on;

for i = 1:n % loop through digits
    [~, m] = size(hand.digits(i).links); % get number of links in the digit
    for j = 1:m % loop through links
        % Plot link mesh
        plot_mesh(hand.digits(i).links(j).mesh.vertices, hand.digits(i).links(j).mesh.faces);
    end
end

%axis auto;
%axis equal tight;
view([-90 90]);
%axis off;
end