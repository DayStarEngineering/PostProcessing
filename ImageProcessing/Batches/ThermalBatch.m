clc;clear all; close all
files = dir([params('image dir'),'/img*']);
outdir = [params('Image Dir'),'/TIFFconverted/ProcessedImages/'];
if ~exist([params('Image Dir'),'/TIFFconverted/ProcessedImages/'],'dir')
    mkdir([params('Image Dir'),'/TIFFconverted/ProcessedImages/'])
end

% If files have not been TIFF converted
if ~exist([params('Image Dir'),'/TIFFconverted'],'dir')
    for ii = 1:length(files)
        I = LoadDayStarImage(files(ii).name);
    end
end


options.viewFactor =1;
h=progressbar([],0,'Progress');

figure
subplottight(1,6,1)
files = dir([params('image dir'),'/TIFFconverted/','/img*']);
picIteration = length(files)/5;
subplot_count = 1;
pic_count = 1e6;


for ii = 1:length(files)
    h=progressbar(h,ii/(length(files)));
    figure(h);
    filename = files(ii).name;
    
    options.noise_method = {'col'};
    options.NoGray       = 1;
    options.BeQuiet      = 1;
    I1 = LoadDayStarImage([params('image_dir'),'/TIFFconverted/',filename],options);
    imwrite(I1,[outdir,strrep(filename,'.tif','_ColumnSubtraction.tif')],'tif');
    fprintf(2,['Col Subtraction, Noise Estimate = ',num2str(estimate_noise(I1))],'\n')
    fprintf('\n')
    
    
    
    if pic_count > picIteration
        
        subplottight(1,5,subplot_count)
        imshow(I1*15)
        title(['Col Subtraction, Noise Estimate = ',num2str(estimate_noise(I1))])
        subplot_count = subplot_count + 1;
        pic_count = 0;
        
    end
    
    pic_count = pic_count + 1;
    
end
% Position, Size, and Color Figure Appropriately
set(gcf,'Position',[10 50 1400 500]);

progressbar(h,-1)