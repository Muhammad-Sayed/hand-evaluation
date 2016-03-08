function [ output_fis ] = addRules( input_fis, postureName, postureEnc )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

output_fis = rmvar(input_fis,'output',1);

output_fis = addvar(output_fis,'output',postureName,[0 1]);

% output_fis = addmf(output_fis,'output',1,'non-anthropomorphic','trimf',[-0.2 0 0.8]);
% output_fis = addmf(output_fis,'output',1,'anthropomorphic','trimf',[0.2 1 1.2]);
output_fis = addmf(output_fis,'output',1,'non-anthropomorphic','trapmf',[-0.1 0 0.2 0.3]);
output_fis = addmf(output_fis,'output',1,'anthropomorphic','trapmf', [0.7 0.8 1 1.1]);

% if all are similar then posture is anthropomorphic
rule1 = [postureEnc 2 1 1];
% if any is not similar then posture is not anthropomorphic
rule2 = [-postureEnc 1 1 1];
ruleList = [rule1;rule2];

output_fis = addrule(output_fis, ruleList);

end

