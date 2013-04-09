clear;
close all;

rat = 'L5L';
load([rat '-dateW']);
dateN= size(dateW,1);
corrMagN = zeros(3,6);
corrMagN0 = zeros(3,6);
core = ones(50)/2500;

sectionCell = {'-apr', '-pos', '-ful'};
scoop = [-5 5];
windowLen = 1800;
chPairArray = [1 3;1 4;3 4];
modeCell = {'cueAlign', 'ActPress'};
dirCell = {'L', 'R'};
activationTotal = [];
for mi = 1: 1
    mode = modeCell{mi};
    for di= 1:1
        dir = dirCell{di};
for s = 1:2
section = sectionCell{s};  
%activation = [];
close all;
for i = 1:3
chPair = chPairArray(i,:);
preName = [rat mode num2str(windowLen) dir num2str(chPair(1)) num2str(chPair(2)) '-' section];
gdfName = [preName '.mat']

load(gdfName);

trials = size(xData,2);	% number of trials

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
     corrN = 0;
  for scoopi =  scoop(1) : scoop(2)
      corrN = corrN + sum(diag(matrix1,scoopi));
  end
      corrMagN(s,i) = corrN;
      corrMagN0(s,i) =sum(diag(matrix1,0));
      xcorrHist = cb_xcorrHist(matrix1);
      scoopHist = cb_scoopHist(matrix1, scoop);  
% %  corrMag(s,i) = sum(scoopHist); 
% UL = sum(xcorrHist([995:999],2));
% BR = sum(xcorrHist([1001:1005],2));
% activation = [activation; (UL - BR)];
      Version = ['Nor-' preName ];
%      figure
%      plot(scoopHist);
%  %   cbJPSTH_show(Version, matrix, xHist, yHist, xcorrHist, scoopHist,1);
% %save(Version, 'matrix', 'xHist', 'yHist', 'xcorrHist', 'scoopHist');
% matVec = reshape(matrix,1,4000000);
% matSort = sort(matVec);
% th = matSort(3999600);
% tl = matSort(400);
% matrix(find(matrix>th))=th;
% matrix(find(matrix<tl))=tl;

%  h=figure
%  imagesc(matrix,[0 0.2]);
%  axis xy;
%  colorbar;
%   saveas(h,Version,'jpg');
  
%    matrix1 = conv2(matrix,core,'same');
     cbJPSTH_show(Version, matrix1, xHist, yHist, xcorrHist, scoopHist,1);
%  vec2 = reshape(matrix1, windowLen^2,1);
%  mean1 = mean(vec2);
%  variance1 = var(vec2);
%  disRange = [mean1+1.5*variance1,max(vec2)];
%   h=figure
%   imagesc(matrix1,disRange);
%   axis xy;
%   colorbar;
%   title(Version);
%    saveas(h,Version,'jpg');
%  
%  
%  
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%surprise
%  matrix = sigSurprise(matrix0,xHist0,yHist0,trials);
% matrix(find(matrix>=4.605)) = 4.605;
% matrix(find(matrix<=-2.996)) = -2.996;
%  %xcorrHist = cb_xcorrHist(matrix);
%   %  scoopHist = cb_scoopHist(matrix, scoop);
%   corrN = 0;
%   for scoopi =  scoop(1) : scoop(2)
%       corrN = corrN + sum(diag(matrix,scoopi));
%   end
%       corrMagS(s,i) = corrN;
%       corrMagS0(s,i) =sum(diag(matrix,0));
  %  Version = ['Sig-' preName ];
 %   cbJPSTH_show(Version, matrix, xHist, yHist, xcorrHist, scoopHist,1);
%save(Version, 'matrix', 'xHist', 'yHist', 'xcorrHist', 'scoopHist');
% h=figure
% imagesc(matrix);
% axis xy;
% colorbar;
%  saveas(h,Version,'jpg');
%  close all;
end%chPair
%activationTotal = [activationTotal activation];
end%section
corrName =[rat mode num2str(windowLen) dir 'bar_2'];
save(corrName, 'corrMagN', 'corrMagN0');
    end%dir
end%mode
% activationName =[rat num2str(windowLen) 'activation'];
% save(activationName, 'activationTotal');