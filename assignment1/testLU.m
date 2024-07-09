N=5;
A=full(build_laplace_2D(N));
A_banded = LUFactorization_banded(A,N);
A_ikj = LUFactorization_ikj(A);
A_kij = LUFactorization(A);

banded_against_ikj = norm(A_banded - A_ikj)
ikj_against_kij = norm(A_ikj - A_kij)

N_array = [18:2:30];
LU_ikj_time = [];
LU_banded_time = [];

% zeros(size(N_array)); LU_banded_time = zeros(size(N_array));

for N=N_array
    A=full(build_laplace_2D(N));
    tic;
    LUFactorization_ikj(A);
    time_elapsed=toc;
    LU_ikj_time = [LU_ikj_time, time_elapsed];
end

for N=N_array
    A=full(build_laplace_2D(N));
    tic;
    LUFactorization_banded(A, N);
    time_elapsed=toc;
    LU_banded_time = [LU_banded_time, time_elapsed];
end

LU_ikj_time
LU_banded_time


abs_time_diff_28 = LU_ikj_time(5) - LU_banded_time(5)

figure(1);
loglog(log10(N_array), LU_ikj_time);
title('loglog')

hold on
loglog(log10(N_array), LU_banded_time);
hold off

pos1 = get(gcf,'Position'); % get position of Figure(1) 
set(gcf,'Position', pos1 - [pos1(3)/2,0,0,0]) % Shift position of Figure(1) 


p1 = polyfit(N_array, LU_ikj_time,1);
y1 = polyval(p1,N_array);
p2 = polyfit(N_array, LU_banded_time,1);
y2 = polyval(p2,N_array);

figure(2);
plot(N_array, y1)
title('polynomial')
hold on
plot(N_array, y2)
hold off
set(gcf,'Position', get(gcf,'Position') + [0,0,150,0]); % When Figure(2) is not the same size as Figure(1)
pos2 = get(gcf,'Position');  % get position of Figure(2) 
set(gcf,'Position', pos2 + [pos1(3)/2,0,0,0]) % Shift position of Figure(2)

    







