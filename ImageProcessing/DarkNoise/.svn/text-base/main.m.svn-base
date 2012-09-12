%% Prepare Workspace
clc, clear all, close all
addpath images
addpath GrayCode

%% Load Image Names
% filenames = dir('images/*.tif'); % struct with filename info

%% Import csv data
info = xlsread('NoiseExp.xlsx','Sheet1');
filenames           = info(1:23,1);
time                = info(1:23,2);
time_since_start    = info(1:23,3);
tempC               = info(1:23,4);
tempF               = info(1:23,5);


for ii=1:length(filenames)
    images(ii).name     = [num2str(filenames(ii)),'.tif'];
    I                   = DayStar_Image(images(ii).name); % come out as 16 bit

% write 16bit gray code converted images to file (one time thing)   
%     outpath = ['images16bit/','16bit',images(ii).name];
%     imwrite(I,outpath,'tif');
 
    images(ii).sigma    = estimate_noise(I);
    images(ii).avg      = mean(mean(I));
    
    images(ii).time     = time(ii);
    images(ii).time_since_start = time_since_start(ii);
    images(ii).tempC    = tempC(ii);
    images(ii).tempF    = tempF(ii); 
    
    [IcolSub, IcolRowSub] = DRDCnoiseSub(I);
    images(ii).uint16colSubMean = mean(mean(IcolSub));
    images(ii).sigma_u16CS    = estimate_noise(IcolSub);
    images(ii).uint16colRowSubMean = mean(mean(IcolRowSub));
    images(ii).sigma_u16CRS    = estimate_noise(IcolRowSub);
    
    [IcSS, IcRSS] = DRDCnoiseSubSnglPrec(I);
    images(ii).singleColSubMean = mean(mean(IcSS));
    images(ii).sigma_singCS    = estimate_noise(IcSS);
    images(ii).singleColRowSubMean = mean(mean(IcRSS));
    images(ii).sigma_singCRS    = estimate_noise(IcRSS);
    
    [u16CS8DCs, u16CRS8DCs] = DRDCnoiseSub8DCs(I);
    images(ii).uint16ColSubMean8DCs = mean(mean(u16CS8DCs));
    images(ii).sigma_u16CS8DCs    = estimate_noise(u16CS8DCs);
    images(ii).uint16ColRowSubMean8DCs = mean(mean(u16CRS8DCs));
    images(ii).sigma_u16CRS8DCs    = estimate_noise(u16CRS8DCs);
    
    [singCS8DCs, singCRS8DCs] = DRDCnoiseSubSngl8DCs(I);
    images(ii).snglColSubMean8DCs = mean(mean(singCS8DCs));
    images(ii).sigma_singCS8DCs    = estimate_noise(singCS8DCs);
    images(ii).snglColRowSubMean8DCs = mean(mean(singCRS8DCs));
    images(ii).sigma_singCRS8DCs    = estimate_noise(singCS8DCs);
    
end


%% plotting
figure
% plot([images.tempC],[images.sigma],'linewidth',2)
% grid on
plot([images.tempC],[images.sigma_u16CS],'r','linewidth',2)
hold on
plot([images.tempC],[images.sigma_u16CRS],'.r','linewidth',2)

plot([images.tempC],[images.sigma_singCS],'g','linewidth',2)
plot([images.tempC],[images.sigma_singCRS],'.g','linewidth',2)

plot([images.tempC],[images.sigma_u16CS8DCs],'k','linewidth',2)
plot([images.tempC],[images.sigma_u16CRS8DCs],'.k','linewidth',2)

plot([images.tempC],[images.sigma_singCS8DCs],'c','linewidth',2)
plot([images.tempC],[images.sigma_singCRS8DCs],'.c','linewidth',2)

xlabel('Temp \deg C'); ylabel('Noise Estimation');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
% plot([images.tempC],[images.avg],'linewidth',2)
% hold on
plot([images.tempC],[images.uint16colSubMean],'r','linewidth',2)
hold on
plot([images.tempC],[images.uint16colRowSubMean],'.r','linewidth',2)

plot([images.tempC],[images.singleColSubMean],'g','linewidth',2)
plot([images.tempC],[images.singleColRowSubMean],'.g','linewidth',2)

plot([images.tempC],[images.uint16ColSubMean8DCs],'k','linewidth',2)
plot([images.tempC],[images.uint16ColRowSubMean8DCs],'.k','linewidth',2)

plot([images.tempC],[images.snglColSubMean8DCs],'c','linewidth',2)
plot([images.tempC],[images.snglColRowSubMean8DCs],'.c','linewidth',2)

grid on
xlabel('Temp \deg C'); ylabel('average');
% legend('intColSub','intColRowSub','singleColSub','singleColRowSub')










