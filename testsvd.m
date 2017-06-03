% clear;
% 
% load ORL.mat;
% 
% X_trn=cell(40,1);
% X_tst=cell(360,1);
% Y_trn=zeros(40,1);
% Y_tst=zeros(360,1);
% count1=1;
% count2=1;
% for i=1:400
%     if(rem(i,10)==0)
%         X_trn{count1}=ORL{i};
%         Y_trn(count1)=ORL_label(i);
%         count1=count1+1;
%     else
%         X_tst{count2}=ORL{i};
%         Y_tst(count2)=ORL_label(i);
%         count2=count2+1;
%     end
% end

% load ORL_group.mat;

numtrn=length(X_trn);
numtst=length(X_tst);

[X_svd,Y_svd]=svddecomposition(X_trn,Y_trn);
k=15;
for i=1:numtrn*2
    X_trn{i}=double(X_svd{i})*vec(:,1:k);
    %X_trn{i}=double(X_trn{i});
end
for i=1:numtst
    X_tst{i}=double(X_tst{i})*vec(:,1:k);
    %X_tst{i}=double(X_tst{i});
end
d=discompute(X_trn,X_tst);
out=distclassify(d, Y_svd);

mean(out==Y_tst)