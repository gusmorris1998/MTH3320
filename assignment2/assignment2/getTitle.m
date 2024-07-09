function [title categories]=getTitle(column,titles,mov_index_from_column_to_global)

% need to use the global ID, to find the title
globID=mov_index_from_column_to_global(column); 
% find in which row of the titles table the movie with globID is stored
table_row=find(table2array(titles(:,1))==globID);
% display the title of this movie, from the second column of the titles table
title=table2cell(titles(table_row,2));
categories=table2cell(titles(table_row,3));

end



