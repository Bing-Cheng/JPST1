close all;
clear;
fs = 24414;
beName =['E:\bcheng\work\paper\my\sync\figures\sorting\ESig_W5L-07-07-09-A_channel3_incorrecttrialsInterval.mat'];
load(beName);

h = figure;
scrsz = get(0,'ScreenSize');
set(h,'Position',[100,20,1000,300]);
plot([1:fs]*1000/fs,data(1:fs));
 %  axis([0 length(rateTMW) 0 100]);
   xlabel('Time (ms)');
   ylabel('Amplitude (v)');
   

   
   
   titleName = ['DisRawData'];
  % title(titleName);
   saveas(h,titleName,'jpg');
   

   
    