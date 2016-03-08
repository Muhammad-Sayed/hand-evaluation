hand = InMoovHand_Right;
warning('off','all');

[ object, objectRange, anthroReference ] = grasp01_LargeDiameter( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 1);

[ object, objectRange, anthroReference ] = grasp02_SmallDiameter( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 2);

[ object, objectRange, anthroReference ] = grasp03_MediumWrap( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 3);

[ object, objectRange, anthroReference ] = grasp04_AdductedThumb( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 4);

[ object, objectRange, anthroReference ] = grasp05_LightTool( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 5);

[ object, objectRange, anthroReference ] = grasp06_Prismatic4Finger( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 6);

[ object, objectRange, anthroReference ] = grasp07_Prismatic3Finger( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 7);

[ object, objectRange, anthroReference ] = grasp08_Prismatic2Finger( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 8);

[ object, objectRange, anthroReference ] = grasp09_PalmarPinch( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 9);

[ object, objectRange, anthroReference ] = grasp10_PowerDisk( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 10);

[ object, objectRange, anthroReference ] = grasp11_PowerSphere( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 11);

[ object, objectRange, anthroReference ] = grasp12_PrecisionDisk( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 12);

[ object, objectRange, anthroReference ] = grasp13_PrecisionSphere( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 13);

[ object, objectRange, anthroReference ] = grasp14_Tripod( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 14);

[ object, objectRange, anthroReference ] = grasp15_FixedHook( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 15);

[object.faces, object.vertices, object.normals] = stlread('objectModels\Cylinder_22.5dX3.15l_80faces_poundCoin.stl');
[ qHand, TimeOutFlag] = InMoovCloseHandFingersFirst( hand, object, 30 );
handPose = handPose2(hand, qHand);
[ object, objectRange, anthroReference ] = grasp16_Lateral( handPose );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 16);

[ object, objectRange, anthroReference ] = grasp17_IndexFingerExtension( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 17);

[ object, objectRange, anthroReference ] = grasp18_ExtensionType( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 18);

[ object, objectRange, anthroReference ] = grasp20_WritingTripod( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 20);

[ object, objectRange, anthroReference ] = grasp22_ParallelExtension( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 22);

%[ object, objectRange, anthroReference ] = grasp23_AbductionGrip( hand );
%[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );

[ object, objectRange, anthroReference ] = grasp24_TipPinch( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 24);

[ object, objectRange, anthroReference ] = grasp25_LateralTripod( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 25);

[ object, objectRange, anthroReference ] = grasp26_Sphere4Finger( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 26);

[ object, objectRange, anthroReference ] = grasp27_Quadpod( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 27);

[ object, objectRange, anthroReference ] = grasp28_Sphere3Finger( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 28);

[ object, objectRange, anthroReference ] = grasp29_Stick( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 29);

[ object, objectRange, anthroReference ] = grasp30_Palmar( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 30);

[ object, objectRange, anthroReference ] = grasp31_Ring( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 31);

[ object, objectRange, anthroReference ] = grasp32_Ventral( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 32);

[ object, objectRange, anthroReference ] = grasp33_InferiorPincer( hand );
objectRange = calculateUniformRange( objectRange );
[ Qbest, qObjectBest, qHandBest] = handTestUniform1( hand, object, objectRange, anthroReference );
%plotAllResults( hand, object, qHandBest, qObjectBest );
saveAllResults( hand, object, qHandBest, qObjectBest, Qbest, 33);

