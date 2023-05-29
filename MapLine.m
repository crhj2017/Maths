function [ynew,xnew,snew]=MapLine(M,x,s,maxdist,maxangle)
    snew = s;
    
    [n,N] = size(x);
    
    ynew = M(x);
    
    converged = 0;
    while converged ~= 1
        sadd = [];
        for i = 2:N
            previousPoint = ynew(:,i-1);
            currentPoint = ynew(:,i);

            distance = abs(norm(currentPoint - previousPoint));

            if distance > maxdist
                sadd = [sadd, (snew(i)+snew(i-1))/2];
            end

            if i < N
                nextPoint = ynew(:,i+1);

                % Calculate angle between lines from i-1 to i and i to i+1
                n1 = (nextPoint-currentPoint)/norm(nextPoint-currentPoint);
                n2 = (previousPoint-currentPoint)/norm(previousPoint-currentPoint);

                angle = atan2(norm(det([n2'; n1'])), dot(n1', n2'));

                if abs(angle - pi) > (2*pi*maxangle/360)
                    sadd = [sadd, (snew(i)+snew(i-1))/2,(snew(i)+snew(i+1))/2];
                end
            end
        end
        
        if isempty(sadd)
            converged = 1;
        end
        
        snew = sort(unique([snew sadd]));
        xnew = interp1(s, x', snew,'spline')';
        N = size(xnew,2);
        ynew = M(xnew);
    
    end
    
    % Check every second point for removal and repeat
    converged = 0; i = 1;
    while converged ~= 1
        if i+1 < size(ynew,2)
            i = i+1;
        else
            converged = 1;
        end
        
        previousPoint = ynew(:,i-1);
        currentPoint = ynew(:,i);
        nextPoint = ynew(:,i+1);
        
        distance = abs(norm(nextPoint-previousPoint));
        
        % Calculate angle between lines from i-1 to i and i to i+1
        n1 = nextPoint-currentPoint;
        n2 = previousPoint-currentPoint;

        %angle = atan2(norm(det([n2'; n1'])), dot(n1', n2'));
        
        %dot product and divide by the norm    
        angle = acos(dot(n1,n2)/(norm(n1)*norm(n2)));
        
        if distance < maxdist && abs(angle - pi) < (2*pi*maxangle/360)
            ynew(:,i) = [];
            snew(i) =[];
            i = i - 1;
        end
    end
    
    length(snew)
end