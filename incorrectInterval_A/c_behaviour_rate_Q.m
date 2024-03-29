clear; 
close all; 
clc;

mode = 'cueAlign';
rat = 'Q5L';

% dateW = {'12-01-10','12-02-10','12-03-10','12-06-10','12-07-10','12-08-10','12-09-10','12-10-10',...
%     '12-13-10','12-16-10','12-17-10'};
dateW = {'12-02-10','12-03-10','12-06-10','12-07-10','12-09-10'};
dateN= length(dateW);
for i = 1 : dateN
date1 = dateW{i};
fileNameLoad = [rat '-' date1 '-5Light.mat'];
load(fileNameLoad);
rateT(i) = ExpData.behaviour.AC(1);
rateL(i) = ExpData.behaviour.AC(2);
rateR(i) = ExpData.behaviour.AC(4);
end

h = figure;
hold on;
    x1 = [0 length(rateT) length(rateT) 0];
 
    yy = [0 0 100 100];
    fill(x1,yy,[0.6 0.6 0.4]);

   lWidth = 1;
   plot(rateT*100,'r','linewidth',lWidth);
   plot(rateL*100,'g','linewidth',lWidth);
   plot(rateR*100,'b','linewidth',lWidth);
   legend('learning','total', 'left', 'right','Location', 'SouthEast');
axis([0 length(rateT) 0 100])
   titleName = [rat 'behavior correction rate'];
   title(titleName);
   saveas(h,titleName,'jpg');
 