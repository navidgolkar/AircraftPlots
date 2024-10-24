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
F(32000)=0;

for h=1:32000
    [x,~,y,z]=atmosisa(h);
    T(h)=x;
    P(h)=y;
    rho(h)=z;
end
P(32000)=0;
rho(32000)=0;
T(32000)=0;

flag=0;
for h=1:32000
    switch 1
        case h<=11000
            F(h)=fsl*(rho(h)/rhosl)^0.7;
        case 11000<h
            F(h)=fsl*1.435*(rho(h)/rhosl);
    end
    if F(h)<d_min && flag==0
        h_c=h;
        flag=1;
    end
end

flag=0;
for i=1:h_c-1
    cl_nu_max=((-F(i)/w)+sqrt(((F(i)/w)^2)+12*k*cd0))/(2*k);
    cd_nu_max=cd0+k*(cl_nu_max^2);
    gamma_max=(F(i)/w)-(cd_nu_max/cl_nu_max);
    %v_max(i)=sqrt((F(i)+sqrt(F(i)^2-4*A*B))/(2*A))/sqrt((rho(i)/rhosl));
    v_max=sqrt((2*w*cos(gamma_max))/(rho(i)*s*cl_nu_max));
    nu_max(i)=v_max*gamma_max;
    inver(i)=1/nu_max(i);
end

figure();
hold on;
H=1:h_c-1;
plot(H,nu_max,'b','LineWidth',1,'DisplayName','RC Max');
plot(H,inver,'g','LineWidth',1,'DisplayName','1/RC');
xline(h_c,'k--','LineWidth',1,'DisplayName','Ceiling Height');
xline(10900,'r--','LineWidth',1,'DisplayName','Tropopause');
legend('RC Max','1/RC','Ceiling Height','Tropopause');
ylim([0 50]);
xlim([0 16000]);
title('ROC vs Velocity');
xlabel('Height (m)');
ylabel('Maximum Rate of Climb (m/s)');
grid on
