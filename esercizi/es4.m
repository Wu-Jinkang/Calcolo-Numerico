addpath("functions");
format longEng
disp("Esercizio 4: ");

x = logspace(-10, 10, 20);
y1 = x.^(1/6);
y2 = arrayfun(@(x) radice(x), x);

T = table(x', y1', y2', 'VariableNames', {'x', 'y1', 'y2'});
disp(T);