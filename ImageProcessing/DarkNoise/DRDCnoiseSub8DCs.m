% require images that are 2192 rows, 2592 cols
% this includes dark rows and columns
% this method will not work for other sizes

% clc; clear all; close all;

function [colsSubImage, colsAndRowsSubImage] = DRDCnoiseSub8DCs(image)

%% Set up
% dark cols and rows
numDRs = 16; % dark rows per half
numDCs = 16; % dark colums per side of image half
usedDCs = 8;

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
DCsEndLeft = 8;
DCsStartRight = numDCs+numCols+usedDCs+1;
DCsEndRight = numDCs+numCols+numDCs;

% dark rows
DRsStartTop = rowEndTop+1;
DRsEndTop = rowEndTop+numDRs;
DRsStartBott = DRsEndTop+1;
DRsEndBott = DRsEndTop+numDRs;

% only use left DCs
LEFT_ONLY = 0;

%% Image manipulation
% imgName = 'images16bit/16bit1.tif';
% image = imread(imgName,'tif');
image = uint16(image);

% figure
% imshow(image);

% Dark row data for top half
DRdataTop = image(DRsStartTop:DRsEndTop,DCsStartLeft:DCsEndRight); % includes subsection of interest
DCdataTop_L = image(rowStartTop:rowEndTop,DCsStartLeft:DCsEndLeft); % first 8 cols
DCdataTop_R = image(rowStartTop:rowEndTop,DCsStartRight:DCsEndRight); % last 8 cols

% Dark row data for bottom half
DRdataBott = image(DRsStartBott:DRsEndBott,DCsStartLeft:DCsEndRight); % includes subsection of interest
DCdataBott_L = image(rowStartBott:rowEndBott,DCsStartLeft:DCsEndLeft); % first 8 cols
DCdataBott_R = image(rowStartBott:rowEndBott,DCsStartRight:DCsEndRight); % last 8 cols
 
% get DC averages excluding DRs region
DCavgTop_L = [];
DCavgBott_L = [];

for ii = 1:usedDCs
    DCavgTop_L(ii)  = mean(DCdataTop_L(:,ii));
    DCavgBott_L(ii) = mean(DCdataBott_L(:,ii));
end
DCavgTop_L = uint16(DCavgTop_L);
DCavgBott_L = uint16(DCavgBott_L);

DCavgTop_R = [];
DCavgBott_R = [];

for ii = 1:usedDCs
    DCavgTop_R(ii)  = mean(DCdataTop_R(:,ii));
    DCavgBott_R(ii) = mean(DCdataBott_R(:,ii));
end
DCavgTop_R = uint16(DCavgTop_R);
DCavgBott_R = uint16(DCavgBott_R);

% subract DC averages from DR subsection to get DR offsets
DSubSecTop_L = DRdataTop(1:numDRs,DCsStartLeft:DCsEndLeft);
DSubSecBott_L = DRdataBott(1:numDRs,DCsStartLeft:DCsEndLeft);
DSubSecTop_R = DRdataTop(1:numDRs,DCsStartRight:DCsEndRight);
DSubSecBott_R = DRdataBott(1:numDRs,DCsStartRight:DCsEndRight);

% subtract DCavg from each col of subsection
for ii = 1:usedDCs
        DSubSecTop_L(1:numDRs,ii) = DSubSecTop_L(1:numDRs,ii)-DCavgTop_L(ii);
        DSubSecBott_L(1:numDRs,ii) = DSubSecBott_L(1:numDRs,ii)-DCavgBott_L(ii);
        DSubSecTop_R(1:numDRs,ii) = DSubSecTop_R(1:numDRs,ii)-DCavgTop_R(ii);
        DSubSecBott_R(1:numDRs,ii) = DSubSecBott_R(1:numDRs,ii)-DCavgBott_R(ii);
end

% average rows of subsections
DRNoiseTop = [];
DRNoiseBott = [];

for jj = 1:numDRs
    if (LEFT_ONLY)
        DRNoiseTop(jj) = uint16(mean(DSubSecTop_L(jj,:)));
        DRNoiseBott(jj) = uint16(mean(DSubSecBott_L(jj,:)));
    else
        DRNoiseTop(jj) = uint16( mean([ mean(DSubSecTop_L(jj,:)) , mean(DSubSecTop_R(jj,:)) ]));
        DRNoiseBott(jj) = uint16( mean([ mean(DSubSecBott_L(jj,:)) , mean(DSubSecBott_R(jj,:)) ]));
    end
end

% subtract row noise from DRs
for jj = 1:numDRs
    for ii = DCsStartLeft:DCsEndRight
        DRdataTop(jj,ii) = DRdataTop(jj,ii) - DRNoiseTop(jj);
        DRdataBott(jj,ii) = DRdataBott(jj,ii) - DRNoiseBott(jj);
    end
end

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
% figure
% imshow(colsSubImage);

%% subtract row noise after removing columns noise
% find row noise from R and L DCs per rwo
% subtract that form columns and move to next row
rowSubImage = cleanImage;

for ii = rowStartTop:rowEndBott
    leftAvg = mean(rowSubImage(ii,DCsStartLeft:DCsEndLeft));
    rightAvg = mean(rowSubImage(ii,DCsStartRight:DCsEndRight));
    rowMean = (leftAvg+rightAvg)/2; 
    for jj = DCsStartLeft:DCsEndRight
        rowSubImage(ii,jj) = rowSubImage(ii,jj) - rowMean;
    end
end

colsAndRowsSubImage = rowSubImage;

% figure
% imshow(colsAndRowsSubImage);
