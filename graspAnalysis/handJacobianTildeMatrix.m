function J = handJacobianTildeMatrix( contactPoints, handContacts, handPose )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%   Source:
%   D. Prattichizzo, J. Trinkle. Chapter 28 on Grasping. 
%   In Handbook on Robotics, B. Siciliano, O. Kathib (eds.), Pages 671-700, 2008.
%
%   ~J' = [ J_1'
%           ...
%           ...
%           J_n' ]   where n is number of contact points
%   
%   ~J_i' = barR_i' * Z_i    where; barR_i = [  R_i     0
%                                               0       R_i ]
%                                   Z_i   = [   d_i_1 ... ... d_i_nq
%                                               l_i_1 ... ... l_i_nq ]
%                            where nq is the number of joints in the hand
%   d_i_j = zeros(3,1)              if contact i does not affect joint j
%           S(c_i - th_j)' * z_j    if joint is revolute
%
%   l_i_j = zeros(3,1)  if contact i does not affect joint j
%           z_j         if joint is revolute
%
%   c_i is position of contact point i
%   th_j is the origin of the coordinate frame associated with the joint j
%   z_j is the unit vector in the direction of the z-axis in the same frame
%       FIX THIS ^
%
%   S(r) = [    0   -r_z  r_y 
%               r_z  0   -r_x 
%              -r_y  r_x  0   ]

% Define a counter to track contact number
contactCounter = 1;
% Define a counter to track joint number
jointCounter = 1;
% Get the number of DoFs in the hand
nq = handPose.DoF;
% Get number of contact points
%   contactPoints is a 4x4xn matrix, each 4x4 matrix is a homogenous
%   transform descriping the pose of contact i at the global frame
[~, ~, nc] = size(contactPoints);
% Preallocate J, J is a 6nc X nq matrix
J = zeros(6*nc,nq);
% prealocate an empty Z_i matrix for each contact, Z_i is a 6*nq matrix
Z = zeros(6,nq);

% We use joints' position and axis several times, better get them all at once
% prealocate empty matrices to store joints' location and axes AS COLs
th = zeros(3,nq);
axis = zeros(3,nq);
% Palm links
if isfield(handPose.palm, 'links') % Check if there are movable parts in the palm
    [~, palmDoF] = size(handPose.palm.links); % get number of joints/links in the palm
    for i = 1:palmDoF
        % Get the position of the joint
        th(:,jointCounter) = handPose.palm.joints(1:3,4,i);
        % Get the axis of rotation of the joint
        %   note that axis is originally stored as row, but we need it as col
        axis(:,jointCounter) = handPose.palm.jointAxes(i,:)';
        % Increment counter
        jointCounter = jointCounter + 1;
    end
end
% Digits
[~, n] = size(handPose.digits); % get number of digits, should be 4 or 5
for i = 1:n % loop through digits
    [~, m] = size(handPose.digits(i).links); % get number of joints (links) in the digit
    for j = 1:m
        % Get the position of the joint
        th(:,jointCounter) = handPose.digits(i).joints(1:3,4,j);
        % Get the axis of rotation of the joint
        %   note that axis is originally stored as row, but we need it as col
        axis(:,jointCounter) = handPose.digits(i).jointAxes(j,:)';
        % Increment counter
        jointCounter = jointCounter + 1;
    end
end
% reset "jointCounter"
jointCounter = 1;


% palm contacts
% Palm root link
% Check if there is a contact on the palm root link
if handContacts.flags.palm(1)
    % A contact on the palm root link does not affect any joints
    %J(((contactCounter*6)-5):contactCounter*6,:) = Z;
    % Increment counter
    contactCounter = contactCounter + 1;
end
% Palm links
if isfield(handPose.palm, 'links') % Check if there are movable parts in the palm
    [~, palmDoF] = size(handPose.palm.links); % get number of joints/links in the palm
    for i = 1:palmDoF
        % check if there is a contact on the link
        if handContacts.flags.palm(i+1)
            % Get the position of the contact
            C = contactPoints(1:3,4,contactCounter);
            % Get S(c-th)
            S = getS(C,th(:,jointCounter));
            % Calculate Jacobian for current joint and contact
            %   Note that a contact on a palm link only affect the joint of that link
            d_i = S' * axis(:,jointCounter);
            Z(:,jointCounter) = [ d_i ; axis(:,jointCounter) ];
            J(((contactCounter*6)-5):contactCounter*6,:) = Z;
            % Reset Z
            Z = zeros(6,nq);
            % Increment contact counter
            contactCounter = contactCounter + 1;
        end
        % Increment joint counter
        jointCounter = jointCounter + 1;
    end
end

% Digits
[~, n] = size(handPose.digits); % get number of digits, should be 4 or 5
for i = 1:n % loop through digits
    [~, m] = size(handPose.digits(i).links); % get number of links in the digit
    if nnz(handContacts.flags.digits(i).links) ~= 0
        for j = 1:m
            % Check if there is a contact on the link
            if handContacts.flags.digits(i).links(j)
                % Get the position of the contact
                C = contactPoints(1:3,4,contactCounter);
                % For every contact on the digits; we need to account for
                % all leading joints plust palm joints affecting the digit
                % Start by palm joints
                if (isfield(handPose.digits(i), 'base') && (handPose.digits(i).base ~= 0)) % Check if the digit's base is movable
                    baseJoint = handPose.digits(i).base;
                    % Get S(c-th)
                    S = getS(C,th(:,baseJoint));
                    % Calculate Z for palm joint and contact
                    d_i = S' * axis(:,baseJoint);
                    Z(:,baseJoint) = [ d_i ; axis(:,baseJoint) ];
                end
                % Now calculate for all leading joints
                for k = 1:j
                    % Get S(c-th), joint numbers are from "jointCounter-(j-k)" to jointCounter
                    S = getS(C,th(:,jointCounter-(j-k)));
                    % Calculate Z for palm joint and contact
                    d_i = S' * axis(:,jointCounter-(j-k));
                    Z(:,jointCounter-(j-k)) = [ d_i ; axis(:,jointCounter-(j-k)) ];
                end
                % Now update J to include Z of current contact
                J(((contactCounter*6)-5):contactCounter*6,:) = Z;
                % Reset Z
                Z = zeros(6,nq);
                % Increment contact counter
                contactCounter = contactCounter + 1;
            end
            % Increment joint counter
            jointCounter = jointCounter + 1;
        end
    else % if no contact on the entire digit
        % Increment joint counter by number of joints in the digit
        jointCounter = jointCounter + m;        
    end
end


end

