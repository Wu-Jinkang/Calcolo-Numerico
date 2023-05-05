clear;
clc;
n=4;
x=zeros(1,n+1);
for j=1:n+1
    x(j)=-1+(j-1)*(2/n);
end
m=1000;
LF=zeros(1,m+1);
z=zeros(1,m+1);
for k=1:m+1
    z(k)=-1+(k-1)*(2/m);
    LF(k)=lebesgue3(x,z(k));
end
plot(z,LF);
xlabel ('points');
ylabel ('Lebesgue function');
title('n=4')
LC=norm(LF,Inf);
disp('Lebesgue constant is');
disp(LC)