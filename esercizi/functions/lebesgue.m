function ll = lebesgue(a, b, nn, type)
%ll = lebesgue(a, b, nn, type)
%Input:
%a,b = Estremi dell'intervallo.
%nn = Vettore contenente i gradi dei polinomi.
%type = Tipologia scelta per risolvere l'esercizio.
%Output:
%ll = Approssimazione della costante di Lebesgue.
%Calcola l'approssimazione della costante di Lebesgue sull'intervallo [a, b].

if nargin < 4
    error("Il numero degli argomenti e' errato." + newline + "Riprovare.");
elseif type ~= fix(type) || type < 0 || type > 1
    error("Il valore di type non e' corretto." + newline + "Riprovare.");
elseif a >= b
    error("Intervallo errato." + newline + "Riprovare.");
end
  
x = linspace(a, b, 10001)';
ll = zeros(size(nn));

%Per ogni grado del polinomio -> Sommatoria
for i = 1 : length(nn)
    grado = nn(i);
    if type == 0
        xi = linspace(a, b, grado + 1);
    elseif type == 1
        xi = chebyshev(grado + 1, a, b);
    end

    Lin = ones(length(x), 1);
 
    for r = 1 : length(xi)
        temp = 1;
        %Produttoria 
        for j = 1 : length(xi)
            if j ~= r            
                temp = temp .* ((x - xi(j)) ./ (xi(r) - xi(j)));
            end
        end
        Lin = Lin + abs(temp);
    end
    ll(i) = max(Lin);
end
return;
end