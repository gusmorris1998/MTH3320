function A = LUFactorization_banded(A, B)

n = size(A,1);

for i=2:n
    for k = max(1, i-B):i-1
        A(i,k) = A(i,k)/A(k,k);
        for j=k+1:min(i+B,n)
            A(i,j)=A(i,j)-A(i,k)*A(k,j);
        end
    end
end