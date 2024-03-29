clear;
close all;
shuffle = 0;
shuffleNumber = 1;

rat = 'W5L';
load([rat '-dateW']);
dateN= size(dateW,1);

corrMagN = zeros(shuffleNumber,6);

core = ones(50)/2500;

sectionCell = {'-apr', '-pos', '-ful'};
scoop = [-5 5];
windowLen = 1800;
scoopM = zeros(6,windowLen);
chPairArray = [1 2;1 3;1 4;2 3;2 4;3 4];
modeCell = {'cueAlign', 'ActPress'};
dirCell = {'L', 'R'};
activationTotal = [];
for mi = 1: 1
    mode = modeCell{mi};
for di= 1:1
        dir = dirCell{di};
for s = 2:2
section = sectionCell{s};  
%activation = [];
close all;
for i = 1:6
chPair = chPairArray(i,:);
preName = [rat mode num2str(windowLen) dir num2str(chPair(1)) num2str(chPair(2)) '-' section];
gdfName = [preName '.mat']

load(gdfName);

trials = size(xData,2);	% number of trials
for shuf = 1 : shuffleNumber
if shuffle
    sIdx = randperm(trials);
    xData = xData(:,sIdx);
    Version = ['Shuffle-' preName ];
else
    Version = ['Nor-' preName ];
end
   xHist0 = sum(xData,2)';   	% build xHisto
   xSqrd = sum(xData.*xData,2)';   % for 'Normalized' proc only
    yHist0 = sum(yData,2)';   	% build xHisto
   ySqrd = sum(yData.*yData,2)'; 
   matrix0 =yData*xData';

%%%%%%%%%%%%%%%%%%%%%%cb  normalize by trials
  xHist  =  xHist0/trials;		% normalize by trials
  yHist  =  yHist0/trials;		% normalize by trials
  xSqrd  =  xSqrd/trials;
  ySqrd  =  ySqrd/trials;
  matrix = matrix0/trials;
%   
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%cb predicted 
matrix_predic = yHist'*xHist;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%cb correct 
matrix = matrix - matrix_predic;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%cb  normalized: corrected/sd
   vnc = (ySqrd - yHist.*yHist)'*(xSqrd - xHist.*xHist); % variances
   vnc(find(~vnc)) = mean(mean(vnc)); %to avoid dividing 0/
   sd = sqrt(vnc);
   matrix = matrix./sd;	% normalized: corrected/sd
    matrix1 = matrix;%conv2(matrix,core,'same')*1000;
    corrN = 0;
  for scoopi =  scoop(1) : scoop(2)
      corrN = corrN + sum(diag(matrix1,scoopi));
  end
  shuf
      corrMagN(shuf,i) = corrN;
      scoopHist = cb_scoopHist(matrix1, scoop);  
      scoopM(i,:) = scoopHist;
end%shuffle
end%chPair
%activationTotal = [activationTotal activation];
end%section
if shuffle
   corrName =[rat mode section num2str(windowLen) 'shuffle' num2str(shuf)];
else
    corrName =[rat mode section num2str(windowLen) 'bar_2'];
end
save(corrName, 'corrMagN','scoopM');
end%dir
end%mode
% activationName =[rat num2str(windowLen) 'activation'];
% save(activationName, 'activationTotal');
