clf;
% Variables
a = 0.8; b = 0.4;
offset = 0.11; h = 1e-6;

% System
M = @(u)[1+u(2,:)-a*u(1,:).^2;b*u(1,:)];
dM = @(x)MyJacobian(M,x,h);

% Unstable fixed point of M
p = [(b-1+sqrt((b-1)^2 + 4*a))/(2*a);
    b*(b-1+sqrt((b-1)^2 + 4*a))/(2*a)];

[V,D] = eigs(dM(p));

eValues = abs(diag(D));

Vu = V(:,eValues>1);
Vs = V(:,eValues<1);

Wu = [p-offset*Vu, p, p+offset*Vu];
Ws = [p-offset*Vs, p, p+offset*Vs];

s = linspace(0,1,size(Wu,2));

maxDist = 0.01;
maxAngle = 5;

ynew = Wu;
hold on
for i = 1:15
    plot(ynew(1,:),ynew(2,:),".-")
    [ynew,xnew,s] = MapLine(M,ynew,s,maxDist,maxAngle);  
end
hold off

[ynew,xnew,s] = MapLine(M,ynew,s,maxDist,maxAngle);