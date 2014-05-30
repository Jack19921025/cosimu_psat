function [CurrentStatus] = sampleAllMeasurements(Config, ResultData, CurrentStatus)
    global MDPData

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
                case 6    %MDP attack for false data injection on substations
                    
                    n = length(ResultData.t);
                    %get state from simulation
                    V = CurrentStatus.busVMeasPu(fa.toBus);
                    MDPData.s_new = ceil((V-1+fa.MDPBusVStateStep*(fa.Nstate+2)/2)/fa.MDPBusVStateStep);
                    if MDPData.s_new < 1 MDPData.s_new = 1;
                    elseif MDPData.s_new > fa.Nstate  MDPData.s_new = fa.Nstate;
                    end
                    MDPData.r = norm(CurrentStatus.busVMeasPu(fa.toBus)-1);
                    
                    %initialization
                    if n == 1
                        MDPData.r = 0;
                        MDPData.Q = zeros(fa.Nstate,fa.Naction);
                        MDPData.s = MDPData.s_new;
                        MDPData.a = ceil(fa.Naction);
                    end
                    
                    % Updating the value of Q   
                    % Decaying update coefficient (1/sqrt(n+2)) can be changed
                    delta = MDPData.r + fa.MDPDiscountFactor*max(MDPData.Q(MDPData.s_new,:)) - MDPData.Q(MDPData.s,MDPData.a);
                    dQ = (1/sqrt(n+2))*delta;
                    MDPData.Q(MDPData.s,MDPData.a) = MDPData.Q(MDPData.s,MDPData.a) + dQ;

                    % Current state is updated
                    MDPData.s = MDPData.s_new;
                    
                    % Action choice : greedy with increasing probability
                    % probability 1-(1/log(n+2)) can be changed
                    pn = rand(1);
                    if (pn < (1-(1/log(n+2))))
                      [~,MDPData.a] = max(MDPData.Q(MDPData.s,:));
                    else
                      MDPData.a = randi([1,fa.Naction]);
                    end
                    
                    %take action
                    CurrentStatus.busVMeasPu(fa.toBus) = V * (1 + fa.MDPBusFalseDataRatioStep * ...
                        floor(MDPData.a-fa.Naction/2) );
                    
                otherwise  
            end               
        end
    end
    
end


end
