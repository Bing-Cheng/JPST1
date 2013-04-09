clear;
block_date = {'08-08-11','08-09-11','08-10-11','08-12-11','09-13-11','09-16-11'};
block_ch = {'12','14','16'};
rat = 'G5L';
xD9 = [];    
for id = 1 : length(block_date)
  date =  block_date{id};
  ch = block_ch{1};
  fin = ['ESig_' rat '-' date '-Resting_channel'];
cb_saveName = [fin ch '_binned.mat'];
load(cb_saveName);%,'xData1');
 xD9 = [xD9 xData1]; 
end

xD10 = [];    
for id = 1 : length(block_date)
  date =  block_date{id};
  ch = block_ch{2};
  fin = ['ESig_' rat '-' date '-Resting_channel'];
cb_saveName = [fin ch '_binned.mat'];
load(cb_saveName);%,'xData1');
 xD10 = [xD10 xData1]; 
end
xD10 = xD10(:,1:end-1);


xD14 = [];    
for id = 1 : length(block_date)
  date =  block_date{id};
  ch = block_ch{3};
  fin = ['ESig_' rat '-' date '-Resting_channel'];
cb_saveName = [fin ch '_binned.mat'];
load(cb_saveName);%,'xData1');
 xD14 = [xD14 xData1]; 
end


mode= 'resting';
windowLen = 1800;


xData = xD9;
yData = xD10;
fileName1 = [rat mode num2str(windowLen) '12.mat']
save(fileName1, 'xData', 'yData') 

xData = xD9;
yData = xD14;
fileName1 = [rat mode num2str(windowLen) '13.mat']
save(fileName1, 'xData', 'yData') 

xData = xD10;
yData = xD14;
fileName1 = [rat mode num2str(windowLen) '23.mat']
save(fileName1, 'xData', 'yData')

