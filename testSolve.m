%% Test Newton iteration using Rosenbrock’s banana
% we find the minimum of obj=((1-x(1))^2+100*(x(2)-x(1)^2)^2);
% by solving grad obj=0 with a Newton iteration:
h=1e-5;
f=@(x)[...
2*(1-x(1))+200*(x(2)-x(1)^2)*x(1);...
200*(x(2)-x(1)^2)];
df=@(x)MyJacobian(f,x,h);
maxit=10;
tolerance=1e-6;
x0=[0;0]; % x0 is the initial guess
[x,conv]=MySolve(f,x0,df,tolerance,maxit);
% the solution should be [1;1] after 5 (or so) iterations
disp('solution')
disp(x)