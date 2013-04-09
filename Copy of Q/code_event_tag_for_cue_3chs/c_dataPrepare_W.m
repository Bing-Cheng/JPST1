clear; 
close all; 
clc;

mode = 'cueAlign';
rat = 'Q5L';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dateW = {
        '12-02-10'	52.00	26.09	100.00	63.16	9.09	41.67	88.89	40.00;  % 07-01, 2
        '12-03-10'	63.77	51.72	83.33	67.86	46.67	57.14	83.33	56.25;  % 07-06, 4
        '12-06-10'	68.75	54.55	88.89	76.47	41.67	70.00	100.00	50.00;  % 07-07, 5
        '12-07-10'	62.79	50.00	75.00	76.92	34.78	66.67	100.00	60.00;  % 07-08, 6
        '12-09-10'	61.29	62.07	100.00	50.00	44.44	90.91	90.00	25.00  % 07-09, 7
        };
     channel = {'9';'10';'14'};
 save([rat '-dateW.mat'],'dateW');   


direct = 'E:\bcheng\work\code\code_event_tag_for_cue_3chs\';
dataLenSec = 4;


rawDataName = ['rawData_' mode rat '.mat'];
         
s = size(dateW);

date = dateW(:,1);

% read all the data into sD
td_h = 1;

      [cTrL cTrR sD] = cs_nsp_data_struct(direct,  rat, date, channel, 0, dataLenSec, td_h);% from 0s to 2s,binsize is 5ms

save(rawDataName, 'cTrL', 'cTrR', 'sD');





