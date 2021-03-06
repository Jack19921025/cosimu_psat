function [CurrentStatus,ResultData] = sampleAllMeasurements(Config, ResultData, CurrentStatus)
%     global MDPData  % TAction

    % perfect measurements without latency
    CurrentStatus.ploadMeas = ResultData.allPLoadHis(:, end);
    CurrentStatus.qloadMeas = ResultData.allQLoadHis(:, end);    
    CurrentStatus.genPMeas = ResultData.allPGenHis(:, end);
    CurrentStatus.genQMeas = ResultData.allQGenHis(:, end);
    CurrentStatus.busVMeasPu = ResultData.allBusVHis(:, end);
    CurrentStatus.plineHeadMeas = ResultData.allLineHeadPHis(:, end);
    CurrentStatus.qlineHeadMeas = ResultData.allLineHeadQHis(:, end);
    CurrentStatus.plineTailMeas = ResultData.allLineTailPHis(:, end);
    CurrentStatus.qlineTailMeas = ResultData.allLineTailQHis(:, end);
    
    try
        CurrentStatus.isOpfConverged = ResultData.isOpfConverged(:,end);
    catch e
        CurrentStatus.isOpfConverged = 1;
    end
    CurrentStatus2 = CurrentStatus;
%     
if Config.measLagSchema == 2
    
    % all tunnel use same latency setting
    iSnapshot = length(ResultData.t) - Config.measAllLatency;
    if iSnapshot < 1
        iSnapshot = 1;
    end
    CurrentStatus.ploadMeas = ResultData.allPLoadHis(:, iSnapshot);
    CurrentStatus.qloadMeas = ResultData.allQLoadHis(:, iSnapshot);
    CurrentStatus.genPMeas = ResultData.allPGenHis(:, iSnapshot);
    CurrentStatus.genQMeas = ResultData.allQGenHis(:, iSnapshot);
    CurrentStatus.busVMeasPu = ResultData.allBusVHis(:, iSnapshot);
    CurrentStatus.plineHeadMeas = ResultData.allLineHeadPHis(:, iSnapshot);
    CurrentStatus.qlineHeadMeas = ResultData.allLineHeadQHis(:, iSnapshot);
    CurrentStatus.plineTailMeas = ResultData.allLineTailPHis(:, iSnapshot);
    CurrentStatus.qlineTailMeas = ResultData.allLineTailQHis(:, iSnapshot);
