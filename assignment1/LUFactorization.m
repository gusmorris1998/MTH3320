function A = LUFactorization(A)

n = size(A,1);

for k=1:n-1                           % pivot k
   for i=k+1:n                        % row i
      A(i,k)=A(i,k)/A(k,k);
      for j=k+1:n                     % column j
         A(i,j)=A(i,j)-A(i,k)*A(k,j);
      end
   end
end