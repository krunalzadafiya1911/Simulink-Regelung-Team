function c = pendulum_cost(x, u)
% cost function for single pendulum problem
% cost function is given by LQR 
% Q MATRIX
% R MATRIX

final = isnan(u(1,:));
u(:,final)  = 0;

Q = [1 0; 0 0.01];           %cost Q matrix
R = 0.00001;                 %cost R matrix

x_final = [pi;0];            %final state

n = size(u);
c = zeros(n);
for i =1:max(n(:))
    c(i) = (x(:,i)-x_final)'*Q*(x(:,i)-x_final) + u(i)'*R*u(i);    %final cost
end