addpath("functions");
format longG
fprintf("Esercizio 27: \n");

a = 0; b = 1;
n = 12;

f = @(x) sum(((1:5)') .* cos( 2 * pi *((1:5)') .* x ) ...
    - exp((1:5)') .* sin( 2 * (pi * ((1:5)') + 0.1) .* x));

for k = 1: 6
    [If, err] = composita(f, a, b, k, n);
    disp("Iterazione " + k);
    disp(If);
end
 