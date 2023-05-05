addpath("functions");
format longEng
disp("Esercizio 6: ");

f = @(x) x - cos(x);
df = @(x) 1 + sin(x);
x0 = 0;
x1 = 0.1;
tol = [ 10.^-3, 10.^-6, 10.^-9, 10.^-12 ];
[N, Npassi, Ncomputazioni] = arrayfun(@(t) newton(x0, f, df, t), tol);
[S, Spassi, Scomputazioni] = arrayfun(@(t) secanti(x0, x1, f, t), tol);
T = table(Npassi', N', Ncomputazioni', Spassi', S', Scomputazioni','VariableNames',{'Passi Newton','Valore Newton', 'Computazioni Newton', 'passi Secanti','Valore Secanti', 'Computazioni Secanti'});
T.Properties.RowNames = compose('%d', tol);
disp(T);