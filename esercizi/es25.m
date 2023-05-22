addpath("functions");
format longG
fprintf("Esercizio 25: \n");

n = [1 2 3 4 5 6 7 9];
fprintf("n\n");
for i=1:length(n)
    a=rats(coefficienti_newton_cotes(n(i)));
    fprintf("%d",n(i));
    disp(a);
end


