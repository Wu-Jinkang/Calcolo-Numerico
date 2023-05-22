function rad = radice(x)
%rad = radice(x)
%Input: 
$x = Numero di cui si vuole conoscere la radice sesta
%Output:
%rad = Radice sesta calcolata
%Restituisce la radice sesta del numero passato in input.
  
if x == 0
    rad = 0;
    return;
end
if x < 0, error("Il numero inserito deve essere positivo." + newline + "Riprovare."), end
x0=x;
for i=0:1000
    delta=(1/6)*((x/(x0.^5))-x0);
    x0=x0+delta;
    if (abs(delta)<abs(eps)), break, end 
end
rad = x0;
return;
end