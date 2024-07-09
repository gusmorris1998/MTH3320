load("xray_data.mat")

rank(F)
[U, S, V] = svd(F);

k_array = [500:10:1850];
x_array = [];
rep_error = [];
x_norm = [];

trans_V = V';

for k=k_array
    U_k = U(:,1:k);
    S_k = S(1:k, 1:k);
    V_k = V(:,1:k); 

    x_k = V_k*inv(S_k)*U_k'*d;
    x_array = [x_array, x_k];
    rep_error = [rep_error, norm(F*x_k-d)];
    x_norm = [x_norm, norm(x_k)];
end

xr = x_array(:,32);

plot(x_norm, rep_error)
hold on  % to plot on the current figure
plot(0.163485,0.0270016,'r*')
hold off

imagesc(reshape(xr, m, m), [-0.01, 0.01]);
