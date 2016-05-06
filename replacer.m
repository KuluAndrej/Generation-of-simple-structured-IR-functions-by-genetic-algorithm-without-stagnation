function []  = replacer(trecs)

THISFOLDER = fileparts(mfilename('fullpath'));
DATAFOLDER = fullfile(THISFOLDER,'Data');
DATAFOLDER2 = fullfile(THISFOLDER,['Data', num2str(trecs)]);
addpath(DATAFOLDER);
addpath(DATAFOLDER2);

pathData = './Data/';       % positive example
pathTest = ['./Data', num2str(trecs), '/'];   % negative example


imlistData = dir([pathData '*.txt']);


for ii =1:length(imlistData)
    copyfile([pathData, imlistData(ii).name],pathTest) 
end

for ii =1:length(imlistData)
    delete([pathData, imlistData(ii).name])    
end





end