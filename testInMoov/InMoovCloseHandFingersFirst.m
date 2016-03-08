function [ q, TimeOutFlag ] = InMoovCloseHandFingersFirst( hand, object, TimeOut )
%UNTITLED7 Summary of this function goes here
%   Close all digits until making contact with object
%   
%   Each digit of the InMoov hand is actuated by a single actuator atached
%   at the distal segment. Ideally, all segments of each digit move
%   together. When a proximal segment is opposed by an external force, the
%   segment is fixed while the remaining segments move together.
%
%   To close the hand, we begin by moving all segments together until one
%   segment makes contact, then we fix all proximal segments up to the
%   segment in contact and continue moving the remaining segments until the
%   distal segment makes contact with the object.
%
%   Due to computational efficiency issues, we also need to take into
%   consideration the resolution of descritizing the configuration space of
%   each digit. Therefore, we begin by a corse resolution. This may lead to
%   a configuration giving no contact followed by a configuration causing
%   collision. In this case, we return to the last "no contact"
%   configuration and use a finer resolution until a valid contact is
%   detected.
%
%   Since the InMoov digits are not coupled with each other, we close each
%   digit seperately starting with the thumb.
%   The InMoov palm movable segments are actuated with the digits it is
%   attached to, i.e thumb, ring and small fingers. Therefore these
%   segments are also included with the corrisponding digit.

% For time out
start = clock;
TimeOutFlag = false;

% Define the corse resolution
corseRes = 8; % one degree
if hand.isRight == 1 % This is to support left hands when implemented, right InMoov hand rotations all are about the -ve y-axis
    corseRes = corseRes * -1;
end

% Load home configuration
q = hand.qHome;

% This function is only called if there is no collision between the hand
% at its home configuration and the object at its current configuration,
% therefore we begin by directly closing the first digit

% This function only works with the InMoov model with collision and contact
% meshes. However the object does not have to have both
if isfield(object, 'contactMesh') % Check if a contactMesh is present
    objectContactMesh = object.contactMesh;
    if isfield(object, 'collisionMesh') % Check if a collisionMesh is present
        objectCollisionMesh = object.collisionMesh;
    else
        objectCollisionMesh = object.contactMesh;
    end
else
    objectContactMesh = object;
    objectCollisionMesh = object;
end

% Index and Middle fingers
% Index and Middle fingers' configuration are q{3}(1,2) to (3,2) for the
% index finger and q{4}(1,2) to (3,2) for the middle finger

for j = 2:3
    %fprintf('Checking digit no %d\n', j);
    % Define important variables
    R = corseRes;
    newQ = zeros(3,1);
    lastQ = zeros(3,1);
    contactJoints = false(3,1);

    % Define joints' motion limits
    limits = [ 85; 90; 65 ];
    if hand.isRight == 1 % This is to support left hands when implemented, right InMoov hand rotations all are about the -ve y-axis
        limits = limits * -1;
    end

    while 1 % Loop until a contact is found or joint limits reached
        % Close all joints that are not in contact by R
        newQ(~contactJoints) = lastQ(~contactJoints) + R;
        % Make sure joints did not reach maximum limit
        for i = 1:3
            if abs(newQ(i)) > abs(limits(i))
                newQ(i) = limits(i);
            end
        end
        % If all joints reached limits, we'll need to end here
        if newQ == limits
            % Store cofiguration
            q{j+1}(1,2) = newQ(1);    % MCP
            q{j+1}(2,2) = newQ(2);    % PIP
            q{j+1}(3,2) = newQ(3);    % DIP
            % Exit loop
            %fprintf('Limits reached, should exit here\n')
            break
        end
        % Apply the new configuration
        %fprintf('Changing finger configuratoin..... ')
        currentPose = InMoovDigitPose(hand, j, newQ);
        %fprintf('DONE\n')
        % Check collision
        collision = [
            meshIntersectionCheck(currentPose.digits(j).links(1).collisionMesh,objectCollisionMesh)
            meshIntersectionCheck(currentPose.digits(j).links(2).collisionMesh,objectCollisionMesh)
            meshIntersectionCheck(currentPose.digits(j).links(3).collisionMesh,objectCollisionMesh)];
        if nnz(collision) ~= 0; % if there is any collision, go back to last configuration
            newQ = lastQ;
            R = R/2;
            %fprintf('Collision, new resolution is %d\n', R);
        else
            %fprintf('No collision, checking contact ... ');
            % Check contact
            contactJoints = [
                meshIntersectionCheck(currentPose.digits(j).links(1).contactMesh,objectContactMesh)
                meshIntersectionCheck(currentPose.digits(j).links(2).contactMesh,objectContactMesh)
                meshIntersectionCheck(currentPose.digits(j).links(3).contactMesh,objectContactMesh)];
            if nnz(contactJoints) ~= 0 % if a contact is detected
                % Find the most distal joint in contact
                m = find(contactJoints, 1, 'last' );
                %fprintf('Contact at %d\n', m);
                if m == 3 % If it is the distal phalanx
                    % Store cofiguration
                    q{j+1}(1,2) = newQ(1);    % MCP
                    q{j+1}(2,2) = newQ(2);    % PIP
                    q{j+1}(3,2) = newQ(3);    % DIP
                    % Exit loop
                    %fprintf('Should exit here\n')
                    break
                else
                    for i = 1:m
                        % Make sure all leading joints are not incremented later
                        contactJoints(i) = 1;
                        % Reset resolution
                        R = corseRes;
                    end
                end
            %else
                %fprintf('No contact\n')
            end
            lastQ = newQ;
        end
        if(etime(clock,start) > TimeOut)
            TimeOutFlag = true;
            return
        end
    end