end    
% elseif Config.measLagSchema == 3
%     
%     % all tunnel use same latency setting
%     for iBus = 1 : length(ResultData.allBusIdx)
%         iTun = ResultData.allBusIdx(iBus);
%         iSnapshot = round(length(ResultData.t) - Config.measTunnelLatency(iTun));
%         if iSnapshot < 1
%             iSnapshot = 1;
%         end
%         CurrentStatus.busVMeasPu(iBus) = ResultData.allBusVHis(iBus, iSnapshot);          
%     end
%     
%     nSample = length(ResultData.t);
%     for iTransf = 1 : ResultData.nTransf
%         iTun = ResultData.allTransfHeadBusIdx(iTransf);
%         iSnapshot = round(nSample - Config.measTunnelLatency(iTun));
%         if iSnapshot < 1
%             iSnapshot = 1;
%         end
%         CurrentStatus.transfTMeas(iTransf) = ResultData.allTransfTHis(iTransf, iSnapshot);
%         CurrentStatus.ptransfHeadMeas = ResultData.allTransfHeadPHis(iTransf, iSnapshot);
%         CurrentStatus.qtransfHeadMeas = ResultData.allTransfHeadQHis(iTransf, iSnapshot);
%         CurrentStatus.ptransfTailMeas = ResultData.allTransfTailPHis(iTransf, iSnapshot);
%         CurrentStatus.qtransfTailMeas = ResultData.allTransfTailQHis(iTransf, iSnapshot);       
%     end
%     
%     for iLine = 1 : ResultData.nLines
%         iTun = ResultData.allLineHeadBusIdx(iLine);
%         iSnapshot = round(nSample - Config.measTunnelLatency(iTun));
%         if iSnapshot < 1
%             iSnapshot = 1;
%         end
%         CurrentStatus.plineHeadMeas(iLine) = ResultData.allLineHeadPHis(iLine, iSnapshot);
%         CurrentStatus.qlineHeadMeas(iLine) = ResultData.allLineHeadQHis(iLine, iSnapshot);
%         
%         iTun = ResultData.allLineTailBusIdx(iLine);
%         iSnapshot = round(nSample - Config.measTunnelLatency(iTun));
%         if iSnapshot < 1
%             iSnapshot = 1;
%         end
%         CurrentStatus.plineTailMeas(iLine) = ResultData.allLineTailPHis(iLine, iSnapshot);
%         CurrentStatus.qlineTailMeas(iLine) = ResultData.allLineTailQHis(iLine, iSnapshot);
%     end
%     
%     for iGen = 1 : ResultData.nGens
%         iTun = ResultData.allGenIdx(iGen);
%         iSnapshot = round(nSample - Config.measTunnelLatency(iTun));
%         if iSnapshot < 1
%             iSnapshot = 1;
%         end
%         CurrentStatus.genPMeasKw(iGen) = ResultData.allPGenHis(iGen, iSnapshot);
%         CurrentStatus.genQMeasKva(iGen) = ResultData.allQGenHis(iGen, iSnapshot);
%     end
%     
%     for iLoad = 1 : ResultData.nLoad
%         iTun = ResultData.allLoadIdx(iLoad);
%         iSnapshot = round(nSample - Config.measTunnelLatency(iTun));
%         if iSnapshot < 1
%             iSnapshot = 1;
%         end
%        CurrentStatus.ploadMeas(iLoad) = ResultData.allPLoadHis(iLoad, iSnapshot);
%        CurrentStatus.qloadMeas(iLoad) = ResultData.allQLoadHis(iLoad, iSnapshot);
%     end
% 
% end
% 
% 
if Config.falseDataSchema == 1
    % false data schema 1    
    CurrentStatus.ploadMeas = CurrentStatus.ploadMeas - Config.measErroRatio + Config.measErroRatio * rand(size(CurrentStatus.ploadMeas));
    CurrentStatus.qloadMeas = CurrentStatus.qloadMeas - Config.measErroRatio + Config.measErroRatio * rand(size(CurrentStatus.qloadMeas));    
    CurrentStatus.genPMeas =  CurrentStatus.genPMeas - Config.measErroRatio + Config.measErroRatio * rand(size(CurrentStatus.genPMeas));
    CurrentStatus.genQMeas = CurrentStatus.genQMeas - Config.measErroRatio + Config.measErroRatio * rand(size(CurrentStatus.genQMeas));

    CurrentStatus.plineHeadMeas = CurrentStatus.plineHeadMeas - Config.measErroRatio + Config.measErroRatio * rand(size(CurrentStatus.plineHeadMeas));
    CurrentStatus.qlineHeadMeas = CurrentStatus.qlineHeadMeas - Config.measErroRatio + Config.measErroRatio * rand(size(CurrentStatus.qlineHeadMeas));
    CurrentStatus.plineTailMeas = CurrentStatus.plineTailMeas - Config.measErroRatio + Config.measErroRatio * rand(size(CurrentStatus.plineTailMeas));
    CurrentStatus.qlineTailMeas = CurrentStatus.qlineTailMeas - Config.measErroRatio + Config.measErroRatio * rand(size(CurrentStatus.qlineTailMeas));
    
