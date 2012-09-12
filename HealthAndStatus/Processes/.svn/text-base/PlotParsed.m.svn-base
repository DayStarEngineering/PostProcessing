% Simple. First, make sure you have run the  "LoadRawFile" script on the
% data file

% Then come here and provide:
%
%   filename: The name of the Raw-parsed file
%   var1    : X axis variable 
%   var2    : Y axis variable

% Variable names are not case sensitive inputs. 

% For HealthAndStatus files, variable names include:
% 'CLOCK_S',
% 'CLOCK_MS',
% 'WATCHDOG',
% 'STATUS',
% 'COMP_POW',
% 'CMOS_POW',
% 'CMOS_IMG',
% 'EXP_TIME',
% 'ROI_STRT',
% 'ROI_END',
% 'DARK_ROW',
% 'LOW_GAIN',
% 'HI_GAIN',
% 'JTAG_CLK',
% 'ADC_RATE', 
% 'USERMODE',
% 'IMGORDER',
% 'WATCH_EN',
% 'LATCH_S',
% 'LATCH_LIMIT',
% 'NUM_BUFS',
% 'BUF_SIZE',             %binary
% 'BUF_LENGTH',           %binary
% 'HEADER',               %binary
% 'HEAD_LENGTH',          %binary
% 'MESSAGE_LENGTH',       %binary
% 'MAX_LENGTH',           %binary
% 'WATCHDOG_MAX',         %binary
% 'WATCHDOG_REBOOT'...    %binary



% For EPS Files, Variable names are:
% 'time', 
% 'time_us',
% 'field1'
% 'field2'
% 'field3' 
% 'field4' 
% 'field5' 
% 'field6'
% 'field7' 
% 'field8'

% Can be easily changed in ParseBinary.m


function data = PlotParsed(filename,var1,var2)

data = load(filename);


figure
plot(data.(upper(var1)),data.(upper(var2)),'linewidth',2)
grid on




end