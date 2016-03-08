function [ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, range, anthroReference )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

tic

% For time out
TimeOut = 60*30;
start = clock;
TimeOutFlag = false;

qObjectBest = zeros(4,4,6);
for k = 1:6
    qObjectBest(:,:,k) = eye(4);
end
qHandBest   = [ hand.qHome; hand.qHome; hand.qHome; hand.qHome; hand.qHome; hand.qHome ];
Qbest       = zeros(6,6);
Qbest(5,5)  = 1000000; % random high initial values for measures that should be minimized

[m,~] = size(range);

aborted = 0;
timedout = 0;
nocontact = 0;
attempted = 0;

for i = 1:m
    %fprintf('Starting attempt %d ... checking collision ... ', i);
    qObject = transl(range(i,1),range(i,2),range(i,3)) * trotx(deg2rad(range(i,4))) * troty(deg2rad(range(i,5))) * trotz(deg2rad(range(i,6)));
    objectPose = objectPose2(object, qObject);
    handPose = handPose2(hand, hand.qHome);
    if handObjectCollision( handPose, objectPose )
        %fprintf('oops, COLLISION, abort\n');
        aborted = aborted +1;
    else
        %fprintf('no collision ... ');
        [ qHand, TimeOutFlag ] = InMoovCloseHandFingersFirst( hand, objectPose, 20 );
        if TimeOutFlag
            %fprintf('TimeOut\n')
            %return
            timedout = timedout + 1;
        else
            handPose = handPose2(hand, qHand);
            
            [ contactPoints, ~, handContacts ] = getContactPoints( handPose, objectPose );
            
            if handContacts.total > 0 % make sure we have contact
                
                % TEMPROARY :: ASSUME ALL CONTACTS ARE SoftFinger
                %[~,~,m] = size(contactPoints);
                %H = selectionMatrix( ones(1,m)*3 );
                H = selectionMatrix( handContacts.type );
                
                tG = graspTildeMatrix( contactPoints, qObject );
                G = H * tG';
                G = G';
                
                tJ = handJacobianTildeMatrix( contactPoints, handContacts, handPose );
                J = H * tJ;
                
                try 
                    Q(1) = SGminSVG(G);                 % Quality measure associated with the position of the contact points  -> Minimum singular value of matrix G
                catch ER
                    Q(1) = 0;
                end
                try
                    Q(2) = SGgraspIsotropyIndex(G);     % Quality measure associated with the position of the contact points (based on algebraic properties of grasp matrix) -> Grasp isotropy index
                catch ER
                    Q(2) = 0;
                end
                % SGdistSingularConfiguration sometimes fails (with error:
                % "The shifted operator is singular. The shift is an
                % eigenvalue."), to avoid this we use a try catch statement
                try
                    Q(3) = SGdistSingularConfiguration(G,J); % Quality measure associated with the hand configuration -> Distance to singular configurations
                catch ER
                    Q(3) = 0;
                end
                try
                    Q(4) = SGmanipEllipsoidVolume(G,J); % Quality measure associated with the hand configuration -> Volume of the manipulability ellipsoid
                catch ER
                    Q(4) = 0;
                end
                % Same with SGunifTransf
                try
                    Q(5) = SGunifTransf(G,J);    % Quality measure associated with the hand configuration -> Uniformity of transformation
                catch ER
                    Q(5) = 1000; % some random high value
                end
                Q(6) = quantifyAnthro( handPose, handContacts, anthroReference );
                
                %found = false;

                for j = 1:6
                    if j == 5 % check if measure should be minimized
                        if abs(Q(j)-1) < abs(Qbest(j,j)-1)
                            %found = true;
                            %fprintf('Qmin at %d, ',j);
                            Qbest(j,:) = Q;
                            qObjectBest(:,:,j) = qObject;
                            qHandBest(j,:)   = qHand;
                        end
                    else % for measures that should be maximized                        
                        if Q(j) > Qbest(j,j)
                            %found = true;
                            %fprintf('Qmax at %d, ',j);
                            Qbest(j,:) = Q;
                            qObjectBest(:,:,j) = qObject;
                            qHandBest(j,:)   = qHand;
                        %else
                            %fprintf('not best grasp\n');
                        end
                    end
                end

%                 if found
%                     fprintf('\n');
%                 else
%                     fprintf('not best grasp\n');
%                 end
                attempted = attempted + 1;
            else
                %fprintf('NO CONTACT!!!\n');
                nocontact = nocontact + 1;
            end
        end
    end
    
    if(etime(clock,start) > TimeOut)
        %TimeOutFlag = true;
        total = attempted+aborted+timedout+nocontact;
        fprintf('TIMEOUT, completed %d attempts, %d aborted due to collision, %d no contact and %d timed out\n', total, aborted, nocontact, timedout);
        toc
        return
    end
%fprintf('Done\n');

end

total = attempted+aborted+timedout+nocontact;
fprintf('Completed %d attempts, %d aborted due to collision, %d no contact and %d timed out\n', total, aborted, nocontact, timedout);
toc

end

