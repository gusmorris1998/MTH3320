function [Q, R]=myGramSchmidt(A)

m = size(A,1); n = size(A,2);
Q = zeros(m,n);
R = zeros(n,n);

for j=1:n
    v_j = A(:,j);
    for i=1:j-1
        R(i,j) = transpose(Q(:,i))*A(:,j);
        v_j = v_j - R(i,j)*Q(:,i);
    end

    R(j,j) = norm(v_j);
    Q(:,j) = v_j/R(j,j);
end



