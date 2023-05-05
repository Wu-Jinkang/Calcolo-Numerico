load('data.mat'); % carica i dati dal file data.mat
x = data(:,1); % estrae la prima colonna come vettore x
y = data(:,2); % estrae la seconda colonna come vettore y

% divide i dati in un set di training (70%) e un set di validation (30%)
n_total = length(x);
n_train = round(n_total * 0.7);
idx_train = randperm(n_total, n_train);
idx_val = setdiff(1:n_total, idx_train);

x_train = x(idx_train);
y_train = y(idx_train);
x_val = x(idx_val);
y_val = y(idx_val);

% calcola l'errore di predizione per diversi gradi del polinomio
n_max = 10; % massimo grado del polinomio
err_val = zeros(n_max, 1);
for n = 1:n_max
p = polyfit(x_train, y_train, n);
y_pred = polyval(p, x_val);
err_val(n) = norm(y_val - y_pred);
end

% grafica la norma del residuo rispetto a valori crescenti di n
plot(1:n_max, err_val, 'o-');
xlabel('Grado del polinomio');
ylabel('Norma del residuo');
title('Errore di predizione sul set di validation');


[min_err, n_best] = min(err_val);
fprintf('Il grado del polinomio che minimizza l''errore di predizione sul set di validation è %d\n', n_best);