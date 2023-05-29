%% Single test call of IVP
clear
%% x''=-x-x'+cos(t) -> solution is [sin(t);cos(t)]
f=@(t,x)[x(2);... % function f defining
-x(1)-x(2)+cos(t)]; % right-hand side
%% other inputs
tspan=[0,2*pi]; % time interval
N=4000; % number of steps
xini=[0;1]; % initial value
[xend,t,xt]=MyIVP(f,xini,tspan,N); % call IVP
plot(t,xt,'.-'); % plot solution