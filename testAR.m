load AR_group.mat;

numtrn=length(X_trn);
numtst=length(X_tst);

[X_lu1,Y_lu1]=ludecomposition(X_trn1,Y_trn);
[vec, val] = tdfda(X_lu1, max(Y_trn)) ;
k=15;
for i=1:numtrn*3
    X_trn1{i}=double(X_lu1{i})*vec(:,1:k);
    %X_trn{i}=double(X_trn{i});
end
for i=1:numtst
    X_tst1{i}=double(X_tst1{i})*vec(:,1:k);
    %X_tst{i}=double(X_tst{i});
end
d=discompute(X_trn1,X_tst1);
