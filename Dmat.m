% This function is the one in Schmid book
function [D0,D1,D2] = Dmat(N) 


vec = (0:1:N)';
D0 = [];
% zero order derivative Tn(y)
for i = 0:N
    D0 = [D0 cos(i*pi*vec/(N))];
end

lv  = length(vec);

D1 = [zeros(lv,1) D0(:,1) 4*D0(:,2)];
D2 = [zeros(lv,1) zeros(lv,1) 4*D0(:,1)];

for j = 3:N
    D1 = [D1 2*j*D0(:,j)+j*D1(:,j-1)/(j-2)];
    D2 = [D2 2*j*D1(:,j)+j*D2(:,j-1)/(j-2)];
end






