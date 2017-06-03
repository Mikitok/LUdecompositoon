% load ORL.mat;
% X_trn=cell(40,1);
% X_tst=cell(360,1);
% Y_trn=zeros(40,1);
% Y_tst=zeros(360,1);
% count1=1;
% count2=1;
% for i=1:400
%     if(rem(i,10)==1)
%         X_trn{count1}=ORL{i};
%         Y_trn(count1)=ORL_label(i);
%         count1=count1+1;
%     else
%         X_tst{count2}=ORL{i};
%         Y_tst(count2)=ORL_label(i);
%         count2=count2+1;
%     end
% end
% save ORL_group.mat X_trn X_tst Y_trn Y_tst;

load AR.mat;
X_trn1=cell(100,1);
X_tst1=cell(600,1);
X_trn2=cell(100,1);
X_tst2=cell(600,1);
Y_trn=zeros(100,1);
Y_tst=zeros(600,1);
count1=1;
count2=1;
count3=1;
for i=1:400
    if(rem(i,26)==1)
        X_trn1{count1}=AR{i};
        Y_trn(count1)=AR_label(i);
    else if(rem(i,26)==14)
        X_trn2{count1}=AR{i};
        count1=count1+1;
        else if(rem(i,26)>1 && rem(i,26)<8)
              X_tst1{count2}=AR{i};
              Y_tst(count2)=AR_label(i);
              count2=count2+1;
            else if(rem(i,26)>14 && rem(i,26)<21)
                X_tst2{count3}=AR{i};
                count3=count3+1;
                end
            end
        end
    end
end
save AR_group.mat X_trn1 X_tst1 X_trn2 X_tst2 Y_trn Y_tst;