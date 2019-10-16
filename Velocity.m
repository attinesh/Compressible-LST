function U = Velocity(N,yoff,lam)

U = zeros(N,1);
h = yoff/(N-1);

for i = 1:N
    U(i,1) = (1 + lam*tanh(yoff-((i-1)*h)));
end

end