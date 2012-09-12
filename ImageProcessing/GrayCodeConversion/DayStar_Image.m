function Image=DayStar_Image(imname)

 close all;

g2bTable = genGray2BinTable();

if strfind(imname,'.raw') 
    I1 = LoadRawFile(imname,'save');
elseif strfind(imname,'.dat')
    I1 = LoadRawFile(imname,'save');
else
    I1=imread(imname);
end

%% Graycode and 16 Bit scaling happens here!!! 
Image=binImgToGrayImg(I1,g2bTable);




    %% plotting
%     if nargout == 0
%     figure
%     subplot(1,2,1)
%     imshow(I1.*(2^16/2^11))          %factor for 16 bit 12 bit difference
%     title('Orignal Image')
%     subplot(1,2,2)
%     imshow(Image)  %factor for 16 bit 12 bit difference
%     title('Converted Image')
% 
%     % Position, Size, and Color Figure Appropriately
%     set(gcf,'Color',[1 1 1].*0.9,'Position',[10 10  1500 600]);
%     end

