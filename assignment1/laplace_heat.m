format long

N=64; n=N^2;
x_0 = 0; y_0 = 0;
h = 1/(1+N);
u_0 = 300;

A=full(build_laplace_2D(N));

g = @(x,y) 5000.*exp(-(((x-0.25).^2)+((y-0.75).^2))/0.01);

b = zeros(n,1);
U = zeros(n,1);

% Creation of the added vector on RHS
k=1;    
for i = 1:N
    for j = 1:N
        if mod(i, N) == 1 || mod(i, N) == 0; U(k) = U(k) + u_0; end
        if mod(j, N) == 1 || mod(j, N) == 0; U(k) = U(k) + u_0; end
        k = k + 1;
    end
end

% Creation of b vector
k=1;
for i = 1:N
    for j = 1:N
        b(k) = -g(x_0+i.*h, y_0+j.*h);
        k = k + 1;
    end
end

% RHS
b = b - (1/(h.^2))*U;

v = A\b;
max_val = max(v)

v = reshape(v, [N, N]);



x=linspace(0,1,N); y=linspace(0,1,N); [X Y]=meshgrid(x, y);
G = 10000.*exp(-(((X-0.75).^2)+((Y-0.75).^2))/0.01);

figure(1)
mesh(x, y, v)
pos1 = get(gcf,'Position'); % get position of Figure(1) 
set(gcf,'Position', pos1 - [pos1(3)/2,0,0,0]) % Shift position of Figure(1)

figure(2)
contour(x, y, v)
pos2 = get(gcf,'Position');  % get position of Figure(2) 
set(gcf,'Position', pos2 + [pos1(3)/2,0,0,0]) % Shift position of Figure(2)