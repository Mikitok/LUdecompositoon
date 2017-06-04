clear;

load ORL.mat;

X_trn=cell(40,1);
X_tst=cell(360,1);
Y_trn=zeros(40,1);
Y_tst=zeros(360,1);
count1=1;
count2=1;
for i=1:400
    if(rem(i,10)==1)
        X_trn{count1}=ORL{i};
        Y_trn(count1)=ORL_label(i);
        count1=count1+1;
    else
        X_tst{count2}=ORL{i};
        Y_tst(count2)=ORL_label(i);
        count2=count2+1;
    end
end

load ORL_group.mat;

numtrn=length(X_trn);
numtst=length(X_tst);

[X_lu,Y_lu]=ludecomposition(X_trn,Y_trn);
[vec, val] = tdfda(X_lu, max(Y_trn)) ;
k=15;
for i=1:numtrn*3
    X_trn{i}=double(X_lu{i})*vec(:,1:k);
    %X_trn{i}=double(X_trn{i});
end
for i=1:numtst
    X_tst{i}=double(X_tst{i})*vec(:,1:k);
    %X_tst{i}=double(X_tst{i});
end
d=discompute(X_trn,X_tst);
out=distclassify(d, Y_lu);
for i=1:5
    for j=1:3
        subplot(5,3,3*(i-1)+j);
        imshow(uint8(a{i,j}));
    end
end

mean(out==Y_tst)