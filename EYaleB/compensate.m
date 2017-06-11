function image_com = compensate( image, method )
%%%%%%%%%%%%%%%%%%%
%  这个函数是用来对光照偏角太大的图片进行光照补偿的处理
%  传入的参数image是要进行处理的图片，method有两个值：vertical和horizontal
%  其中vertical是对光源的左右变化进行处理，horizontal是对光源的仰角的变化进行处理
%  返回值image_com是处理好的图片

% image=imread('yaleB01_P00A+120E+00.png');
% image=imresize(image,[100,100]);
load yale-b_avg_100X100.mat;

image=double(image);
[row,column]=size(image);
image_com=image-img_avg;
key=mean(mean(image_com));

switch lower(method)
    case 'vertical'
         line=mean(image_com)-key;
         for i=1:row
             image_com(i,:)=image(i,:)-line;
         end         
    case 'horizontal'
        line=mean(image_com,2)-key;
        for i=1:column
            image_com(:,i)=image(:,i)-line;
        end
end
% image_com=image_com-key;
image_com=round(image_com);
image_com(find(image_com<0))=0;
image_com(find(image_com>255))=255;
end

