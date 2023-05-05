function rad = radice(x)
%rad = radice(x)
%Input: x, numero di cui si vuole conoscere la radice
%Output: rad, radice sesta del numero in input
%Restituisce la radice sesta del numero passato in input.

if x==0
    rad=0;
    return;
end
if x<0, error("Non esiste la radice sesta di un numero negativo." + newline + "Riprovare."), end
x0=x;
for i=0:1000
    delta=(1/6)*((x/(x0.^5))-x0);
    x0=x0+delta;
    if (abs(delta)<abs(eps)) %controllo di aver raggiunto la massima precisione possibile
        break; 
    end
end
rad=x0;
return;