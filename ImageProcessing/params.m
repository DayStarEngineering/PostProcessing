% Use this fuction to store information/global specs throughout program


function output = params(input)


switch upper(strrep(input,'_',' '))
    %% Directory where images are stored
    case 'IMAGE DIR'
        output = './DayStarPic';
    %% Has the Startup script been run?
    case 'STARTUP'
        if strfind(path,'Utils') & ...
            strfind(path,'DarkNoise') & ...
            strfind(path,'HighDynamicRange') & ...
            strfind(path,'Images') & ...
            strfind(path,'GrayCodeConversion')& ... 
            strfind(path,'Batches')
           output = true;
        else
           output = false;
        end
    otherwise
        fprintf(2,'Uh oh, invalid parameter request!\n')
        dbstack(2,'-completenames')
        
        
    
end



end
