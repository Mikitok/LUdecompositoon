function [ X_svd, Y_svd] = svddecomposition( X_trn, Y_trn )
% svddecomposition函数是用svd分解生成两张近似图像。
% X_trn是单样本训练集，为一个num*1的cell元组。
% Y_trn是和每个样本对应的标签集，为一个num*1的列向量。
% X_svd是原样本和生成的近似图像的集合，为一个2num*1的cell元组。
% Y_svd是和X_svd中样本对应的标签集，为一个2num*1的列向量。

samplenum=length(X_trn);
[m,n]=size(X_trn{1});
X_svd=cell(2*samplenum,1);

for i=1:samplenum
    X_trn{i}=double(X_trn{i});
    % 保存原有的训练样本
    X_svd{2*i-1}=X_trn{i};
    
    % 对训练样本求近似图像
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

