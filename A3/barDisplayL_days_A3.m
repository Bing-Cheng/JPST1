close all;
clear;
rat = 'A5L';
comp = 'norm';
%comp = 'jsig';
windowLen =2000;
chPairArray = [1 2;1 3;1 4;2 3;2 4;3 4];

modeCell = {'cueAlign', 'ActPress'};
dirCell = {'L', 'R'};

load([rat '-dateW.mat']);
rateT = dateW(:,2);
rateL = dateW(:,3);
rateR = dateW(:,5);

for j =1 :length(rateT)
%rateTD(j) = rateT{j} - rateT{j-1};
rateTM(j) = rateT{j}; 
rateRM(j) = rateR{j}; 
rateLM(j) = rateL{j}; 
end
h = figure;
hold on;
   x1 = [0 9.5 9.5 0];
   x2 = [9.5 15.5 15.5 9.5];
   x3 = [15.5 18 18 15.5];
   yy = [0 0 100 100];
   fill(x1,yy,[0.4 0.6 0.4]);
   fill(x2,yy,[0.4 0.4 0.6]);
   fill(x3,yy,[0.6 0.4 0.6]);
   lWidth = 3;
   plot(rateTM,'r','linewidth',lWidth);
   plot(rateLM,'g','linewidth',lWidth);
   plot(rateRM,'b','linewidth',lWidth);
   legend('left learning', 'steady', 'right learning', 'total', 'left', 'right','Location', 'NorthWest');

   titleName = [rat 'behavior correction rate'];
   title(titleName);
   saveas(h,titleName,'jpg');



for mi = 1: 1
    mode = modeCell{mi};
    for di= 1:2
        dir = dirCell{di};

corrName =[rat mode num2str(windowLen) dir 'bar']
load([rat dir 'trialNo.mat']);
load(corrName);

h = figure;
hold on;
   bar(trialNo);
   titleName = [rat 'behavior trial number' dir];
   title(titleName);
   saveas(h,titleName,'jpg');
%    plot(rateLM*100,'g');
%    plot(rateRM*100,'b');
   
   
   for pi = 1 : 6
       h = figure;
hold on;
   bar(corrMagN(:,pi)/10,'r');

   %plot(corrMagN0(:,pi),'g');
   titleName = [rat '-' num2str(chPairArray(pi,1)) num2str(chPairArray(pi,2)) '-' dir];
   title(titleName);
   saveas(h, titleName,'jpg');
   end
   
%    plot(rateTD*1000,'g');
%    plot(trialNo,'b');

%saveas(h, [rat '-' comp dir],'jpg');
    end
end