function [D]=discompute(X_trn,X_tst,method)
%%%%%%%%%%%%%%%%%%%%%
%   这个函数是来计算训练样本和测试样本之间的距离
%   X_trn是训练样本，X_tst是测试样本，都是cell矩阵，一个cell存放一张图片
%   method有四个值可供选择：chi-square（卡方距离）、manhatton（曼哈顿距离）、cosine（余弦距离）、euclidean（欧氏距离）
%   返回值D即距离，是一个大小为length(X_tst) * length(X_trn) 的矩阵

if nargin<3 
    method='euclidean';
end
D=zeros(length(X_tst),length(X_trn));
switch lower(method)
    case 'chi-square'
        for i=1:length(X_tst)
            x1=X_tst{i};
            for j=1:length(X_trn)
                x2=X_trn{j};
                A=(x1-x2).^2./(x1+x2);
                in=find(isnan(A)==1);
                A(in)=0;
                D(i,j)=sum(sum(A));     % Chi-square distance
            end
        end
    case 'manhattan'
        for i=1:length(X_tst)
            x1=X_tst{i};
            for j=1:length(X_trn)
                x2=X_trn{j};
                D(i,j)=sum(sum(abs(x1-x2))); %Mahatton distance
            end
        end
    case 'cosine'
        for i=1:length(X_tst)
            x1=X_tst{i};
%              [x1]=normlizedata(x1,'1-norm');
            for j=1:length(X_trn)
                x2=X_trn{j};
%                    [x2]=normlizedata(x2,'1-norm');
                D(i,j)=sum(1-(diag(x1*x2')./(sqrt(diag(x1*x1')).*sqrt(diag(x2*x2'))))); % Cosine distance
            end
        end
    case 'euclidean'
        for i=1:length(X_tst)
            x1=X_tst{i};
            for j=1:length(X_trn)
                x2=X_trn{j};
                D(i,j)=sum(sum(((x1-x2).^2),2)); %Euclidean distance
            end
        end
end