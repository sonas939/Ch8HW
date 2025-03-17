function y = SparseMvMult(nzA, ir, ic, x)
   % assuming nzA, ir, ic are valid and x is mx1, where m = N^2
    m = length(ir)-1 % to account for length(n)+1 need to subtract 1
    y = zeros(m, 1);
    
    for i = 1:m
        sum = 0;
        for j = ir(i):(ir(i+1)-1) % loop through values in each row
            sum = sum + nzA(j) * x(ic(j));
        end
        y(i) = sum;
    end
end