elseif Config.falseDataSchema == 2
    % this is a special bad data injection attack 
    nAttacks = length(Config.falseDataAttacks);
    for iAttack = 1 : nAttacks
        fa = Config.falseDataAttacks{iAttack};
        nBus = length(fa.toBus);
        for iBus = 1 : nBus
            % find the bus be attacked ; here only attack on substation is
            % modelled. therefore, only buses are used as targets
            busIdx = fa.toBus(iBus);
            switch fa.strategy
                case 1 
                    % for random erro injected into all measurements on this bus, such as v, theta, pl, ql, pg, qg
                    % for v of this bus, using v = v*(1-erroRatio)+random(v*erroRatio)
                    v = CurrentStatus.busVMeasPu(busIdx);
                    CurrentStatus.busVMeasPu(busIdx) = v *(1 - fa.erroRatio/2) + v * fa.erroRatio * rand(1);
                    % for ql and pl on this bus, bus the same random signal
                    % ratio method as v
                    idxLoad = find(ResultData.allLoadIdx==busIdx);
                    if ~isempty(idxLoad)
                        pl = CurrentStatus.ploadMeas(idxLoad) ;
                        CurrentStatus.ploadMeas(idxLoad) = pl * (1 - fa.erroRatio/2) + pl * fa.erroRatio * rand(1);
                        ql = CurrentStatus.qloadMeas(idxLoad) ;
                        CurrentStatus.qloadMeas(idxLoad) = ql * (1 - fa.erroRatio/2) + ql * fa.erroRatio * rand(1);
                    end
                    % for qg and pg on this bus, bus the same random signal
                    % ratio method as v
                    idxGen = find(ResultData.allGenIdx==busIdx);
                    if ~isempty(idxGen)
                        pg = CurrentStatus.genPMeasKw(idxGen) ;
                        CurrentStatus.genPMeasKw(idxGen) = pg * (1 - fa.erroRatio/2) + pg * fa.erroRatio * rand(1);
                        qg = CurrentStatus.genQMeasKva(idxGen) ;
                        CurrentStatus.genQMeasKva(idxGen) = qg * (1 - fa.erroRatio/2) + qg * fa.erroRatio * rand(1);
                    end
                    
                case 1.1 
                    % for random erro augment injected into all measurements on this bus, only on pl, ql
                    % for ql and pl on this bus, bus the same random signal
                    % ratio method as v
                    idxLoad = find(ResultData.allLoadIdx==busIdx);
                    if ~isempty(idxLoad)
                        pl = CurrentStatus.ploadMeas(idxLoad) ;
                        CurrentStatus.ploadMeas(idxLoad) = pl *(1 + fa.erroRatio * rand(1));
                        ql = CurrentStatus.qloadMeas(idxLoad) ;
                        CurrentStatus.qloadMeas(idxLoad) = ql + ql * fa.erroRatio * rand(1);
                    end
                    
                case 1.2 % for random erro decrease injected into all measurements on this bus, only on pl, ql
                    % for ql and pl on this bus, bus the same random signal
                    % ratio method as v
                    idxLoad = find(ResultData.allLoadIdx==busIdx);
                    if ~isempty(idxLoad)
                        pl = CurrentStatus.ploadMeas(idxLoad) ;
                        CurrentStatus.ploadMeas(idxLoad) = pl *(1 - fa.erroRatio * rand(1));
                        ql = CurrentStatus.qloadMeas(idxLoad) ;
                        CurrentStatus.qloadMeas(idxLoad) = ql *(1 - fa.erroRatio * rand(1));
                    end
                    
                case 2 
                    % for augment random erro data injected into all measurements on this bus                   
                    % for v of this bus, using v = v*(1-erroRatio)+random(v*erroRatio)
                    v = CurrentStatus.busVMeasPu(busIdx);
                    CurrentStatus.busVMeasPu(busIdx) = v *(1 - fa.erroRatio/2) + v * fa.erroRatio * rand(1);
                    % for ql and pl on this bus, bus the same random signal
                    % ratio method as v
                    idxLoad = find(ResultData.allLoadIdx==busIdx);
                    if ~isempty(idxLoad)
                        pl = CurrentStatus.ploadMeas(idxLoad) ;
                        CurrentStatus.ploadMeas(idxLoad) = pl * (1 - fa.erroRatio/2) + pl * fa.erroRatio * rand(1);
                        ql = CurrentStatus.qloadMeas(idxLoad) ;
                        CurrentStatus.qloadMeas(idxLoad) = ql * (1 - fa.erroRatio/2) + ql * fa.erroRatio * rand(1);
                    end
                    % for qg and pg on this bus, bus the same random signal
                    % ratio method as v
                    idxGen = find(ResultData.allGenIdx==busIdx);
                    if ~isempty(idxGen)
                        pg = CurrentStatus.genPMeasKw(idxGen) ;
                        CurrentStatus.genPMeasKw(idxGen) = pg * (1 - fa.erroRatio/2) + pg * fa.erroRatio * rand(1);
                        qg = CurrentStatus.genQMeasKva(idxGen) ;
                        CurrentStatus.genQMeasKva(idxGen) = qg * (1 - fa.erroRatio/2) + qg * fa.erroRatio * rand(1);
                    end
                    % change the augDir and erroRatio periodicaly                     
                    if fa.erroRatio >= fa.maxErroRatio
                        fa.augDir = -1;
                    elseif fa.erroRatio <= 0
                        fa.augDir = 1;
                    end
                    fa.erroRatio = fa.erroRatio + fa.augDir*fa.erroRatioStep;
                    Config.falseDataAttacks{iAttack} = fa;
                    
                case 3 % for the conversary voltage control bad data injection on all the measurement on the bus based on currrent v
                     v = CurrentStatus.busVMeasPu(busIdx);
                     vRandDir = 1;
                     loadRandDir = 1;
                     if v > fa.highV
                         vRandDir = -1;
                         loadRandDir = 1;
                     elseif v < fa.lowV
                         vRandDir = 1;
                         loadRandDir = -1;
                     else
                         seed = rand(1);
                         if seed > 0.5
                              vRandDir = 1;                              
                         else
                              vRandDir = -1;
                         end
                         seed = rand(1);
                         if seed > 0.5
                             loadRandDir = 1;                              
                         else
                             loadRandDir = -1;
                         end
                     end
                    CurrentStatus.busVMeasPu(busIdx) = v *(1 + vRandDir * fa.erroRatio);
                    % for ql and pl on this bus, bus the same random signal
                    % ratio method as v
                    idxLoad = find(ResultData.allLoadIdx==busIdx);
                    if ~isempty(idxLoad)
                        pl = CurrentStatus.ploadMeas(idxLoad) ;
                        CurrentStatus.ploadMeas(idxLoad) = pl * (1 + loadRandDir* fa.erroRatio);
                        ql = CurrentStatus.qloadMeas(idxLoad) ;
                        CurrentStatus.qloadMeas(idxLoad) = ql * (1 + loadRandDir * fa.erroRatio);
                    end
                    % for qg and pg on this bus, bus the same random signal
                    % ratio method as v
                    idxGen = find(ResultData.allGenIdx==busIdx);
                    if ~isempty(idxGen)
                        pg = CurrentStatus.genPMeasKw(idxGen) ;
                        CurrentStatus.genPMeasKw(idxGen) = pg * (1 + loadRandDir*fa.erroRatio);
                        qg = CurrentStatus.genQMeasKva(idxGen) ;
                        CurrentStatus.genQMeasKva(idxGen) = qg * (1 + loadRandDir*fa.erroRatio);
                    end
                    
                case 4 % fix rate change of load
                    vRandDir = 1;
                    loadRandDir = -1;
                    v = CurrentStatus.busVMeasPu(busIdx);
                    CurrentStatus.busVMeasPu(busIdx) = v *(1 + vRandDir * fa.erroRatio);
                    % for ql and pl on this bus, bus the same random signal
                    % ratio method as v
                    idxLoad = find(ResultData.allLoadIdx==busIdx);
                    if ~isempty(idxLoad)
                        pl = CurrentStatus.ploadMeas(idxLoad) ;
                        CurrentStatus.ploadMeas(idxLoad) = pl * (1 + loadRandDir* fa.erroRatio);
                        ql = CurrentStatus.qloadMeas(idxLoad) ;
                        CurrentStatus.qloadMeas(idxLoad) = ql * (1 + loadRandDir * fa.erroRatio);
                    end
                    
                    idxLine = find(ResultData.allLineHeadBusIdx == busIdx);
                    if ~isempty(idxLine)
                        ph = CurrentStatus.plineHeadMeas(idxLine) ;
                        CurrentStatus.plineHeadMeas(idxLine) = ph * (1 + loadRandDir* fa.erroRatio);
                        qh = CurrentStatus.qlineHeadMeas(idxLine) ;
                        CurrentStatus.qlineHeadMeas(idxLine) = qh * (1 + loadRandDir * fa.erroRatio);
                    end
                    
                    idxLine = find(ResultData.allLineTailBusIdx == busIdx);
                    if ~isempty(idxLine)
                        pt = CurrentStatus.plineTailMeas(idxLine) ;
                        CurrentStatus.plineTailMeas(idxLine) = pt * (1 + loadRandDir* fa.erroRatio);
                        qt = CurrentStatus.qlineTailMeas(idxLine) ;
                        CurrentStatus.qlineTailMeas(idxLine) = qt * (1 + loadRandDir * fa.erroRatio);
                    end
                    
                    
                case 5 % voltage change rate (trend) is used to generate bad data (converse trend)
                    vHis = ResultData.allBusVHis(busIdx, [end-2:end]);
                    p = polyfit([1:3], vHis, 1);
                    vTrend = p(1);
                    vRandDir = 1;
                    loadRandDir = -1;
                    if vTrend > 0
                        vRandDir = -1;
                        loadRandDir = 1;
                    end
                    v = CurrentStatus.busVMeasPu(busIdx);
                    CurrentStatus.busVMeasPu(busIdx) = v *(1 + vRandDir * fa.erroRatio);
                    % for ql and pl on this bus, bus the same random signal
                    % ratio method as v
                    idxLoad = find(ResultData.allLoadIdx==busIdx);
                    if ~isempty(idxLoad)
                        pl = CurrentStatus.ploadMeas(idxLoad) ;
                        CurrentStatus.ploadMeas(idxLoad) = pl * (1 + loadRandDir* fa.erroRatio);
                        ql = CurrentStatus.qloadMeas(idxLoad) ;
                        CurrentStatus.qloadMeas(idxLoad) = ql * (1 + loadRandDir * fa.erroRatio);
                    end 
                case 6    %MDP attack for false data injection to substations
                    
                    n = length(ResultData.t);
                    MDPData_k = ResultData.MDPData{iAttack};

                    %get new state from simulation
                    states = ones(length(fa.MDPStateName),1);
                    s_new = 0;
                    for stateNameIndex = 1:length(fa.MDPStateName)
                        eval(['S = CurrentStatus.' fa.MDPStateName{stateNameIndex} ';']);
                        statemin = fa.MDPStateLimits(stateNameIndex,1);
                        statemax = fa.MDPStateLimits(stateNameIndex,2);
                        statestep = (statemax-statemin)/(fa.Nstate(stateNameIndex)-2);
                        states(stateNameIndex) = ceil((S-statemin)/statestep)+1;

                        % consider the limits
                        if states(stateNameIndex) < 1 , states(stateNameIndex) = 1;
                        elseif states(stateNameIndex) > fa.Nstate(stateNameIndex) , states(stateNameIndex) = fa.Nstate(stateNameIndex);
                        end

                        s_new = s_new*fa.Nstate(stateNameIndex)+states(stateNameIndex)-1;
                    end
                    s_new = s_new + 1;
                    MDPData_k.s_new = s_new;

                    %get reward
                    switch fa.reward
                        case 'voltage'
                            v = CurrentStatus.busVMeasPu(fa.toBus);
                            if abs(v-1)<0.1
                                MDPData_k.r = abs(v-1) + 1;
                            elseif v-1.1>=0
                                MDPData_k.r = 3*(v-1.1) + 0.1 + 1;
                            elseif v-0.9<=0
                                MDPData_k.r = 3*(0.9-v) + 0.1 + 1;
                            end
                            % penal for OPF not converged
                            if fa.PenalForNotConvergence && ~CurrentStatus.isOpfConverged
                                MDPData_k.r = 0;
                            end
                        case 'pLoss'
                            MDPData_k.r = ResultData.pLossHis(end);
                        case 'minEigValue'
                            MDPData_k.r = - ResultData.minEigValueHis(end);
                            % penal for OPF not converged
                            if fa.PenalForNotConvergence && ~CurrentStatus.isOpfConverged
                                MDPData_k.r = -5;
                            end
                    end
                    

                    %initialization
                    if n == 1 && fa.Qlearning == 1 % && fa.Continouslearning == 0
