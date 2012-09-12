% Function to load binary file data

function data = ParseBinary(filename,plotYN)


%% First, parse the binary into text
if exist('TMP/file0.txt','file')
    delete('TMP/file0.txt')
end
cd Binary
unix(['./dpcl ../RawFiles/',filename,' > ../TMP/file0.txt']);
cd ..


%% Load the Binary File
tmp = load('file0.txt');

%% Make a Structure of the file data
fields = upper({'time', 'time_us', 'field1' 'field2' 'field3' 'field4' 'field5' 'field6' 'field7' 'field8'});

for ii =1:length(fields)
    eval([fields{ii}, '= tmp(:,ii);']);
    data.(fields{ii}) = tmp(:,ii);
    
    if exist('plotYN','var')
        
        if ii > 2
            figure; plot(data.(fields{2}),data.(fields{ii}));
        end
    end
end

new_filename = ['./ParsedFiles/',strrep(filename,'.dat','.mat')];
save(new_filename,fields{:})

delete('TMP/file0.txt');

figure_awesome

end

