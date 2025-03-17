
function A = Create_Poisson_Matrix(N)
    % construct N
    rows = N^2;
    A = zeros(rows, rows);
    for i = 1:rows
        A(i,i) = 4;
        if mod(i-1, N) ~= 0
            A(i, i-1) = -1;
        end
    
        if mod(i, N) ~= 0
            A(i, i+1) = -1;
        end
    
        if i > N
            A(i, i-N) = -1;
        end
    
        if i <= rows - N
            A(i, i+N) = -1;
        end
    end
end
