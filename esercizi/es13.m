addpath("functions");
format longG
fprintf("Esercizio 13: \n");
n = 5;
A = [ 1 3 2; 3 5 4; 5 7 6; 3 6 4; 1 4 2 ];
b = [ 15 28 41 33 22 ]';
D = diag(1:5);
D1 = diag(pi*[1 1 1 1 1]);

%{
[x, nr] = miaqr(A, b);
fprintf("A x = b: %.15f\n", nr);
fprintf([repmat('%.15f\t', 1, size(x, 2)) '\n'], x');
%}

%Secondo me questo risulato è sbagliato
%{
[x, nr] = miaqr(D*A, D*b);
fprintf("(D*A)x = (D*b): %.15f\n", nr);
fprintf([repmat('%.15f\t', 1, size(x, 2)) '\n'], x');
%}

%{
[x, nr] = miaqr(D1*A, D1*b);
fprintf("(D1*A)x = (D1*b): %.15f\n", nr);
fprintf([repmat('%.15f\t', 1, size(x, 2)) '\n'], x');
%}