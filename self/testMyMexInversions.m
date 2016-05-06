function [] = testMyMexInversions()
    artime1 = zeros(100, 1);
    artime2 = zeros(100, 1);
    size = 1000;
    
    for ii = 1:1000
        if mod(ii,100) == 0
            fprintf('iter #%d\n', ii);
        end
        a = randperm(size);
        tic
        temp2 = find_permuteq(a);
        artime2(ii) = toc;
        
        tic
        temp1 = mymexinversions(a);
        artime1(ii) = toc;
        
        if (temp1 ~= temp2)
            disp('error\n')
            g=sprintf('%d ', a);
            fprintf('Answer: %s\n', g)
        end
    end
    mean(artime1)
    mean(artime2)
    
end


function [s] = find_permuteq(p)
    n = length(p);
    if n<=2 
        s = p(1)>p(n);
        return
    end
    s = merge_per(sort(p(1:ceil(n/2))),sort(p(ceil(n/2)+1:n)));
    s = s+find_permuteq(p(1:ceil(n/2)))+find_permuteq(p(ceil(n/2)+1:n));
end

function [s] = merge_per(vec1, vec2)
    
    n1 = length(vec1);
    [~, d1] = sort([vec1, vec2]);
    [~, d2] = sort(d1); % Find ind-s IX such that B(IX) = A, where B = sort(A)
    
    s = sum(d2(1:n1)) - n1*(n1+1)/2;
    
end