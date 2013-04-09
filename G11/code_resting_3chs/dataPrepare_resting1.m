clear;
block_date = {'08-08-11','08-09-11','08-10-11','08-12-11','09-13-11','09-16-11'};
block_ch = {'12','14','16'};
dir = ['E:\bcheng\work\data1\G11\'];
for id = 1 : length(block_date)
date =  block_date{id};  
fin = ['ESig_G5L-' date '-Resting_channel'];
for ic = 1 : length(block_ch)
   ch = block_ch{ic};
 cb_fName = [dir fin ch '_combined_sorted.mat'];
load(cb_fName);
%'idx_sorted', 'index_sorted', 'rate'
spike1 = index_sorted(find(idx_sorted==1));
trial1 = floor(spike1/(1.8*24414));

xData1 = [];
for tr = 0 : trial1(end)
timeBin = zeros(1800,1);
idx = find(trial1==tr);
timeStampSample = spike1(idx) - tr*(1.8*24414);
timeStampMS = timeStampSample*1000/24414;
timeStampMSint = floor(timeStampMS)+1;
timeBin(timeStampMSint)=1;
 xData1 = [xData1 timeBin]; 
end
trialNo(ic) = size(xData1,2);
cb_saveName = [fin ch '_binned.mat'];
save(cb_saveName,'xData1');
end
trialNoMin = min(trialNo);
trialNoMax = max(trialNo);
if trialNoMin ~= trialNoMax
for ic = 1 : length(block_ch)
  date =  block_date{id};
  ch = block_ch{ic};
  cb_saveName = [fin ch '_binned.mat'];
  load(cb_saveName);
  xData1 = xData1(:,1:trialNoMin);
  save(cb_saveName,'xData1');
end
end
end