function I2 = adapsim(a, b, f, tol, fa, f1, fb)
%I2 = adapsim(a, b, f, tol, fa, f1, fb)
%Input:
%a,b = Estremi dell'intervallo.
%f = Funzione integranda.
%tol = Tolleranza massima.
%fa = Funzione calcolata nell'estremo a.
%f1 = Funzione calcolata nel punto medio.
%fb = Funzione calcolata nell'estremo b.
%Output:
%I2 = Approssimazione calcolata.
%Calcola l'approssimazione dell'integrale mediante la formula adattiva Simpson.

if tol <=0, error("La tolleranza deve essere positiva." + newline + "Riprovare."), end
if a >=b, error("L'intervallo e' stato inserito in maniera non corretta." + newline + "Riprovare."), end
x1 = (a+b)/2;
if nargin <= 4
    fa = feval(f, a);
    f1 = feval(f, x1);
    fb = feval(f, b);
end
h = (b-a)/6;
x2 = (a+x1)/2;
x3 = (x1+b)/2;
f2 = feval(f, x2);
f3 = feval(f, x3);
I1 = h * (fa + 4*f1 + fb);
I2 = .5 * h * (fa + 4*f1 + 2*f2 + 4*f3 + fb);
err = (abs(I2 - I1))/15;
if err > tol
    I2 = adapsim(a, x1, f, tol/2, fa, f2, f1) + adapsim(x1, b, f, tol/2, f1, f3, fb);
end
return;
end