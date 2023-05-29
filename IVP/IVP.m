function [xend,t,xt]=MyIVP(f,x0,tspan,N) % Solves IVP for given system of ODEs of the form x*(t)=f(t,x(t))
    %Timestep
    h = (tspan(2)-tspan(1))/N;
    
    % Initial x value
    xt(:,1) = x0;
    
    % Vector of times
    t = tspan(1):h:tspan(2);
    
    for k = 1:N
        t_k = tspan(1) + k*h;
        
        % Euler Method
        %xt(:,k+1) = xt(:,k) + h * feval(f,t_k,xt(:,k));
        
        % Dormand - Prince
        k1 = f(t_k, xt(:,k));
        k2 = feval(f, t_k + 1/5 * h, xt(:,k) + h * (1/5 * k1));
        k3 = feval(f, t_k + 3/10 * h, xt(:,k) + h * (3/40 * k1 + 9/40 * k2));
        k4 = feval(f, t_k + 4/5 * h, xt(:,k) + h * (44/45 * k1 - 56/15 * k2 + 32/9 * k3));
        k5 = feval(f, t_k + 8/9 * h, xt(:,k) + h * (19372/6561 * k1 - 25360/2187 * k2 + 64448/6561 * k3 - 212/729 * k4));
        k6 = feval(f, t_k + h, xt(:,k) + h * (9017/3168 * k1 - 355/33 * k2 + 46732/5247 * k3 + 49/176 * k4 - 5103/18656 * k5));
        k7 = feval(f, t_k + h, xt(:,k) + h * (35/384 * k1 + 0 + 500/1113 * k3 + 125/192 * k4 - 2187/6784 * k5 + 11/84 * k6));
        
        xt(:,k+1) = xt(:,k) + h * (35/384 * k1 + 500/1113 * k3 + ...
        125/192 * k4 - 2187/6784 * k5 + 11/84 * k6);
    end
    xend = xt(:,length(xt));
end 
