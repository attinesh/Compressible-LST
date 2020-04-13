function [U1,U2,x1,x2] = Velocity(N,yoff,lam)


U1 = zeros(N,1);
U2 = zeros(N,1);
h = yoff/(N-1);

for i = 1:N
    x1(i,1) = yoff-((i-1)*h);
    U1(i,1) = 0.5*(1 + lam*tanh(yoff-((i-1)*h)));
    x2(i,1) = -yoff+((i-1)*h);
    U2(i,1) = 0.5*(1 + lam*tanh(-yoff+((i-1)*h)));
end
end