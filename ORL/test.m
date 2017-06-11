clear;
load ORL.mat;

for t=0:9
X_trn=cell(40,1);
X_tst=cell(360,1);
Y_trn=zeros(40,1);
Y_tst=zeros(360,1);
count1=1;
count2=1;
for i=1:400
    if(rem(i,10)==t)
        X_trn{count1}=ORL{i};
        Y_trn(count1)=ORL_label(i);
        count1=count1+1;
    else
        X_tst{count2}=ORL{i};
        Y_tst(count2)=ORL_label(i);
        count2=count2+1;
    end
end

method={'lu','svd','lu_svd'};
train={'new', 'origin'};

for i=1:3
    for j=1:2
        [Xtrn, Ytrn, Xtst] =  processing( X_trn, Y_trn, X_tst, method{i}, 'bdlda', [15,15], train{j} );
        d=discompute(Xtrn,Xtst);
        out=distclassify(d, Ytrn);
        rate2((i-1)*2+j,t+1)=mean(out==Y_tst);
    end
end
end