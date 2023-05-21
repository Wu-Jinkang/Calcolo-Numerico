addpath("functions");
format longG
fprintf("Esercizio 21: \n");

a  = -5; b = 5;
f  = @(x) 1 ./ (1 + x.^2);
f1 = @(x) -2*x ./ (1 + x.^2).^2;

xx = linspace(a, b, 10001)';

nn=(2:2:100)';
err_la_eq = zeros(length(nn), 1);
err_ne_eq = zeros(length(nn), 1);
err_la_ch = zeros(length(nn), 1);
err_ne_ch = zeros(length(nn), 1);
for i = 1:length(nn)
    deg = nn(i);
    xi = linspace(a, b, deg+1); fi = f(xi);
    
    yq = lagrange(xi', fi', xx);
    err_la_eq(i) = max(abs(f(xx) - yq));

    yq = newton17(xi', fi', xx);
    err_ne_eq(i) = max(abs(f(xx) - yq));
    
    % Cheby
    xi = chebyshev(deg +1, a, b); fi = f(xi);
    yq = lagrange(xi', fi', xx);
    err_la_ch(i) = max(abs(f(xx) - yq));

    yq = newton17(xi', fi', xx);
    err_ne_ch(i) = max(abs(f(xx) - yq));

end
fig = figure;
semilogy(nn, err_la_eq)
hold on;
grid on;
semilogy(nn, err_ne_eq)
semilogy(nn, err_la_ch)
semilogy(nn, err_ne_ch)


nn=(3:2:99)';
err_he_eq = zeros(length(nn), 1);
err_he_ch = zeros(length(nn), 1);
for i = 1:length(nn)
    deg = nn(i);
    xi = linspace(a, b, deg+1); fi = f(xi); f1i = f1(xi);

    yq = hermite(xi', fi', f1i', xx);
    err_he_eq(i) = max(abs(f(xx) - yq));

    xi = chebyshev(deg +1, a, b); fi = f(xi); f1i = f1(xi);
    yq = hermite(xi', fi', f1i', xx);
    err_he_ch(i) = max(abs(f(xx) - yq));
end

semilogy(nn, err_he_eq)
semilogy(nn, err_he_ch)
legend("Lagrange equidistanti", "Newton equidistanti", "Lagrange Chebyshev", ...
    "Newton Chebyshev", "Hermite equidistanti", "Hermite Chebyshev");