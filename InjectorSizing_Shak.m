%% initialize params 
OD=55.11/1000;%m
ID=45.71/1000;%m

AnnulusArea=(pi()/4)*(OD^2-ID^2);

m_dot=0.32;%kg/s total

h_massFrac=0.1116;
O_massFrac=1-h_massFrac;

m_dot_h=m_dot*h_massFrac;
m_dot_O=m_dot*O_massFrac;

gamma=1.4; %should check on this; in anal model we get gamma of mixed gas, this should be gamma of separate.
R_O=259.84; %J/kg*k %gas constant O 
R_H=4124.2; %J/kg*k     %gas constant H
T_t=300;%K assume constant temp

%% Critical Injector Area Calculation
% Equations taken from:
% - "Small-size rotating detonation engine: scaling and minimum mass flow
% rate" [Sean Connolly-Boutin et al]

% P_o = ;
% T_o = ;
% 
% A_star = m_dot_P_history/((SQRT(gamma1_fr)*P_o)/(SQRT(R_sp/w1)*T-o);
% 
% disp([' '])
% disp(['................................................................']);
% disp(['Critical Injector Area'])
% 
% disp([' '])
% disp(['Critical Injector Area ', num2str(A_star),' (m^2)']);
