function plotAllResults( hand, object, qHandBest, qObjectBest )
%UNTITLED17 Summary of this function goes here
%   Detailed explanation goes here

[n,~] = size(qHandBest);
for j = 1:n
    figure
    handPose = handPose2(hand, qHandBest(j,:));
    objectPose = objectPose2(object, qObjectBest(:,:,j));
    plotHandMesh5(handPose, 0.5, 'b');
    trisurf(objectPose.faces, objectPose.vertices(:,1),objectPose.vertices(:,2),objectPose.vertices(:,3),'FaceAlpha', 0.3, 'FaceColor', 'r');
    [ contactPoints, contactNormals, handContacts ] = getContactPoints( handPose, objectPose );
    plotAllContacts2( contactPoints, contactNormals, 30 );
    axis tight
end

end

