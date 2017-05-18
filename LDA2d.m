function [ P, X  ] = LDA2d( X_trn, k, percent  )
if nargin <1
    help LDA2d;
end
if nargin < 2
    k=0;
    percent=0.9;
end
if nargin<3
    percent=0.9;
end

[c,num]=size(X_trn);
[m,n]=size(X_trn{1});
X_sample_mean=cell(c,1);
X_mean=zeros(m,n);

% 计算类内均值和类间均值
for i=1:c
    X_sample_mean{i}=zeros(m,n);
    for j=1:num
        X_sample_mean{i}=X_sample_mean{i}+X_trn{i,j};
        X_mean=X_mean+X_trn{i,j};
    end
    X_sample_mean{i}=X_sample_mean{i}/num;
end
X_mean=X_mean/c/num;

% 计算Sb
Sb=0;
for i=1:c
    Sb=Sb+(X_sample_mean{i}-X_mean)*(X_sample_mean{i}-X_mean)'/c;
end

% 计算Sw
Sw=0;
for i=1:c
    for j=1:num
        Sw=Sw+(X_trn{i,j}-X_sample_mean{i})*(X_trn{i,j}-X_sample_mean{i})';
    end
end
Sw=Sw/c/num;

% 计算特征值和特征向量
Sw=Sw+eye(size(Sw,1))*1.e-8;
[fvec,fvalue]=eig(inv(Sw)*Sb);
fvalue=diag(rot90(rot90(fvalue)));
fvec=rot90(fvec);
% 如果未给出k值，则计算k值
sumper=0;
t=sum(fvalue);
if k==0
    while sumper<percent
        k=k+1;
        sumper=sumper+fvalue(k)/t;
    end
end
P=fvec(1:k,:);

% 计算投影后的样本
X=cell(c,num);
for i=1:c
    for j=1:num
        X{i,j}=P*X_trn{i,j};
    end
end
end

