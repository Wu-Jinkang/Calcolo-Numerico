load("data.mat");
x = data(:, 1);
y = data(:, 2);
errori = zeros(10, 1);
for i = 1 : 10
    p = polyfit(x, y, i);
    y_tilde = polyval(p, x);
    errori(i) = norm(y - y_tilde, inf);
end

[errore, indice] = min(errori);
disp(errore);
disp(indice);

plot(1:10, errori);
xlabel("Grado del polinomio");
ylabel("Norma del residuo");