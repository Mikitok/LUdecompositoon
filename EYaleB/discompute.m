function [D]=discompute(X_trn,X_tst,method)
%%%%%%%%%%%%%%%%%%%%%
%   这个函数是来计算训练样本和测试样本之间的距离
%   X_trn是训练样本，X_tst是测试样本，都是cell矩阵，一个cell存放一张图片
%   method有四个值可供选择：chi-square（卡方距离）、manhatton（曼哈顿距离）、cosine（余弦距离）、euclidean（欧氏距离）
%   返回值D即距离，是cell矩阵，一个cell存放一个测试样本和所有训练样本的距离
%   对于D中的每个cell，行对应着不同的块，列对应着不同的训练样本

if nargin<3 method='euclidean';end
D=cell(length(X_tst),1);
switch lower(method)
    case 'chi-square'
        for j=1:length(X_tst)
            x1=X_tst{j};
            for i=1:length(X_trn)
                x2=X_trn{i};
                A=(x1-x2).^2./(x1+x2);
                in=find(isnan(A)==1);
                A(in)=0;
                D{j}(:,i)=sum(A,2);     % Chi-square distance
            end
        end
    case 'manhattan'
        for j=1:length(X_tst)
            x1=X_tst{j};
            for i=1:length(X_trn)
                x2=X_trn{i};
                D{j}(:,i)=sum(abs(x1-x2),2); %Mahatton distance
            end
        end
    case 'cosine'
        for j=1:length(X_tst)
            x1=X_tst{j};
%              [x1]=normlizedata(x1,'1-norm');
            for i=1:length(X_trn)
                x2=X_trn{i};
%                    [x2]=normlizedata(x2,'1-norm');
                D{j}(:,i)=1-(diag(x1*x2')./(sqrt(diag(x1*x1')).*sqrt(diag(x2*x2')))); % Cosine distance
            end
        end
    case 'euclidean'
        for j=1:length(X_tst)
            x1=X_tst{j};
            for i=1:length(X_trn)
                x2=X_trn{i};
                D{j}(:,i)=(sum(((x1-x2).^2),2)); %Euclidean distance
            end
        end
end
