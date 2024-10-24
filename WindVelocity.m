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

A=rhosl*s*cd0/2;
B=2*k*w^2/(rhosl*s);

d_min=2*w*sqrt(k*cd0);
cl_d_min=sqrt(cd0/k);
v_d_min=sqrt((2*w)/(rhosl*s*cl_d_min));
cl_br=sqrt(cd0/(3*k));
cd_br=cd0+k*cl_br^2;
v_br=sqrt((2*w)/(rhosl*s*cl_br));
d_br=(cd_br/cl_br)*w;
i=1;
min=v_d_min/v_br;
for vbgr=0.8:0.01:1.5
    w(i)=(vbgr^5-vbgr)/(2/3-2*vbgr^4);
    i=i+1;
end

v1=0.8:0.01:1.5;
p(1)=yline(v_d_min,'r--','DisplayName','V Minimum Drag');
hold on;
xline(0);
p(2)=plot(w*v_br,v1*v_br,'b','LineWidth',2,'DisplayName','V Maximum Best Range');
p(3)=yline(v_br,'g--','DisplayName','V Best Range without Wind');
title('Best Range Velocity vs Wind Velocity');
xlabel('V wind (m/s)');
ylabel('V Best Range (m/s)');
xlim([-100 100]);
ylim([v_d_min-10 250]);
legend(p);
