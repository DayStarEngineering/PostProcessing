files = dir(IMAGE_DIR);
outdir = '~/Desktop/EliotDayStar/15xBrightness/';
options.viewFactor =15;
h=progressbar([],0,'Progress')

for ii = 3:length(files)
    h=progressbar(h,ii/(length(files)-3))
    filename = files(ii).name;
    
    options.noise_method = {'none'};
    I1 = LoadDayStarImage(filename,options);
    imwrite(I1,[outdir,strrep(filename,'.tif','_raw.tif')],'tif');
    
        options.noise_method = {'col'};
    I1 = LoadDayStarImage(filename,options);
    imwrite(I1,[outdir,strrep(filename,'.tif','_ColumnSubtraction.tif')],'tif');
    
        options.noise_method = {'row_col'};
    I1 = LoadDayStarImage(filename,options);
    imwrite(I1,[outdir,strrep(filename,'.tif','_RowColumnSubtraction.tif')],'tif');
end

progressbar(h,-1)
    
    
    
    
