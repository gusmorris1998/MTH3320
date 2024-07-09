% https://grouplens.org/datasets/movielens/
% this script uses
%    ml-latest-small/ratings.csv
% and
%    ml-latest-small/movies.csv

% read the ratings data
R=csvread('ratings.csv',1,0);
% This data set has 671 users who have ranked 9,066 movies between 1995 and 2016,
% in 100,004 ratings between 0.5 and 5.0 (in increments of 0.5)

% the matrix R contains 100,004 lines with one rating per line:
% column 1: user ID for 671 users (from 1 to 671, in increasing order)
% column 2: movie ID for 9,066 movies (IDs between 1 and 163,949)
% column 3: the rating
% column 4: timestamp of the rating

titles=readtable('movies.csv','Delimiter',',');
% titles is a table with 1 movie per row, and 3 columns: global ID, title, categories

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% first we want to convert the list of ratings into a sparse ratings matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% the 9,066 movies in R have global IDs that range between 1 and 163,949, and
% correspond to IDs for the movies on the movielens website and in the movies.csv file
% we need to map these global IDs to local IDs between 1 and 9,066; we will
% use these local IDs as column numbers in our sparse ratings matrix

% an easy way to do this: first generate a sparse matrix with many empty columns
% (movies with global IDs that don't have ratings at all); then take out
% the empty columns

Rsp=sparse(R(:,1),R(:,2),R(:,3));
ind=full(sum(Rsp)>0); % a vector of length the maximum global movie ID; 
                      % a 1 indicates that the movie with this global ID has been ranked in our data set 
%sum(ind) % check: this should be 9066
% mov_index_from_local_to_global is a map from local movie ID to global movie ID
mov_index_from_column_to_global=find(ind); % construct the index by finding the locations with a nonzero
Rsp=Rsp(:,mov_index_from_column_to_global); % select only the nonzero columns

size(Rsp)

% spy plot for the nonzero structure
figure(100)
spy(Rsp)

% save the sparse ratings matrix, Rsp, to a file called Rsp.mat, for later
% use
save('Rsp','Rsp')

% save the titles data
save('titles','titles')
save('mov_index_from_column_to_global','mov_index_from_column_to_global')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% now some statistics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% generate a binary matrix indicating all ratings by a 1
Rr=Rsp>0;

% ratings per movie (minimum 1)
sum(Rr);
figure(1)
plot(sum(Rr))
title('ratings per movie')

figure(2)
histogram(sum(Rr))
title('histogram of ratings per movie')

% ratings per user (minimum 20)
sum(Rr');
figure(11)
plot(sum(Rr'))
title('ratings per user')

figure(12)
histogram(sum(Rr'))
title('histogram of ratings per user')

% histogram of ratings
figure(20)
histogram(nonzeros(Rsp))
title('histogram of rating values')

