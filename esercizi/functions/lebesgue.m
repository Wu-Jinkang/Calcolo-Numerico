function ll = lebesgue(a, b, nn, type)
    x = linspace(a,b,10001);
    if type == 0
        for i = 1:length(nn)
            xi = linspace(a,b,nn(i)+1);
            L = ones(length(x),nn(i)+1);
            for j = 1:length(xi)
                L(:,j) = L(:,j).*(x'-xi(j))./(xi(j)-xi([1:j-1,j+1:end]));
            end
            ll(i) = max(sum(abs(L),2));
        end
    elseif type == 1
        for i = 1:length(nn)
            xi = cos((2*(0:nn(i))+1)*pi/(2*(nn(i))+2));
            xi = (b-a)*xi/2 + (b+a)/2;
            L = ones(length(x),nn(i)+1);
            for j = 1:length(xi)
                L(:,j) = L(:,j).*(x'-xi(j))./(xi(j)-xi([1:j-1,j+1:end]));
            end
            ll(i) = max(sum(abs(L),2));
        end
    end
return;
end