function g=gValue(R,U,M,lambda)

g=0;
[m, n]=size(R);
Q = R';

for i=1:m
    Ji=find(Q(:,i));
    nJi=numel(Ji);
    ui = U(:,i);

    g = g + nJi * norm(ui)^2;
end

for j=1:n
    Ij=find(R(:,j));
    nIj=numel(Ij);
    mj = M(:,j);

    g = g + nIj * norm(mj)^2;
end

g = lambda * g;

for j=1:n
    Ij=find(R(:,j));
    r_Ij=R(Ij,j);
    U_Ij=U(:,Ij)';
    mj = M(:,j);

    g = g + norm(r_Ij-U_Ij*mj)^2;
end
