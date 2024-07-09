function [Ai bi]=system_user_i(Q,M,lambda,i)

% find the number of features from M
f=size(M,1);

M_t = transpose(M);

% determine the index set for movie j ranked by user i
Ji=find(Q(:,i));

% determine the number of elements in the index set (the number of users
% who have ranked movie i)
nJi=numel(Ji);

%% submatrix of movie matrix M' that contains only the rows of
%% the movies that are ranked by user i
M_t_Ji=M_t(Ji,:);

%%  the vector containing all the known ratings given by user i 
q_Ji = Q(Ji,i);

Ai = M_t_Ji'*M_t_Ji+lambda*nJi*eye(f);

bi = M_t_Ji'*q_Ji;

end




