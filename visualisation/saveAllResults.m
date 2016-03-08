function saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, graspNo )
%UNTITLED17 Summary of this function goes here
%   Detailed explanation goes here

[n,~] = size(qHandBest);
for j = 1:n
    h = figure;
    handPose = handPose2(hand, qHandBest(j,:));
    objectPose = objectPose2(object, qObjectBest(:,:,j));
    plotHandMesh5(handPose, 0.5, 'b');
    trisurf(objectPose.faces, objectPose.vertices(:,1),objectPose.vertices(:,2),objectPose.vertices(:,3),'FaceAlpha', 0.3, 'FaceColor', 'r');
    [ contactPoints, contactNormals, handContacts ] = getContactPoints( handPose, objectPose );
    plotAllContacts2( contactPoints, contactNormals, 30 );
    axis tight
    filename = sprintf('%.2d_%d.fig', graspNo, j);
    savefig(filename);
    filename = sprintf('%.2d_%d.jpg', graspNo, j);
    saveas(h,filename);
    close(h)
end
filename = sprintf('Qbest_%.2d.mat', graspNo);
save(filename,'Qbest')

end