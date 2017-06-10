clear;
load AR_part.mat;
load ratel.mat;
% for k=1:15
for t=0:6
 X_trn1=cell(100,1);
X_tst1=cell(600,1);
X_trn2=cell(100,1);
X_tst2=cell(600,1);
Y_trn1=zeros(100,1);
Y_tst1=zeros(600,1);
Y_trn2=zeros(100,1);
Y_tst2=zeros(600,1);
count1=1;
count2=1;
for i=1:700
   if(rem(i,7)==t)
        X_trn1{count1}=imresize(X1{i},[120,90]);
        X_trn2{count1}=imresize(X2{i},[120,90]);
        Y_trn1(count1)=Y1(i);
        Y_trn2(count1)=Y2(i);
        count1=count1+1;
    else
        X_tst1{count2}=imresize(X1{i},[120,90]);
        X_tst2{count2}=imresize(X2{i},[120,90]);
        Y_tst1(count2)=Y1(i);
        Y_tst2(count2)=Y2(i);
        count2=count2+1;
    end
end
k=15;

numtrn=length(X_trn1);
numtst=length(X_tst1);
%%%%%%%%  第一个子集  %%%%%%%%%
[X_svd,Y_svd]=svddecomposition(X_trn1,Y_trn1);
[ X_lu, Y_lu] = ludecomposition( X_trn1, Y_trn1 );
k=15;
X_all1=cell(4*numtrn,1);
Y_all1=zeros(4*numtrn,1);
count1=1;
count2=2;
for i=1:numtrn*4
    if (rem(i,4)==0)
        X_all1{i}=X_svd{count2};
        Y_all1(i)=Y_svd(count2);
        count2=count2+2;
    else
        X_all1{i}=X_lu{count1};
        Y_all1(i)=Y_lu(count1);
        count1=count1+1;
    end
end

% [vec1, ~] = tdfda(X_all1, max(Y_all1)) ;
[vec1, ~] = tdfda1(X_all1, max(Y_all1)) ;
%%%%%  使用生成的新的训练样本集分类%%%%%%
for i=1:numtrn*4
%     X_trn1{i}=vec1(:,1:k)'*double(X_all1{i});
    X_trn1{i}=double(X_all1{i})*vec1(:,1:k);
    %X_trn{i}=double(X_trn{i});
end

% %%%%%  使用原先的训练样本集分类  %%%%%%%
% for i=1:numtrn
% %     X_trn1{i}=vec1(:,1:k)'*double(X_trn1{i});
%     X_trn1{i}=double(X_trn1{i})*vec1(:,1:k);
%     %X_trn{i}=double(X_trn{i});
% end

for i=1:numtst
%     X_tst1{i}=vec1(:,1:k)'*double(X_tst1{i});
    X_tst1{i}=double(X_tst1{i})*vec1(:,1:k);
    %X_tst{i}=double(X_tst{i});
end

d=discompute(X_trn1,X_tst1);
out=distclassify(d, Y_all1);
ratel1(5,t+1)=mean(out==Y_tst1);


%%%%%%%%  第二个子集  %%%%%%%%
[X_svd,Y_svd]=svddecomposition(X_trn2,Y_trn2);
[ X_lu, Y_lu] = ludecomposition( X_trn2, Y_trn2 );
k=15;
X_all2=cell(4*numtrn,1);
Y_all2=zeros(4*numtrn,1);
count1=1;
count2=2;
for i=1:numtrn*4
    if (rem(i,4)==0)
        X_all2{i}=X_svd{count2};
        Y_all2(i)=Y_svd(count2);
        count2=count2+2;
    else
        X_all2{i}=X_lu{count1};
        Y_all2(i)=Y_lu(count1);
        count1=count1+1;
    end
end

% [vec2, ~] = tdfda(X_all2, max(Y_all2)) ;
[vec2, ~] = tdfda1(X_all2, max(Y_all2)) ;
%%%%%  使用生成的新的训练样本集分类%%%%%%
for i=1:numtrn*4
%     X_trn2{i}=vec2(:,1:k)'*double(X_all2{i});
    X_trn2{i}=double(X_all2{i})*vec2(:,1:k);
    %X_trn{i}=double(X_trn{i});
end

% %%%%%%  使用原先的训练样本集分类  %%%%%%%
% for i=1:numtrn
% %     X_trn2{i}=vec2(:,1:k)'*double(X_trn2{i});
%     X_trn2{i}=double(X_trn2{i})*vec2(:,1:k);
%     %X_trn{i}=double(X_trn{i});
% end

for i=1:numtst
%     X_tst2{i}=vec2(:,1:k)'*double(X_tst2{i});
    X_tst2{i}=double(X_tst2{i})*vec2(:,1:k);
    %X_tst{i}=double(X_tst{i});
end
d=discompute(X_trn2,X_tst2);
out=distclassify(d, Y_all2);

ratel2(5,t+1)=mean(out==Y_tst2);
end