%                         MDPData_k.r = 0;
%                         MDPData_k.Q = - 5 * ones(fa.Nstate,prod(fa.Naction));
%                         switch fa.reward
%                         case 'voltage'
%                             MDPData_k.Q = zeros(fa.Nstate,prod(fa.Naction));
%                         case 'pLoss'
%                             MDPData_k.Q = zeros(fa.Nstate,prod(fa.Naction));
%                         case 'minEigValue'
%                             MDPData_k.Q = - 5 * ones(fa.Nstate,prod(fa.Naction));
%                         end
                        MDPData_k.s = MDPData_k.s_new;
%                         MDPData_k.a = 1;
%                         MDPData_k.Iters = zeros(prod(fa.Nstate),prod(fa.Naction));
%                         MDPData_k.ActionHistory = [];
%                         MDPData_k.StatesHistory = [];
%                         MDPData_k.rHistory = [];
%                         MDPData_k.VHistory = [];
                    end

                    Iter =  MDPData_k.Iters(MDPData_k.s,MDPData_k.a);
                    MDPData_k.Iters(MDPData_k.s,MDPData_k.a) = Iter+1;
                    MDPData_k.ActionHistory = [MDPData_k.ActionHistory MDPData_k.a];
                    MDPData_k.StatesHistory = [MDPData_k.StatesHistory MDPData_k.s];
                    MDPData_k.rHistory = [MDPData_k.rHistory MDPData_k.r];
                    MDPData_k.VHistory = [MDPData_k.VHistory CurrentStatus.busVMeasPu(fa.toBus)];
                    if fa.Qlearning && ResultData.t(end)<=fa.LearningEndTime
                        % Updating the value of Q   
                        % Decaying update coefficient (1/sqrt(Iter+2)) can be changed
                        delta = MDPData_k.r + fa.MDPDiscountFactor*max(MDPData_k.Q(MDPData_k.s_new,:)) - MDPData_k.Q(MDPData_k.s,MDPData_k.a);
                        dQ = eval(fa.learningRate)*delta;
                        % dQ = delta;
