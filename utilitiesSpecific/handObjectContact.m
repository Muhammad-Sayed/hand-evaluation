function [ contact ] = handObjectContact( hand, object )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% MAKE SURE IF WE USE THE "SURF" PART OF INTERSECTION CHECKING

contact.total = 0; % A counter to store total number of (segments in) contact

% Check if the object has a contactMesh, otherwise the object itself is the contact mesh
if isfield(object, 'contactMesh')
    objectMesh = object.contactMesh;
else
    objectMesh = object;
end

% Palm
% Predefine flag and direction variables for all palm parts
if isfield(hand.palm, 'links') % Check if there are movable parts in the palm
    [~, m] = size(hand.palm.links); % get number of joints/links in the palm
    contact.flags.palm = false(m+1,1);
    contact.direction.palm = zeros(m+1,1);
else
    contact.flags.palm = false;
    contact.direction.palm = 0;
end 
% Check if there is an intersection between the boundary boxes
contact.palm.root.box = intersectionBox(hand.palm.root.contactMesh, objectMesh);
% If true, check if the meshes intersect
if contact.palm.root.box.flag ~= 0
    [contact.palm.root.intersect] = SurfaceIntersection(hand.palm.root.contactMesh, objectMesh);
    if nnz(contact.palm.root.intersect) ~= 0 % Is any intersection (contact) detected?
        %fprintf('Palm in contact with object\n');
        %contact.flags.palm.root = true;
        contact.flags.palm(1) = true;
        contact.direction.palm(1)  = determineContactSurface(hand.palm.root.contactMesh, contact.palm.root.intersect);
        contact.total = contact.total +1;
        %if contact.total == 1 % check if this is the first contact
            contact.type = [ hand.palm.root.contactType ];
            
        %else
        %    contact.type = [ contact.type hand.palm.root.contactType ];
        %end
            
    %else
        %contact.flags.palm.root = false;
    end
%else % No intersection between boundary boxes => no contact
    %contact.flags.palm.root = false;
end

% Palm links
if isfield(hand.palm, 'links') % Check if there are movable parts in the palm
    [~, m] = size(hand.palm.links); % get number of joints/links in the palm
    for j = 1:m % loop through links, THIS DOES NOT SUPPORT CHAINS
        % Check if there is an intersection between the boundary boxes
        contact.palm.links(j).box = intersectionBox(hand.palm.links(j).contactMesh, objectMesh);
        % If true, check if the meshes intersect
        if contact.palm.links(j).box.flag ~= 0
            [contact.palm.links(j).intersect] = SurfaceIntersection(hand.palm.links(j).contactMesh, objectMesh);
            if nnz(contact.palm.links(j).intersect) ~= 0 % Is any intersection (contact) detected?
                %fprintf('Palm segment %d in contact with object\n', j);
                %contact.flags.palm.links(j) = true;
                contact.flags.palm(j+1) = true;
                contact.direction.palm(j+1)  = determineContactSurface(hand.palm.links(j).contactMesh, contact.palm.links(j).intersect);
                contact.total = contact.total +1;
                if contact.total == 1 % check if this is the first contact
                    contact.type = [ hand.palm.links(j).contactType ];
                else
                    contact.type = [ contact.type hand.palm.links(j).contactType ];
                end
                
            %else
                %contact.flags.palm.links(j) = false;
            end
        %else % No intersection between boundary boxes => no contact
            %contact.flags.palm.links(j) = false;
        end
    end
end

% Digits
[~, n] = size(hand.digits); % get number of digits, should be 4 or 5
for i = 1:n % loop through digits
    [~, m] = size(hand.digits(i).links); % get number of links in the digit
    for j = 1:m % loop through links
        % Check if there is an intersection between the boundary boxes
        contact.digits(i).links(j).box = intersectionBox(hand.digits(i).links(j).contactMesh, objectMesh);
        if contact.digits(i).links(j).box.flag ~= 0
            % Check intersection for each link link mesh
            [contact.digits(i).links(j).intersect] = SurfaceIntersection(hand.digits(i).links(j).contactMesh, objectMesh);
            if nnz(contact.digits(i).links(j).intersect) ~= 0 % Is any intersection (contact) detected?
                %fprintf('Digit %d Segment %d in contact with object\n', i, j);
                contact.flags.digits(i).links(j) = true;
                contact.direction.digits(i).links(j) = determineContactSurface(hand.digits(i).links(j).contactMesh, contact.digits(i).links(j).intersect);
                contact.total = contact.total +1;
                if contact.total == 1 % check if this is the first contact
                    contact.type = [ hand.digits(i).links(j).contactType ];
                else
                    contact.type = [ contact.type hand.digits(i).links(j).contactType ];
                end
            else
                contact.flags.digits(i).links(j) = false;
                contact.direction.digits(i).links(j) = 0;
            end
        else % No intersection between boundary boxes => no contact
            contact.flags.digits(i).links(j) = false;
            contact.direction.digits(i).links(j) = 0;
        end
    end
end

end