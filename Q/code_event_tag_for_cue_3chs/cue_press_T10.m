%generate cue-press events
clear; close all; clc;
%% document needed: event(RePr, RiPr, LePr, RewE), waveform, sorted spikes
mon = '12';
day = '02';
year = '10';
sec = 'A';
channel = {'1','9','10','14'};
% channel = {'2','4','6','8','15'};
% channel = {'2','4','6','8'};
% channel = {'2','8','15'};
% channel = {'6','8'};
evet_dir= 'G:\Q10_data\channel_data\Q10_1209\Q5L-';
correcttrials_dir= 'G:\Q10_data\channel_data\Q10_1209\sorted\ESig_Q5L-';
for ch_num=1:length(channel)
    ch = channel{ch_num}
test1 = strcat(evet_dir, mon, '-', day, '-',year,'-A-LePr.mat');
test2 = strcat(evet_dir, mon, '-', day, '-',year,'-A-RePr.mat');
test3 = strcat(evet_dir, mon, '-', day, '-',year,'-A-RiPr.mat');
test4 = strcat(evet_dir, mon, '-', day, '-',year,'-A-Qdir.mat');
test5 = strcat(evet_dir, mon, '-', day, '-',year,'-A-RewE.mat');
load(strcat(correcttrials_dir, mon, '-', day, '-',year,'-', sec, '_channel',ch,'_correcttrials.mat'));
test_ch = strcat('C:\bing\code\ESig_Q5L-', mon, '-', day, '-',year,'-',sec,'_channel',ch,'_correcttrials_sorted.mat');
load(test_ch);
index = index_sorted(idx_sorted==1);

LePr = load(test1);
RePr = load(test2);
RiPr = load(test3);
Qdir = load(test4);
RewE = load(test5);

LePr = LePr.LePr;
RePr = RePr.RePr;
RiPr = RiPr.RiPr;
Qdir = Qdir.Qdir;
RewE = RewE.RewE;

test6 = strcat(evet_dir, mon, day, year,'-5Light.mat');
load(test6)

event = cell(length(RePr),4);
RiPr = [RiPr, ones(size(RiPr,1),1)];
   LePr = [LePr, zeros(size(LePr,1),1)-ones(size(LePr,1),1)];
   Press = [RiPr', LePr']';
   Press = sortrows(Press);
    
for i = 1:length(Qdir)
    event(i,1)={num2str(Qdir(i,1))};
    event(i,2)={num2str(ExpData.cues(i))};
    event(i,3)={num2str(Press((Press(:,2)==i),3))};
            
end

for i = 1:length(RewE)
    event(RewE(i,2),4)={'Y'};%{num2str(RewE(i,2))}
end


n = 1;
righttrial = 0;
spike_1 = [];
counter = 0;
index = sort(index);
count = 0;
spike_1_class1=[];
%%pick up cue light RIGHT, press RIGHT
for i=1:length(Qdir)
if event{i,4}=='Y' %choose those are right
    righttrial = righttrial+1;
    if str2num(event{i,2})>0
        %counter = counter + 1;
        a = str2num(event{i,3});
        if a(1)==1 & ~isempty(find(RePr(:,2)==i))
            counter = counter+1;
            i;
           timetrain = find(index((index<TrialStart(righttrial)+floor(24414.1*5)))>TrialStart(righttrial)+24414);
           spike_1 = [spike_1';[-0.1 index(timetrain)-TrialStart(righttrial)-24414]']';
        end
        
    end
end
end
dst = strcat('Q5L-', mon, '-', day, '-',year,'-channel',num2str(ch),'-sorted-event-rightcue-rightpress-template.mat');

save(dst,'spike_1','counter')
        
righttrial = 0;
spike_1 = [];
counter = 0;
index = sort(index);
count = 0;

for i=1:length(Qdir)
if event{i,4}=='Y' %choose those are right
    righttrial = righttrial+1;
    if str2num(event{i,2})<0  % all the left trials: L & LL
%    if str2num(event{i,2})==-1
        a = str2num(event{i,3});
        if a(1)==-1 & ~isempty(find(RePr(:,2)==i))
            counter = counter+1;
            i;
           timetrain = find(index((index<TrialStart(righttrial)+floor(24414.1*5)))>TrialStart(righttrial)+24414);
           spike_1 = [spike_1';[-0.1 index(timetrain)-TrialStart(righttrial)-24414]']';
        end
        
    end
end
end

dst2 = strcat('Q5L-', mon, '-', day, '-',year,'-channel',num2str(ch),'-sorted-event-leftcue-leftpress-template.mat');
save(dst2,'spike_1','counter')


% spike_1 = [];
% counter = 0;
% index = sort(index);
% Rewardspike =[];
% for i=1:righttrial-1%length(Qdir)
% 
% counter = counter+1;
% i;
%     count=count+1;
% Rewardspike = find(index((index<TrialStart(i+1)))>TrialStart(i+1)-floor(24414.1*2));
% spike_1 = [spike_1';[-0.1 index(Rewardspike)-TrialStart(i+1)]']';
% if event{i,4}=='Y'
% eventmarker{i} = {'R',event{i,2}};
% else
% eventmarker{i} = {'W',event{i,2}};
% end
% end
% 
% %count
% 
% dst3 = strcat('D:\data\T10_5L\SpikeTrain\Reward\T5L-', mon, '-', day, '-',year,'-channel',num2str(ch),'-sorted-reward-template.mat');
% save(dst3,'spike_1','counter')


end%channel
clear
clc
disp('done')