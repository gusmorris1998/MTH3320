load Rsp
load titles
load mov_index_from_column_to_global

lambda=0.02;
nits=200;
f=20;
user = 329;
highest_rated_Rsp = []; highest_rated_R_pred = [];

[mMovies nUsers] = size(Rsp);

U = ones(f, nUsers);
M = ones(f, mMovies);

for i=1:nits
    [U M]=myALS(Rsp,U,M,lambda); % do one ALS iteration
    R_pred=U'*M; % the predicted ratings matrix
    g(i)=gValue(Rsp,U,M,lambda); % value of the function g we optimise
    i
end

[stored_Rsp,indices_Rsp] = maxk(Rsp(user,:),10);
[stored_R_pred,indices_R_pred] = maxk(R_pred(user,:),10);

for i=1:size(indices_Rsp,2)
    [title categories]=getTitle(indices_Rsp(i), titles,mov_index_from_column_to_global);
    highest_rated_Rsp = [highest_rated_Rsp; [title categories]];
end

for i=1:size(indices_R_pred,2)
    [title categories]=getTitle(indices_R_pred(i), titles,mov_index_from_column_to_global);
    highest_rated_R_pred = [highest_rated_R_pred; [title categories]];
end

highest_rated_Rsp
highest_rated_R_pred

% plot of the value of the g function that is being optimised, as a
% function of iterations
figure(2)
plot(g)
xlabel('iterations')
title('value of the g function')