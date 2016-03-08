% hand = InMoovHand_Right;
% attempts = 50;
% 
% warning('off','all');
% 
% [ object, objectRange, anthroReference ] = grasp01_LargeDiameter( hand );
% [ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
% %plotAllResults( hand, object, qHandBest, qObjectBest );
% saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 1);
% 
% [ object, objectRange, anthroReference ] = grasp02_SmallDiameter( hand );
% [ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
% %plotAllResults( hand, object, qHandBest, qObjectBest );
% saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 2);
% 
% [ object, objectRange, anthroReference ] = grasp03_MediumWrap( hand );
% [ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
% %plotAllResults( hand, object, qHandBest, qObjectBest );
% saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 3);
% 
% [ object, objectRange, anthroReference ] = grasp04_AdductedThumb( hand );
% [ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
% %plotAllResults( hand, object, qHandBest, qObjectBest );
% saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 4);
% 
% [ object, objectRange, anthroReference ] = grasp05_LightTool( hand );
% [ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
% %plotAllResults( hand, object, qHandBest, qObjectBest );
% saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 5);
% 
% [ object, objectRange, anthroReference ] = grasp06_Prismatic4Finger( hand );
% [ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
% %plotAllResults( hand, object, qHandBest, qObjectBest );
% saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 6);
% 
% [ object, objectRange, anthroReference ] = grasp07_Prismatic3Finger( hand );
% [ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
% %plotAllResults( hand, object, qHandBest, qObjectBest );
% saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 7);
% 
% [ object, objectRange, anthroReference ] = grasp08_Prismatic2Finger( hand );
% [ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
% %plotAllResults( hand, object, qHandBest, qObjectBest );
% saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 8);
% 
% [ object, objectRange, anthroReference ] = grasp09_PalmarPinch( hand );
% [ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
% %plotAllResults( hand, object, qHandBest, qObjectBest );
% saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 9);

% [ object, objectRange, anthroReference ] = grasp10_PowerDisk( hand );
% [ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
% %plotAllResults( hand, object, qHandBest, qObjectBest );
% saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 10);
% 
% [ object, objectRange, anthroReference ] = grasp11_PowerSphere( hand );
% [ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
% %plotAllResults( hand, object, qHandBest, qObjectBest );
% saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 11);
% 
% [ object, objectRange, anthroReference ] = grasp12_PrecisionDisk( hand );
% [ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
% %plotAllResults( hand, object, qHandBest, qObjectBest );
% saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 12);
% 
% [ object, objectRange, anthroReference ] = grasp13_PrecisionSphere( hand );
% [ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
% %plotAllResults( hand, object, qHandBest, qObjectBest );
% saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 13);
% 
% [ object, objectRange, anthroReference ] = grasp14_Tripod( hand );
% [ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
% %plotAllResults( hand, object, qHandBest, qObjectBest );
% saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 14);
% 
% [ object, objectRange, anthroReference ] = grasp15_FixedHook( hand );
% [ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
% %plotAllResults( hand, object, qHandBest, qObjectBest );
% saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 15);
% 
% [object.faces, object.vertices, object.normals] = stlread('objectModels\Cylinder_22.5dX3.15l_80faces_poundCoin.stl');
% [ qHand, TimeOutFlag] = InMoovCloseHandFingersFirst( hand, object, 30 );
% handPose = handPose2(hand, qHand);
% [ object, objectRange, anthroReference ] = grasp16_Lateral( handPose );
% [ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
% %plotAllResults( hand, object, qHandBest, qObjectBest );
% saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 16);

% [ object, objectRange, anthroReference ] = grasp17_IndexFingerExtension( hand );
% [ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
% %plotAllResults( hand, object, qHandBest, qObjectBest );
% saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 17);
% 
% [ object, objectRange, anthroReference ] = grasp18_ExtensionType( hand );
% [ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
% %plotAllResults( hand, object, qHandBest, qObjectBest );
% saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 18);
% 
% [ object, objectRange, anthroReference ] = grasp20_WritingTripod( hand );
% [ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
% %plotAllResults( hand, object, qHandBest, qObjectBest );
% saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 20);
% 
% [ object, objectRange, anthroReference ] = grasp22_ParallelExtension( hand );
% [ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
% %plotAllResults( hand, object, qHandBest, qObjectBest );
% saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 22);

%[ object, objectRange, anthroReference ] = grasp23_AbductionGrip( hand );
%[ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
%plotAllResults( hand, object, qHandBest, qObjectBest );

[ object, objectRange, anthroReference ] = grasp24_TipPinch( hand );
[ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 24);

[ object, objectRange, anthroReference ] = grasp25_LateralTripod( hand );
[ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 25);

[ object, objectRange, anthroReference ] = grasp26_Sphere4Finger( hand );
[ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 26);

[ object, objectRange, anthroReference ] = grasp27_Quadpod( hand );
[ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 27);

[ object, objectRange, anthroReference ] = grasp28_Sphere3Finger( hand );
[ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 28);

[ object, objectRange, anthroReference ] = grasp29_Stick( hand );
[ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 29);

[ object, objectRange, anthroReference ] = grasp30_Palmar( hand );
[ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 30);

[ object, objectRange, anthroReference ] = grasp31_Ring( hand );
[ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 31);

[ object, objectRange, anthroReference ] = grasp32_Ventral( hand );
[ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 32);

[ object, objectRange, anthroReference ] = grasp33_InferiorPincer( hand );
[ Qbest, qObjectBest, qHandBest] = handTestRand1( hand, object, objectRange, anthroReference, attempts );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 33);

