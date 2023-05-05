function [A1,A2,b1,b2] = linsis1(n,simme)
%
%
rng(0);
[q1,r1] = qr(rand(n));
if nargin==2
    q2 = q1';
else
    [q2,r1] = qr(rand(n));
end;
A1 = q1*diag([1 2/n:1/n:1])*q2;
A2 = q1*diag([1e-10 2/n:1/n:1])*q2;
b1 = sum(A1,2);
b2 = sum(A2,2);
return