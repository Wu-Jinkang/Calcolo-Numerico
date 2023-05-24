function [If, err] = composita(fun, a, b, k, n)
%[If, err] = composita(fun, a, b, k, n)
%Input:
%fun = Identificatore function della funzione integranda
%a,b = Estremi dell'intervallo di integrazione.
%k = Grado del polinomio
%n = Numero delle ascisse.
%Output:
%If = Approssimazione dell'integrale ottenuta.
%err = Stima dell'errore di quadratura.
%Calcolo della formula composita di Newton-Cotes di grado k u n+1 ascisse
%equidistanti, con n multiplo pari di k.

if a >= b, error("L'intervallo e' stato inserito in maniera non corretta." + newline + "Riprovare."), end
if k <= 0, error("Il grado del polinomio deve essere positivo." + newline + "Riprovare."), end
if n <= 0, error("Il numero delle ascisse non e' corretto."+ newline + "Riprovare."), end
if mod(n, 2) ~= 0, error("Il numero delle ascisse non e' un multiplo pari di k." + newline + "Riprovare."), end

mu = 1;
if mod(n, 2) ~= 0
    mu = 2;
end

coefficienti = coefficienti_newton_cotes(k);
h = (b-a)/n;

If = 0;
for i = 0:n-1
    I1 = If;
    x = linspace(a + i*h, a + (i+1)*h, k+1);
    fx = feval(fun, x);
    If = If + h/k*sum(fx.*coefficienti);
end

err = abs(If-I1)/(2^(n+mu)+1);

return;
end