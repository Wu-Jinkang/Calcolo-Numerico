%Lebesgue function 
function LF=lebesgue3(x,z)
%x are interpolating nodes and z are evaluating points
n=length(x);
L=ones(1,n);
for i = 1:n
    for j = 1:n
        if j~=i
            L(i) = L(i)*((z - x(j))/(x(i)-x(j)));
        end
    end
end
LF=sum(abs(L));
return;
end