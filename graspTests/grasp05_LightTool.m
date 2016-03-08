function [ object, range, anthroReference ] = grasp05_LightTool( hand )
%UNTITLED15 Summary of this function goes here
%   This function test a hand ability to perform the Light Tool grasp
%       Input   :: hand model
%       Output  :: 
%
%   Object for this grasp is a Cylinder with 1cm diameter

% Define anthropomorphic reference
% Opposition can be 1) "palm", 2) "pad", or 3) "side"
anthroReference.oppositionType  = 1;
% Thumb position can be 1) "Adducted" or 2) "Abducted"
anthroReference.thumbPosition   = 1;
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
                                    0           3 ;     % thumb
                                    3           3 ;     % index finger
                                    3           3 ;     % middle finger
                                    3           3 ;     % ring finger
                                    3           3 ];    % small finger

%Import object
[object.faces, object.vertices, object.normals] = stlread('objectModels\Cylinder_10dX250l_56faces.stl');
%[object.contactMesh.faces, object.contactMesh.vertices, object.contactMesh.normals] = stlread('objectModels\Cylinder_110dX250l_92faces.stl');
% Generate collision meshes (using 1 mm tollerance marigne)
%object.collisionMesh = smallerMesh( object.contactMesh, 1 );

% Calculate object pose range
%range = zeros(6,2);
%   Transition;
%   For this grasp, the object should be able to reach the base of the
%   digits, therefore;  Xmin < palmXmax - objectDiameter
%                       Xmax > palmXmax - objectDiameter
range(1,1) = max(hand.palm.root.collisionMesh.vertices(:,1)) - 10;
range(1,2) = max(hand.palm.root.collisionMesh.vertices(:,1));
%   The object should be able to spane the hand's Y workspace
range(2,1) = min(hand.palm.root.collisionMesh.vertices(:,2));
range(2,2) = max(hand.palm.root.collisionMesh.vertices(:,2));
%   The object should be able to make contact with the palm, object minZ
%   point must be in contact with palm top surface, therefore
%                       Zmin < palm_+ve_Zmin + abs(objectZmin)
%                       Zmax > palmZmax + abs(objectZmin)
%range(3,1) = min(hand.palm.root.collisionMesh.vertices(hand.palm.root.collisionMesh.vertices(:,3)>0,3)) + abs(min(object.vertices(:,3))) - 1;
%range(3,2) = max(hand.palm.root.collisionMesh.vertices(:,3)) + abs(min(object.vertices(:,3))) + 1;
% replace abs(objectZmin) with cylinder radius
range(3,1) = min(hand.palm.root.collisionMesh.vertices(hand.palm.root.collisionMesh.vertices(:,3)>0,3)) + 4;
range(3,2) = max(hand.palm.root.collisionMesh.vertices(:,3)) + 6;
%   Rotation;
%   The cylinder's longtuidnal axis lies in a plane parallel to the hand's
%   frontal plane, therefore the object must be rotated around the X axis
%   by 90 degrees (+- 2 degrees for tolerance)
range(4,1) = 88;
range(4,2) = 92;
%   The cylinder's longtuidnal axis lies in a plane parallel to the hand's
%   transverse plane, therefore the object should be rotated about Y axis
%   with a very little margine
range(5,1) = -2;
range(5,2) = 2;
%   A cylinder does not require rotation about the Z axis
range(6,1) = 0;
range(6,2) = 0;

end

