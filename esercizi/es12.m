addpath("functions");
format longG
fprintf("Esercizio 12: \n");
n = 5;
[A1, A2, b1, b2] = linsis1(5, 1);
%{
fprintf("A1:\n");
fprintf([repmat('%.15f\t', 1, size(A1, 2)) '\n'], A1');
fprintf("\nA2:\n");
fprintf([repmat('%.15f\t', 1, size(A2, 2)) '\n'], A2');
fprintf("\nb1:\n");
fprintf([repmat('%.15f\t', 1, size(b1, 2)) '\n'], b1');
fprintf("\nb2:\n");
fprintf([repmat('%.15f\t', 1, size(b2, 2)) '\n'], b2');
%}

disp(cond(A1));
x1 = mialdl(A1, b1);
fprintf("\nx1:\n");
fprintf([repmat('%.15f\t', 1, size(x1, 2)) '\n'], x1');

disp(cond(A2));
x2 = mialdl(A2, b2);
fprintf("x2:\n");
fprintf([repmat('%.15f\t', 1, size(x2, 2)) '\n'], x2');