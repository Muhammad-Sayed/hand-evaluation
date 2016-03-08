function [ object, range, anthroReference ] = grasp07_Prismatic3Finger( hand )
%UNTITLED15 Summary of this function goes here
%   This function test a hand ability to perform the Prismatic 3 Finger grasp
%       Input   :: hand model
%       Output  :: 
%
%   Object for this grasp is a Cylinder with 1cm diameter

% Define anthropomorphic reference
% Opposition can be 1) "palm", 2) "pad", or 3) "side"
anthroReference.oppositionType  = 2;
% Thumb position can be 1) "Adducted" or 2) "Abducted"
anthroReference.thumbPosition   = 2;
% VF1 (virtual finger) can be 0) "palm", 1) "thumb", or 2) "index finger"
anthroReference.VF1             = 1;
% VF2 is combination of up to 4 fingers, encoded as a 4 bit binary code
% in the follosing order VF2 = [ 0 0 0 0 ] =>  [ index middle ring small ]
anthroReference.VF2             = bi2de([1 1 1 0]);
% contacts is 6*2 matrix (palm & 5 fingers, proximal & distal degments),
% fields can hold the following values; 
%   0 : the segment should not be in contact
%   1 : the segment contact is irrelevant
%   2 : the segment contact is redundunt ( contact should be on at least one redundunt segment in the digit )
%   3 : the segment should be in contact
% Segment ( irrelvant for palm )    proximal    distal
anthroReference.contacts        = [ 0           0 ;     % palm
                                    0           3 ;     % thumb
                                    0           3 ;     % index finger
                                    0           3 ;     % middle finger
                                    0           3 ;     % ring finger
                                    0           0 ];    % small finger

%Import object
[object.faces, object.vertices, object.normals] = stlread('objectModels\Cylinder_10dX250l_56faces.stl');
%[object.contactMesh.faces, object.contactMesh.vertices, object.contactMesh.normals] = stlread('objectModels\Cylinder_110dX250l_92faces.stl');
% Generate collision meshes (using 1 mm tollerance marigne)
%object.collisionMesh = smallerMesh( object.contactMesh, 1 );

% Calculate object pose range
%range = zeros(6,2);
%   Transition;
%   The object should be able to spane the hand's X workspace
range(1,1) = 0;
range(1,2) = max(hand.palm.root.collisionMesh.vertices(:,1));
%   The object should be able to spane the hand's Y workspace
range(2,1) = min(hand.palm.root.collisionMesh.vertices(:,2));
range(2,2) = max(hand.palm.root.collisionMesh.vertices(:,2));
%   The object should be able to make contact with the distal segments
%                       Zmin < length of shortest digit
%                       Zmax = length of longest digit
range(3,1) = max(hand.palm.root.collisionMesh.vertices(:,3)) + 15;
range(3,2) = longestDigitLength(hand);
%   Rotation;
%   The cylinder's longtuidnal axis can be rotated around the X axis
%   by 90 +- 45 degrees for tolerance
range(4,1) = 45;
range(4,2) = 135;
%   The cylinder's longtuidnal axis can be rotated about Y axis
%   by +- 45 degrees for tolerance
range(5,1) = -45;
range(5,2) = 45;
%   A cylinder does not require rotation about the Z axis
range(6,1) = 0;
range(6,2) = 0;

end

