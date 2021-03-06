clear;
addpath([pwd, '\coSimu']);
addpath([pwd, '\psat']);
addpath([pwd, '\psat\filters']);
addpath([pwd, '\matpower4.1']);
addpath([pwd, '\matpower4.1\extras\se']);
addpath([pwd, '\debug']);
addpath([pwd, '\tests']);
addpath([pwd, '\loadshape']);
pwdstr = pwd;

Config = initialConfig();

%% user config for experiment
Config.verbose = 0; % 0 not output details ; 1 output all logs
Config.caseName = 'd_014_dyn_cy.m'; % case name for psat simulator
Config.opfCaseName = 'case14'; % case name for the matpower4.1
Config.simuEndTime = 1800; % seconds based simulation time, 5*60 means 5 min;
Config.controlPeriod = 2*60; % seconds based control interval, 2*60 means 2 min;
Config.sampleRate  = 0.5; % secnods based sample rate for all measurements;
Config.enableOPFCtrl = 1; % opf control should be used for this control;
Config.enableLoadShape = 1; % load shape will not enable for this simulation;
Config.lfTStep = 0.5 % seconds based time step for lf model driven simulation;
Config.dynTStep = 0.05; % seconds based time step for dyn model driven simulation;
Config.seEnable = 1; % 0 disable, 1 enable state estimation;
Config.measLagSchema = 1; %1 for perfect comm with no latency; 2 for same latency for all tunnels; 3 for dif. latency for dif. tunnels;
Config.ctrlLagSchema = 1; %1 for perfect comm with no latency; 2 for same latency for all tunnels; 3 for dif. latency for dif. tunnels;
Config.falseDataSchema = 0; % 0 for no false data  ; 1 for random erro based on white noise ; 2 for special false data strategy

%% cyber attacks

% Config.falseDataSchema = 2;
% Config.falseDataAttacks{1}.toBus = [2:3];
% Config.falseDataAttacks{1}.strategy = [4]';
% Config.falseDataAttacks{1}.erroRatio = [0.3]';
           

%% execute the simulation

% testBadDataInjectionMulti(Config, 2);

parpool(6)
spmd
  % build magic squares in parallel
  testBadDataInjectionMulti(Config, labindex);
end