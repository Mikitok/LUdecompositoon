clear;
load AR_part.mat;

for k=1:15
% for t=0:6
% k=15;
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

[X_lu1,Y_lu1]=ludecomposition(X_trn1,Y_trn1);
[vec1, ~] = tdfda(X_lu1, max(Y_trn1)) ;
% k=15;

%%%%%%  使用生成的新的训练样本集分类%%%%%%
for i=1:numtrn*3
    X_trn1{i}=vec1(:,1:k)'*double(X_lu1{i});
    %X_trn{i}=double(X_trn{i});
end

%%%%%%  使用原先的训练样本集分类  %%%%%%%
% for i=1:numtrn
%     X_trn1{i}=double(X_trn{i})*vec(:,1:k);
%     %X_trn{i}=double(X_trn{i});
% end
for i=1:numtst
    X_tst1{i}=vec1(:,1:k)'*double(X_tst1{i});
    %X_tst{i}=double(X_tst{i});
end
d=discompute(X_trn1,X_tst1);
out=distclassify(d, Y_lu1);
ratek1(1,k)=mean(out==Y_tst1);

[X_lu2,Y_lu2]=ludecomposition(X_trn2,Y_trn2);
[vec2, ~] = tdfda(X_lu2, max(Y_trn2)) ;
%%%%%%  使用生成的新的训练样本集分类%%%%%%
for i=1:numtrn*3
    X_trn2{i}=vec2(:,1:k)'*double(X_lu2{i});
    %X_trn{i}=double(X_trn{i});
end

%%%%%%  使用原先的训练样本集分类  %%%%%%%
% for i=1:numtrn
%     X_trn1{i}=double(X_trn{i})*vec(:,1:k);
%     %X_trn{i}=double(X_trn{i});
% end
for i=1:numtst
    X_tst2{i}=vec2(:,1:k)'*double(X_tst2{i});
    %X_tst{i}=double(X_tst{i});
end
d=discompute(X_trn2,X_tst2);
out=distclassify(d, Y_lu2);

ratek2(1,k)=mean(out==Y_tst2);

end