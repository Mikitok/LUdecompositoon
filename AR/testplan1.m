clear;
load AR_part.mat;

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
        X_trn1{count1}=equalization(floor(imresize(X1{i},[120,90])));
        X_trn2{count1}=equalization(floor(imresize(X2{i},[120,90])));
        Y_trn1(count1)=Y1(i);
        Y_trn2(count1)=Y2(i);
        count1=count1+1;
    else
        X_tst1{count2}=equalization(floor(imresize(X1{i},[120,90])));
        X_tst2{count2}=equalization(floor(imresize(X2{i},[120,90])));
        Y_tst1(count2)=Y1(i);
        Y_tst2(count2)=Y2(i);
        count2=count2+1;
    end
end

[Xtrnlu, Ytrnlu, Xtstlu] =  processing( X_trn1, Y_trn1, X_tst1, 'lu', 'left_lda', [15,15], 'new' );
[Xtrnsvd,Ytrnsvd,Xtstsvd] = processing( X_trn1, Y_trn1, X_tst1, 'svd', 'right_lda', [15,15], 'origin' );
Ytrn=[Ytrnlu;Ytrnsvd];
d1=discompute(Xtrnlu,Xtstlu);
d2=discompute(Xtrnsvd,Xtstsvd);
d=[d1,d2];
[~,ind]=min(d,[],2);
out=Ytrn(ind);
rate1(t+1)=mean(out==Y_tst1);

[Xtrnlu, Ytrnlu, Xtstlu] =  processing( X_trn2, Y_trn2, X_tst2, 'lu', 'left_lda', [15,15], 'new' );
[Xtrnsvd,Ytrnsvd,Xtstsvd] = processing( X_trn2, Y_trn2, X_tst2,  'svd', 'right_lda', [15,15], 'origin' );
Ytrn=[Ytrnlu;Ytrnsvd];
d1=discompute(Xtrnlu,Xtstlu);
d2=discompute(Xtrnsvd,Xtstsvd);
d=[d1,d2];
[~,ind]=min(d,[],2);
out=Ytrn(ind);
rate2(t+1)=mean(out==Y_tst1);

end
