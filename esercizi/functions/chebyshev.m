function x = chebyshev(n, a, b)
%x = chebyshev(n, a, b)
%Input:
%n = Grado del polinomio
%a, b = Estremi dell'intervallo.
%Output:
%x = Ascisse di Chebyshev.
%Calcola le ascisse di Chebyshev.
if nargin < 3
    error("Il numero degli argomenti e' errato." + newline + "Riprovare.");
elseif n <= 0 || n ~= fix(n)
        error("Il grado del polinomio deve essere positivo." + newline + "Riprovare.");
elseif a >= b
        error("L'intervallo e' stato inserito in maniera non corretta." + newline + "Riprovare.");
end

x = cos(((2*(0:n) + 1)*pi)/(2*(n+1))); %Ascisse su [-1,1]
x = (a+b)/2 + ((b-a)/2)*x;

return;
end