function [Xtrn, Ytrn, Xtst] =  processing( X_trn, Y_trn, X_tst, method, lda, k, trainsample )
%  X_trn是训练样本集
%  Y_trn是训练样本对应的标签
%  X_tst是测试样本集
%  method 是表示图像分解的方法，有lu, svd, lu_svd三个选项，默认lu
%  lda是表示lda的方法：有left_lda，right_lda，bdlda三种，默认为left_lda
%  t是表示用第几个作训练样本，默认是1
%  k是一个二维数组，第一个表示left_lda降的维数，第二个表示right_lda降的维数，默认为[15，15]
%  trainsample表示是使用原训练样本，还是新训练样本，有：new、origin两种，默认为new
%  Xtrn是处理后的训练样本
%  Xtst是处理后的测试样本
if nargin>7||nargin<3     help processing;        end
if nargin<7     trainsample='new';  end
if nargin<6     k=[15,15];      end
if nargin<5     lda='left_lda';   end
if nargin<4     method='lu';    end

numtrn=length(X_trn);
numtst=length(X_tst);
switch lower(method)
    case 'lu'
        [X_dec,Y_dec]=ludecomposition(X_trn,Y_trn);
    case 'svd'
        [X_dec,Y_dec]=svddecomposition(X_trn,Y_trn);
    case 'lu_svd'
        [X_svd,Y_svd]=svddecomposition(X_trn,Y_trn);
        [X_lu, Y_lu] = ludecomposition( X_trn, Y_trn );
        X_dec=cell(4*numtrn,1);
        Y_dec=zeros(4*numtrn,1);
        count1=1;
        count2=2;
        for i=1:numtrn*4
            if (rem(i,4)==0)
                X_dec{i}=X_svd{count2};
                Y_dec(i)=Y_svd(count2);
                count2=count2+2;
            else
                X_dec{i}=X_lu{count1};
                Y_dec(i)=Y_lu(count1);
                count1=count1+1;
            end
        end
    otherwise
         help processing;           
end

len=length(X_dec);

Xtst=cell(numtst,1);
switch lower(lda)
    case 'left_lda'
        [vec, ~] = left_lda(X_dec, max(Y_dec)) ;
        switch lower(trainsample)
            case 'origin'
                Xtrn=cell(numtrn,1);
                for i=1:numtrn
                    Xtrn{i}=vec(:,1:k(1))'*double(X_trn{i});
                end
                Ytrn=Y_trn;
            case 'new'
                Xtrn=cell(len,1);
                for i=1:len
                    Xtrn{i}=vec(:,1:k(1))'*double(X_dec{i});
                end
                Ytrn=Y_dec;
        end
        for i=1:numtst
            Xtst{i}=vec(:,1:k(1))'*double(X_tst{i});
        end
    case 'right_lda'
        [vec, ~] = right_lda(X_dec, max(Y_dec)) ;
        switch lower(trainsample)
            case 'origin'
                Xtrn=cell(numtrn,1);
                for i=1:numtrn
                    Xtrn{i}=double(X_trn{i})*vec(:,1:k(2));
                end
                Ytrn=Y_trn;
            case 'new'
                Xtrn=cell(len,1);
                for i=1:len
                    Xtrn{i}=double(X_dec{i})*vec(:,1:k(2));
                end
                Ytrn=Y_dec;
        end
        for i=1:numtst
            Xtst{i}=double(X_tst{i})*vec(:,1:k(2));
        end
    case 'bdlda'
        [vec1, ~] = left_lda(X_dec, max(Y_dec)) ;
        [vec2, ~] = right_lda(X_dec, max(Y_dec)) ;
        switch lower(trainsample)
            case 'origin'
                Xtrn=cell(numtrn,1);
                for i=1:numtrn
                    Xtrn{i}=vec1(:,1:k(1))'*double(X_trn{i})*vec2(:,1:k(2));
                end
                Ytrn=Y_trn;
            case 'new'
                Xtrn=cell(len,1);
                for i=1:len
                    Xtrn{i}=vec1(:,1:k(1))'*double(X_dec{i})*vec2(:,1:k(2));
                end
                Ytrn=Y_dec;
        end
        for i=1:numtst
            Xtst{i}=vec1(:,1:k(1))'*double(X_tst{i})*vec2(:,1:k(2));
        end
    otherwise
         help processing;           
end
end

