clear;
load EYaleB.mat;

% for t=0:6
t=1;
X_trn=cell(38,1);
X_tst=cell(2394,1);
Y_trn=zeros(38,1);
Y_tst=zeros(2394,1);
count1=1;
count2=1;
for i=1:2432
    if(rem(i,64)==t)
        X_trn{count1}=EYaleB{i};
        Y_trn(count1)=EYaleB_label(i);
        count1=count1+1;
    else
        X_tst{count2}=EYaleB{i};
        Y_tst(count2)=EYaleB_label(i);
        count2=count2+1;
    end
end

method={'lu','svd','lu_svd'};
train={'new', 'origin'};
lda='left_lda';

for i=1:3
    for j=1:2
        [Xtrn, Ytrn, Xtst] =  processing( X_trn, Y_trn, X_tst, method{i}, lda, [15,15], train{j} );
        d=discompute(Xtrn,Xtst);
        out=distclassify(d, Ytrn);
        rate1((i-1)*2+j,t+1)=mean(out==Y_tst);
    end
end
% end