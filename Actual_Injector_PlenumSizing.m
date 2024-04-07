% DETechnologies - 2024
% Logan Palmer

%% Housekeeping
close all force 
clear 
clc

%% Initialize Params 
% geometry
OD=60e-3;
Delta=5e-3;
ID=OD-2*Delta;

AnnulusArea=(pi()/4)*(OD^2-ID^2);
m_dot=0.33472; % g/s total

% mass flow rate of propellant
h_massFrac=0.11191;
O_massFrac=1-h_massFrac;
m_dot_h=m_dot*h_massFrac;
m_dot_O=m_dot*O_massFrac;

% chemical properties
gamma=1.4013789; 
R_O=259.84; % gas constant O 
R_H=4124.2; % gas constant H
T_t=293; % K assume constant temp

%% Init Actual Injection Areas based on DFMA / Physical Constraints
OxyInjectorArea=12.2727/100;
HydroInjectorArea=5.4545/100;

%% Calculate Req'd Upstream Pressure
P_upstream_O=(m_dot_O*sqrt(T_t)/OxyInjectorArea)*sqrt(R_O/gamma)*(((gamma+1)/2)^((gamma+1)/(2*(gamma-1))));
P_upstream_H=(m_dot_h*sqrt(T_t)/HydroInjectorArea)*sqrt(R_H/gamma)*(((gamma+1)/2)^((gamma+1)/(2*(gamma-1))));

% summary
fprintf('Summary')
fprintf("\nP_upstream_O: %f kPa",P_upstream_O)
fprintf("\nP_upstream_H: %f kPa",P_upstream_H)










