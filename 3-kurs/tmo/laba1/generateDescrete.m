function list = generateDescrete(f,count)
    list = zeros(count, 1); 

    for j=1:count 
        
        z = rand(); 
        S = z; 
        i = 1; 

        % 5 - количество возможных значений
        while i <= 5
            S = S - f(i); 
            if S < 0 
                list(j) = i;
                break;
            end 
            i = i + 1;
        end
    end 
end

