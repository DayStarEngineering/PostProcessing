%     picFileName is .tif image file name string
%     must call genGray2BinTable() functio before using this function

function grayImage=binImgToGrayImg(I, lookUpTable)

      fprintf('Converting from Gray to Binary')

%     I = imread(picFileName);
    
    % initialize corrected image
    row = size(I,1);
    col = size(I,2);
    grayImage = uint16(zeros(size(I)));

    % iterate through image
    one = uint16(1);
    
    for r = 1:row
        for c = 1:col
            grayImage(r,c) = lookUpTable(I(r,c)+one);
        end
    end
    

%     %% plotting
%     if nargout == 0
%     figure
%     subplot(1,2,1)
%     imshow(I.*(2^16/2^11))          %factor for 16 bit 12 bit difference
%     title('Orignal Image')
%     subplot(1,2,2)
%     imshow(grayImage.*(2^16/2^11))  %factor for 16 bit 12 bit difference
%     title('Converted Image')
% 
%     % Position, Size, and Color Figure Appropriately
%     set(gcf,'Color',[1 1 1].*0.9,'Position',[10 10  1500 600]);
%     end
    
    %% Scale to 16 bit image
    grayImage = grayImage.*(2^16/2^11);
end