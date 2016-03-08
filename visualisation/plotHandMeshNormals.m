function plotHandMeshNormals(hand)

plotMeshNormals(hand.palm.mesh);
[~, n] = size(hand.digits); % get number of digits, should be 4 or 5
hold on;

for i = 1:n % loop through digits
    [~, m] = size(hand.digits(i).links); % get number of links in the digit
    for j = 1:m % loop through links
        % Plot link mesh
        plotMeshNormals(hand.digits(i).links(j).mesh);
    end
end

end