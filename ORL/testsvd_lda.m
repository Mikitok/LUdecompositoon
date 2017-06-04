clear;

load ORL_group.mat;
numtrn=length(X_trn);
numtst=length(X_tst);

[X_svd,Y_svd]=svddecomposition(X_trn,Y_trn);

for i=1:numtrn
%     tmp=imresize(double(X_trn{i}),[32,32]);
%     X(i,:)=reshape(tmp,1,32*32);
    X(i,:)=reshape(double(X_trn{i})',1,m*n);
end
W=LDA(X,Y_trn);
X=X*W;