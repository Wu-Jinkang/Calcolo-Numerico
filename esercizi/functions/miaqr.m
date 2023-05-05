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
if (n>=m),error("Il sistema non e' sovradeterminato." + newline + "Riprovare."),end
k = size(b,1);
if(m~=k), error("La dimensione della matrice e quella dei termini noti sono differenti." + newline + "Riprovare."), end
if(size(b,2)>1),error("Non e' stato inserito un vettore dei termini noti corretto." + newline + "Riprovare."),end

QR = QRfatt(A); %Fattorizzo A tramite la fattorizzazione QR di Householder
[x,nr] = QRsolve(QR,b); %Risolvo il sistema
return;
end

function QR = QRfatt(A)
%QR = QRfatt(A)
%Input: 
%A = Matrice sovradimensionata a rango massimo.
%Output: 
%QR = Matrice A fattorizzata QR di Householder.
%Esegue la fattorizzazione QR della matrice.

[m, n] = size(A);
norma_euclidea = norm(A);
QR = A;
for i = 1:n
    alfa = norm(QR(i : m, i));
    if abs(alfa)<=eps*norma_euclidea, error("La matrice non ha rango massimo." + newline + "Riprovare."),end
    if QR(i,i)>=0, alfa =-alfa; end
    v1 = QR(i,i)-alfa;
    QR(i,i) = alfa;
    QR(i+1:m,i) = QR(i+1:m,i)/v1; %Vettore normalizzato
    beta = -v1/alfa;
    QR(i:m,i+1:n) = QR(i: m,i+1:n)-(beta*[1;QR(i+1:m,i)])*([1 QR(i+1:m,i)']*QR(i:m,i+1:n));
end
end

function [x, norma_euclidea] = QRsolve(QR, b)
%[x, norma_euclidea] = QRsolve(QR, b)
%Input: 
%QR = Matrice QR di Householder
%b = Vettore dei termini noti
%Output: 
%x = Soluzione del sistema
%norma_euclidea = Norma euclidea del vettore residuo
%Risolve il sistema QRx = b e ritorna la norma euclidea del vettore residuo.

x = b;
[m, n] = size(QR);
for i = 1:n
    v = [1; QR(i+1:m,i)];
    x(i:m) = x(i:m)-((2*(v*v'))/(v'*v))*x(i:m);
end
x(1:n) = Usolve(QR(1:n , 1 : n), x(1 : n));
norma_euclidea = norm(x(n+1:m)); %Del vettore residuo
x=x(1:n);
end

function b = Usolve(U, b)
%b = Usolve(U, b)
%Input: 
%U = Matrice quadrata triangolare superiore.
%b = Vettore dei termini noti.
%Output: 
%x = Soluzione del sistema.
%Risolve il sistema Ux = b.

n = size(U,1);
for i = n:-1:1
    if(n > 1)    
        b(i) = b(i)-U(i, i+1:n)*b(i+1:n);
    end
    b(i) = b(i)/U(i,i);
end
end