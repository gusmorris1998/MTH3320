%--------------------------------------------------------------------------
% Step 1:
%
% load data, now you should have a symmetric matrices A

m = 50;
lambdas = linspace(rand, 100 + rand*100, m);
[Q,~]   = qr(randn(m), 0);

A = Q*diag(lambdas)*Q';


[Vmat, Dmat] = eig(A);
[dmat, ind] = sort(diag(Dmat), 'descend');
Vmat = Vmat(:,ind);

%--------------------------------------------------------------------------
% Step 2:
%
% Test your myHess function

% check is P'*A*P = H
[P, H] = myHess(A);

% extract entries below the subdiagonal, these should be zeros
L = tril(H, -2);

if ( norm(P'*A*P - H, 'fro') > 1E-10) || norm(L, 'fro') > 1E-10
    disp('myHess failed')
end

%--------------------------------------------------------------------------
% Step 3
%
% Test your QRWithoutShift function

% maximum number of QR iterations in the test
n = 5000;

% check is Q'*H*Q = T
[Q, T] = QRWithoutShifts(H, n);

% check if T is upper triangular
L = tril(T, -1);

if ( norm(Q'*H*Q - T, 'fro') > 1E-8) || norm(L, 'fro') > 1E-8
    disp('QRWithoutShifts failed')
end

%--------------------------------------------------------------------------
% Step 4
%
% Test your QREig function

steps = 10:10:1000;

err_V = zeros(length(steps), 1);
err_D = zeros(length(steps), 1);
for i = 1:length(steps)
    [V,D] = QREig(A, steps(i)); % your eigenvalue solver
    d  = diag(D);
    % sort all eigenvalues in the descending order
    [~,ind] = sort(abs(d), 'descend');
    dyours = d(ind);
    % rearrange eigenvectors
    Vyours = V(:,ind);
    for j = 1:size(Vyours, 2)
        Vyours(:,j) = flip_vec(Vyours(:,j), Vmat(:,j));
    end
    
    err_V(i) = norm(Vyours - Vmat, 'fro');
    err_D(i) = sum(abs(dyours - dmat));
end


figure('position', [100, 100, 800, 800])

% eigenvalues
subplot(2,2,1)
plot(dmat, 'o-')
xlabel('Index')
ylabel('|\lambda_i|')
title('Eigenvalues')
axis tight

% error in eigenvector estimates
subplot(2,2,3)
semilogy(steps, err_V, 'o-')
xlabel('Iteration')
ylabel('$\|b^{(k)} - v_1\|$', 'Interpreter','latex')
title('Convergence of eigenvectors')
axis tight

% error in eigenvalue estimates
subplot(2,2,4)
semilogy(steps, err_D, 'o-')
xlabel('Iteration')
ylabel('$\|\lambda^{(k)} - \lambda_1\|$', 'Interpreter','latex')
title('Convergence of Eigenvalues')
axis tight

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
