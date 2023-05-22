function coefficienti = coefficienti_newton_cotes(n)
%coefficienti = coefficienti_newton_cotes(n)
%Input:
%n = Grado della formula di Newton-Cotes.
%Output:
%coefficienti = Coefficienti della formula di Newton-Cotes.
%Restituisce i pesi della quadratura della formula di Newton-Cotes di grado n.

if n <= 0, error("Il grado deve essere positivo." + newline + "Riprovare."), end

coefficienti = zeros(n, 1);

for i = 0 : n
    k = [0:i-1 i+1: n];
    denominatore = prod(i-k);
    p = poly(k);
    p = [p ./ (n+1:-1:1) 0];
    numeratore = polyval(p, n);
    coefficienti(i+1) = numeratore/denominatore;
end

return;
end