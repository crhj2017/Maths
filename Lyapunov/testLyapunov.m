N = 100000;
n = 2;
h = 1e-6;

a = 0.8;
b = 0.4;

M_H = @(x)[1+x(2)-a*x(1)^2; b*x(1)];

xini = [1;1];

[lambda, Rdiag, x] = LyapunovQR(M_H, xini, N);

p1 = x(:,N);
p2 = x(:,N+1);

M = @(p)(M_H(M_H(p)));
dM = @(p)MyJacobian(M,p,h);

e = abs(eigs(dM(p2)));

% lambda 2
e - exp(2*lambda)
