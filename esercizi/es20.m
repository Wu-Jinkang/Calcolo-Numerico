addpath("functions");
format longG
fprintf("Esercizio 20: \n");

nn=1:100;
a = 0; b = 1;
ll  = lebesgue(a, b, nn, 0);
ll1 = lebesgue(a, b, nn, 1);
 
a1 = -3; b1 = 7;
ll2 = lebesgue(a1, b1, nn, 0);
ll3 = lebesgue(a1, b1, nn, 1);

fig = figure;
set(fig, 'DefaultAxesFontName', 'Arial');
set(fig, 'DefaultAxesFontSize', 16);

subplot(2,2,1);
plot(nn, ll);
grid on;
xlabel('Grado del polinomio');
ylabel('Costante di Lebesgue');
title('Ascisse equidistanti per [0, 1]');
 
subplot(2,2,2);
plot(nn, ll1);
grid on;
xlabel('Grado del polinomio');
ylabel('Costante di Lebesgue');
title('Ascisse di Chebyshev [0, 1]');
 
subplot(2,2,3);
plot(nn, ll2);
grid on;
xlabel('Grado del polinomio');
ylabel('Costante di Lebesgue');
title('Ascisse equidistanti per [-3, 7]');

subplot(2,2,4);
plot(nn, ll3);
grid on;
xlabel('Grado del polinomio');
ylabel('Costante di Lebesgue');
title('Ascisse di Chebyshev [-3, 7]');
