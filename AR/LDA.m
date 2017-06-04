function W=LDA(X,Y,dims)
% Input:    n*d matrix,each row is a sample;
% Target:   n*1 matrix,each is the class label 
% W:         d*(k-1) matrix,to project samples to (k-1) dimention
%dims:      the target dimension

% ��ʼ��
[n,dim]=size(X);   %  n��������Ŀ
ClassLabel=unique(Y);   %  ClassLabel��������ǩ�����ظ���
c=length(ClassLabel);   % c��������Ŀ

nGroup=zeros(c,1);            % ÿ�������ж��ٸ�
GroupMean=zeros(c,dim);       % ÿ��ľ�ֵ
SB=zeros(dim,dim);          % �����ɢ�Ⱦ���
SW=zeros(dim,dim);          % ������ɢ�Ⱦ���

% ����������ɢ�Ⱦ���������ɢ�Ⱦ���
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

m=mean(X);    % m�����������ľ�ֵ
for i=1:c
    tmp=GroupMean(i,:)-m;
    SB=SB+nGroup(i)*(tmp')*tmp;
end

%  �������ֵ����������
[V, L] = eig(SB,SW);
[L,index]=sort(diag(L),'descend');
V=V(:,index);
if nargin>=3    
    W=V(:,1:dims);
else
    index=find(L>1.e-5);
    W=V(:,index);
end



    
    