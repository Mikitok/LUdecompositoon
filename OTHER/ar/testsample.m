X=double(imread('yaleB_e1.png'));  
X=floor(imresize(X,[100,80]));
[L,U,P]=lu(X);
TEF=sum(sum((L*U).^2));
[m,n]=size(X);

B=cell(n,1);
BEF=zeros(n,1);
for i=1:n
    B{i}=L(:,i)*U(i,:);
    BEF(i)=sum(sum(B{i}.^2));
end

[BEF,IX]=sort(BEF,'descend');

i=1;
EF=0;
S=zeros(m,n);
while(EF/TEF < 0.92 || i<11)
    EF=EF+BEF(i);
    S=S+B{IX(i)};
    i=i+1;
end
% 
% for i=1:91
%     EF=EF+BEF(i);
%     S=S+B{IX(i)};
% end
imshow(uint8(P'*S))