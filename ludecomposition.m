function [ X_lu, Y_lu] = ludecomposition( X_trn, Y_trn )
% ludecomposition��������lu�ֽ��������Ž���ͼ��
% X_trn�ǵ�����ѵ������Ϊһ��num*1��cellԪ�顣
% Y_trn�Ǻ�ÿ��������Ӧ�ı�ǩ����Ϊһ��num*1����������
% X_lu��ԭ���������ɵĽ���ͼ��ļ��ϣ�Ϊһ��3num*1��cellԪ�顣
% Y_lu�Ǻ�X_lu��������Ӧ�ı�ǩ����Ϊһ��3num*1����������

samplenum=length(X_trn);
[m,n]=size(X_trn{1});
X_lu=cell(3*samplenum,1);

b1=cell( n , 1 );
ind1=zeros( n , 1 );
b2=cell( m, 1);
ind2=zeros(m,1);
for i=1:samplenum
    X_trn{i}=double(X_trn{i});
    % ����ԭ�е�ѵ������
    X_lu{3*(i-1)+1}=X_trn{i};
    
    % ��ѵ�����������ͼ��
    [l,u,p]=lu(X_trn{i});
    for j=1:n
        b1{ j }=l( : , j )*u( j , : );
        ind1( j ) = sum( sum( b1{ j }.^2 ) );
    end
    tef=sum(ind1);
    ind1 = ind1/tef ;
    [ind1,dx1]=sort(ind1 ,'descend');
    ef=0;
    k=0;
    s1=zeros(m,n);
    while ef<0.92
        k=k+1;
        ef=ef+ind1(k);
        s1=s1+ b1{dx1(k)};
    end
    X_lu{3*i-1}=p' * s1;
    
    %��ѵ��������ת�������ͼ��
    X_trn{i}=X_trn{i}';
    [l,u,p]=lu(X_trn{i});
    for j=1:n
        b2{ j }= l( : , j )*u( j , : );
        ind2( j ) = sum( sum( b2{ j }.^2 ) );
    end
    tef=sum(ind2);
    ind2=ind2/tef;
    [ind2,dx2]=sort(ind2 ,'descend');
    ef=0;
    k=0;
    s2=zeros(n,m);
     while ef<0.92
        k=k+1;
        ef=ef+ind2(k);
        s2=s2+ b2{dx2(k)};
     end
    X_lu{3*i}=(p' * s2)';
    %imshow(uint8(X_lu{3*i}));
end
Y_lu=[Y_trn,Y_trn,Y_trn]; 
end
