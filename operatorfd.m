% Matrices
function [A,B] = operatorfd(U,x,eta,rho,temp,M1)

if size(U)~= size(x)~= size(rho) ~= size(temp)
    fprintf('ya fucked up')
    exit
end


% Matrix size

N = size(U,1);

%B matrix

B = cat(3,[U;rho;zeros(N,1);zeros(N,1)], [temp./(rho*gamma*M1.^2);U ;zeros(N,1)], [zeros(N,1);zeros(N,1);U;zeros(N,1)],...
    [zeros(N,1); gamma-1./rho; zeros(N,1); U]);



%A matrix

A = cat();

end