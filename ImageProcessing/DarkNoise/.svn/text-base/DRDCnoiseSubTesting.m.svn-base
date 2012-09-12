% DRDCnoiseSub Testing

clc; clear all; close all;

%% load image
imgName = 'images16bit/16bit1.tif';
image = imread(imgName,'tif');

% image stats
imageMean = mean(mean(single(image)))
imageMin = min(min(single(image)))
imageMax = max(max(single(image)))
imageStdDev = std(std(single(image)))


%% uint 16 stats (no negatives)
[IcolSub, IcolRowSub] = DRDCnoiseSub(image);

IcolSubMean = mean(mean(IcolSub))
IcolSubMin = min(min(IcolSub))
IcolSubMax = max(max(IcolSub))
IcolSubStdDev = std(std(single(IcolSub)))

IcolRowSubMean = mean(mean(IcolRowSub))
IcolRowSubMin = min(min(IcolRowSub))
IcolRowSubMax = max(max(IcolRowSub))
IcolRowSubStdDev = std(std(single(IcolRowSub)))


%% single precision stats 

[IcSS, IcRSS] = DRDCnoiseSubSnglPrec(image);

IcSSMean = mean(mean(IcSS))
IcSSMin = min(min(IcSS))
IcSSMax = max(max(IcSS))
IcSSStdDev = std(std(IcSS))

IcRSSMean = mean(mean(IcRSS))
IcRSSMin = min(min(IcRSS))
IcRSSMax = max(max(IcRSS))
IcRSSStdDev = std(std(IcRSS))


%% write images to file
% imwrite(IcolSub,'imagesClean/16bit1colClean.tif','tif');
% imwrite(IcolRowSub,'imagesClean/16bit1colRowClean.tif','tif');