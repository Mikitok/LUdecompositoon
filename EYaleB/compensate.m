function image_com = compensate( image, method )
%%%%%%%%%%%%%%%%%%%
%  ��������������Թ���ƫ��̫���ͼƬ���й��ղ����Ĵ���
%  ����Ĳ���image��Ҫ���д����ͼƬ��method������ֵ��vertical��horizontal
%  ����vertical�ǶԹ�Դ�����ұ仯���д���horizontal�ǶԹ�Դ�����ǵı仯���д���
%  ����ֵimage_com�Ǵ���õ�ͼƬ

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

