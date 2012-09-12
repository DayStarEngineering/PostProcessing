% Given a directory, either read all files in that directory and plot, or
% reload the saved    .mat   file with all the data stored.



function all_data = PlotBatch(file_dir)
close all;


%% First, look and see if the .mat file exists with this batch directory.
batchname   = regexp(file_dir,'/','split');

if exist([batchname{end},'.mat'],'file')
    all_data = load([batchname{end},'.mat']);
    all_data = all_data.all_data;
else
    addpath(file_dir)
    
    %% Gotta Parse Each Raw File
    for ii = 1:42
        params{ii} = ['field_',num2str(ii),' '];
        eval(['all_data.',params{ii},'=[];']);
    end
    
    files = dir([file_dir,'/*.txt']);
    
    for ii = 1:length(files)
        filename = files(ii).name;
        
        eval(['[',params{:} , ']= textread(filename,''%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %s %s %s %s %s %s %s %s %s'');']);
        
        % Convert Hex to Numbers
        for jj=(length(params)-8):length(params)
            eval([params{jj},' = hex2dec(',params{jj},');']);
        end
        
        % Put all data into the big structure
        for jj=1:length(params)
            eval(['all_data.',params{jj},'= [all_data.',params{jj},';',params{jj},'];']);
        end
        
        
    end
    
    new_filename = ['./ParsedFiles/',[batchname{end},'.mat']];
    %         save(new_filename,[strrep(params(:),' ','')])
    save(new_filename,'all_data');
    
end

%% Now Perform All the Plotting
tags = fieldnames(all_data);
nametags = strrep(tags,'_',' ');

for ii = 3:length(tags)
    if size(all_data.(char(tags(1)))) == size(all_data.(char(tags(ii))))
        figure
        plot(all_data.(char(tags(1))),all_data.(char(tags(ii))))
        xlabel(nametags(1));ylabel(nametags(ii));
        title([nametags(1),'  VS  ',nametags(ii)])
    else
        fprintf(2,['\nOops, Columns 1 and Columns ',num2str(ii),' are not the same length!!! \n\n'])
    end  
end

figure_awesome();





end





