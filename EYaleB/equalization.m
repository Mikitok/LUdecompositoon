function equ_image = equalization( image )
%%%%%%%%%%%%%%%%%%%%%%%%
%   ���������ֱ��ͼ���⻯��ʵ��
%   ����image����Ҫ����ĺ���
%   ����ֵequ_image�Ǿ��⻯֮���ͼƬ

[row,column] = size(image);
maxPexel=max(max(image));

%ͳ������ֵ�ķֲ��ܶ�
pixelNum=zeros(1,maxPexel+1);
for i=0:maxPexel
    pixelNum(i+1)=length(find(image==i))/(row*column*1.0);
end

%����ֱ��ͼ�ֲ�
pixelEqualize=zeros(1,maxPexel+1);
for i=1:maxPexel+1
    if i==1
        pixelEqualize(i)=pixelNum(i);
    else
        pixelEqualize(i)=pixelEqualize(i-1)+pixelNum(i);
    end
end

%ȡ��
pixelEqualize=round(256 .* pixelEqualize +0.5);

%���⻯
for i=1:row
    for j=1:column
        equ_image(i,j)=pixelEqualize(image(i,j)+1);
    end
end
end

