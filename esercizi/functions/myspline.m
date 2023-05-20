function yy = myspline(xi, fi, xx, type)
%yy = myspline(xi, fi, xx, type)
%Input:
%xi = Valori delle ascisse.
%fi = Valori della funzione calcolati nelle ascisse.
%xx = Vettore contenente le ascisse a cui voglio approssimare la funzione.
%type = Tipologia per risolvere l'esercizio.
%Output:
%yy = Spline calcolata.
%Calcola la spline cubica interpolante naturale oppure la not-a-knot, a
%seconda del valore di type.

if nargin < 4
    error("Il numero degli argomenti e' errato." + newline + "Riprovare.");
elseif length(xi) ~= length(fi)
    error("La lunghezza dei due vettori non corrisponde." + newline + "Riprovare.");
elseif length(xi) ~= unique(xi)
    error("Le ascisse di interpolazione non sono distinte tra loro." + newline + "Riprovare.");
elseif size(xi, 2) > 1 || size(fi, 2) > 1
    error("Non e' stato inserito un vettore colonna correttamente." + newline + "Riprovare.")
elseif isempty(xx)
    error("La partizione assegnata e' vuota." + newline + "Riprovare.");
end

n = length(xi) - 1;
epsilon = zeros(n-1,1); %Vettore sovradiagonale
q = zeros(n-1,1); %Vettore sottodiagonale

for i = 2 : n
    hi = (xi(i) - xi(i-1));
    hi1 = (xi(+1) - x(i));
    q(i-1) = hi / (hi + hi1);
    epsilon(i-1) = hi1 / (hi + hi1);
end

diff_div = diff_div_spline(xi, fi); %Calcolo le differenze divise

a = 2*ones(n-1,1);
if type == 0
    m = tridia(a, q, epsilon, diff_div * 6);
    m = [0; m; 0];
else
    a(1) = 2 - q(1);
    a(n-1) = 2 - epsilon(n-1);
    q(n-1) = q(n-1) - epsilon(n-1);
    epsilon(1) = epsilon(1) - q(1);
    diff_div(1) = (1 - q(1)) * diff_div(1);
    diff_div(n-1) = (1 - epsilon(n-1)) * diff_div(n-1);
    
    m = tridia(a, q, epsilon, diff_div * 6);
end

yy = calcola_punti(xi, fi, m, xx);
end

function diff_div = diff_div_spline(xi, fi)
%diff_div = diffdivspline(xi, fi)
%Input:
%xi = Valori delle ascisse.
%fi = Valori della funzione calcolati nelle ascisse.
%Output:
%diff_div = Differenze divise calcolate.
%Calcola le differenze divise per la spline

n = size(xi);
diff_div = fi;
n = n-1;
for j = 1 : 2
    for i = n+1 : -1 : j+1
        diff_div(i) = (diff_div(i) - diff_div(i-1))/(xi(i) - xi(i-j));
    end
end
diff_div = diff_div(3:n+1);
return;
end

function x = tridia(a, b, c, g)
%x = tridia(a, b, c, g)
%Input:
%a = Vettore diagonale principale.
%b = Vettore sovradiagonale.
%c = Vettore sottodiagonale.
%g = Vettore dei termini noti.
%Output:
%x = Vettore soluzione
%Risoluzione di un sistema tridiagonale.

n = length(g);
x = g;
for i = 1 : n-1
   b(i) = b(i)/a(i);
   a(i+1) = a(i+1) - b(i)*c(i);
   x(i+1) = x(i+1) - b(i)*x(i);
end

x(n) = x(n)/a(n);
for i = n-1 : -1 : 1
   x(i) = (x(i) - c(i)*x(i+1))/a(i);
end
return;
end

function yy = calcola_punti(xi, fi, m, xx)
%yy = calcola_punti(xi, fi, m, xx)
%Input:
%xi = Valori delle ascisse.
%fi = Valori della funzione calcolati nelle ascisse.
%m = Matrice dei coefficienti.
%xx = Partizione assegnata.
%Output:
%yy = Valori della spline.
%Calcola i valori della spline nei punti definiti in xx.

n = length(xi);
yy = zeros(size(xx));

for i = 1:length(xx)
    for j = 1:n-1
        if xx(i) >= xi(j) && xx(i) <= xi(j+1)
            yy(i) = m(j,1)*(xi(j+1)-xx(i))^3/6 + m(j+1,1)*(xx(i)-xi(j))^3/6 + (fi(j)-m(j,1)*((xi(j+1)-xi(j))/6)^2)*(xi(j+1)-xx(i))/(xi(j+1)-xi(j)) + (fi(j+1)-m(j+1,1)*((xi(j+1)-xi(j))/6)^2)*(xx(i)-xi(j))/(xi(j+1)-xi(j));
        end
    end
end
end