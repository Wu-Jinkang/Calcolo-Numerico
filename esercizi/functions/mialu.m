function x = mialu(A, b)
%x = mialu(A, b)
%Input:
%A = Matrice quadrata nonsingolare.
%b = Vettore dei termini noti.
%Output:
%x = Soluzione del sistema.
%Risolve il sistema lineare Ax = b, andando ad utilizzare la fattorizzazione LU con pivoting parziale.

if(size(A, 1)~=size(A, 2)), error("La matrice non e' quadrata."), end
if(size(b, 2) > 1), error("Deve essere inserito il vettore dei termini noti." + newline + "Riprovare."), end
if(size(A, 1)~=size(b, 1)), error("La matrice e il vettore dei termini noti non hanno la stessa dimensione."), end

[LU,p] = LUpivot(A); %Fattorizzazione di A con fattorizzazione LU con pivoting parziale
x = b;
x = x(p); %Cambio le posizioni degli elementi del vettore dei termini noti con quelle effettuate per il pivoting
x = LUsolve(LU, x); %Risolvo il sistema
return
end

function [LU, p] = LUpivot(A)
%[LU, p] = LUpivot(A)
%Input:
%A = Matrice quadrata nonsingolare.
%Output:
%LU = Fattorizzazione LU di A.
%p = Vettore delle permutazioni (che tiene traccia di tale fattorizzazione).
%Esegue la fattorizzazione LU con pivoting parziale.

LU = A;
n = size(LU);
p = [1:n];
for i = 1:n-1
    [maxv, k] = max(abs(LU(i:n, i)));   %Considero il valore massimo del vettore in argomento
    if(maxv == 0), error("La matrice e' singolare." + newline + "Riprovare."), end
    k = k+i-1;
    if k>i
        LU([i k],:) = LU([k i],:); %Scambio le righe 
        p([i k]) = p([k i]);  %Salvo lo scambio nel vettore
    end
    LU(i+1:n, i) = LU(i+1:n, i) / LU(i, i);
    LU(i+1:n, i+1:n) = LU(i+1:n, i+1:n) - LU(i+1:n, i) * LU(i, i+1:n);
end
return
end

function x = LUsolve(LU, b)
%x = LUsolve(LU, b)
%Input:
%LU = Fattorizzazione LU di una matrice quadrata nonsingolare.
%b = Vettore dei termini noti.
%Output:
%x = Soluzione del sistema.
%Risolve il sistema LUx = b

x = b(:);
n = size(LU);
for i=1:n-1
    x(i+1:n)=x(i+1:n)-LU(i+1:n,i)*x(i);  %L
end
for i=n:-1:1
    x(i)=x(i)/LU(i,i);
    x(1:i-1)=x(1:i-1)-LU(1:i-1,i)*x(i); %U
end
return
end