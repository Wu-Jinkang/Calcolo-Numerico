function [I2, nvalfunz] = composita_adattiva_newton_cotes_4(a, b, f, tol, fa, fm, f2, f3, fb)
%[I2, nvalfunz] = composita_adattiva_newton_cotes_4(a, b, f, tol, fa, fm, f2, f3, fb)
%Input:
%a,b = Estremi dell'intervallo.
%f = Funzione integranda.
%tol = Tolleranza massima.
%fa = Funzione calcolata nell'estremo a.
%fm = Funzione calcolata nel punto medio.
%f2 = Funzione calcolata nel punto compreso tra l'estremo sinistro ed il punto medio. 
%f3 = Funzione calcolata nel punto compreso tra il punto medio e l'estremo
%destro
%fb = Funzione calcolata nell'estremo b.
%Output:
%I2 = Approssimazione calcolata.
%nvalfunz = Numero di valutazioni funzionali.
%

if tol <= 0, error("La tolleranza deve essere positiva." + newline + "Riprovare."), end
if a >= b, error("L'intervallo e' stato inserito in maniera non corretta." + newline + "Riprovare."), end

xm = (a+b)/2;
x2 = (a+xm)/2;
x3 = (xm+b)/2;

nvalfunz = 0;
if nargin <= 4
    fa = feval(f, a);
    fb = feval(f, b);
    fm = feval(f, xm);
    f2 = feval(f, x2);
    f3 = feval(f, x3);
    nvalfunz = nvalfunz + 5;
end

h = (b-a)/90;

I1 = h * (7*fa + 32*f2 + 12*fm + 32*f3 + 7*fb);

x4 = (a + x2)/2;
x5 = (x2 + xm)/2;
x6 = (xm + x3)/2;
x7 = (x3 + b)/2;

f4 = feval(f, x4);
f5 = feval(f, x5);
f6 = feval(f, x6);
f7 = feval(f, x7);
nvalfunz = nvalfunz + 4;

I2 = h/2 * (7*fa + 32*f4 + 12*f2 + 32*f5 + 14*fm + 32*f6 + 12*f3 + 32*f7 + 7*fb);

err = abs(I2-I1)/63;

if err > tol
    [I2s, nvalfunzs] = composita_adattiva_newton_cotes_4(a, xm, f, tol/2, fa, f2, f4, f5, fm);
    [I2d, nvalfunzd] = composita_adattiva_newton_cotes_4(xm, b, f, tol/2, fm, f3, f6, f7, fb);
    I2 = I2s + I2d; 
    nvalfunz = nvalfunz + nvalfunzs + nvalfunzd;
end
return;
end