function ylist=MyTrackCurve(userf,userdf,y0,ytan,varargin)
    % Curve Tracking Stepsize
    stepsize = 0;
    maxStepsize = varargin{4};
    minStepsize = varargin{6};
    
    % MySolve variables
    maxit=5000;
    tolerance=1e-7;
    
    % Initial y value
    ylist(:,1) = y0;
    
    % Steps
    i = 1; nmax = varargin{8};
    
    % Flag for first stepsize 0
    first = 0;
    
    while i <= nmax
        ypred = ylist(:,i) + stepsize * ytan;
        
        % New n+1 system of equations + Jacobian
        F = @(y)[userf(y); ytan' * (y - ypred)];
        dF = @(y)MyJacobian(F,y,tolerance);
        
        % MySolve for F
        [ylist(:,i+1), conv, J] = MySolve(F, ypred, dF, tolerance, maxit);
        
        % Check Newton-Iteration Convergence
        if conv == 0
            % Adjust Stepsize
            stepsize = stepsize/2;
            
            % Stop continuation for stepsize lower than min
            if stepsize < minStepsize && first ~= 1
                break
            end
            
        elseif conv == 1
            % Adjust Stepsize
            stepsize = min(stepsize * 1.2, maxStepsize);
            
            % Create e_(n+1) basis vector
            basisVector = zeros(size(J,1), 1);
            basisVector(size(basisVector,1)) = 1;
            
            % Set new tangent
            z = J\basisVector;
            ytan = z/norm(z, Inf) * sign(z' * ytan);
            
            % Increment
            i = i + 1;
        end
        
        % After initial stepsize of 0, reset to given stepsize
        if first == 0
            stepsize = varargin{2};
            first = 1;
        end
    end
end