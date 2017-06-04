function [out]=distclassify(D,Y,method)
%%%%%%%%%%%%%%%%%%
%   这个函数是用来进行分类的
%   参数D是距离（参见discompute.m），Y是所有训练样本的标签
%   method有四个值可选：vote（投票）、min_dist（最小值）、max_dist（最大值）和sum_dist（总和）。
%   out返回所有测试样本的标签，是一个行向量

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
