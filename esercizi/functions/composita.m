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

u = 1;
if mod(n, 2) ~= 0, error("Il numero delle ascisse non e' un multiplo pari di k." + newline + "Riprovare.");
else 
    u = 2;
end

%GUARDA BILIOT

return;
end