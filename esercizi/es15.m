addpath("functions");
format longG
fprintf("Esercizio 15: \n");
n = 100;
e = 1/n*(1:1:n)';
Q = 2*eye(n) + diag(ones(n-1,1),1) + diag(ones(n-1,1),-1);
func = @(x) 1/2*x'*Q*x-e'*(sin((pi/2)*x)+x);
grad  = @(x) Q*x - e' * (1 + cos((pi/2)*x));
jacob = @(x) Q + e' * (sin((pi/2) * x));
tol = 1e-3;
tol_8 = 1e-8;
tol_13 = 1e-13;

%fprintf([repmat('%.2f\t', 1, size(e, 2)) '\n'], e');
%fprintf([repmat('%.2f\t', 1, size(Q, 2)) '\n'], Q');
%testfsin = fsin(1:1:100);
%fprintf([repmat('%.2f\t', 1, size(testfsin, 2)) '\n'], testfsin');

[x, nit] = newton_j(grad, jacob, zeros(n,1), tol, 1000);
[x_8, nit_8] = newton_j(grad, jacob, zeros(n,1), tol_8, 1000);
[x_13, nit_13] = newton_j(grad, jacob, zeros(n,1), tol_13, 1000);
%fprintf([repmat('%.2f\t', 1, size(x, 2)) '\n'], x');
%fprintf([repmat('%.2f\t', 1, size(nit, 2)) '\n'], x');
fig = figure;
plot(1:1:100, x);
hold on;
grid on;
plot(1:1:100, x_8);
plot(1:1:100, x_13);
legend("Tol 1e^-3", "Tol 1e^-8", "Tol 1e^-13");