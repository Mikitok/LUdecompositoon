function [Xtrn, Ytrn, Xtst] =  processing( X_trn, Y_trn, X_tst, method, lda, k, trainsample )
%  X_trn��ѵ��������
%  Y_trn��ѵ��������Ӧ�ı�ǩ
%  X_tst�ǲ���������
%  method �Ǳ�ʾͼ��ֽ�ķ�������lu, svd, lu_svd����ѡ�Ĭ��lu
%  lda�Ǳ�ʾlda�ķ�������left_lda��right_lda��bdlda���֣�Ĭ��Ϊleft_lda
%  t�Ǳ�ʾ�õڼ�����ѵ��������Ĭ����1
%  k��һ����ά���飬��һ����ʾleft_lda����ά�����ڶ�����ʾright_lda����ά����Ĭ��Ϊ[15��15]
%  trainsample��ʾ��ʹ��ԭѵ��������������ѵ���������У�new��origin���֣�Ĭ��Ϊnew
%  Xtrn�Ǵ�����ѵ������
%  Xtst�Ǵ����Ĳ�������
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

