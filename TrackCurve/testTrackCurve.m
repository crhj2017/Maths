%% test MyTrackCurve using simple functions
clear;clf;

f=@(y)(y(1)^2+y(2)^2-1);
y0=[0;1];
ytan=[1;0];

hjac=1e-4;
df=@(y)MyJacobian(f,y,hjac);

% This call may have to be adapted if your function cannot cope with options:
ylist=MyTrackCurve(f,df,y0,ytan,'stepsize',0.01,'maxStepsize',2,'minStepsize',1e-6, "nmax", 100);
%% Plot the result (should be a circle)
plot(ylist(1,:),ylist(2,:),'.');
axis equal
