%% combine sorted spikes as from neurons
clear; close all; clc;

date = '11-02-10';
ch = '16';
ids = [1 2 4];
dir = ['.\spikes\'];
fin = ['ESig_O5L-' date '-A_channel'];
ext = '_correcttrialsL_5_templatesort.mat';

load([dir fin ch ext])

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




