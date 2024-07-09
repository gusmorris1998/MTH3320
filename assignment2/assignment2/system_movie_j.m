function [Aj bj]=system_movie_j(R,U,lambda,j)

% find the number of features from U
f=size(U,1);

% determine the index set with all users that have ranked movie j
Ij=find(R(:,j));

% determine the number of elements in the index set (the number of users
% who have ranked movie j)
nIj=numel(Ij);

% the submatrix of U containing all the columns of U corresponding to users
% who have ranked movie j
U_Ij=U(:,Ij);

% the ratings given to movie j
r_Ij=R(Ij,j);

% the matrix in the system for computing the optimal m_j
Aj=U_Ij*U_Ij'+lambda*nIj*eye(f);

% the RHS in the system for computing the optimal m_j
bj=U_Ij*r_Ij;

end