function tiffReadyImage = LoadRawFile(filename,save)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Month Day Year
%      +-------------------------+------------------------\    __      ____
%  {=  |     Zach Dischner,      | Email:   zach.dischner  \___| \____/ ___\___|
%  {=  |  Aerospace Engineering  |         @colorado.edu   /   ===---======)--->
%      +-------------------------+------------------------/                    |
%
%     Function  :
%
%     Purpose   :
%
%     Input     :
%
%     Output    :
%
%     Procedure :
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fileID = fopen([params('Image Dir'),'/',filename]);
rawImage = fread(fileID,'uint16');
fclose(fileID);

fprintf('Converting raw image to tiff \n')

if length(rawImage) == 5681664;     % Length of file with dark rows/cols
    tiffReadyImage = zeros(2192,2592);
    [m n] = size(tiffReadyImage);
    kk = 1;
    for ii = 1:m
        for jj = 1:n
            tiffReadyImage(ii,jj) = rawImage(kk);
            kk = kk+1;
        end
    end
    
    % No dark rows/cols in file
else
    
    
    tiffReadyImage = zeros(2160,2560);
    [m n] = size(tiffReadyImage);
    kk = 1;
    for ii = 1:m
        for jj = 1:n
            tiffReadyImage(ii,jj) = rawImage(kk);
            kk = kk+1;
        end
    end
end

tiffReadyImage = uint16(tiffReadyImage);

if exist('save','var')
    if ~exist([params('image dir'),'/TIFFconverted'],'dir')
        mkdir([params('image dir'),'/TIFFconverted'])
    end
    
    % Depends on what kind of raw file
    if strfind(filename,'.raw')
        fprintf(['Saving new tiff file to: ',params('image dir'),'/TIFFconverted/',strrep(filename,'.raw','.tif'),'\n\n'])
        imwrite(tiffReadyImage.*2^5,[params('image dir'),'/TIFFconverted/',strrep(filename,'.raw','.tif')],'tif');
    elseif strfind(filename,'.dat')
        fprintf(['Saving new tiff file to: ',params('image dir'),'/TIFFconverted/',strrep(filename,'.dat','.tif'),'\n\n'])
        imwrite(tiffReadyImage.*2^5,[params('image dir'),'/TIFFconverted/',strrep(filename,'.dat','.tif')],'tif');
    else
        disp('UNSUPPORTED FILE TYPE!!! FOR THE LOVE OF GOD NO!!!')
        dbstack('-completenames')
    end
end









end