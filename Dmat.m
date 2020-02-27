function [D0,D1,D2] = Dmat(N)

D0 = [];
vec = (0:1:N)';

% zero order derivative Tn(y)
for i = 0:N
    D0 = [D0 cos(i*pi*vec/N)];
end







