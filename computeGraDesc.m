function [thetas, cost] = computeGraDesc(iter, lrate, x, y, m, n)

 cost = 0;
 thetas = zeros((n+1), 1); % Initialize model parameters


 for r = 1:iter
   % Compute model parameters
   thetas(1) = thetas(1) - (lrate*(1/m)*(sum(((x(1) .' * thetas(1)) - y))));
   thetas((2:end),1) = thetas((2:end),1) - (lrate*(1/m))*(sum((x(:,(2:end)) .' * ((x(:,(2:end))  * thetas((2:end),1)) - y) )));

   % Compute cost function
   h01 = x * thetas;
   h02 = h01 - y;
   cost = (1/(2*m)) * (sum(h02 .^2));

   % Print Progress
   fprintf("At Iteration %d ", r)
   fprintf(" with parameters w = %f,", thetas .')
   fprintf(" cost = %d \n", cost)

 endfor
end
