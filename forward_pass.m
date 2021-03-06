function [xnew,unew,cnew] = forward_pass(x0,u,xn,L,x,du,Alpha,lims,diff)
%% forward_pass: parallel forward-pass (rollout)
  % this function is written for forward pass calculation.
  
  % this function estimate the preducted state, cost and input vector over
  % the time step
  
  % internally time is on the 3rd dimension, 
  % to facillitate vectorized dynamics calls
  
%% ******** Owner of Code ************************************************
  % Krunalkumar, Zadafiya (TU Kaiserslautern)
  %
  % Author: zadafiya@rhrk.uni-kl.de
  % **********************************************************************
  % Begin initializataion code - DO NOT EDIT

n        = size(x0,1);
K        = length(Alpha);
K1       = ones(1,K);                               % useful for expansion
m        = size(u,1);
N        = size(u,2);

xnew        = zeros(n,K,N+1);
xnew(:,:,1) = x0(:,ones(1,K));
unew        = zeros(m,K,N);
cnew        = zeros(1,K,N+1);

for i = 1:N
    unew(:,:,i) = u(:,i*K1);
    
    if ~isempty(du)
        unew(:,:,i) = unew(:,:,i) + du(:,i)*Alpha;
    end    
    
    if ~isempty(L)
        if ~isempty(diff)
            dx = diff(xnew(:,:,i), x(:,i*K1));
        else
            dx          = xnew(:,:,i) - x(:,i*K1);
        end
        unew(:,:,i) = unew(:,:,i) + L(:,:,i)*dx;
    end
    
    if ~isempty(lims)
        %unew = randn(1,1,500);
        unew(:,:,i) = min(lims(:,2*K1), max(lims(:,1*K1), unew(:,:,i)));
    end

    [xnew(:,:,i+1), cnew(:,:,i)] = pendulum_dyn_cst(xnew(:,:,i), unew(:,:,i), xn, i*K1);
end
[~, cnew(:,:,N+1)] = pendulum_dyn_cst(xnew(:,:,N+1),nan(m,K,1),xn, i);
% put the time dimension in the columns
xnew = permute(xnew, [1 3 2]);
unew = permute(unew, [1 3 2]);
cnew = permute(cnew, [1 3 2]);

end