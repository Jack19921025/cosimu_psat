function ResultData = simplePSAT(Config)
initpsat
clpsat.mesg = Config.verbose; 
% Time domain simulation
disp('Time domain simulation.')
Settings.freq = 60;
clpsat.readfile = 1;
Settings.fixt = 1;
Settings.distrsw = Config.distrsw;
% Settings.static = Config.simuType;

runpsat(Config.caseName,Config.caseFileDir,'data');

CurrentStatus = initialCurrentStatus(Config);

simplePF(Config, CurrentStatus);


if Config.simuType == 0
    Settings.tstep = Config.lfTStep;
else
    Settings.tstep = Config.dynTStep;
end

Settings.tf = Config.simuEndTime;
clpsat.pq2z = 0;
ResultData = initialResultData(Config, CurrentStatus);
if Config.simuType == 0
    ResultData = cosimu_lf(Config, CurrentStatus, ResultData);
else
    ResultData = cosimu_dyn(Config, CurrentStatus, ResultData);
end
