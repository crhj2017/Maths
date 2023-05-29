function [x,converged,J]=MySolve(f,x0,df,tol,maxit)
    % Initial x value
    xt(:,1) = x0;
    x = 0;
    converged = 0;
    
    for k = 1:maxit
        % Jacobian
        J = df(xt(:,k));
        
        % Newton-Iteration
        xt(:,k+1) = xt(:,k) - J\ f(xt(:,k));
        
        % Convergence Check
        if norm(xt(:,k+1) - xt(:,k)) < tol && norm(f(xt(:,k))) < tol
            converged = 1;
            x = xt(:,k+1);
            break
        end
    end
end

% Solves non-linear systems of the form 0 = f(x)
