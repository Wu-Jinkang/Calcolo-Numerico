addpath("functions");
format longG
fprintf("Esercizio 23: \n");

% Definizione della funzione di Runge
f = @(x) 1./(1+x.^2);

% Ascisse equidistanti
x = linspace(-5,5,10001);

% Ascisse della partizione
n_values = 4:4:400;
errors_natural = zeros(size(n_values));
errors_not_a_knot = zeros(size(n_values));

%err_mat = zeros(size(n_values));

for i=1:length(n_values)
    n = n_values(i);
    xi = linspace(-5,5,n+1);
    yi = f(xi);

    %s_mat = spline(xi, f(xi), x);
    %err_mat(i) = max(abs(s_mat - f(x)));

    % Spline interpolante naturale
    s_natural = myspline(xi',yi',x', 0);
    errors_natural(i) = max(abs(f(x)-s_natural'));

    % Spline interpolante not-a-knot
    s_not_a_knot = myspline(xi',yi',x', 1);
    errors_not_a_knot(i) = max(abs(f(x)-s_not_a_knot'));
end

% Grafico dell'errore di approssimazione
semilogy(n_values, errors_natural, 'g', n_values, errors_not_a_knot, 'b');
legend('Spline naturale','Spline not-a-knot');
xlabel('Numero di nodi');
ylabel('Errore di approssimazione');