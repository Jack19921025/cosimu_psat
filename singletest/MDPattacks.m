% startTime =  strrep(strrep(datestr(now), ':', '-'), ' ', '-');
% mkdir(['../debug/' startTime])
% MDPattack([],startTime,'basic');
% MDPattack({'Config.falseDataAttacks{1}.PenalForNotConvergence=0'},startTime,'noPenal');
% MDPattack({...
%     'Config.falseDataAttacks{1}.reward=''minEigValue''' ,...
%     'Config.falseDataAttacks{1}.RatioOffset=[2 0 2 0 2 0]'},startTime,'reverseQ1');
% MDPattack({...
%     'Config.falseDataAttacks{1}.reward=''minEigValue''' ,...
%     'Config.falseDataAttacks{1}.RatioOffset=[2 0 2 0 2 0]',...
%     'Config.falseDataAttacks{1}.MDPDiscountFactor=0.5'},startTime,'longQ1');
MDPattack({...
    'Config.falseDataAttacks{1}.reward=''minEigValue''' ,...
    'Config.falseDataAttacks{1}.RatioOffset=[2 0]',...
    'Config.falseDataAttacks{1}.MDPDiscountFactor=0.5',...
    'Config.falseDataAttacks{1}.Naction = [5 5]',...
    'Config.falseDataAttacks{1}.MDPBusFalseDataRatioStep=[1 1]',...
    'Config.falseDataAttacks{1}.InjectionName = {''ploadMeas(1)'',''qloadMeas(1)''}'},startTime,'singleBus');
% MDPattack({'Config.falseDataAttacks{1}.PenalForNotConvergence=0', ...
%     'Config.falseDataAttacks{1}.learningRate=''2/(sqrt(Iter+1)+2)'''},startTime,'lowLearningRate');
% MDPattack({'Config.falseDataAttacks{1}.PenalForNotConvergence=0', ...
%     'Config.falseDataAttacks{1}.learningRate=''1'''},startTime,'highLearningRate');

% MDPattack({...
%     % 'Config.falseDataAttacks{1}.PenalForNotConvergence=0', ...
%     'Config.falseDataAttacks{1}.reward=''minEigValue'''},startTime,'EigValue');

% MDPattack({'Config.seEnable = 1', ...
%     'Config.falseDataAttacks{1}.reward=''minEigValue'''},startTime,'enableSE1');


    % 'Config.falseDataAttacks{1}.PenalForNotConvergence=0' ...
% MDPattack({ ... 
%     'Config.seEnable = 1' , ...
%     'Config.falseDataAttacks{1}.reward=''minEigValue''' , ...
%     'Config.falseDataAttacks{1}.RatioOffset=[2 0 2 0 2 0]'},startTime,'reverseQ2enableSE2');

% MDPattack({...
%     % 'Config.falseDataAttacks{1}.PenalForNotConvergence=0,',...
%     'Config.falseDataAttacks{1}.RatioOffset=[2 0 2 0 2 0]'},startTime,'reverseQ2');