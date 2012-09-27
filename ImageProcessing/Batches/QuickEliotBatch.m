files = dir('/Users/zachdischner/Desktop/StarTest_9_9_2012/Gray/TIFFconverted/Col_Sub/');


outdir = '/Users/zachdischner/Desktop/QuickEliot/';

for ii = length(files)-10:length(files)
    
    file = files(ii).name;
    image = imread(['/Users/zachdischner/Desktop/StarTest_9_9_2012/Gray/TIFFconverted/Col_Sub/',files(1000).name]);
    
    imwrite(image,[outdir,'Orig/',files(ii).name],'tif');
    imwrite(image*10,[outdir,'10X/',files(ii).name],'tif');
    imwrite(1e5-image*100,[outdir,'Inverted/',files(ii).name],'tif');
    
end