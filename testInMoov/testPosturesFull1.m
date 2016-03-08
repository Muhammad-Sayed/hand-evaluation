tic
warning('off','all');

hand = InMoovHand_Right;

postureName = {'Fist', 'Bunched_Hand', 'Closed_Hand', 'Flat_Hand', 'Open_Hand', 'Clawed_Hand', 'Bent_Hand', 'C_Hand', 'O_Hand', 'L_Hand', 'M_Hand', 'N_Hand', 'Irish_T_Hand', 'V_Hand', 'Y_Hand', 'Full_C_Hand', 'Full_O_Hand'};
posture = {'The hand is tightly closed. The thumb is in opposition, abducted, curved, and touches the back of the fingers.',
'The fingers are together, bent at first knuckle, and straight. The thumb is in opposition, abducted, straight, and touches the fingertips.',
'The hand is closed. The thumb is in retroposition, adducted, adjacent to the palm, and straight.',
'The fingers are together, extended, and straight. The thumb is in retroposition, adducted, far from the palm, and straight.',
'The fingers are separated, extended, and straight. The thumb is in retroposition, adducted, far from the palm, and straight.',
'The fingers are separated, extended, and bent at second knuckle. The thumb is in retroposition, adducted, far from the palm , and bent at second-knuckle.',
'The fingers are together, bent at first knuckle, and straight. The thumb is in retroposition, adducted, adjacent to the palm, and straight.',
'The hand is closed. The index finger is extended and slightly curved. The thumb is in opposition, abducted, and slightly curved.',
'The fingers are together, extended and slightly curved. The index finger is slightly bent at first knuckle and curved. The thumb is in opposition, abducted, slightly curved, and touches the index fingertip.',
'The hand is closed. The index finger is extended and straight. The thumb is in retroposition, adducted, far from the palm, and straight.',
'The hand is flat. The small finger is bent at first knuckle and bent at second knuckle. The thumb is in opposition, abducted, curved, and touches the back of the small finger.',
'The hand is flat. The lower fingers are bent at first knuckle and bent at second knuckle. The thumb is in opposition, abducted, curved, and touches the back of the lower fingers.',
'The hand is closed. The index finger is extended and curved. The thumb is in opposition, adducted, straight, and touches the pad of the index finger middle phalanx.',
'The lower fingers are bent at first knuckle and bent at second knuckle. The thumb is in opposition, abducted, curved, and touches the back of the lower fingers.',
'The hand is closed. The small finger is extended and straight. The thumb is in retroposition, adducted, far from the palm, and straight.',
'The fingers are together, extended, and slightly curved. The thumb is in opposition, abducted, and slightly curved.',
'The fingers are together, slightly bent at first knuckle, and curved. The thumb is in opposition, abducted, slightly curved, and touching the index distal phalanx.'};

% Generate FIS for gestures
postureEvaluationRaw = readfis('postureEvaluationRaw');
for i = 1:17
    postureEnc{i} = parsePostureFull( posture{i} );
    postureFIS{i} = addRules( postureEvaluationRaw, postureName{i}, postureEnc{i} );
end

postureRes1 = zeros(759375, 17);

for i = 1:759375
    
    q = fixQ1(DIRPROD20b(i,:));
    postureObserved = handObservablePosture2(hand, q);
    
    for j = 1:17
        postureRes1(i,j) = evalfis(postureObserved, postureFIS{j});
    end
    
    clc
    i
    
end
toc