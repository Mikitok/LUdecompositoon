clear;
load rate1.mat;
for t=0:9
load ORL.mat;

X_trn=cell(40,1);
X_tst=cell(360,1);
Y_trn=zeros(40,1);
Y_tst=zeros(360,1);
count1=1;
count2=1;
for i=1:400
    if(rem(i,10)==t)
        X_trn{count1}=ORL{i};
        Y_trn(count1)=ORL_label(i);
        count1=count1+1;
    else
        X_tst{count2}=ORL{i};
        Y_tst(count2)=ORL_label(i);
        count2=count2+1;
    end
end

% load ORL_group.mat;

numtrn=length(X_trn);
numtst=length(X_tst);

[X_svd,Y_svd]=svddecomposition(X_trn,Y_trn);
[ X_lu, Y_lu] = ludecomposition( X_trn, Y_trn );
k=15;
X_all=cell(4*numtrn,1);
Y_all=zeros(4*numtrn,1);
count1=1;
count2=2;
for i=1:numtrn*4
    if (rem(i,4)==0)
        X_all{i}=X_svd{count2};
        Y_all(i)=Y_svd(count2);
        count2=count2+2;
    else
        X_all{i}=X_lu{count1};
        Y_all(i)=Y_lu(count1);
        count1=count1+1;
    end
end
% [vec, val] = tdfda(X_all, max(Y_all)) ;
[vec, val] = tdfda1(X_all, max(Y_all)) ;

%%%%%  使用生成的新的训练样本集分类%%%%%%
for i=1:numtrn*4
%     X_trn{i}=vec(:,1:k)'*double(X_all{i});
    %X_trn{i}=double(X_trn{i});
    X_trn{i}=double(X_all{i})*vec(:,1:k);
end

% %%%%%%  使用原先的训练样本集分类  %%%%%%%
% for i=1:numtrn
% %     X_trn{i}=vec(:,1:k)'*double(X_trn{i});
%     %X_trn{i}=double(X_trn{i});
%     X_trn{i}=double(X_trn{i})*vec(:,1:k);
% end

for i=1:numtst
%     X_tst{i}=vec(:,1:k)'*double(X_tst{i});
    %X_tst{i}=double(X_tst{i});
    X_tst{i}=double(X_tst{i})*vec(:,1:k);
end
d=discompute(X_trn,X_tst);
out=distclassify(d, Y_all);

rate1(5,t+1)=mean(out==Y_tst);
end