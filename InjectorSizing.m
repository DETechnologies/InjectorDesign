%
close all force
clear 
clc

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

iterator=1

%% sonic nozzle mass flow choking
if ~ iterator
    AreaRatio=0.15;%area of injector / area of annulus
    InjectorArea=AnnulusArea*AreaRatio;
    
    %Oxygen first
    P_upstream_O=(m_dot_O*sqrt(T_t)/InjectorArea)*sqrt(R_O/gamma)*(((gamma+1)/2)^((gamma+1)/(2*(gamma-1))));
    
    
    AreaRatio=0.06;%area of injector / area of annulus
    InjectorArea=AnnulusArea*AreaRatio;
    
    %Hydrogen now
    P_upstream_H=(m_dot_h*sqrt(T_t)/InjectorArea)*sqrt(R_H/gamma)*(((gamma+1)/2)^((gamma+1)/(2*(gamma-1))));
end 
%% iterator loop

PlenumDesired=1.33e+6; 
e=0.005e+6;
stepsize=0.001;

loopNum=0; %couter init.
if iterator
    AreaRatio=0.11; %starting point for oxygen
    while true %for oxygen first.
        OxyInjectorArea=AnnulusArea*AreaRatio;
        P_upstream_O=(m_dot_O*sqrt(T_t)/OxyInjectorArea)*sqrt(R_O/gamma)*(((gamma+1)/2)^((gamma+1)/(2*(gamma-1))));

        if abs(P_upstream_O - PlenumDesired) < e
            %jump out!!!
            break
        else
            if (P_upstream_O - PlenumDesired) > e
                AreaRatio=AreaRatio+stepsize;
                fprintf("\n UP!")
            elseif (P_upstream_O - PlenumDesired) < -e
                AreaRatio=AreaRatio-stepsize;
                fprintf("\n DOWN!")
            end
        end 
        loopNum=loopNum+1;
        fprintf('\n \nloop number: %d',loopNum)
    end 
    disp(['Oxygen Details! Injector Area:',num2str(OxyInjectorArea),"m^3"]);
    disp(["AnnulusArea Ratio:",num2str(AreaRatio)]);

    % NOW REPEAT THE SAME THING FOR HYDROGEN!!!!!!
    AreaRatio=0.06;
    stepsize=0.0005;
    while true 
        HydroInjectorArea=AnnulusArea*AreaRatio;
        P_upstream_H=(m_dot_h*sqrt(T_t)/HydroInjectorArea)*sqrt(R_H/gamma)*(((gamma+1)/2)^((gamma+1)/(2*(gamma-1))));

        if abs(P_upstream_H - PlenumDesired) < e
            %jump out!!!
            break
        else
            if (P_upstream_H - PlenumDesired) > e
                AreaRatio=AreaRatio+stepsize;
                fprintf("\n UP!")
            elseif (P_upstream_H - PlenumDesired) < -e
                AreaRatio=AreaRatio-stepsize;
                fprintf("\n DOWN!")
            end
        end 
        loopNum=loopNum+1;
        fprintf('\n \nloop number: %d',loopNum)
    end 
    disp(['Hydrogen Details! Injector Area:',num2str(HydroInjectorArea),"m^3"]);
    disp(["AnnulusArea Ratio:",num2str(AreaRatio)]);
end 




