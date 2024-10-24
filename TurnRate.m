clear all;
close all;
clc;
format compact;

[tsl,~,psl,rhosl]=atmosisa(0);

%aircraft properties
s=122.4;
cd0=0.037;
w=93000*9.81;
fsl=2*147000;
cl_max=2.2;
r=286.9;
AR=9.5;
e=0.9244;
k=1/(e*AR*pi);

%Structural Limits
n1=2.1+(24000/(0.225*w+10000));
n2=1-0.3*n1;
n3=-0.4*n1;
gamma1=acos(1/n1);

%Airspeed Limits
vstall=sqrt((2*w)/(rhosl*s*cl_max));
va=vstall*sqrt(n1);
vd=243;

for velocity=1:vd
    turn1(velocity)=vstall*tan(gamma1)/(velocity);
end

for loadfactor=1:25
   vel=sqrt(((loadfactor+9)/10)*(vstall^2));
   gam=acos(1/((loadfactor+9)/10));
   turn2(loadfactor)=tan(gam)/sqrt((loadfactor+9)/10);
end

p(1)=xline(va,'g','DisplayName','Design Manoeuvring Speed');
hold on;
p(2)=xline(vd,'r','DisplayName','Maximum Speed in Level Flight with Maximum Continuous Power');
ylim([0 2]);
velocity=1:vd;
p(3)=plot(velocity,turn1,'b','DisplayName','Structural Limit (n=n1)');
loadfactor=1:25;
p(4)=plot(sqrt(((loadfactor+9)/10)*(vstall^2)),turn2,'m--','DisplayName','Buffet Velocity');
legend(p);
title('The Manoeuvre Boundaries');
xlabel('Velocity (m/s)');
ylabel('Rate of Turn (rad/s)');
