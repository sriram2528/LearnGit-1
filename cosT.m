clc;
clear all;

%% System Matrices for a Distillation Process
%% of the Form dx/dt = Ax + Bu
A =randi(2,2);
B = [0 1]';

K = lqr(A,B,diag([1 1]),1);
F = A-B*K;

%% Simulate Your LQ Optimal Control Design

tf=100; dt=0.001; t=0; 
x0=[1 1]'; x=x0;
X=[];  T=[]; U=[]; 
while (t<=tf);
    T=[T;t]; X=[X,x];
    u=cos(t); U=[U,u];
    x=x+dt*(F*x+B*u);
    t=t+dt;
end;

figure(1);
subplot(2,1,1); 
plot(T,X); hold on; box on; grid on;
plot(T,cos(T),'k'); 

ylabel('system states (x)');
legend('x1','x2');
subplot(2,1,2); 
plot(T,U);hold on; box on; grid on;
ylabel('control signals (u)');
xlabel('time (sec)');
legend('u1','u2');