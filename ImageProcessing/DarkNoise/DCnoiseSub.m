% require images that are 2192 rows, 2592 cols
% this includes dark rows and columns
% this method will not work for other sizes

function [colsSubImage] = DCnoiseSub(image)
%% Set up
% dark cols and rows
numDRs = 16; % dark rows per half
numDCs = 16; % dark colums per side of image half

% image area
numRows = 1080; % per half
numCols = 2560; % per half

% image top area
rowStartTop = 1;
rowEndTop = numRows;

% image bottom area
rowStartBott = rowEndTop+numDRs*2+1;
rowEndBott = numRows*2+numDRs*2;

% dark cols
DCsStartLeft = 1;
DCsEndLeft = 16;
DCsStartRight = numDCs+numCols+1;
DCsEndRight = numDCs+numCols+numDCs;

% dark rows
DRsStartTop = rowEndTop+1;
DRsEndTop = rowEndTop+numDRs;
DRsStartBott = DRsEndTop+1;
DRsEndBott = DRsEndTop+numDRs;

%% Image manipulation
% image = uint16(image./(2^5)); % eleven bit equivalent, was 16 for viewing
image = uint16(image);

% Dark row data for top half
DRdataTop = image(DRsStartTop:DRsEndTop,DCsStartLeft:DCsEndRight); % includes subsection of interest

% Dark row data for bottom half
DRdataBott = image(DRsStartBott:DRsEndBott,DCsStartLeft:DCsEndRight); % includes subsection of interest
 
% get col averages for image area
for ii = DCsStartLeft:DCsEndRight
    topDRColAvgs(ii) = uint16(mean(DRdataTop(:,ii)));
    bottDRColAvgs(ii) =  uint16(mean(DRdataBott(:,ii)));
end

%% subtract col averages from image area
cleanImage = image;

for ii = DCsStartLeft:DCsEndRight
    % top
    for jj = rowStartTop:DRsEndTop
        cleanImage(jj,ii) = cleanImage(jj,ii) - topDRColAvgs(ii);
    end
    % bott
    for kk = DRsStartBott:rowEndBott
        cleanImage(kk,ii) = cleanImage(kk,ii) - bottDRColAvgs(ii);
    end
end

% image is now colums clean and the colums noise is subtracted out
% everywhere include the dark rows and columns
colsSubImage = cleanImage;

