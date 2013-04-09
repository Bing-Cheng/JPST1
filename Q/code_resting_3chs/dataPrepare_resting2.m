clear;
block_date = {'12-02-10','12-03-10','12-06-10','12-07-10','12-09-10'};
block_ch = {'9','10','14'};

xD9 = [];    
for id = 1 : length(block_date)
  date =  block_date{id};
  ch = '9';
  fin = ['ESig_Q5L-' date '-Resting_channel'];
cb_saveName = [fin ch '_binned.mat'];
load(cb_saveName);%,'xData1');
 xD9 = [xD9 xData1]; 
end

xD10 = [];    
for id = 1 : length(block_date)
  date =  block_date{id};
  ch = '10';
  fin = ['ESig_Q5L-' date '-Resting_channel'];
cb_saveName = [fin ch '_binned.mat'];
load(cb_saveName);%,'xData1');
 xD10 = [xD10 xData1]; 
end

xD14 = [];    
for id = 1 : length(block_date)
  date =  block_date{id};
  ch = '14';
  fin = ['ESig_Q5L-' date '-Resting_channel'];
cb_saveName = [fin ch '_binned.mat'];
load(cb_saveName);%,'xData1');
 xD14 = [xD14 xData1]; 
end

rat = 'Q5L';
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

