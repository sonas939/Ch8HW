N = input("Enter a value greater than or equal to N: ");
A = Create_Poisson_Matrix(N);
disp('A:');
disp(A);

[nzA, ir, ic] = Create_Poisson_problem_nzA(N);
% Display the results
disp('nzA:');
disp(nzA);

disp('ir:');
disp(ir);

disp('ic:');
disp(ic);

% Testing the implementation for Create_Poisson_problem_nzA
for i = 1:length(ir)-1
    for j = ir(i):(ir(i+1)-1)
        if A(i,ic(j)) ~= nzA(j)
            disp(["False at row:", i, "and index:", j]);
        end
    end
end

% Test SparseMvMult.m by ensuring mxv of poisson matrix we created is same
% as mxv from sparse matrix
x = (1:N^2)'
test_product = A * x;
product = SparseMvMult(nzA, ir, ic, x);

if isequal(test_product, product)
    disp('correct');
    disp('test_product:');
    disp(test_product);
    disp('product:');
    disp(product);
else
    disp('incorrect');
    disp('test_product:');
    disp(test_product);
    disp('product:');
    disp(product);
end

% modified code from above. Less efficient but double checks all values in
% poisson matrix are accounted for
% putting at end because sets all values of A to 0
for i = 1:length(ir)-1
    for j = ir(i):(ir(i+1)-1)
        if A(i, ic(j)) == nzA(j)
            A(i, ic(j)) = 0;
        end
    end
end

if all(A(i,:) == 0)
    disp("Values are correct.");
end
