function [U M]=myALS(R, U, M, lambda)
    
[m, n]=size(R);

for j=1:n
    [Aj bj]=system_movie_j(R, U, lambda, j);
    M(:,j)=Aj\bj;
end

for i=1:m
    Q = R';
    [Ai bi]=system_user_i(Q, M, lambda, i);
    U(:,i)=Ai\bi;
end




    