end

% Ring and Small fingers
% Ring and Small fingers' configuration are q{1}(2,2) and q{4}(1,2) to
% (3,2) for the ring finger and q{1}(3,2) and q{5}(1,2) to (3,2) for the
% small finger 

if ~TimeOutFlag
    for j = 4:5
        % Define important variables
        R = corseRes;
        newQ = zeros(4,1);
        lastQ = zeros(4,1);
        contactJoints = false(4,1);

        % Define joints' motion limits
        if j == 4
            limits = [ 15; 85; 90; 65 ];
        else
            limits = [ 20; 85; 90; 65 ];
        end
        if hand.isRight == 1 % This is to support left hands when implemented, right InMoov hand rotations all are about the -ve y-axis
            limits = limits * -1;
        end

        while 1 % Loop until a contact is found or joint limits reached
            % Close all joints that are not in contact by R
            newQ(~contactJoints) = lastQ(~contactJoints) + R;
            % Make sure joints did not reach maximum limit
            for i = 1:4
                if abs(newQ(i)) > abs(limits(i))
                    newQ(i) = limits(i);
                end
            end
            % If all joints reached limits, we'll need to end here
            if newQ == limits
                % Store cofiguration
                q{1}(j-2,2) = newQ(1);  % Palm joint
                q{j+1}(1,2) = newQ(2);  % MCP
                q{j+1}(2,2) = newQ(3);  % PIP
                q{j+1}(3,2) = newQ(4);  % DIP
                % Exit loop
                %fprintf('Limits reached, should exit here\n')
                break
            end
            % Apply the new configuration
            currentPose = InMoovDigitPose(hand, j, newQ);
            % Check collision
            collision = [   
                meshIntersectionCheck(currentPose.palm.links(j-2).collisionMesh,objectCollisionMesh)
                meshIntersectionCheck(currentPose.digits(j).links(1).collisionMesh,objectCollisionMesh)
                meshIntersectionCheck(currentPose.digits(j).links(2).collisionMesh,objectCollisionMesh)
                meshIntersectionCheck(currentPose.digits(j).links(3).collisionMesh,objectCollisionMesh)];
            if nnz(collision) ~= 0; % if there is any collision, go back to last configuration
                newQ = lastQ;
                R = R/2;
                %fprintf('Collision, new resolution is %d\n', R);
            else
                % Check contact
                contactJoints = [   
                    meshIntersectionCheck(currentPose.palm.links(j-2).contactMesh,objectContactMesh)
                    meshIntersectionCheck(currentPose.digits(j).links(1).contactMesh,objectContactMesh)
                    meshIntersectionCheck(currentPose.digits(j).links(2).contactMesh,objectContactMesh)
                    meshIntersectionCheck(currentPose.digits(j).links(3).contactMesh,objectContactMesh)];
                if nnz(contactJoints) ~= 0 % if a contact is detected
                    % Find the most distal joint in contact
                    m = find(contactJoints, 1, 'last' );
                    %fprintf('Contact at %d\n', m);
                    if m == 4 % If it is the distal phalanx
                        % Store cofiguration
                        q{1}(j-2,2) = newQ(1);  % Palm joint
                        q{j+1}(1,2) = newQ(2);  % MCP
                        q{j+1}(2,2) = newQ(3);  % PIP
                        q{j+1}(3,2) = newQ(4);  % DIP
                        % Exit loop
                        %fprintf('Should exit here\n')
                        break
                    else
                        for i = 1:m
                            % Make sure all leading joints are not incremented later
                            contactJoints(i) = 1;
                            % Reset resolution
                            R = corseRes;
                        end
                    end
                end

                lastQ = newQ;
            end
            if(etime(clock,start) > TimeOut)
                TimeOutFlag = true;
                return
            end
        end
    end
