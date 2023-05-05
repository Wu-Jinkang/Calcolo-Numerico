addpath("functions");
format longG
disp("Esercizio 7: ");

f = @(x) (x - cos(x)).^5;
df = @(x) 5*(x-cos(x))^4*(sin(x)+1);
x0 = 0;
x1 = 0.1;
tol = [ 10.^-3, 10.^-6, 10.^-9, 10.^-12 ];
[N, Npassi, Ncomp] = arrayfun(@(t) newton(x0, f, df, t), tol);
[mN, mNpassi, NMcomp] = arrayfun(@(t) newton_modificato(x0, f, df, 5, t), tol);
[S, Spassi, Scomp] = arrayfun(@(t) secanti(x0, x1, f, t), tol);

T = table(Ncomp', Scomp', NMcomp', mNpassi', mN', Npassi', N', Spassi', S','VariableNames',{'Ncomp', 'Scomp', 'NMcomp','Passi Newton modificato','Valore Newton modificato','Passi Newton','Valore Newton','passi Secanti','Valore Secanti'});
T.Properties.RowNames = compose('%d', tol);
disp(T);