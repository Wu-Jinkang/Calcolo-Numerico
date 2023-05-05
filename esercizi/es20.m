addpath("functions");
format longG
fprintf("Esercizio 20: \n");

nn = 1:100;
a = 0;
b = 1;

%ll = lebesgue2(a, b, nn, 0);
disp(1:10001);
lebesgue_plot(10001,1:10001, [a, b], "plot", "plot");
%plot(ll);
%ll = lebesgue(a, b, nn, 1);

a = -3;
b = 7;