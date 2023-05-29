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

if nargin < 3
    error("Il numero degli argomenti e' errato." + newline + "Riprovare.");
elseif length(xi) ~= length(fi)
    error("La lunghezza dei due vettori non corrisponde." + newline + "Riprovare.");
elseif length(xi) ~= length(unique(xi))
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
    hi1 = (xi(i+1) - xi(i));
    q(i-1) = hi / (hi + hi1);
    epsilon(i-1) = hi1 / (hi + hi1);
end

diff_div = diff_div_spline(xi, fi); %Calcolo le differenze divise

a = 2*ones(n-1,1);

%Caso default oppure type diverso da 0 -> Spline not-a-knot
if nargin < 4 || type ~= 0
    diff_div = diff_div * 6;

    a(1) = 2 - q(1);
    epsilon(1) = epsilon(1) - q(1);
    diff_div_1 = diff_div(1);
    diff_div(1) = (1 - q(1)) * diff_div(1);
    q(1) = 0;

    a(n-1) = 2 - epsilon(n-1);
    q(n-1) = q(n-1) - epsilon(n-1);
    diff_div_n = diff_div(n-1);
    diff_div(n-1) = (1 - epsilon(n-1)) * diff_div(n-1);
    epsilon(n-1) = 0;

    m = tridia(a, epsilon, q, diff_div);

    m0 = diff_div_1 - m(1) - m(2);
    mn = diff_div_n - m(n-1) - m(n-2);
    m = [m0; m; mn];
else
    %Caso type == 1 -> Spline naturale
    m = tridia(a, epsilon, q, diff_div * 6);
    m = [0; m; 0];
end
   
yy = calcola_punti(xi, fi, m, xx);
return;
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
%x = Vettore soluzione.
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

yy = zeros(length(xx), 1);

for j = 1 : length(xx)
    for i = 2 : length(xi) 
        if((xx(j) >= xi(i-1) && xx(j) <= xi(i)) || xx(j) < xi(1))
            hi = xi(i)-xi(i-1);
            ri = fi(i-1)-hi^2/6*m(i-1);
            qi = (fi(i)-fi(i-1))/hi-hi/6*(m(i)-m(i-1));
            yy(j) =((xx(j)-xi(i-1))^3*m(i)+(xi(i)-xx(j))^3*m(i-1))/(6*hi)+qi*(xx(j)-xi(i-1))+ri;
            break
        end
    end
end
return;
end