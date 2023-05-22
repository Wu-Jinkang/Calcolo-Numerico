function x = mialdl(A, b)
%x = mialdl(A, b)
%Input:
%A: Matrice simmetrica definita positiva(sdp).
%b: Vettore dei termini noti.
%Output:
%x: Soluzione del sistema lineare.
%Risolve il sistema Ax = b, andando ad utilizzare la fattorizzazione LDL^t.

if(size(A, 1)~=size(A, 2)), error("La matrice non e' quadrata." + newline + "Riprovare."), end
if(size(A, 1)~=size(b)), error("La dimensione del vettore dei termini noti e quella della matrice non coincidono." + newline + "Riprovare."), end
   
LDLt = fattLDLt(A); %Fattorizzo la matrice tramite la fattorizzazione LDLt
x = ltud(LDLt, b); %Risolvo il sistema Lx = b
x = diagonal(LDLt, x);  %Risolvo Dx = b (b e' la soluzione 'x' precedente)
x = utud(LDLt', x); %Risolvo il sistema L'x = b (b e' la soluzione 'x' precedente)
return;
end
    
function LDLt = fattLDLt(A)
%LDLt = fattLDLt(A)
%Input:
%A = Matrice simmetrica definita positiva(sdp).
%Output:
%LDLt: Fattorizzazione della matrice A in LDLt:
% -L = Matrice triangolare inferiore a diagonale unitaria.
% -D = Matrice diagonale.
%Esegue la fattorizzazione LDL^t.

LDLt = A;
if(LDLt(1, 1) <= 0), error("La matrice non e' sdp." + newline + "Riprovare."), end

n = size(A);
LDLt(2:n, 1) = LDLt(2:n, 1)/LDLt(1, 1);

for i = 2:n
    v = (LDLt(i, 1:i-1).').*diag(LDLt(1:i-1, 1:i-1));
    LDLt(i, i) = LDLt(i, i) - LDLt(i, 1:i-1)*v;
    if(LDLt(i,i) <= 0), error("La matrice non e' sdp." + newline + "Riprovare."), end
    LDLt(i+1:n, i) = (LDLt(i+1:n, i)-LDLt(i+1:n, 1:i-1) *v)/LDLt(i, i);
end
return;
end
    
function b = ltud(L, b)
%b = ltud(L, b)
%ltud = triangolare inferiore a diagonale unitaria.
%Input:
%L = Matrice triangolare inferiore a diagonale unitaria.
%b = Vettore dei termini noti.
%Output:
%b = Soluzione del sistema.
%Risolve un sistema triangolare inferiore.

n = size(L, 1);
for i = 1:n
   b(i)=b(i)-L(i,1:i-1)*b(1:i-1);
end
end
    
function x = diagonal(D, b)
%x = diagonal(D, b)
%Input:
%D = Matrice diagonale
%b = Vettore dei termini noti
%Output:
%x = Soluzione del sistema lineare Dx = b
%Risolve un sistema diagonale.

n = size(D);
x = b(:);
for i = 1:n
    x(i) = x(i)/D(i, i);
end
end
    
function x = utud(U, b)
%x = utud(U, b)
%utud = triangolare superiore a diagonale unitaria.
%Input:
%U = Matrice triangolare superiore a diagonale unitaria.
%b = Vettore dei termini noti.
%Output:
%x = Soluzione del sistema lineare Ux = b.
%Risolve un sistema triangolare superiore.

n = size(U);
x = b(:);
for i = n:-1:1
  x(i)=x(i)-U(i,i+1:n)*x(i+1:n);
end
end