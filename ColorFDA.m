function [newspace,new_cls_data] = ColorFDA(X)
[m,num]=size(X);
for i=1:m
    X1=0;
    for j=1:num
        X1=X{i,j}+X1;
    end;
    E_cls{i}=X1/num;
end;
X_all=0;
for i=1:m
    X1=E_cls{i}; 
    X_all=X1+X_all; 
end;
E_all=X_all/(num*m);%����ѵ��������������
%E_all=mean(X)
Sb1=0;
for i=1:m
    Sb1=((E_cls{i})-E_all)'*( (E_cls{i})-E_all)*num+Sb1;
end;
Sb=Sb1/(num*m);

Sw1=0;
for i=1:m
    for j=1:num
      Sw1=(X{i,j}-E_cls{i})'*(X{i,j}-E_cls{i})+Sw1;
    end;
end;
Sw=Sw1/(num*m);
Sw=Sw+eye(size(Sw,1))*1.e-8;
%Sw=reshape(Sw,10,10);
%���������ֵ����������
%[V,L]=eig(inv(Sw)*Sb);
S=inv(Sw)*Sb;
S=(S+S')/2;
[V, L] = eig(S);
%V=V(:,condition);
L=diag(L);%����LΪ�ԽǵĶԽǾ���
%index=find(L>1.e-5);%�ҵ�����ĳ�����ĸþ�����±�

%L=L(index);
[a temp]=sort(L,'descend');
temp=temp(1:60);
L=a(1:60);
newspace=V(:,temp);%�����������ֵ����Ӧ����������

for i=1:m
    for j=1:num
    %for j=1:size(X,1)
        %tempic=reshape(X(j,:),1,100);
        %new_cls_data{i}=X_tst{i}*V;
        new_cls_data{i,j}=X{i,j}*newspace;
    %end;
    end;
end;




