%Written and prepared by Navid Golkar
%Flight(Altitude) Enevelope diagram of Airbus A321

clear all;
close all;
clc;
format compact;

h1=0:11;
h2=12:20;
[t1,~,p1,rho1]=atmosisa(h1*1000);
[t2,~,p2,rho2]=atmosisa(h2*1000);
temperature=[t1';t2'];
density=[rho1';rho2'];

%aircraft properties
[tempsl,~,psl,rhosl]=atmosisa(0);
s=122.4;
cd0=0.037;
w=93000*9.81;
tsl=2*140000;
cl_max=2.2;
hcruise=11.9;
gamma=1.4;
r=286.9;
mach_max=0.3;
k=0.0344;

%flight envelope
A=0.5*density*s*cd0;
B=(2*k*w^2)./(density*s);
ta1=tsl*(rho1/rhosl).^0.7;
ta2=1.43*tsl*rho2/rhosl;
ta=[ta1';ta2'];
vmax=sqrt((ta+sqrt(ta.^2-4.*A.*B))./(2.*A));
vmin=sqrt((ta-sqrt(ta.^2-4.*A.*B))./(2.*A));
vstall=sqrt((2*w)./(density*s*cl_max));
vcomp=mach_max.*sqrt(gamma*r*temperature);

h=[h1,h2];
plot(vmax,h,'m','LineWidth',2);
title('Flight Envelope');
xlabel('V (m/s)');
ylabel('H (km)');
hold on;
plot(vmin,h,'b','LineWidth',2);
axis([0 1000 0 22]);
plot(vstall,h,'r--','LineWidth',1);
z=0:1000;
plot(z,hcruise*ones(1001,1),'g--','LineWidth',1);
plot(vcomp,h,'k--','LineWidth',1);
legend('V max','V min','V stall','H cruise','V Compressibility');
xlim([0 450]);
grid on;
