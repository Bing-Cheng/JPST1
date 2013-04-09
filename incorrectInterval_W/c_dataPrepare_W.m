clear; 
close all; 
clc;

mode = 'interval';
rat = 'W5L';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dateW = {
%         '06-30-09'  42.45	20.00	72.00	66.67	2.56	38.89	100.00	48.00;  % 06-30, 1
        '07-01-09'	52.00	26.09	100.00	63.16	9.09	41.67	88.89	40.00;  % 07-01, 2
%         '07-02-09'	75.00	66.67	100.00	75.00	66.67	66.67   100.00	50.00;  % 07-02, 3
        '07-06-09'	63.77	51.72	83.33	67.86	46.67	57.14	83.33	56.25;  % 07-06, 4
        '07-07-09'	68.75	54.55	88.89	76.47	41.67	70.00	100.00	50.00;  % 07-07, 5
        '07-08-09'	62.79	50.00	75.00	76.92	34.78	66.67	100.00	60.00;  % 07-08, 6
        '07-09-09'	61.29	62.07	100.00	50.00	44.44	90.91	90.00	25.00;  % 07-09, 7
        '07-10-09'	52.63	52.17	54.55	52.17	38.46	70.00	100.00	21.43;  % 07-10, 8
        '07-13-09'	55.15	54.10	54.17	59.18	31.43	84.62	100.00	39.39;  % 07-13, 9
        '07-14-09'	66.67	57.14	56.67	89.19	43.24	84.21	100.00	78.95;  % 07-14, 10
        '07-16-09'	63.33	69.57	40.74	70.21	66.67	72.73	61.11	75.86;  % 07-16, 11
        '07-17-09'	66.96	75.00	38.46	76.32	65.00	82.14	68.18	87.50;  % 07-17, 12
        %10
        '07-21-09'	62.93	72.50	23.53	85.71	52.17	100.00	88.24	84.00;  % 07-21, 13
        '07-22-09'	69.42	81.82	21.43	85.71	70.83	95.00	84.00	87.50;  % 07-22, 14
        '07-23-09'	67.63	72.00	35.00	89.80	57.14	90.91	88.00	91.67;  % 07-23, 15
        '07-24-09'	81.90	78.26	64.00	95.56	75.00	80.77	100.00	91.30;  % 07-24, 16
        '07-27-09'	73.39	78.00	42.86	86.96	66.67	95.00	86.36	87.50;  % 07-27, 17
        '07-28-09'	78.51	84.31	45.83	89.13	83.33	85.19	84.00	95.24;  % 07-28, 18
        '07-29-09'	78.33	76.92	63.64	86.96	78.57	75.00	75.00	100.00; % 07-29, 19
%         '07-30-09'	77.42	72.50	64.71	88.89	76.47	69.57	84.21	94.12;	% 07-30, 20
        '07-31-09'	88.00	86.67	73.33	96.67	100.00	75.00	100.00	93.33;	% 07-31, 21
        '08-10-09'	81.70	83.33	67.57	89.29	83.87	82.76	82.76	96.30;	% 08-10, 22
        '08-11-09'	90.74	92.06	88.57	90.63	91.18	93.10	96.88	84.38;	% 08-11, 23
%         '08-13-09'	93.38	89.66	96.43	96.00	93.10	86.21	100.00	92.86;	% 08-13, 24
%         '08-14-09'	91.11	97.30	88.24	86.11	100.00	94.74	100.00	72.22;	% 08-14, 25
        %20
        '08-17-09'	82.08	85.00	63.64	88.64	79.17	93.75	84.00	94.74;	% 08-17, 26
        '08-18-09'	81.48	88.57	65.52	86.36	82.35	94.44	82.61	90.48;	% 08-18, 27
        '08-19-09'	86.90	96.67	66.67	93.33	93.75	100.00	94.12	92.31;	% 08-19, 28
        '08-20-09'	89.62	93.33	86.36	87.18	100.00	88.00	85.71	88.89;	% 08-20, 29
        '08-21-09'	89.89	100.00	94.44	79.49	100.00	100.00	90.00	68.42;	% 08-21, 30
        '08-24-09'	92.81	96.72	87.50	91.67	96.77	96.67	93.33	90.00;	% 08-24, 31
        '08-25-09'	91.51	97.50	86.96	88.37	100.00	95.24	90.48	86.36;	% 08-25, 32
        '08-26-09'	88.32	96.08	87.50	81.48	96.00	96.15	82.14	80.77;	% 08-26, 33
        '08-27-09'	93.81	100.00	100.00	85.71	100.00	100.00	88.00	83.33;	% 08-27, 34
        '08-28-09'	81.82	94.00	84.38	68.00	92.31	95.83	60.87	74.07;	% 08-28, 35
        %30
        '09-01-09'	96.15	96.23	100.00	94.23	100.00	92.86	96.15	92.31;	% 09-01, 36
%         '09-08-09'	83.33	97.56	100.00	63.83	100.00	95.45	63.64	64.00;  % 09-08,
        '09-09-09'	90.18	100.00	85.19	80.85	100.00	100.00	81.82	86.96;	% 09-09, 37
%         '09-10-09'	94.44	87.80	94.44	82.05	78.26	100.00	76.19	88.89;	% 09-10, 38
%         '09-21-09'	80.77	77.50	75.00	87.50	72.22	81.82	81.82	94.44;	% 09-21, 39
%         '09-22-09'	82.24	82.93	73.08	87.50	73.68	90.91	86.96	88.24;	% 09-22, 40
%         '09-23-09'	81.70	89.29	80.65	75.76	88.00	90.32	81.82	69.70;	% 09-23, 41
%         '09-24-09'	78.65	83.33	70.00	74.29	73.68	94.12	65.00	86.67;	% 09-24, 42
        };
     channel = {'2';'3';'12';'13'};
 save([rat '-dateW.mat'],'dateW');   


direct = 'E:\bcheng\work\data1\w\interval\';
dataLenSec = 4;


rawDataName = ['rawData_' mode rat '.mat'];
         
s = size(dateW);

date = dateW(:,1);

% read all the data into sD
td_h = 1;

      [cTrL cTrR sD] = cs_nsp_data_struct(direct,  rat, date, channel, 0, dataLenSec, td_h);% from 0s to 2s,binsize is 5ms

save(rawDataName, 'cTrL', 'cTrR', 'sD');





