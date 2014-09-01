startTime =  strrep(strrep(datestr(now), ':', '-'), ' ', '-');
mkdir(['../debug/' startTime])
MDPattack([],startTime,'basic');
MDPattack({'Config.falseDataAttacks{1}.PenalForNotConvergence=0'},startTime,'noPenal');
MDPattack({'Config.falseDataAttacks{1}.PenalForNotConvergence=0,',...
    'Config.falseDataAttacks{1}.RatioOffset=[2 0 2 0 2 0]'},startTime,'reverseQ');
MDPattack({'Config.falseDataAttacks{1}.PenalForNotConvergence=0', ...
    'Config.falseDataAttacks{1}.learningRate=''2/(sqrt(Iter+1)+2)'''},startTime,'lowLearningRate');
MDPattack({'Config.falseDataAttacks{1}.PenalForNotConvergence=0', ...
    'Config.falseDataAttacks{1}.learningRate=''1'''},startTime,'highLearningRate');