function A = LUFactorization_ikj(A)
 
n = size(A,1);
 
for i=2:n
    for k=1:i-1
        A(i,k) = A(i,k)/A(k,k);
        for j=k+1:n
            A(i,j)=A(i,j)-A(i,k)*A(k,j);
        end
    end
end


    
