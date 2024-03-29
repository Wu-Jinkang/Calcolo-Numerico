function s = lagrange(x, y, xq)
%s = lagrange(x, y, xq)
%Input:
%x = Vettore contenete le ascisse d'interpolazione.
%y = Vettore contenete i valori della funzione nelle ascisse d'interpolazione.
%xq = Vettore contenente le ascisse in cui vogliamo approssimare la funzione.
%Output:
%s = Valori approssimati della funzione.
%Calcola i valori approssimati della funzione, ottenuti mediante il polinomio interpolante, in forma di Lagrange, nelle ascisse xq.

if(length(x) ~= length(unique(x))), error("Le ascisse d'interpolazione non sono distinte tra loro." + newline + "Riprovare."),end 
if(length(x) ~= length(y)), error("Il numero delle ascisse d'interpolazione e quello dei valori della funzione non corrisponde." + newline + "Riprovare."),end
if(isempty(xq)), error("Il vettore contenente le ascisse in cui interpolare la funzione è vuoto." + newline + "Riprovare."),end
if(size(x,2) > 1 || size(y,2) > 1 || size(xq,2) > 1),error("Non sono stati inseriti correttamente i vettori colonna." + newline + "Riprovare."),end
 
n = size(x, 1);
Lin = ones(size(xq, 1), n);
%Calcolo la produttoria Lin(x)
for i = 1 : n
    for j = 1 : n
        if (i~=j)
            Lin(:,i)=Lin(:,i).*((xq-x(j))/(x(i)-x(j)));
        end
    end
end
s = zeros(size(xq));
%Calcolo la sommatoria fi*Lin(x)
for i=1:n
    s = s+y(i).*Lin(:,i);
end
end