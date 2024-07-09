format shortg
clc
clear all
close all

% parameters
lambda=0.01; % regularisation parameter
nits=500; % number of prescribed ALS iterations
f=2; % number of features (numbers of rows in U and M)

% ratings matrix
R=[5 0 0;0 4 0; 4 5 1; 0 0 2; 0 2 0];

% highly accurate prediction matrix (obtained from running ALS for 5000
% iterations)
Rpred_accurate=[4.9861 6.2009 1.2467; 3.2106 3.9928 0.80279; 3.9993 4.9737 1; 1.2706 1.5802 1.9859; 1.6053 1.9964 0.40139]

% initialization
U=[1 2 3 4 5; 1 2 3 4 5]; % as in question 3 of tutorial 6
M = ones(f, 3); % this is actually not used, so it does not matter which values we initialize M with

for i=1:nits
    [U M]=myALS(R,U,M,lambda); % do one ALS iteration
    R_pred=U'*M; % the predicted ratings matrix
    err(i)=norm(R_pred-Rpred_accurate); % error= norm of difference between current prediction and highly accurate result
    g(i)=gValue(R,U,M,lambda); % value of the function g we optimise
end

% error plot, as a function of iterations
figure(1)
plot(log10(err))
xlabel('iterations')
title('error')

% plot of the value of the g function that is being optimised, as a
% function of iterations
figure(2)
plot(g)
xlabel('iterations')
title('value of the g function')

% the predicted Ratings, after 500 iterations
R_pred=U'*M
