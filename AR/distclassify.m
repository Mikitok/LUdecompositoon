function [out]=distclassify(D,Y,method)
%%%%%%%%%%%%%%%%%%
%   ����������������з����
%   ����D�Ǿ��루�μ�discompute.m����Y������ѵ�������ı�ǩ
%   method���ĸ�ֵ��ѡ��vote��ͶƱ����min_dist����Сֵ����max_dist�����ֵ����sum_dist���ܺͣ���
%   out�������в��������ı�ǩ����һ��������

if nargin<2 || nargin>3
    help Distclassify
else
    numclass=max(Y);
    numtest=length(D);
    numsample=length(Y);
    if nargin<3 
        method='sum_dist';
    end
    switch lower(method)
        case 'vote'
            A=zeros(numtest,numsample);
            for i=1:length(D)
                [~,d]=min(D{i}');
                for j=1:numclass
                    A(i,j)=sum(Y(j)==d);
                end
            end
            [~,out]=max(A');
        case 'min_dist'
            A=zeros(numtest,numsample);
            for i=1:numtest
                A(i,:)=min(D{i});
            end
            [~,out]=min(A');
        case 'max_dist'
            A=zeros(numtest,numsample);
            for i=1:numtest
                A(i,:)=max(D{i});
            end
            [~,out]=min(A');
        case 'sum_dist'
            A=zeros(numtest,numsample);
            for i=1:length(D)
                A(i,:)=sum(D{i});
            end
            [~,out]=min(A');
            out=Y(out);
    end
end
