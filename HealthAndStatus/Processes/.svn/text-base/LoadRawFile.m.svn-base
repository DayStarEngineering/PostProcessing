% Simple function to load raw H&S data into a structure


function [HSData,new_filename] = LoadRawFile(filename)


%% Define Data Names
% params = {'CLOCK_S',
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
% };
params = {'TIME'
        'UTIME'
        'CPU'
        'MEM'
        'LOADAVE'
        'DF'
        'DFDATA'
        'DFDATA1'
        'IMGFC'
        'HEALTHFC'
        'DONEFC'
        'PARTSFC'
        'NUMZOMB'
        'NUMPDOG'
        'NUMSTIMG'
        'NUMDCOL'
        'NUMSCHED'
        'NUMSSM'
        'STIMG0'
        'STIMG1'
        'STIMG2'
        'STIMG3'
        'STIMG4'
        'SCHED0'
        'SCHED1'
        'SCHED2'};

% raw = load(filename);
% % raw_strings = fread(fopen(filename),size(raw),'char');
% 
% %% Now The Binary Data
% [m n] = size(raw);
% 
% % Number of columns
% % for ii = n-8:n
% %     
% %     % Number of Rows
% %     for jj = 1:m
% %         raw(jj,ii) = hex2dec(raw_strings(jj,(jj-1)*n + ii));
% %         
% %     end
% % end
% 
% %% Load Regular Data
% for ii = 1:length(params)
%     eval(['HSData.',lower(params{ii}),' = raw(:,',num2str(ii),')']);
% end



% [CLOCK_S,...
%     CLOCK_MS,...
%     WATCHDOG,...
%     STATUS,...
%     COMP_POW,...
%     CMOS_POW,...
%     CMOS_IMG,...
%     EXP_TIME,...
%     ROI_STRT,...
%     ROI_END,...
%     DARK_ROW,...
%     LOW_GAIN,...
%     HI_GAIN,...
%     JTAG_CLK,...
%     ADC_RATE,...
%     USERMODE,...
%     IMGORDER,...
%     WATCH_EN,...
%     LATCH_S,...
%     LATCH_LIMIT,...
%     NUM_BUFS,...
%     BUF_SIZE,...             %binary
%     BUF_LENGTH,...           %binary
%     HEADER,...               %binary
%     HEAD_LENGTH,...          %binary
%     MESSAGE_LENGTH,...       %binary
%     MAX_LENGTH,...           %binary
%     WATCHDOG_MAX,...         %binary
%     WATCHDOG_REBOOT]

[TIME ,...
    UTIME,...
    CPU,...
    MEM,...
    LOADAVE,...
    DF,...
    DFDATA,...
    DFDATA1,...
    IMGFC,...
    HEALTHFC,...
    DONEFC,...
    PARTSFC,...
    NUMZOMB,...
    NUMPDOG,...
    NUMSTIMG,...
    NUMDCOL,...
    NUMSCHED,...
    NUMSSM,...
    STIMG0,...
    STIMG1,...
    STIMG2,...
    STIMG3,...
    STIMG4,...
    SCHED0,...
    SCHED1,...
    SCHED2] = textread(filename,...
    '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %s %s %s %s %s %s %s %s'); 
% Load all regular fields as a float, and all hex/binary fields as strings 


ii = 1;
idx = 1;

while idx < length(CLOCK_S)
    if mod(idx,2) ~= 0
      for jj = 1:length(params)
          eval([params{jj},'_tmp(ii) = ',params{jj},'(idx);']);
      end  
        ii = ii + 1;
    end
    idx = idx + 1;
end

for jj = 1:length(params)
          eval([params{jj},' = ',params{jj},'_tmp;']);
end  
        


% BUF_SIZE        = hex2dec(BUF_SIZE);
% BUF_LENGTH      = hex2dec(BUF_LENGTH);
% HEADER          = hex2dec(HEADER);
% HEAD_LENGTH     = hex2dec(HEAD_LENGTH);
% MESSAGE_LENGTH	= hex2dec(MESSAGE_LENGTH);
% MAX_LENGTH      = hex2dec(MAX_LENGTH);
% WATCHDOG_MAX    = hex2dec(WATCHDOG_MAX);
% WATCHDOG_REBOOT = hex2dec(WATCHDOG_REBOOT);
STIMG0  = hex2dec(STIMG0);
STIMG1  = hex2dec(STIMG1);
STIMG2  = hex2dec(STIMG2);
STIMG3  = hex2dec(STIMG3);
STIMG4  = hex2dec(STIMG4);
SCHED0  = hex2dec(SCHED0);
SCHED1  = hex2dec(SCHED1);
SCHED2  = hex2dec(SCHED2);


new_filename = ['./ParsedFiles/',strrep(filename,'.txt','.mat')]
save(new_filename,params{:})


for jj = 1:length(params)
          eval(['HSData.',params{jj},' = ',params{jj},'_tmp;']);
end  


end

