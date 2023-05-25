addpath("functions");
format longG;
fprintf("Esercizio 30: \n");

a = 1e-5; b = 1;
f = @(x) 1./x .* cos(log(1./x));

tols = [1e-2, 1e-3, 1e-4, 1e-5, 1e-6, 1e-7, 1e-8, 1e-9]';
sim = zeros(length(tols), 2);
ad4 = zeros(length(tols), 2);
for i=1:length(tols)
    [I2, nvalfunz] = adapsim(a, b, f, tols(i));
    sim(i,1) = abs(sin(log(10^5)) - I2);
    sim(i, 2) = nvalfunz;
    [I2, nvalfun] = composita_adattiva_newton_cotes_4(a, b, f, tols(i));
    ad4(i,1) = abs(sin(log(10^5)) - I2);
    ad4(i, 2) = nvalfun;
end
disp(sim);
disp(ad4);