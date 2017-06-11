function equ_image = equalization( image )
%%%%%%%%%%%%%%%%%%%%%%%%
%   这个函数是直方图均衡化的实现
%   参数image是需要处理的函数
%   返回值equ_image是均衡化之后的图片

[row,column] = size(image);
maxPexel=max(max(image));

%统计像素值的分布密度
pixelNum=zeros(1,maxPexel+1);
for i=0:maxPexel
    pixelNum(i+1)=length(find(image==i))/(row*column*1.0);
end

%计算直方图分布
pixelEqualize=zeros(1,maxPexel+1);
for i=1:maxPexel+1
    if i==1
        pixelEqualize(i)=pixelNum(i);
    else
        pixelEqualize(i)=pixelEqualize(i-1)+pixelNum(i);
    end
end

%取整
pixelEqualize=round(256 .* pixelEqualize +0.5);

%均衡化
for i=1:row
    for j=1:column
        equ_image(i,j)=pixelEqualize(image(i,j)+1);
    end
end
end

