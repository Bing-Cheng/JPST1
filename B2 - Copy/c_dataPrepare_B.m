clear; 
close all; 
clc;

mode = 'cueAlign';
rat = 'B5L';

eventDir = 'E:\bcheng\work\data1\B\B5L_event\'; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dateW = {'05-04-11','05-05-11','05-10-11','05-16-11','05-20-11','05-25-11','05-26-11',...%'05-31-11','06-01-11',...
    '06-02-11','06-03-11','06-06-11','06-07-11','06-10-11',};
dateN= length(dateW);
for i = 1 : dateN
date1 = dateW{i};
date2=[date1(1:2),date1(4:5),date1(7:8)];
fileNameLoad = [eventDir rat '-' date2 '-5Light.mat'];
load(fileNameLoad);
rateT(i) = ExpData.behaviour.AC(1);
rateL(i) = ExpData.behaviour.AC(2);
rateR(i) = ExpData.behaviour.AC(4);
end
figure
hold on;
plot(rateT,'r');
plot(rateL,'g');
plot(rateR,'b');
 save([rat '-dateW.mat'],'dateW','rateT');       
 date = dateW';
 channel = {'5';'7';'11';'16'};

direct = 'E:\bcheng\work\data1\B\SpikeTrain\';
dataLenSec = 4;


rawDataName = ['rawData_' mode rat '.mat'];
         


% read all the data into sD
td_h = 1;

      [cTrL cTrR sD] = cs_nsp_data_struct(direct,  rat, date, channel, 0, dataLenSec, td_h);% from 0s to 2s,binsize is 5ms

save(rawDataName, 'cTrL', 'cTrR', 'sD');





