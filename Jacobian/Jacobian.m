function [df] = MyJacobian(f,x,h)
    % Jacobian Dimensions
    n = size(x,1);
    
    % Offset identity matrix
    A = eye(n)*h;
    
    % Calculate derivatives
    for j = 1:n
        df(:,j) = 1/(2*h) * (f(x + A(:,j)) - f(x - A(:,j)));
    end
end
