clear; 
close all; 
clc;

mode = 'cueAlign';
rat = 'L5L';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dateW = {
%         '06-22-10'	0.12195122	0.064516129	0.727272727 0           0.058823529	0.071428571	0           0;              % 06-22, 2          1
%         '06-23-10'	0.1875      0.025       0.214285714 0.423076923	0           0.047619048	0.454545455	0.4;            % 06-23, 4          2
        '06-24-10'	0.228571429	0.113207547	0.588235294 0.228571429	0.153846154	0.074074074	0.086956522	0.5;            % 06-24, 5          3
%         '06-25-10'	0.310077519	0.293103448	0.1         0.487804878	0.266666667	0.321428571	0.421052632	0.545454545;	% 06-25, 6          4
        '06-28-10'	0.345070423	0.254237288	0.5         0.358490566	0.233333333	0.275862069	0.36        0.357142857;	% 06-28, 7          5
        '06-29-10'	0.220930233	0.094594595	0.514285714	0.206349206	0.085714286	0.102564103	0.266666667	0.151515152;	% 06-29, 8          6
        '06-30-10'	0.3125      0.121495327	0.657894737	0.389473684	0.090909091	0.153846154	0.4375      0.340425532;    % 06-30, 9          7
        '07-01-10'	0.540178571	0.674418605	0.475       0.448979592	0.710526316	0.645833333	0.604651163	0.327272727;	% 07-01, 10         8
        '07-02-10'	0.567460317	0.898734177	0.609756098	0.356060606	0.888888889	0.906976744	0.464285714	0.276315789;	% 07-02, 11         9
        '07-06-10'	0.553633218	0.752688172	0.901960784	0.303448276	0.666666667	0.857142857	0.329113924	0.272727273;	% 07-06, 12         10
        '07-07-10'	0.58041958	0.8         0.916666667	0.337837838	0.863636364	0.739130435	0.260869565	0.405063291;	% 07-07, 13         11
        '07-08-10'	0.559183673	0.568421053	0.808510638	0.436893204	0.509433962	0.642857143	0.375       0.510638298;	% 07-08, 14         12
        '07-09-10'	0.721774194	0.862745098	0.765957447	0.555555556	0.882352941	0.843137255	0.470588235	0.645833333;	% 07-09, 15         13
        %10
        '07-12-10'	0.635820896	0.752136752	0.738461538	0.503267974	0.769230769	0.738461538	0.540540541	0.46835443;     % 07-12, 16         14
 %       '07-13-10'	0.783673469	0.847826087	0.857142857	0.692307692	0.869565217	0.826086957	0.642857143	0.75;           % 07-13, 17         15
%         '07-14-10'	0.744       0.769230769	0.911111111	0.643564356	0.711864407	0.844444444	0.625       0.666666667;	% 07-14, 18         16
        '07-15-10'	0.7625      0.833333333	0.895833333	0.625       0.9         0.760869565	0.66        0.586956522;	% 07-15, 19         17
%         '07-16-10'	0.764227642	0.976470588	0.974358974	0.549180328	0.977272727	0.975609756	0.5         0.6;            % 07-16, 21         18
         '07-19-10'	0.741758242	0.861538462	0.944444444	0.555555556	0.925925926	0.815789474	0.43902439	0.675;          % 07-19, 21         18
        '07-20-10'	0.635714286	0.535714286	0.92        0.610169492	0.666666667	0.4375      0.558823529	0.68;           % 07-20, 21         18
        '07-21-10'	0.729591837	0.916666667	0.837209302	0.50617284	0.942857143	0.891891892	0.431818182	0.594594595;	% 07-21, 21         18
%        '07-22-10'	0.794979079	0.888888889	0.952380952	0.654205607	0.931818182	0.847826087	0.589285714	0.725490196;	% 07-22, 21         18
%cb trialno is 73 in ch7, but 74 in ch13        '07-23-10'	0.800904977	0.902439024	0.906976744	0.666666667	0.974358974	0.837209302	0.66        0.673913043;	% 07-23, 21         18
%        '07-26-10'  0.764705882	0.794871795	1           0.670103093	0.833333333	0.75        0.66        0.680851064;
        '07-27-10'  0.855072464	0.86746988	0.970588235	0.8         0.906976744	0.825       0.711111111	0.888888889;
        '07-28-10'  0.801886792	0.759036145	0.860465116	0.813953488	0.760869565	0.756756757	0.818181818	0.80952381;
        '07-29-10'  0.803921569	0.844155844	0.844444444	0.743902439	0.894736842	0.794871795	0.658536585	0.829268293;
%         '07-30-10'  0.87        0.888888889	0.947368421	0.814814815	0.875       0.902439024	0.804878049	0.825;
%         '08-02-10'  0.764367816	0.791666667	0.818181818	0.710144928	0.8         0.783783784	0.710526316	0.709677419;
%         '08-03-10'  0.833333333	0.935064935	0.947368421	0.696629213	0.904761905	0.971428571	0.652173913	0.744186047;
        '08-04-10'  0.719387755	0.826666667	0.962962963	0.563829787	0.833333333	0.818181818	0.586956522	0.541666667;
        '08-05-10'  0.663043478	0.726027397	0.882352941	0.506493506	0.794117647	0.666666667	0.529411765	0.488372093;
        %20
        '08-06-10'  0.532258065	0.787878788	0.961538462	0.234042553	0.852941176	0.71875     0.348837209 0.137254902;
        '08-09-10'  0.765182186	0.924731183	0.972972973	0.572649573	0.977777778	0.875       0.636363636	0.516129032;
        '08-10-10'  0.513227513	0.6         0.740740741	0.353658537	0.558139535	0.648648649	0.4         0.30952381;
%         '08-11-10'  0.843478261	0.904761905	1           0.740740741	0.891304348	0.921052632	0.705882353	0.771929825;
        '08-12-10'  0.711267606	0.785714286	0.782608696	0.619047619	0.806451613	0.76        0.678571429	0.571428571;
%        '08-13-10'  0.62962963	0.779661017	0.838709677	0.416666667	0.892857143	0.677419355	0.551724138	0.325581395;
        };
 
 channel = {'7'; '9'; '13'; '16'};

        direct = 'E:\bcheng\work\data1\L\merge\';
 save([rat '-dateW.mat'],'dateW');   


dataLenSec = 4;


rawDataName = ['rawData_' mode rat '.mat'];
         
s = size(dateW);

date = dateW(:,1);

% read all the data into sD
td_h = 1;

      [cTrL cTrR sD] = cs_nsp_data_struct(direct,  rat, date, channel, 0, dataLenSec, td_h);% from 0s to 2s,binsize is 5ms

save(rawDataName, 'cTrL', 'cTrR', 'sD');





