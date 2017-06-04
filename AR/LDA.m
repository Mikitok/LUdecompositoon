function W=LDA(X,Y,dims)
% Input:    n*d matrix,each row is a sample;
% Target:   n*1 matrix,each is the class label 
% W:         d*(k-1) matrix,to project samples to (k-1) dimention
%dims:      the target dimension

% 初始化
[n,dim]=size(X);   %  n：样本数目
ClassLabel=unique(Y);   %  ClassLabel：样本标签（不重复）
c=length(ClassLabel);   % c：样本数目

nGroup=zeros(c,1);            % 每类样本有多少个
GroupMean=zeros(c,dim);       % 每类的均值
SB=zeros(dim,dim);          % 类间离散度矩阵
SW=zeros(dim,dim);          % 类内离散度矩阵

% 计算类内离散度矩阵和类间离散度矩阵
for i=1:c    
    group=(Y==ClassLabel(i));
    nGroup(i)=sum(double(group));
    GroupMean(i,:)=mean(X(group,:));
    tmp=zeros(dim,dim);
    for j=1:n
        if group(j)==1
            t=X(j,:)-GroupMean(i,:);
            tmp=tmp+t'*t;
        end
    end
    SW=SW+tmp;
end

m=mean(X);    % m：所有样本的均值
for i=1:c
    tmp=GroupMean(i,:)-m;
    SB=SB+nGroup(i)*(tmp')*tmp;
end

%  求得特征值和特征向量
[V, L] = eig(SB,SW);
[L,index]=sort(diag(L),'descend');
V=V(:,index);
if nargin>=3    
    W=V(:,1:dims);
else
    index=find(L>1.e-5);
    W=V(:,index);
end



    
    