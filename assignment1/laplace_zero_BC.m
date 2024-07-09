format long

N=32; n=N^2;
x_0 = 0; y_0 = 0;
h = 1/(1+N);

A=full(build_laplace_2D(N));
b = zeros(n,1);

f = @(x,y) -2*(x + y - x^2 - y^2);


k=1;
for i = 1:N
    for j = 1:N
        b(k) = f(x_0+i.*h, y_0+j.*h);
        k = k + 1;
    end
end

% Set up domain
x=(0:h:1); y=(0:h:1); [X Y]=meshgrid(x, y);

v = A\b;
u = (X-X.*X).*(Y-Y.*Y);
v = reshape(v, [N, N]);

% add boundary values
newv = zeros(size(v)+2);
newv(2:end-1,2:end-1)=v;
v=newv;

% Difference between numerical solver and actual solution
diff = norm(u - v)

% Real solution
figure(1);
u=(X-X.*X).*(Y-Y.*Y);
mesh(X, Y, u);
pos1 = get(gcf,'Position'); % get position of Figure(1) 
set(gcf,'Position', pos1 - [pos1(3)/2,0,0,0]) % Shift position of Figure(1)

% 2d model
figure(2);
mesh(x, y, newv);
pos2 = get(gcf,'Position');  % get position of Figure(2) 
set(gcf,'Position', pos2 + [pos1(3)/2,0,0,0]) % Shift position of Figure(2)

