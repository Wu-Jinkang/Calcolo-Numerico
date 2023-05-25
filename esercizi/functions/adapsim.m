function [I2, nvalfunz] = adapsim(a, b, f, tol, fa, f1, fb)
%[I2, nvalfunz] = adapsim(a, b, f, tol, fa, f1, fb)
%Input:
%a,b = Estremi dell'intervallo.
%f = Funzione integranda.
%tol = Tolleranza massima.
%fa = Funzione calcolata nell'estremo a.
%f1 = Funzione calcolata nel punto medio.
%fb = Funzione calcolata nell'estremo b.
%Output:
%I2 = Approssimazione calcolata.
%nvalfunz = Numero di valutazioni funzionali.
%Calcola l'approssimazione dell'integrale mediante la formula adattiva Simpson.

if tol <= 0, error("La tolleranza deve essere positiva." + newline + "Riprovare."), end
if a >= b, error("L'intervallo e' stato inserito in maniera non corretta." + newline + "Riprovare."), end

x1 = (a+b)/2;
nvalfunz = 0;
if nargin <= 4
    fa = feval(f, a);
    f1 = feval(f, x1);
    fb = feval(f, b);
    nvalfunz = nvalfunz + 3;
end

h = (b-a)/6;

x2 = (a+x1)/2;
x3 = (x1+b)/2;

f2 = feval(f, x2);
f3 = feval(f, x3);
nvalfunz = nvalfunz + 2;

I1 = h * (fa + 4*f1 + fb);
I2 = (h/2) * (fa + 4*f2 + 2*f1 + 4*f3 + fb);
err = abs(I2 - I1)/15;

if err > tol
    [I2s, nvalfunzs] = adapsim(a, x1, f, tol/2, fa, f2, f1);
    [I2d, nvalfunzd] = adapsim(x1, b, f, tol/2, f1, f3, fb);
    I2 = I2s + I2d;
    nvalfunz = nvalfunz + nvalfunzs + nvalfunzd;
end
return;
end