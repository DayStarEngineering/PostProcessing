clc;clear all; close all
files = dir([params('image dir'),'/*.dat*']);
% For raw, un processed, un gray converted images

for ii = 1:length(files)
    filename = files(ii).name;
    
    g2bTable = genGray2BinTable();    
    
    %% For Tiff images
%     Gray_Image = imread([params('image_dir'),'/',filename]);
    
    %% For Non-Tiff images
    Gray_Image = LoadRawFile(filename);

    
    fprintf('Saving Gray Code Image\n\n')
    if ~exist([params('image dir'),'/Gray'],'dir')
        mkdir([params('image dir'),'/Gray']);
    end
    imwrite(Gray_Image*2^5,[params('image_dir'),'/Gray/',strrep(filename,'.dat','_gray.tif')])
    
    image = binImgToGrayImg(Gray_Image./2^5, g2bTable).*2^5;
    
    
    fprintf(['Saving new tiff file to: ',params('image dir'),'/Gray/TIFFconverted/',strrep(filename,'.dat','.tif'),'\n\n'])
    if ~exist([params('image dir'),'/Gray/TIFFconverted'],'dir')
        mkdir([params('image dir'),'/Gray/TIFFconverted']);
    end
    imwrite(image,[params('image dir'),'/Gray/TIFFconverted/',strrep(filename,'.dat','.tif')],'tif');
    
    fprintf('Performing Column Subtraction\n\n')
    DC_image = DCnoiseSub(image);
    
    fprintf('Saving new Noise-Free Image\n\n')
    if ~exist([params('image dir'),'/Gray/TIFFconverted/Col_Sub'],'dir')
        mkdir([params('image dir'),'/Gray/TIFFconverted/Col_Sub']);
    end
    imwrite(DC_image,[params('image_dir'),'/Gray/TIFFconverted/Col_Sub/',strrep(filename,'.dat','_DC.tif')],'tif');
    
    

end

