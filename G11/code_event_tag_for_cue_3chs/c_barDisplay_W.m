close all;
clear;
rat = 'Q5L';
comp = 'norm';
%comp = 'jsig';
windowLen =1800;
chPairArray = [1 2;1 3;1 4;2 3;2 4;3 4];

modeCell = {'cueAlign', 'ActPress'};
dirCell = {'L', 'R'};
corrMagN_avgP= zeros(2,6,2);

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
%    x1 = [0 23.5 23.5 0];
%    x2 = [23.5 length(rateT) length(rateT) 23.5];
%    
%    yy = [0 0 100 100];
%    fill(x1,yy,[0.4 0.6 0.4]);
%    fill(x2,yy,[0.4 0.4 0.6]);
   lWidth = 3;
   plot(rateTM,'r','linewidth',lWidth);
   plot(rateLM,'g','linewidth',lWidth);
   plot(rateRM,'b','linewidth',lWidth);
   legend('total', 'left', 'right','Location', 'SouthEast');
axis([0 length(rateT) 0 100])
   titleName = [rat 'behavior correction rate'];
   title(titleName);
   saveas(h,titleName,'jpg');
   
for mi = 1: 1
    mode = modeCell{mi};
    for di= 1:2
        dir = dirCell{di};

corrName =[rat mode num2str(windowLen) dir 'bar_2']
load(corrName);
corrMagN_avgP(:,:,di) = corrMagN(1:2,:);

   
%    for pi = 1 : 6
%        h = figure;
% hold on;
%    bar(corrMagN(1:2,pi)/10,'r');
% 
%    %plot(corrMagN0(:,pi),'g');
%    titleName = [rat '-' num2str(chPairArray(pi,1)) num2str(chPairArray(pi,2)) '-' dir '-2'];
%    title(titleName);
%    saveas(h, titleName,'jpg');
%    end
%    
%    plot(rateTD*1000,'g');
%    plot(trialNo,'b');

%saveas(h, [rat '-' comp dir],'jpg');
     end
end
corrMagN_avgLR = sum(corrMagN_avgP,3)/100000;
  h = figure;

    bar(corrMagN_avgLR','group');
cm2 = [0.4 0.6 0.4; 0.4 0.4 0.6];
colormap(cm2);
set(gca,'XTick',1:6);
set(gca,'XTickLabel',{'2-3','2-12','2-13','3-12','3-13','12-13'});
legend('learning', 'learned','location','north');
xlabel('neuron pairs');
ylabel('correlation strength');
v= axis;
v(4) = 4;
axis(v);
    titleName = [rat '-' num2str(windowLen)  '-Correlation Strength comparision'];
%    title(titleName);
    saveas(h, titleName,'jpg');