%                         if MDPData_k.Q(MDPData_k.s,MDPData_k.a)>0.2 && abs(dQ)>0.00001 
%                             disp([num2str(MDPData_k.s) ' ' num2str(MDPData_k.a) ' ' num2str(MDPData_k.r) ' ' num2str(length(MDPData_k.rHistory)+1)]);
%                         end
                        MDPData_k.Q(MDPData_k.s,MDPData_k.a) = MDPData_k.Q(MDPData_k.s,MDPData_k.a) + dQ;
                    end

                    % Current state is updated
                    MDPData_k.s = MDPData_k.s_new;

                    % Action choice : greedy with increasing probability
                    % probability 1-(1/log(Iter+2)) can be changed
                    pn = rand(1); 
                    if (pn < (1-(1/log(Iter+2)))) || fa.Qlearning == 0 || ResultData.t(end)>fa.LearningEndTime
                      [~,MDPData_k.a] = max(MDPData_k.Q(MDPData_k.s,:));
                    else
                      MDPData_k.a = randi([1,prod(fa.Naction)]);
                    end
%                     MDPData_k.id = MDPData_k.id + 1;
%                     if mod(length(MDPData_k.rHistory),15)<5
%                         MDPData_k.a = 8627;
%                     else
%                         MDPData_k.a = 1626;
%                     end
                    %take action
                    Ratios = action2Ratio(MDPData_k.a,fa.Naction,fa.MDPBusFalseDataRatioStep,fa.RatioOffset);
                    
                    for k = 1:length(Ratios)
                        eval(['CurrentStatus.' fa.InjectionName{k}  ...
                            ' = CurrentStatus2.' fa.InjectionName{k} ' * Ratios(k);']);
                    end
                    
                    ResultData.MDPData{iAttack} = MDPData_k;
                    
                otherwise  
            end               
        end
    end
    
end


end
