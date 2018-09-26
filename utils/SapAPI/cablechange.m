   %% clean-up the workspace & command window
   clear;
   clc;

%% pass data to Sap2000 as one-dimensional arrays
   feature('COM_SafeArraySingleDim', 1);

%% pass non-scalar arrays to Sap2000 API by reference
   feature('COM_PassSafeArrayByRef', 1);

%% create Sap2000 object
   SapObject = actxserver('CSI.SAP2000.API.SapObject');

%% start Sap2000 application
   SapObject.ApplicationStart;

%% create SapModel object
   SapModel = SapObject.SapModel;

%% initialize model
   ret = SapModel.InitializeNewModel;


%   'open an existing file
   FileName =[ 'D:\SAP\stage_1.sdb']
   ret = SapModel.File.OpenFile(FileName);
%% switch to k-m units
   kN_m_C = 6;
   ret = SapModel.SetPresentUnits(kN_m_C);

FileName=['D:\SAP\result_opt.sdb'];
ret = SapModel.File.Save(FileName);

    CablenumberLtoR=  [36          26 37          ];
    PretensionLtoR=[0.9998			0.9999	0.9995				];

   %% unlocked model
ret = SapModel.SetModelIsLocked(0);
%%   'set cable data
PretensionLtoR
   for j=1:length(CablenumberLtoR)
   cablenumber=num2str(CablenumberLtoR(j));
   ret = SapModel.CableObj.SetCableData(cablenumber, 9, 1, 0, 0, PretensionLtoR(j));
   end
%%  run model and set output

%   'run model (this will create the analysis model)
   ret = SapModel.Analyze.RunAnalysis;
% 'clear all case and combo output selections
    ret = SapModel.Results.Setup.DeselectAllCasesAndCombosForOutput;

% 'set case and combo output selections
   ret = SapModel.Results.Setup.SetCaseSelectedForOutput('nonlinear');
%  set output option
   Envelopes=1;
   Step_by_Step=2;
   Last_Step=3;
   ret = SapModel.Results.Setup.SetOptionNLStatic(Envelopes);
