function [ object, range, anthroReference ] = grasp16_Lateral( handPose )
%UNTITLED15 Summary of this function goes here
%

% Define anthropomorphic reference
% Opposition can be 1) "palm", 2) "pad", or 3) "side"
anthroReference.oppositionType  = 3;
% Thumb position can be 1) "Adducted" or 2) "Abducted"
anthroReference.thumbPosition   = 1;
% VF1 (virtual finger) can be 0) "palm", 1) "thumb", or 2) "index finger"
anthroReference.VF1             = 1;
% VF2 is combination of up to 4 fingers, encoded as a 4 bit binary code
% in the follosing order VF2 = [ 0 0 0 0 ] =>  [ index middle ring small ]
anthroReference.VF2             = bi2de([1 0 0 0]);
% contacts is 6*2 matrix (palm & 5 fingers, proximal & distal degments),
% fields can hold the following values; 
%   0 : the segment should not be in contact
%   1 : the segment contact is irrelevant
%   2 : the segment contact is redundunt ( contact should be on at least one redundunt segment in the digit )
%   3 : the segment should be in contact
% Segment ( irrelvant for palm )    proximal    distal
anthroReference.contacts        = [ 0           0 ;     % palm
                                    0           3 ;     % thumb
                                    3           3 ;     % index finger
                                    0           0 ;     % middle finger
                                    0           0 ;     % ring finger
                                    0           0 ];    % small finger

%Import object; Credit Card
[object.faces, object.vertices, object.normals] = stlread('objectModels\Box_85.6X54X1_12faces_creditCard.stl');

% Calculate object pose range
%   Transition;
%   X
range(1,1) = poseDigitXmin(handPose,2);
range(1,2) = poseDigitXmax(handPose,2);
%   Y
range(2,1) = poseDigitYmin(handPose,2) - 1;
range(2,2) = poseDigitYmax(handPose,2) + 1;
%   Z
range(3,1) = poseDigitZmin(handPose,2);
range(3,2) = poseDigitZmax(handPose,2);
%   Rotation;
%   X
range(4,1) = 88;
range(4,2) = 92;
%   Y
range(5,1) = 0;
range(5,2) = 0;
%   Z
range(6,1) = 0;
range(6,2) = 0;

end

