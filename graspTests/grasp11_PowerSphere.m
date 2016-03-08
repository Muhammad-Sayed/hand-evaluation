function [ object, range, anthroReference ] = grasp11_PowerSphere( hand )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% Define anthropomorphic reference
% Opposition can be 1) "palm", 2) "pad", or 3) "side"
anthroReference.oppositionType  = 1;
% Thumb position can be 1) "Adducted" or 2) "Abducted"
anthroReference.thumbPosition   = 2;
% VF1 (virtual finger) can be 0) "palm", 1) "thumb", or 2) "index finger"
anthroReference.VF1             = 0;
% VF2 is combination of up to 4 fingers, encoded as a 4 bit binary code
% in the follosing order VF2 = [ 0 0 0 0 ] =>  [ index middle ring small ]
anthroReference.VF2             = bi2de([1 1 1 1]);
% contacts is 6*2 matrix (palm & 5 fingers, proximal & distal degments),
% fields can hold the following values; 
%   0 : the segment should not be in contact
%   1 : the segment contact is irrelevant
%   2 : the segment contact is redundunt ( contact should be on at least one redundunt segment in the digit )
%   3 : the segment should be in contact
% Segment ( irrelvant for palm )    proximal    distal
anthroReference.contacts        = [ 3           3 ;     % palm
                                    3           3 ;     % thumb
                                    3           3 ;     % index finger
                                    3           3 ;     % middle finger
                                    3           3 ;     % ring finger
                                    3           3 ];    % small finger
                                
% Import object; Tennis Ball
[object.faces, object.vertices, object.normals] = stlread('objectModels\Sphere_67mm_980faces_tennisBall.stl');

% Calculate object pose range
%   Transition;
%   X
range(1,1) = max(hand.palm.root.collisionMesh.vertices(:,1)) - 39;
range(1,2) = max(hand.palm.root.collisionMesh.vertices(:,1)) - 29;
%   Y
range(2,1) = min(hand.palm.root.collisionMesh.vertices(:,2));
range(2,2) = max(hand.palm.root.collisionMesh.vertices(:,2));
%   Z
range(3,1) = min(hand.palm.root.collisionMesh.vertices(hand.palm.root.collisionMesh.vertices(:,3)>0,3)) + 33;
range(3,2) = max(hand.palm.root.collisionMesh.vertices(:,3)) + 34;
%   Rotation;
%   X
range(4,1) = 0;
range(4,2) = 0;
%   Y
range(5,1) = 0;
range(5,2) = 0;
%   Z
range(6,1) = 0;
range(6,2) = 0;

end

