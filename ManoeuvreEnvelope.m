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

%Airspeed Limits
vstall=sqrt((2*w)/(rhosl*s*cl_max));
va=vstall*sqrt(n1);
vc=231; %maximum cruising speed
vd=243;

c1=n1/(va^2);
for i=1:va
    x(i)=c1*i^2;
end

c2=n3/(vstall^2);
for j=1:vstall
    y(j)=c2*j^2;
end

figure();
hold on;
yline(0);
yline(n1,'b--','n1: The Positive Load Factor');
yline(n2,'y--','n2');
yline(n3,'b--','n3: The Negative Load Factor');
yline(1,'k--','n=1');
%p(1)=xline(vstall,'k-.','Stall Velocity');
p(1)=plot([vstall vstall],[n3 1],'g-.','DisplayName','Stall Velocity');
%p(2)=xline(va,'b','V A');
p(2)=plot([va va],[n3 n1],'r-.','DisplayName','Design Manoeuvring Speed');
%p(3)=xline(vc,'m','V C');
p(3)=plot([vc vc],[n3 n1],'c-.','DisplayName','Design Cruising Speed');
%p(4)=xline(vd,'g','V D');
p(4)=plot([vd vd],[n2 n1],'m-.','DisplayName','Maximum Speed in Level Flight with Maximum Continuous Power');
plot([vc vd],[n3 n2],'b');
plot([vstall vc],[n3 n3],'b');
plot([va vd],[n1 n1],'b');
ylim([-2 4]);
xlim([0 300]);
title('The Manoeuvre Envelope');
xlabel('Velocity (m/s)');
ylabel('n - Load Factor');

i=1:va;
plot(i,x,'b');
j=1:vstall;
plot(j,y,'b');
legend(p);
