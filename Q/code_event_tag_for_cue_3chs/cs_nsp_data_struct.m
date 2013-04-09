function [cTrL cTrR sD] = cs_nsp_data_struct(direct, rat, date, channel, ts, te, binsize)
% NSP_DATA_STRUCT Create a data struct.
%
% Input arguments
%   dirct:      (string) directory of the .mat files
%   rat:        (string) the name of the rat
%   date:       (cell of string) each row contains a date, num_date x 1
%   channel:    (cell of string) num_channel x 1
%   ts:         (double) starting time (s) of each trail
%   te:         (double) ending time (s) of each trail
%   binsize:    (double) time period (ms) for one bin
%
% Output arguments
%   sD:         (cell of struct) each cell contain the information for
%                                one date, num_date x num_channel
%
%%%%%%%%%%%%%%%% Detailed Description %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% One data struct for each date.
%
% Field           Type             Size / Typical value
% -------------------------------------------------------------------------
%   .left         (matrix)         num_trail x num_bin
%   .right        (matrix)         num_trail x num_bin
%   .rat          (string)         'W5L', W 5 lights
%   .date         (string)         '07_30_09'
%   .channel      (string)         '13'
%
% Example:
%   direct = 'D:\NeuralSignalTrails\';
%   rat = 'W5L';
%   date = {'07-01-09'; '07-06-09'; '07-07-09'; '07-09-09';
%           '07-10-09'; '07-14-09'; '07-17-09'; '07-21-09';
%           '07-22-09'; '07-23-09'; '07-24-09'; '07-30-09'};
%   channel = {'13'};
%   % read all the data into sD
%   sD = nsp_data_struct(direct, rat, date, channel, 0, 2, 80);
%
%
% Copyright (c) 2009 by Neural Signal Processing Group.
% Arizona State University
%
% Version 1.0alpha hongwei 102809
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sD = cell(length(date), length(channel));
cTrL = cell(length(date), length(channel));
cTrR = cell(length(date), length(channel));


for channel_ind = 1:length(channel)
    for date_ind = 1:length(date)
        % read trails -  left cue, left press
        fnamel = [direct rat '-' date{date_ind} ...
                  '-channel' channel{channel_ind} ...
                  '-sorted-event-whole-template.mat'];
        [cTrL1 Tl] = cs_nsp_read_trail(fnamel, ts, te, binsize);
        
        % read trails - right cue, right press
%         fnamer = [direct rat '-' date{date_ind} ...
%                   '-channel' channel{channel_ind} ...
%                   '-sorted-event-rightcue-rightpress-template.mat'];
%         [cTrR1 Tr] = cs_nsp_read_trail(fnamer, ts, te, binsize);
        
         cTrR1 =0;
             Tr= 0;
        % form the struct
        sT = struct('left', Tl,...
                    'right', Tr,...
                    'rat', rat,...
                    'date', date{date_ind},...
                    'channel', channel{channel_ind});
        sD(date_ind, channel_ind) = {sT};
         cTrL(date_ind, channel_ind) = {cTrL1};
         cTrR(date_ind, channel_ind) = {cTrR1};

    end
end
