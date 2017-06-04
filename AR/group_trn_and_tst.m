% load AR.mat;
% X_trn1=cell(100,1);
% X_tst1=cell(600,1);
% X_trn2=cell(100,1);
% X_tst2=cell(600,1);
% Y_trn=zeros(100,1);
% Y_tst=zeros(600,1);
% count1=1;
% count2=1;
% count3=1;
% for i=1:400
%     if(rem(i,26)==1)
%         X_trn1{count1}=AR{i};
%         Y_trn(count1)=AR_label(i);
%     else if(rem(i,26)==14)
%         X_trn2{count1}=AR{i};
%         count1=count1+1;
%         else if(rem(i,26)>1 && rem(i,26)<8)
%               X_tst1{count2}=AR{i};
%               Y_tst(count2)=AR_label(i);
%               count2=count2+1;
%             else if(rem(i,26)>14 && rem(i,26)<21)
%                 X_tst2{count3}=AR{i};
%                 count3=count3+1;
%                 end
%             end
%         end
%     end
% end
% save AR_group.mat X_trn1 X_tst1 X_trn2 X_tst2 Y_trn Y_tst;

load AR.mat;
X1=cell(700,1);
X2=cell(700,1);
Y1=zeros(700,1);
Y2=zeros(700,1);
count1=1;
count2=1;
for i=1:2600
    if(rem(i,26)>0 && rem(i,26)<8)
        X1{count1}=AR{i};
        Y1(count1)=AR_label(i);
        count1=count1+1;
    else if(rem(i,26)>13 && rem(i,26)<21)
        X2{count2}=AR{i};
        Y2(count2)=AR_label(i);
        count2=count2+1;
        end
    end
end
save AR_part.mat X1 X2 Y1 Y2;