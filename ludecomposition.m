function [ X_lu ] = ludecomposition( X_trn )
% ludecomposition函数是用lu分解生成两张近似图像。
% X_trn是单样本训练集，为一个num*1的cell元组。
% X_lu是原样本和生成的近似图像的集合，为一个num*3的cell元组。

samplenum=length(X_trn);
[m,n]=size(X_trn{1});
X_lu=cell(samplenum,3);

b1=cell( n , 1 );
ind1=zeros( n , 1 );
b2=cell( m, 1);
ind2=zeros(m,1);
for i=1:samplenum
    X_trn{i}=double(X_trn{i});
    % 保存原有的训练样本
    X_lu{i,1}=X_trn{i};
    
    % 对训练样本求近似图像
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
    X_lu{i,2}=p' * s1;
    
    %对训练样本的转置求近似图像
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
    X_lu{i,3}=(p' * s2)';
    %imshow(uint8(X_lu{3*i}));
end
end

