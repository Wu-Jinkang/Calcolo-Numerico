addpath("functions");
format longG
disp("Esercizio 9: ");

%1° Test:
%A = [7 4 7; 7 6 1; 7 2 3];
%b = [1; 1; 8];
%2° Test:
%A = [7 1 7; 3 4 8; 9 4 2];
%b = [5; 5; 6];

A = A*A';
x = mialdl(A,b);
disp(x);
