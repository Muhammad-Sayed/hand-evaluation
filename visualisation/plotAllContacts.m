function plotAllContacts( handPose, objectPose, length )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% This function only works with the hand models with collision and contact
% meshes. However the object does not have to have both
if isfield(objectPose, 'contactMesh') % Check if a contactMesh is present
    objectContactMesh = objectPose.contactMesh;
else
    objectContactMesh = objectPose;
end

contact = handObjectContact(handPose, objectContactMesh);

hold on;
R = 15;
N = 7;

% palm contact
if nnz(contact.flags.palm) ~= 0
    if contact.flags.palm(1)
        [ contactNormal, contactPoint ] = getContactNormal( contact.palm.root.intersect, handPose.palm.root.contactMesh, objectContactMesh );
        plotContactNormal( contactNormal, contactPoint, length );
        plotContactCone( R, N, length, contactNormal, contactPoint, 0.3, 'r' );
    end
    % Palm links
    if isfield(handPose.palm, 'links') % Check if there are movable parts in the palm
        [~, m] = size(handPose.palm.links); % get number of joints/links in the palm
        for i = 1:m
            if contact.flags.palm(i+1)
            [ contactNormal, contactPoint ] = getContactNormal( contact.palm.links(i).intersect, handPose.palm.links(i).contactMesh, objectContactMesh );
            plotContactNormal( contactNormal, contactPoint, length );
            plotContactCone( R, N, length, contactNormal, contactPoint, 0.3, 'r' );
            end
        end
    end
end

% Digits
[~, n] = size(handPose.digits); % get number of digits, should be 4 or 5
for i = 1:n % loop through digits
    if nnz(contact.flags.digits(i).links) ~= 0
        [~, m] = size(handPose.digits(i).links); % get number of links in the digit
        for j = 1:m
            if contact.flags.digits(i).links(j)
                [ contactNormal, contactPoint ] = getContactNormal( contact.digits(i).links(j).intersect, handPose.digits(i).links(j).contactMesh, objectContactMesh );
                plotContactNormal( contactNormal, contactPoint, length );
                plotContactCone( R, N, length, contactNormal, contactPoint, 0.3, 'r' );
            end
        end
    end
end

end