end


% Thumb
% Thumb's configuration are q{1}(1,2) for the palm segment, q{2}(1,2) for
% the proximal joint (thumb MCP) and q{2}(2,2) for the IP joint

if ~TimeOutFlag
    %fprintf('Checking Thumb...');

    % Thumb may collide with Index, Middle and Ring ( inc base ) fingers, we need to move all fingers to ckeck collisions
    fingersPose = handPose2(hand, q);

    % Define important variables
    R = corseRes;
    newQ = zeros(3,1);
    lastQ = zeros(3,1);
    contactJoints = false(3,1);
    %thumbContactQ = zeros(3,1);

    % Define thumb's joints' motion limits
    limits = [ 90; 85; 90 ];
    if hand.isRight == 1 % This is to support left hands when implemented, right InMoov hand rotations all are about the -ve y-axis
        limits = limits * -1;
    end

    while 1 % Loop until a contact is found or joint limits reached
        % Close all joints that are not in contact by R
        newQ(~contactJoints) = lastQ(~contactJoints) + R;
        % Make sure joints did not reach maximum limit
        for i = 1:3
            if abs(newQ(i)) > abs(limits(i))
                newQ(i) = limits(i);
            end
        end
        % If all joints reached limits, we'll need to end here
        if newQ == limits
            % Store cofiguration
            q{1}(1,2) = newQ(1);    % First palm joint => thumb CMC
            q{2}(1,2) = newQ(2);    % First thumb joint
            q{2}(2,2) = newQ(3);    % Second thumb joint
            % Exit loop
            %fprintf('Should exit here\n')
            break
        end
        % Apply the new configuration
        currentPose = InMoovDigitPose(hand, 1, newQ);
        % Check collision
        collision = [   
            % Check collision with object
            meshIntersectionCheck(currentPose.palm.links(1).collisionMesh,objectCollisionMesh)
            meshIntersectionCheck(currentPose.digits(1).links(1).collisionMesh,objectCollisionMesh)
            meshIntersectionCheck(currentPose.digits(1).links(2).collisionMesh,objectCollisionMesh) 
            % Check collision with fingers
            meshIntersectionCheck(currentPose.digits(1).links(1).collisionMesh,fingersPose.digits(2).links(2).collisionMesh)
            meshIntersectionCheck(currentPose.digits(1).links(2).collisionMesh,fingersPose.digits(2).links(3).collisionMesh)
            meshIntersectionCheck(currentPose.digits(1).links(1).collisionMesh,fingersPose.digits(3).links(2).collisionMesh)
            meshIntersectionCheck(currentPose.digits(1).links(2).collisionMesh,fingersPose.digits(3).links(3).collisionMesh)
            meshIntersectionCheck(currentPose.digits(1).links(2).collisionMesh,fingersPose.palm.links(2).collisionMesh) % thumb tip with ring base
            meshIntersectionCheck(currentPose.digits(1).links(1).collisionMesh,fingersPose.digits(4).links(2).collisionMesh)
            meshIntersectionCheck(currentPose.digits(1).links(2).collisionMesh,fingersPose.digits(4).links(3).collisionMesh) ];
        if nnz(collision) ~= 0; % if there is any collision, go back to last configuration
            newQ = lastQ;
            R = R/2;
            %fprintf('Collision, new resolution is %d\n', R);
        else
            % Check contact with object
            contactJoints = [   meshIntersectionCheck(currentPose.palm.links(1).contactMesh,objectContactMesh)
                                meshIntersectionCheck(currentPose.digits(1).links(1).contactMesh,objectContactMesh)
                                meshIntersectionCheck(currentPose.digits(1).links(2).contactMesh,objectContactMesh) ];
            % Check contact with fingers
            contactFingers = [   
                % Check contact with Index finger Middle link
                0            meshIntersectionCheck(currentPose.digits(1).links(1).contactMesh,fingersPose.digits(2).links(2).contactMesh)            meshIntersectionCheck(currentPose.digits(1).links(2).contactMesh,fingersPose.digits(2).links(2).contactMesh) ;
                % Check contact with Index finger Distal link
                0            meshIntersectionCheck(currentPose.digits(1).links(1).contactMesh,fingersPose.digits(2).links(3).contactMesh)            meshIntersectionCheck(currentPose.digits(1).links(2).contactMesh,fingersPose.digits(2).links(3).contactMesh) ;
                % Check contact with Middle finger Middle link
                0            meshIntersectionCheck(currentPose.digits(1).links(1).contactMesh,fingersPose.digits(3).links(2).contactMesh)            meshIntersectionCheck(currentPose.digits(1).links(2).contactMesh,fingersPose.digits(3).links(2).contactMesh) ;
                % Check contact with Middle finger Distal link
                0            meshIntersectionCheck(currentPose.digits(1).links(1).contactMesh,fingersPose.digits(3).links(3).contactMesh)            meshIntersectionCheck(currentPose.digits(1).links(2).contactMesh,fingersPose.digits(3).links(3).contactMesh) ;
                % Check contact with Ring finger base ( tip only )
                0            0          meshIntersectionCheck(currentPose.digits(1).links(2).contactMesh,fingersPose.palm.links(2).contactMesh) ;
                % Check contact with Ring finger Middle link
                0            meshIntersectionCheck(currentPose.digits(1).links(1).contactMesh,fingersPose.digits(4).links(2).contactMesh)            meshIntersectionCheck(currentPose.digits(1).links(2).contactMesh,fingersPose.digits(4).links(2).contactMesh) ;
                % Check contact with Ring finger Distal link
                0            meshIntersectionCheck(currentPose.digits(1).links(1).contactMesh,fingersPose.digits(4).links(3).contactMesh)            meshIntersectionCheck(currentPose.digits(1).links(2).contactMesh,fingersPose.digits(4).links(3).contactMesh) ];
            if nnz(contactJoints) ~= 0 % if a contact is detected
                %fprintf('Contact with object\n')
                % Find the most distal joint in contact
                m = find(contactJoints, 1, 'last' );
                %fprintf('Contact at %d\n', m);
                if m == 3 % If it is the distal phalanx
                    % Store cofiguration
                    q{1}(1,2) = newQ(1);    % First palm joint => thumb CMC
                    q{2}(1,2) = newQ(2);    % First thumb joint
                    q{2}(2,2) = newQ(3);    % Second thumb joint
                    % Exit loop
                    %fprintf('Should exit here\n')
                    break
                else
                    for i = 1:m
                        % Make sure all leading joints are not incremented later
                        contactJoints(i) = 1;
                        % Reset resolution
                        R = corseRes;
                    end
                end
            elseif nnz(contactFingers) ~= 0 % if a contact with fingers is detected
                %fprintf('Contact with fingers\n')
                flag = 0; % flag to break the main loop
                for j = 1:7
                    % Find the most distal joint in contact
                    m = find(contactFingers(j,:), 1, 'last' );
                    if m == 3 % If it is the distal phalanx
                        % Store cofiguration
                        q{1}(1,2) = newQ(1);    % First palm joint => thumb CMC
                        q{2}(1,2) = newQ(2);    % First thumb joint
                        q{2}(2,2) = newQ(3);    % Second thumb joint
                        % Exit loop
                        %fprintf('Should exit here\n')
                        flag = 1;
                        break
                    else
                        for i = 1:m
                            % Make sure all leading joints are not incremented later
                            contactJoints(i) = 1;
                            % Reset resolution
                            R = corseRes;
                        end
                    end
                end
                if flag == 1;
                    break
                end
            end

            lastQ = newQ;
        end
        
        if(etime(clock,start) > TimeOut)
            TimeOutFlag = true;
            return
        end
    end
end


if TimeOutFlag
    q = hand.qHome;
end

end

