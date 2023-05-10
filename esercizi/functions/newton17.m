function s = newton(x, y, xq)
%s = newton(x, y, xq)
%Input:
%x = Vettore colonna contenete le ascisse d'interpolazione.
%y = Vettore colonna contenete i valori della funzione nelle ascisse d'interpolazione.
%xq = Vettore contente le ascisse in cui vogliamo approssimare la funzione.
%Output:
%s = Valori approssimati della funzione.
%Calcola i valori approssimati della funzione, ottenuti attraverso il polinomio interpolante in forma di Newton nelle ascisse xq.

if(length(x) ~= length(unique(x))), error("Le ascisse d'interpolazione non sono distinte tra loro." + newline + "Riprovare."),end 
if(length(x) ~= length(y)), error("Il numero delle ascisse d'interpolazione e quello dei valori della funzione non corrisponde." + newline + "Riprovare."),end
if(isempty(xq)), error("Il vettore contenente le ascisse in cui interpolare la funzione e' vuoto." + newline + "Riprovare."),end
if(size(x,2) > 1 || size(Y,2) > 1 || size(xq,2) > 1),error("Non sono stati inseriti correttamente i vettori colonna." + newline + "Riprovare."),end

diff_divise = differenze_divise(x, y);
n = length(diff_divise) - 1;
s = diff_divise(n+1) * ones(size(xq));

%Uso l'algoritmo di Horner per ridurre il numero di operazioni
for i=n:-1:1
    s = s.*(xq-x(i)) + diff_divise(i);  
end
return;
end

function diff_divise = differenze_divise(x, f)
%Calcola le differenze divise
n = size(x);
if(n ~= length(f)), error("La dimensione di x e quella di f non coincidono." + newline + "Riprovare."), end
diff_divise = f;
n = n-1;
for i = 1 : n
    for j = n + 1 : -1 : i + 1
        diff_divise(j) = (diff_divise(j) - diff_divise(j-1))/(x(j) - x(j-i));
    end
end
return;
end