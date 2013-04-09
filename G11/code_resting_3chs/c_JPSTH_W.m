clear;
close all;
shuffle = 0;
rat = 'G5L';
corrMagN = zeros(1,3);

core = ones(50)/2500;
% core2 = conv2(core,core);
% core3 = conv2(core2,core);
% core4 = conv2(core3,core);
% core5 = conv2(core4,core);
% core6 = conv2(core5,core);
% core7 = conv2(core6,core);
% core8 = conv2(core7,core);


scoop = [-5 5];
windowLen = 1800;
scoopM = zeros(3,windowLen);
chPairArray = [1 2;1 3;2 3];

    mode = 'resting';

for i = 1:3
chPair = chPairArray(i,:);
preName = [rat mode num2str(windowLen) num2str(chPair(1)) num2str(chPair(2))];
gdfName = [preName '.mat']

load(gdfName);

trials = size(xData,2);	% number of trials
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
    matrix1 = conv2(matrix,core,'same')*1000;
    matrix = matrix1;
    corrN = 0;
  for scoopi =  scoop(1) : scoop(2)
      corrN = corrN + sum(diag(matrix,scoopi));
  end
      corrMagN(i) = corrN;
      xcorrHist = cb_xcorrHist(matrix);
      scoopHist = cb_scoopHist(matrix, scoop);  
      scoopM(i,:) = scoopHist;
      Version = ['Nor-' preName ];
vec2 = reshape(matrix, size(matrix,1)^2,1);
 mean1 = mean(vec2);
 variance1 = var(vec2);
   toprg =max(vec2)
 toprg = 30.7746;

bottomrg = mean1+1.5*variance1;
 disRange = [bottomrg,toprg];
   cbJPSTH_show(Version, matrix, xHist, yHist, xcorrHist, scoopHist,1,disRange);

end%chPair
if shuffle
   corrName =[rat mode num2str(windowLen) 'shuffle'];
else
    corrName =[rat mode num2str(windowLen) 'bar_2'];
end
save(corrName, 'corrMagN','scoopM');
