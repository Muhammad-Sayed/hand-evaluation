function [ contactPoints, contactNormals, handContacts ] = getContactPoints( handPose, objectPose )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% This function only works with the hand models with collision and contact
% meshes. However the object does not have to have both
if isfield(objectPose, 'contactMesh') % Check if a contactMesh is present
    objectContactMesh = objectPose.contactMesh;
else
    objectContactMesh = objectPose;
end

% Get contact between hand and object
handContacts = handObjectContact(handPose, objectContactMesh);

if handContacts.total == 0 % terminate if no contact
    contactPoints = false;
    contactNormals = false;
    return
end

% Preallocate a 4x4xn matrix to hold contact points' poses and nx3 matrix
% to hold contat normals
contactPoints = zeros(4,4,handContacts.total);
contactNormals = zeros(handContacts.total,3);

% Define a counter to track contact number
counter = 1;

% palm contact
if nnz(handContacts.flags.palm) ~= 0
    if handContacts.flags.palm(1)
        [ contactNormal, contactPoint ] = getContactNormal( handContacts.palm.root.intersect, handPose.palm.root.contactMesh, objectContactMesh );
        % Get angle-axis rotation between the contact normal and the z-axis
        angleOfRotation = acos(dot([0 0 1],contactNormal)/(norm([0 0 1])*norm(contactNormal)));
        axisOfRotation = cross([0 0 1],contactNormal);
        % Get rotation matrix for the angle-axis rotation
        rotation = angleAxis2rotationMatrix(angleOfRotation, axisOfRotation);
        % Calculate full transform
        contactPoints(:,:,counter) = [ rotation contactPoint' ; [0 0 0 1] ];
        % Store normal
        contactNormals(counter,:) = contactNormal;
        % Increment counter
        counter = counter + 1;
    end
    % Palm links
    if isfield(handPose.palm, 'links') % Check if there are movable parts in the palm
        [~, m] = size(handPose.palm.links); % get number of joints/links in the palm
        for i = 1:m
            if handContacts.flags.palm(i+1)
            [ contactNormal, contactPoint ] = getContactNormal( handContacts.palm.links(i).intersect, handPose.palm.links(i).contactMesh, objectContactMesh );
            % Get angle-axis rotation between the contact normal and the z-axis
            angleOfRotation = acos(dot([0 0 1],contactNormal)/(norm([0 0 1])*norm(contactNormal)));
            axisOfRotation = cross([0 0 1],contactNormal);
            % Get rotation matrix for the angle-axis rotation
            rotation = angleAxis2rotationMatrix(angleOfRotation, axisOfRotation);
            % Calculate full transform
            contactPoints(:,:,counter) = [ rotation contactPoint' ; [0 0 0 1] ];
            % Store normal
            contactNormals(counter,:) = contactNormal;
            % Increment counter
            counter = counter + 1;
            end
        end
    end
end

% Digits
[~, n] = size(handPose.digits); % get number of digits, should be 4 or 5
for i = 1:n % loop through digits
    if nnz(handContacts.flags.digits(i).links) ~= 0
        [~, m] = size(handPose.digits(i).links); % get number of links in the digit
        for j = 1:m
            if handContacts.flags.digits(i).links(j)
                [ contactNormal, contactPoint ] = getContactNormal( handContacts.digits(i).links(j).intersect, handPose.digits(i).links(j).contactMesh, objectContactMesh );
                % Get angle-axis rotation between the contact normal and the z-axis
                angleOfRotation = acos(dot([0 0 1],contactNormal)/(norm([0 0 1])*norm(contactNormal)));
                axisOfRotation = cross([0 0 1],contactNormal);
                % Get rotation matrix for the angle-axis rotation
                rotation = angleAxis2rotationMatrix(angleOfRotation, axisOfRotation);
                % Calculate full transform
                contactPoints(:,:,counter) = [ rotation contactPoint' ; [0 0 0 1] ];
                % Store normal
                contactNormals(counter,:) = contactNormal;
                % Increment counter
                counter = counter + 1;
            end
        end
    end
end

end

