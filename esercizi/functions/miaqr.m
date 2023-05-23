function [x, nr] = miaqr(A, b)
%[x, nr] = miaqr(A, b)
%Input: 
%A = Matrice sovradimensionata a rango massimo.
%b = Vettore dei termini noti.
%Output: 
%x = Soluzione del sistema.
%nr = Norma euclidea del vettore residuo.
%Risolve il sistema Ax = b nel senso dei minimi quadrati e ritorna la norma euclidea del vettore residuo.

[m, n] = size(A);
if n >= m, error("Il sistema non e' sovradeterminato." + newline + "Riprovare."),end

k = size(b,1);
if m ~= k, error("La dimensione della matrice e quella dei termini noti sono differenti." + newline + "Riprovare."), end

if(size(b,2) > 1),error("Non e' stato inserito un vettore dei termini noti corretto." + newline + "Riprovare."),end

for i = 1:n
    alfa = norm(A(i:m, i));
    if alfa == 0, error("La matrice non e' ha rango massimo." + newline + "Riprovare."), end
    if A(i,i) >= 0, alfa = -alfa; end   
    v1 = A(i,i) - alfa;
    A(i,i) = alfa;
    A(i+1:m, i) = A(i+1:m, i) / v1; %Vettore normalizzato
    beta = -v1 / alfa;
    A(i:m, i+1:n) = A(i:m, i+1:n) - (beta * [1; A(i+1:m, i)]) * ([1 A(i+1:m, i)'] * A(i:m, i+1:n));
    b(i:m) = b(i:m) - (beta * [1 A(i+1:m, i)'] * b(i:m)) * [1; A(i+1:m, i)];
end  

%Risolvo il sistema Ax=b
x = b(:);
for i = n:-1:1   
    x(i) = x(i) / A(i,i);
    x(1:i-1) = x(1:i-1)   - A(1:i-1, i) * x(i);
end  
nr = norm(x(n+1:m)); 
return;
end