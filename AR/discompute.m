function [D]=discompute(X_trn,X_tst,method)
%%%%%%%%%%%%%%%%%%%%%
%   ���������������ѵ�������Ͳ�������֮��ľ���
%   X_trn��ѵ��������X_tst�ǲ�������������cell����һ��cell���һ��ͼƬ
%   method���ĸ�ֵ�ɹ�ѡ��chi-square���������룩��manhatton�������پ��룩��cosine�����Ҿ��룩��euclidean��ŷ�Ͼ��룩
%   ����ֵD�����룬��cell����һ��cell���һ����������������ѵ�������ľ���
%   ����D�е�ÿ��cell���ж�Ӧ�Ų�ͬ�Ŀ飬�ж�Ӧ�Ų�ͬ��ѵ������

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
