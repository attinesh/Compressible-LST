function [e,d] = Cainoperator(etaj,b)


N = size(etaj,2);
N_s = (N/2)+1;

d = zeros(N,N);
e = zeros(N_s,N_s);
for i = 1:N
    for j =1:N
        if(i==j)
            d(i,j) = - ((N-1)/(b*N))*(sin(4*pi*etaj(j)));
        else
            d(i,j) = ((1-cos(4*pi*etaj(j)))*(-1^(i-j))*cot(pi*(i-j)/N)/(4*b)) - (sin(4*pi*etaj(j))*(sin(pi*(i-j)*(N-1)/N))/(b*N*sin(pi*(i-j)/N)));
        end 
    end
end

for i = 1:N_s
    for j = 1:N_s
        if (j ==1 || j ==N_s)
            e(i,j) = d(i,j);
        else
            e(i,j) = d(i,j)+d(i,N+2-j);
        end
    end
end




