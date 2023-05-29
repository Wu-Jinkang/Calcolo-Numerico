function [x, passi, valutazioni_funzionali] = newton(x0, f, f1, tol, max)
%[x, passi, valutazioni_funzionali] = newton(x0, f, f1, tol, max)
%Input
%x0 = Punto di partenza
%f = Funzione di cui si vuole conoscere la radice
%f1 = Derivata prima della funzione f
%Input opzionali:
%tol = Tolleranza richiesta (default = impostata sulla precisone di macchina)
%max = Numero massimo di iterazioni (default = impostati a 1000)
%Output
%x = Soluzione approssimata
%passi = Numero di passi effetutati prima di raggiungere la tolleranza desiderata 
%valutazioni_funzionali = Numero di valutazioni funzionali effettuate dal metodo
%Calcola un'approssimazione della radice della funzione passata come argomento.

if ~exist("max", "var"), max=1000; end
if ~exist("tol", "var"), tol=eps; end

passi = 1;
valutazioni_funzionali = 0;
fx = f(x0);
f1x = f1(x0);
valutazioni_funzionali = valutazioni_funzionali + 2;

if f1x == 0, error("Derivata prima uguale a 0." + newline + "Riprovare."),end

x = x0-fx/f1x;
while(passi < max) && abs(x-x0)>tol*(1+abs(x0))
    passi = passi+1;
    x0 = x;
    fx = f(x0);
    f1x = f1(x0);
    valutazioni_funzionali = valutazioni_funzionali + 2;
    if f1x==0, error("Derivata prima uguale a 0." + newline + "Riprovare."),end
    x = x0-fx/f1x;
end
if abs(x-x0)>tol*(1+abs(x0)),error("Il metodo non converge." + newline + "Riprovare."),end
return;
end