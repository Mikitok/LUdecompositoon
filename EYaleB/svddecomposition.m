function [ X_svd, Y_svd] = svddecomposition( X_trn, Y_trn )
% svddecomposition��������svd�ֽ��������Ž���ͼ��
% X_trn�ǵ�����ѵ������Ϊһ��num*1��cellԪ�顣
% Y_trn�Ǻ�ÿ��������Ӧ�ı�ǩ����Ϊһ��num*1����������
% X_svd��ԭ���������ɵĽ���ͼ��ļ��ϣ�Ϊһ��2num*1��cellԪ�顣
% Y_svd�Ǻ�X_svd��������Ӧ�ı�ǩ����Ϊһ��2num*1����������

samplenum=length(X_trn);
[m,n]=size(X_trn{1});
X_svd=cell(2*samplenum,1);

for i=1:samplenum
    X_trn{i}=double(X_trn{i});
    % ����ԭ�е�ѵ������
    X_svd{2*i-1}=X_trn{i};
    
    % ��ѵ�����������ͼ��
    [u,s,v]=svd(X_trn{i});
    f=diag(s);
    sam=zeros(m,n);
    for j=1:3
        sam=sam+f(j)*u(:,j)*v(:,j)';
    end
    X_svd{2*i}=sam;
end
Y_svd=[Y_trn,Y_trn]; 
Y_svd=reshape(Y_svd',samplenum*2,1);
end

