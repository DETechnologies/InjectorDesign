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


%% init desired params
CombutionInitPressure=130e+3;
PlenumDesired=1.89*CombutionInitPressure*3; 

e=0.5e+3;
stepsize=1e-4;

% starting point A_i/A_a:
AreaRatio_O=0.17; 
AreaRatio_H=0.06;

%% start iterator
iterator=1

loopNum=0; %init couter.
if iterator
    while true %for oxygen first.
        OxyInjectorArea=AnnulusArea*AreaRatio_O;
        P_upstream_O=(m_dot_O*sqrt(T_t)/OxyInjectorArea)*sqrt(R_O/gamma)*(((gamma+1)/2)^((gamma+1)/(2*(gamma-1))));

        if abs(P_upstream_O - PlenumDesired) < e
            %jump out!!!
            break
        else
            if (P_upstream_O - PlenumDesired) > e
                AreaRatio_O=AreaRatio_O+stepsize;
            elseif (P_upstream_O - PlenumDesired) < -e
                AreaRatio_O=AreaRatio_O-stepsize;
            end
        end 
        loopNum=loopNum+1;
        fprintf('\n \nloop number: %d',loopNum)
    end 
    % print results
    fprintf('\nOxygen Plenum Pressure, %d',P_upstream_O)
    fprintf('\nOxygen Injection Area Ratio, %d',AreaRatio_O)
    fprintf('\nOxygen Injection Area [m^3], %d',OxyInjectorArea)

    % NOW REPEAT THE SAME THING FOR HYDROGEN

    loopNum=0; % reset counter.
    fprintf('\n \nloop number: %d',loopNum)
    while true 
        HydroInjectorArea=AnnulusArea*AreaRatio_H;
        P_upstream_H=(m_dot_h*sqrt(T_t)/HydroInjectorArea)*sqrt(R_H/gamma)*(((gamma+1)/2)^((gamma+1)/(2*(gamma-1))));

        if abs(P_upstream_H - PlenumDesired) < e
            %jump out!!!
            break
        else
            if (P_upstream_H - PlenumDesired) > e
                AreaRatio_H=AreaRatio_H+stepsize;
            elseif (P_upstream_H - PlenumDesired) < -e
                AreaRatio_H=AreaRatio_H-stepsize;
            end
        end 
        loopNum=loopNum+1;
        fprintf('\n \nloop number: %d',loopNum)
    end 
    % print results
    fprintf('\nHydrogen Plenum Pressure, %d',P_upstream_H)
    fprintf('\nHydrogen Injection Area Ratio, %d',AreaRatio_H)
    fprintf('\nHydrogen Injection Area [m^3], %d',HydroInjectorArea)
end 

% Print All Results
fprintf('\n\n\n\nSummary')
fprintf('\nOxygen Plenum Pressure, %d',P_upstream_O)
fprintf('\nOxygen Injection Area Ratio, %d',AreaRatio_O)
fprintf('\nOxygen Injection Area [m^3], %d',OxyInjectorArea)
fprintf('\nHydrogen Plenum Pressure, %d',P_upstream_H)
fprintf('\nHydrogen Injection Area Ratio, %d',AreaRatio_H)
fprintf('\nHydrogen Injection Area [m^3], %d',HydroInjectorArea)
