function position = thumbPosition( handPose )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

% Thumb position can be 1) Adducted or 2) Abducted

% We define two conditions to determine if the thumb is Adducted;
%   first; the thumb distal link must lie completely to the radial side of
%   the palm
%   second; the thumb distal link must lie relatively in - or close to -
%   the same "plane" as the palm

% first; find the index of thumb distal link
[~, m] = size(handPose.digits(1).links); % get number of links in the digit

% For the first condition, we verifiy that thumb mesh verticies Ymax is
% less than palm Ymin ( for right hand ) OR thumb Ymin is more than palm
% Ymax ( for left hand )
if handPose.isRight
    if max(handPose.digits(1).links(m).contactMesh.vertices(:,2)) < min(handPose.palm.root.contactMesh.vertices(:,2))
        %condition1 = true;
        % For the second condition, we check if the difference between the
        % thumb mesh vertices Zmax and the palm Zmax is "relatively small",
        % we define "relatively small" as the thickness of the palm
        difference = max(handPose.digits(1).links(m).contactMesh.vertices(:,3)) - max(handPose.palm.root.contactMesh.vertices(:,3));
        margine = max(handPose.palm.root.contactMesh.vertices(:,3)) - min(handPose.palm.root.contactMesh.vertices(:,3));
        if difference <= margine
            position = 1; % thumb is considered "Adducted"
        else
            position = 2; % thumb is considered "Abducted"
        end
    else
        position = 2; % thumb is considered "Abducted"
    end
else % if hand is left
    if min(handPose.digits(1).links(m).contactMesh.vertices(:,2)) > max(handPose.palm.root.contactMesh.vertices(:,2))
        difference = max(handPose.digits(1).links(m).contactMesh.vertices(:,3)) - max(handPose.palm.root.contactMesh.vertices(:,3));
        margine = max(handPose.palm.root.contactMesh.vertices(:,3)) - min(handPose.palm.root.contactMesh.vertices(:,3));
        if difference <= margine
            position = 1; %
        else
            position = 2;
        end
    else
        position = 2;
    end
end


end

