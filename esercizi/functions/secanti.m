function [x, passi, valutazioni_funzionali] = secanti(x0, x1, func, tol, max)
%[x, passi, valutazioni_funzionali] = secanti(x0, x1, f, tol, max)
%Input:
%x0 = Punto di partenza
%x1 = Punto calcolato con un iterazione del metodo di Newton da x0
%func = Funzione di cui si vuole conoscere la radice
%Input opzionali:
%tol = Tolleranza richiesta (default = impostata sulla precisone di macchina)
%max = Numero massimo di iterazioni (default = impostati a 1000)
%Output:
%x = Soluzione approssimata
%passi = Numero di passi effetutati prima di raggiungere la tolleranza desiderata 
%valutazioni_funzionali = Numero di valutazioni funzionali effettuate dal metodo
%Calcola un'approssimazione della radice della funzione passata come argomento.

if ~exist("tol", "var"), tol=eps; end 
if ~exist("max", "var"), max=1000; end

valutazioni_funzionali = 0;
passi=0;
f = func(x0);
valutazioni_funzionali = valutazioni_funzionali +1;
x = x1;
for i = 1:max
    passi = passi+1;
    if(abs(x-x0)<tol*(1+abs(x0))), break, end
    f0 = f;
    f = func(x);
    valutazioni_funzionali = valutazioni_funzionali +1;
    if f0 == f, disp("Precisione massima raggiunta."), break, end
    x1 = (f*x0-f0*x)/(f-f0); 
    x0 = x;
    x = x1;
end
if abs(x-x1)>tol*(1+abs(x0)), disp("Il metodo non converge."), end
return;
end