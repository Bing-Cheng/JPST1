function [cTr D] = cs_nsp_read_trail(fname, ts, te, binsize)
% NSP_DATA_STRUCT Create a data struct.
%
% Input arguments
%   fname:      (string) full path and name of the .mat files
%   ts:         (double) starting time (s) of each trail
%   te:         (double) ending time (s) of each trail
%   binsize:    (double) time period (ms) for one bin
%
% Output arguments
%   D:          (matrix) num_bin x num_trail
%
%
% Copyright (c) 2009 by Neural Signal Processing Group.
% Arizona State University
%
% Version 1.0alpha hongwei 102809
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fs = 24414.06;      % sampling rate
if ts < 0
    ts = 0;         % starting time should be positive
    disp('The start of the trail has been changed to 0s.');
end
if te > 4
    te = 4;         % each trail is at most 4 seconds long
    disp('The end of the trail has been changed to 4s.');
end

num_bin = floor( 1000*(te-ts)/binsize );
if num_bin <=0
    error('??? invalid ts and te');
end

% load data

T = load(fname);
if size(T.spike_1,1) < size(T.spike_1,2)
    T.spike_1 = T.spike_1';
end
t = [(T.spike_1/fs - ts)*1000; -5000];   % time instants (ms)

% read the data and form the bin histogram
D = [];
D_n = zeros(num_bin, 1);
% trail_ind = 1;
% t_p = -5*1000;
i = 1;
j=0;
while i < length(t)
    is = i;     % i_start, the start of a trail
    while t(i)<t(i+1) && i<length(t)
        i = i+1;
    end
    ie = i;     % i_end, the end of a trail
    i = i+1;
    
    trail = t(is:ie)/binsize;
    j=j+1;%j is the trial index
    cTr{j} =t(is:ie); 
    for k = 1:num_bin
        tmp = find(trail>=k-1 & trail<k);
        D_n(k, 1) = length(tmp);
    end
    D = [D D_n];
    D_n = zeros(num_bin, 1);
    
%     t_n = t(i);
%     bin_ind = floor(t_n/binsize)+1;
%     
%     if bin_ind < 1  % t_n < ts
%         while bin_ind<1 && i <length(t)
%             i = i+1;
%             t_n = t(i);     % read the next spike instant
%             bin_ind = floor(t_n/binsize)+1;
%         end
%         if i == length(t)
%             i = i+1;
%         end
%     elseif bin_ind > num_bin  % t_n > te
%         D = [D D_n];
%         D_n = zeros(num_bin, 1);
%         while bin_ind>num_bin && i <length(t)
%             i = i+1;
%             t_n = t(i);
%             bin_ind = floor(t_n/binsize)+1;
%         end
%         if i == length(t)
%             i = i+1;
%         end
%     else
%         D_n(bin_ind) = D_n(bin_ind) + 1;
%         i = i+1;      
%     end
end
if size(D,2)~= T.counter
    fname
    T.counter
    size(D,2)
end
    
