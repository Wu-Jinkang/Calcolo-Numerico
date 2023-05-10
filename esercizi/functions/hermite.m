function yy = hermite(xi, fi, f1i, xx)
% 
% yy = hermite(xi, fi, f1i, xx)
%
%Input:
%xi = Vettore colonna contenente le ascisse d'interpolazione.
%fi = Vettore colonna contenente i valori della funzione nelle ascisse d'interpolazione.
%f1i = Vettore colonna contenente i valori della derivata prima, che assume nelle ascisse d'interpolazione.
%xx = Vettore contenente le ascisse in cui vogliamo approssimare la funzione.
%Output:
%yy = Valori approssimati della funzione con il polinomio interpolante di hermite.
%Calcola i valori approssimati della funzione, calcolati attraverso il polinomio interpolante in forma di Lagrange nelle ascisse xx.

if(length(xi) ~= length(unique(xi))), error("Le ascisse d'interpolazione non sono distinte tra loro." + newline + "Riprovare."),end 
if(length(xi) ~= length(fi)), error("Il numero delle ascisse d'interpolazione e quello dei valori della funzione non corrisponde." + newline + "Riprovare."),end
if(isempty(xx)), error("Il vettore xx non contiene alcuna ascissa." + newline + "Riprovare."), end  
if(length(fi) ~= length(f1i)), error("La lunghezza di fi non corrisponde a quella di f1i." + newline + "Riprovare."),end
if(size(xi,2)>1 || size(fi,2)>1 || size(f1i,2)>1), error("Non sono stati inseriti correttamente i vettori colonna." + newline + "Riprovare."),end

n = (length(xi));
fi(1:2:2*n-1) = fi;
fi(2:2:2*n) = f1i;

diff_divise = differenze_divise(xi, fi');
  
n = length(diff_divise)-1;
yy = diff_divise(n+1)*ones(size(xx));    
%Uso l'algoritmo di Horner per ridurre il numero di operazioni
for i = n:-1:1
    yy = yy.*(xx-xi(ceil(i/2)))+diff_divise(i);
end
return;
end
  
function f = differenze_divise(x, f)
%Calcola le differenze divise
n = (length(f)/2)-1;

for i = 2*n+1:-2:3
    f(i) = (f(i)-f(i-2))/(x(ceil(i/2))-x(ceil((i-1)/2)));
end
for j = 2:2*n+1
    for i = (2*n+2):-1:j+1
        f(i) = (f(i)-f(i-1))/(x(ceil(i/2))-x(ceil((i-j)/2)));
    end
end
return;
end