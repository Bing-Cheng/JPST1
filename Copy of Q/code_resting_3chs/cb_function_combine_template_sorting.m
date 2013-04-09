%% combine sorted spikes as from neurons
% clear; close all; clc;
% 
% date = '11-02-10';
% ch = '16';
% ids = [1 2 4];

function re = cb_function_combine_template_sorting(date,ch,ids)
dir = ['G:\Q10_data\spikes\restingData\'];
fin = ['ESig_Q5L-' date '-Resting_channel'];
ext = 'L_5_templatesort.mat';
% ESig_Q5L-12-02-10-Resting_channel1L_5_templatesort
cb_fName = [dir fin ch ext];
load(cb_fName)

idx_sorted = zeros(size(idx));

if ids(1)>1
   no = find(idx==1);
   idx_sorted(no) = 10;
end

for i=1:length(ids)
    no = find(idx==ids(i));
    idx_sorted(no) = 1; % '1' means selected spikes
end

rate = length(find(idx_sorted==1)) / (index(end)/24414);

index_sorted = index;

save( [fin ch '_correcttrials_sorted.mat'], 'idx_sorted', 'index_sorted', 'rate');
re = 1;



