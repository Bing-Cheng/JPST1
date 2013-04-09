clear; 
close all; 
clc;

mode = 'interval';
rat = 'A5L';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dateW = {
%         '08-28-09'  21.74	5.26	75.00	15.79	0.00	12.50	22.22   10.00;  % 08-28, 1, too few trials
        '09-09-09'  39.51	45.16	18.75	44.12	61.54	33.33	55.56	31.25;  % 09-09, 2
        '09-10-09'  39.84	30.19	64.29	36.17	36.00	25.00	32.00	40.91;  % 09-10, 3
%         '09-11-09'  0       0       0       0       0       0       0       0    ;  % 09-11, 4,
%         '09-16-09'  35.77	50.00	10.00	39.62	57.14	42.11	33.33   47.83;  % 09-16, 5, no channel 5
        '09-17-09'  43.31	66.67	27.50	31.67	73.91	61.76	20.59	46.15;  % 09-17, 6
        '09-18-09'  36.13	51.35	34.48	26.42	52.38	50.00	18.75	38.10;  % 09-18, 7
        '09-21-09'  41.98	63.64	41.38	25.86	68.18	59.09	25.00	26.92;  % 09-21, 8
        '09-22-09'  41.96	67.65	48.00	22.64	61.90	76.92	21.43	24.00;  % 09-22, 9
        '09-23-09'  38.86	55.77	50.00	22.89	65.22	48.28	13.64	33.33;  % 09-23, 10
        '09-24-09'  34.64	50.88	32.00	22.54	37.14	72.73	15.00	32.26;  % 09-24, 11
%         '09-25-09'  44.25	56.41	55.00	31.48	76.92	46.15	31.03   32.00;  % 09-25, 12, only 4 and 5
%         '09-28-09'  43.90	47.73	42.86	41.18	40.00	54.17	32.26   55.00;  % 09-28, 13, no chan 12
%         '09-30-09'  52.08	66.10	60.00	35.00	75.76	53.85	24.24   48.15;  % 09-30, 14, no chan 5
%         '10-05-09'  56.48	91.89	65.00	27.45	100.00	85.00	22.22   33.33;  % 10-05, 15, no chan 12
%         '10-06-09'  41.84	92.31	52.17	10.20	92.86	91.67	12.00   8.33;	% 10-06, 16, no data
%         '10-07-09'  55.28	91.30	52.50	34.67	91.30	91.30	32.35   36.59;  % 10-07, 17, no chan 12
        '10-08-09'  46.31	95.12	75.00	14.29	95.00	95.24	14.29	14.29;  % 10-08, 18
        '10-12-09'  53.66	78.57	91.30	27.06	84.00	74.19	25.00	29.27;	% 10-12, 19
        '10-14-09'  61.61	85.53	75.68	40.54	90.00	80.56	31.15	52.00;	% 10-14, 20
%         '10-15-09'  55.56	93.02	75.00	26.03	94.74	91.67	27.78   24.32;	% 10-15, 21, no chan 4, 11
%         '10-22-09'  52.12	91.30	85.00	20.47	96.77	86.84	14.93   26.67;	% 10-22, 22, no data
        '10-23-09'  41.38	83.78	84.62	8.54	83.33	84.21	7.14	10.00;	% 10-23, 23
        '10-26-09'  60.99	78.00	90.48	40.00	64.29	95.45	37.84	42.42;	% 10-26, 24
%         '10-27-09'  59.84	97.62	86.96	21.05	94.74	100.00	32.00   12.50;	% 10-27, 25, no chan 12
        '10-28-09'  66.46	90.74	100.00	39.24	92.86	88.46	43.90	34.21;	% 10-28, 26
%         '10-29-09'  57.69	90.57	96.00	23.08	100.00	83.87	15.91   32.35;	% 10-29, 27, no data
        '10-30-09'  58.52	86.36	84.62	29.23	85.71	86.96	32.35	25.81;	% 10-30, 28
        '11-02-09'  64.66	78.26	70.59	49.06	86.36	70.83	46.67	52.17;	% 11-02, 29
        '11-03-09'  63.19	53.57	92.00	60.32	62.07	44.44	58.82	62.07;	% 11-03, 30
        '11-05-09'  74.63	74.00	78.57	73.21	85.71	65.52	66.67	80.77;	% 11-05, 31
        };
channel = {'4'; '5'; '11'; '12'};
 save([rat '-dateW.mat'],'dateW');    


direct = 'E:\bcheng\work\data1\a\interval\';
dataLenSec = 4;


rawDataName = ['rawData_' mode rat '.mat'];
         
s = size(dateW);

date = dateW(:,1);

% read all the data into sD
td_h = 1;

      [cTrL cTrR sD] = cs_nsp_data_struct(direct,  rat, date, channel, 0, dataLenSec, td_h);% from 0s to 2s,binsize is 5ms

save(rawDataName, 'cTrL', 'cTrR', 'sD');





