close all;
clear;
rat = 'A5L';
comp = 'norm';
%comp = 'jsig';
windowLen =1800;
chPairArray = [1 2;1 3;1 4;2 3;2 4;3 4];

modeCell = {'cueAlign', 'ActPress','interval'};
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
   
for mi = 3: 3
    mode = modeCell{mi};
 

corrName =[rat mode num2str(windowLen) 'bar_2']
load(corrName);

     
end
corrMagN_compare = corrMagN/100000;
  h = figure;

    bar(corrMagN_compare','group');
cm2 = [0.4 0.6 0.4; 0.4 0.4 0.6];
colormap(cm2);
set(gca,'XTick',1:6);
set(gca,'XTickLabel',{'2-3','2-12','2-13','3-12','3-13','12-13'});
legend('learning', 'learned','location','north');
xlabel('neuron pairs');
ylabel('correlation strength');
v= axis;
v(4) = 4;
%axis(v);
    titleName = [rat '-' num2str(windowLen)  '-Correlation Strength comparision for interval'];
%    title(titleName);
    saveas(h, titleName,'jpg');