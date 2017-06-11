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

method={'lu','svd','lu_svd'};
train={'new', 'origin'};

for i=1:3
    for j=1:2
        [Xtrn, Ytrn, Xtst] =  processing( X_trn1, Y_trn1, X_tst1, method{i}, 'left_lda', [15,15], train{j} );
        d=discompute(Xtrn,Xtst);
        out=distclassify(d, Ytrn);
        rate1((i-1)*2+j,t+1)=mean(out==Y_tst1);
        
        [Xtrn, Ytrn, Xtst] =  processing( X_trn2, Y_trn2, X_tst2, method{i}, 'left_lda', [15,15], train{j} );
        d=discompute(Xtrn,Xtst);
        out=distclassify(d, Ytrn);
        rate2((i-1)*2+j,t+1)=mean(out==Y_tst2);
    end
end
end