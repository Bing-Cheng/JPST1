clear;
block_date = {'12-02-10','12-03-10','12-06-10','12-07-10','12-09-10'};
block_ch = {'9','10','14'};

for id = 1 : length(block_date)
for ic = 1 : length(block_ch)
  date =  block_date{id};
  ch = block_ch{ic};
%  dir = ['G:\Q10_data\spikes\restingData\'];
fin = ['ESig_Q5L-' date '-Resting_channel'];
cb_fName = [fin ch '_correcttrials_sorted.mat'];
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
cb_saveName = [fin ch '_binned.mat'];
save(cb_saveName,'xData1');
end
end