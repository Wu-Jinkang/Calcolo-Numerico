addpath("functions");
format longG
disp("Esercizio 10: ");

%1° TEST
A = [6 2; 6 9; 4 1];
b = [1; 2; 2];
[x, nr] = miaqr(A,b);

disp(x);
disp(nr);
disp(A\b);

%2° TEST
A = [8 1 2; 1 5 9; 2 4 7; 4 2 5];
b = [9; 1; 7; 7];
[x, nr] = miaqr(A,b);

disp(x);
disp(nr);
disp(A\b);

%CORRETTO