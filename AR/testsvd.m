clear;
load AR_part.mat;

for k=1:15
% for t=0:6
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
   if(rem(i,7)==1)
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


numtrn=length(X_trn1);
numtst=length(X_tst1);


[X_svd1,Y_svd1]=svddecomposition(X_trn1,Y_trn1);
[vec1, ~] = tdfda(X_svd1, max(Y_trn1)) ;


%%%%%%  使用生成的新的训练样本集分类%%%%%%
% for i=1:numtrn*2
%     X_trn1{i}=double(X_svd1{i})*vec1(:,1:k);
%     %X_trn{i}=double(X_trn{i});
% end
% k=15;
%%%%%%  使用原先的训练样本集分类  %%%%%%%
for i=1:numtrn
    X_trn1{i}=double(X_trn1{i})*vec1(:,1:k);
    %X_trn{i}=double(X_trn{i});
end
for i=1:numtst
    X_tst1{i}=double(X_tst1{i})*vec1(:,1:k);
    %X_tst{i}=double(X_tst{i});
end
d=discompute(X_trn1,X_tst1);
out=distclassify(d, Y_trn1);
ratek1(2,k)=mean(out==Y_tst1);

[X_svd2,Y_svd2]=svddecomposition(X_trn2,Y_trn2);
[vec2, ~] = tdfda(X_svd2, max(Y_trn2)) ;
%%%%%%  使用生成的新的训练样本集分类%%%%%%
% for i=1:numtrn*2
%     X_trn2{i}=double(X_svd2{i})*vec2(:,1:k);
%     %X_trn{i}=double(X_trn{i});
% end

%%%%%%  使用原先的训练样本集分类  %%%%%%%
for i=1:numtrn
    X_trn2{i}=double(X_trn2{i})*vec2(:,1:k);
    %X_trn{i}=double(X_trn{i});
end
for i=1:numtst
    X_tst2{i}=double(X_tst2{i})*vec2(:,1:k);
    %X_tst{i}=double(X_tst{i});
end
d=discompute(X_trn2,X_tst2);
out=distclassify(d, Y_trn2);
% for i=1:5
%     for j=1:3
%         subplot(5,3,3*(i-1)+j);
%         imshow(uint8(a{i,j}));
%     end
% end

ratek2(2,k)=mean(out==Y_tst2);
end