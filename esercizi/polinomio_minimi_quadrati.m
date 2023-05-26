load("data.mat");
format lonG;
x = data(:, 1);
y = data(:, 2);
errori = zeros(10, 1);
for i = 1 : 10
    p = polyfit(x, y, i);
    y_tilde = polyval(p, x);
    errori(i) = norm(x.^i - y_tilde);
end

[errore, grado] = min(errori);
disp(errore);
disp(grado);

plot(1:10, errori);
xlabel("Grado del polinomio");
ylabel("Norma del residuo");