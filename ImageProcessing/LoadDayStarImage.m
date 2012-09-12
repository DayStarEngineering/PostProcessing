function I = LoadDayStarImage(filename,options)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Month Day Year
%      +-------------------------+------------------------\    __      ____
%  {=  |     Zach Dischner,      | Email:   zach.dischner  \___| \____/ ___\___|
%  {=  |  Aerospace Engineering  |         @colorado.edu   /   ===---======)--->
%      +-------------------------+------------------------/                    |
%
%     Function  :LoadDayStarImage
%
%     Purpose   :Do all prelim work to load up a DayStar Image
%
%     Input     :filename
%                      *Name of file to load
%                options
%                      *Structure of options for loading
%
%     Output    :I
%                      *Gray code converted, and (optional) noise processed
%                       image
%                      *If no outputs are called, the processed images are 
%                       simply displayed
% 
%     Some Options:
%           options.
%               * noise_method:'row_col','col','wiener','medfilt'. CELL INPUT 
%                               Different methods for
%                               noise reduction to return.  Can input
%                               multiple as a cell array of methods. EG:
%                     >>options.noise_method = {'col','medfilt'}
%               * NoGray      : Just set this field to something if the
%                               image already has been GrayCode converted. 
%               * centroid    : show some weird measure of matlab's centroid of regeon (NOT HELPFUL NOW)  
%                                 
%
%     EX: (Make sure 'RunMeOnStartup' is modified to contain your image_dir
% 
% 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% See if workspace has been prepared
if ~exist('STARTUP','var')
    RunMeOnStartup
end

%% Get All Options From User Input
if ~exist('options','var')
    options.noise_method = {'none'};  % Default for noise reduction later
end

% No Noise method specified
if ~isfield(options,'noise_method')
    options.noise_method = {'none'};
end

% Noise method not cell type
if ~iscell(options.noise_method)
    options.noise_method = cell(options.noise_method);
end

% Show Centroids?
if isfield(options,'centroids')
    centroids = 1;
end

% Has this file already been gray code converted?
if isfield(options,'NoGray')
    NoGray = 1;
else
    NoGray = 0;
end

if isfield(options,'BeQuiet')
    BeQuiet = 1;
else 
    BeQuiet = 0;
end

% if isfield(options,'noise_method')
%     noise_method = {options.noise_method};
% else
%     noise_method = {'row_col'};
% end


% viewing multiplication factor
if ~isfield(options,'viewFactor')
    viewFactor = 1; 
else
    viewFactor = options.viewFactor;
end




%% Load Image, with GrayCode Conversion

% Gray Code conversion has already occured
if NoGray == 0
    pic = DayStar_Image(filename);
else 
    pic = imread(filename);
end

[m n] = size(pic);

if m == 2160 && n == 2560
    I = pic;
    return
end

%% If view factor wanted, multiply by view factor
pic = pic;


%% Perform Row/Column Noise Subtraction
[just_col both] = DRDCnoiseSub8DCs(pic);


if nargout == 0
    figure
    subplottight(1,3,1)
    imshow(pic*viewFactor)
    title(['Original Image, Noise Estimate = ',num2str(estimate_noise(pic))])
    if exist('centroids','var')
        ShowCentroidsPrelim(pic*viewFactor)
    end
    
    subplottight(1,3,2)
    imshow(just_col*viewFactor)
    title(['Col Subtraction, Noise Estimate = ',num2str(estimate_noise(just_col))])
    if exist('centroids','var')
        ShowCentroidsPrelim(just_col*viewFactor)
    end
    
    subplottight(1,3,3)
    imshow(both*viewFactor)
    title(['Col + Row Subtraction, Noise Estimate = ',num2str(estimate_noise(both))])
    if exist('centroids','var')
        ShowCentroidsPrelim(both*viewFactor)
    end
    
    % Position, Size, and Color Figure Appropriately
    set(gcf,'Position',[10 50 1400 500]);
    return
    
end


%% Decide what to return
for ii = 1:length(options.noise_method)
    method = options.noise_method{ii};
    
    switch method
        case 'row_col'
            [tmp pic] = DRDCnoiseSub8DCs(pic);
            if ~BeQuiet
                fprintf('\nRow and Column Subtraction \n')
            end
            
        case 'col'
            [pic] = DCnoiseSub(pic);
            if ~BeQuiet
                fprintf('\nColumn Subtraction \n')
            end
        case 'medfilt'
            pic = medfilt2(pic,[3,3]);
            if ~BeQuiet
                fprintf('\nMedian Noise Filter\n')
            end
        case 'wiener'
            pic = wiener2(pic,[10,10]);
            if ~BeQuiet
                fprintf('\nWiener Noise Filter\n')
            end
        case 'none'
            if ~BeQuiet
                fprintf('\nNo Noise Reduction\n')
            end
        otherwise
            [tmp pic] = DRDCnoiseSub8DCs(pic);
            if ~BeQuiet
                fprintf('\nRow and Column Subtraction \n')
            end
    end
    
end


%% Remove Dark Rows, Dark Columns
pic(1081:1081 + 32,:) = [];
pic(:,1:16) = [];
pic(:,2560:end) = [];
I = pic*viewFactor;





end


