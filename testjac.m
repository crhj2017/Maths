format long g
format compact

% Test
f = @(x)[sin(x(3))+sin(x(1)*x(2)); cos(x(1)+x(2)*x(3)^2)];
h = 1e-6;

x0=[0;0;0];
df0=MyJacobian(f,x0,h)
x1=[1;1;1];
df1=MyJacobian(f,x1,h)