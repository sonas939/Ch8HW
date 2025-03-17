function [nzA, ir, ic] = Create_Poisson_problem_nzA(N)
    % ask user to redo input if N is less than 1
    while N < 1
        N = input('Invalid input. Enter a value greater than or equal to 1: ');
    end

    % get estimate of nnzeros. Each row can have at most 5 vals - each
    % boundary (4 - top, bottom, left, right). NOT ACCURATE - just overestimate to avoid having to
    % allocate memory each iteration
    n = N^2;
    estimate_nnzeros = 5*n - 4*N;

    % define nzA, ir, ic
    nzA = zeros(estimate_nnzeros, 1);
    ir = zeros(n+1, 1);
    ic = zeros(estimate_nnzeros, 1);

    actual_nnzeros = 0;
    
    for i = 1:N
        for j = 1:N
            actual_nnzeros = actual_nnzeros + 1;
            row = (i-1) * N + j % thus row loops from 1:n

            % redefine ir, nzA, ic
            ir(row) = actual_nnzeros;
            nzA(actual_nnzeros) = 4 % know there is a 4 in each row
            ic(actual_nnzeros) = row % 4 is always at the index of row

            % Now check for i-1, i-N, i+1, i+N (when i = 1:n)
            if j > 1 % if j = 1,means j-1 would be out of bounds. Same as if j-1>0
                actual_nnzeros = actual_nnzeros + 1;
                nzA(actual_nnzeros) = -1;
                ic(actual_nnzeros) = row - 1; % col is exactly one less than current row
            end

            if j < N % if j = N, means j+1 would be out of bounds. Same as if j+1<=N
                actual_nnzeros = actual_nnzeros + 1;
                nzA(actual_nnzeros) = -1;
                ic(actual_nnzeros) = row + 1;
            end

            if row + N <= n % if row + N > N^2, i+N is out of bounds
                actual_nnzeros = actual_nnzeros + 1;
                nzA(actual_nnzeros) = -1;
                ic(actual_nnzeros) = row + N;
            end

            if row - N >= 1 % if row - N < 1, i-N is out of bounds
                actual_nnzeros = actual_nnzeros + 1;
                nzA(actual_nnzeros) = -1;
                ic(actual_nnzeros) = row - N;
            end
        end
    end

    ir(n+1) = actual_nnzeros + 1; % set last row + 1 equal to number of nonzeroes + 1

    % resize nzA and ic with actual number of nnzeros
    nzA = nzA(1:actual_nnzeros);
    ic = ic(1:actual_nnzeros);
end
