function [lambda, Rdiag, x] = LyapunovQR(M,xini,N)
    
    n = size(xini,1);
    
    % Preallocate
    x = NaN(n,N);
    A = NaN(n,n,N);
    R = NaN(n,n,N);
    Q = NaN(n,n,N+1);
    Rdiag = NaN(n,N);
    lambda = NaN(n,N);
    
    x(:,1) = xini;
    
    h = 1e-6;
    df = @(x)MyJacobian(M,x,h);
    
    % Calculate x and A for each x
    for k = 1:N
        x(:,k+1) = M(x(:,k));
        
        A(:,:,k) = df(x(:,k));
    end
    
    Q(:,:,1) = eye(n);
    
    for i = 1:N
       [Q(:,:,i+1), R(:,:,i)] = qr(A(:,:,i)*Q(:,:,i));
       
       Rdiag(:,i) = diag(R(:,:,i));
       
       for s = 1:2
           if Rdiag(s,i) < 0
               Rdiag(s,i) = abs(Rdiag(s,i));
               Q(:,s,i) = -1 * Q(:,s,i);
           end
       end
    end
    
    for z = 1:n
        sum = 0;
        for q = 1:N
            sum = sum + log(Rdiag(z,q));
            lambda(z,q) = (1/(q+1)) * sum;
        end
    end
end