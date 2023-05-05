function ll = lebesgue2(a, b, nn, type)
%
%   ll = lebesgue(a, b, nn, type)
%
%   lebesgue(a, b, nn, type) calcola la costante di Lebesgue per
%   l'interpolazione polinomiale sull'intervallo [a,b], per i polinomi di
%   grado specificato nel vettore nn, utilizzando ascisse equidistanti, se
%   type=0, o di Chebyshev, se type=1. ll è un vettore delle stesse
%   dimensioni di nn contenente le costanti di Lebesgue corrispondenti.
%
%   INPUT
%        a,b - estremi dell'intervallo
%        nn - vettore
%        type - se type=0 utilizza ascisse equidistanti, se type=1
%        Chebyshev
%
%   OUTPUT
%       ll - valore approssimato
%

if type == 0
    % Ascisse equidistanti
    x = linspace(a, b, 10001)';
else
    % Ascisse di Chebyshev
    x = (b-a)/2*cos(pi*(0:10000)'/10000) + (a+b)/2;
end

nmax = max(nn);
ll = zeros(size(nn));

for k = 1:length(nn)
    n = nn(k);
    xi = linspace(a, b, n)';
    L = ones(10001, n);
    for j = 1:n
        for i = 1:n
            if i ~= j
                L(:, j) = L(:, j) .* (x-xi(i))/(xi(j)-xi(i));
            end
        end
    end
    ll(k) = max(sum(abs(L), 2));
end