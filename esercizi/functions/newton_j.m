function [x, nit] = newton_j(fun, jacobian, x0, tol, maxit)
%[x, nit] = newton_j(fun, jacobian, x0, tol, maxit)
%Input: 
%fun = Vettore di funzioni nonlineari di cui vogliamo trovare le radici.
%jacobian = Matrice di funzioni contenenti il giacobiano di fun. 
%x0 = Vettore di partenza.
%Input opzionali:
%tol = Tolleranza desiderata(default = precisione di macchina).
%max = Massimo numero di iterazioni del metodo(default = 1000).
%Output:
%x = Vettore contente le radici del sistema non lineare.
%nit = Numero di iterazioni compiute dal metodo per trovare la radice.
%Trova il vettore soluzione di un sistema di equazioni usando il metodo di Newton partendo da x0

if ~exist("tol", "var"), tol=eps; end 
if ~exist("maxit", "var"), maxit=1000; end
nit=0;
x=x0;
j=jacobian(x);
for i = 1:maxit
    f = -1*fun(x);
    dx = mialu(j,f); %Uso la function mialu per ricavarmi il vettore della differenza dx
    x = x + dx;
    nit = nit + 1;
    if(norm(dx)<=tol*(1+norm(x-dx)))   %Controllo se la tolleranza e' rispettata
        break;
    end
end
if (norm(dx)>tol*(1+norm(x-dx))), disp("Il metodo non coverge."), end
