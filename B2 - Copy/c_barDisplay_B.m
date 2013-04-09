close all;
clear;
rat = 'B5L';
comp = 'norm';
%comp = 'jsig';
windowLen =1800;
chPairArray = [1 2;1 3;1 4;2 3;2 4;3 4];

modeCell = {'cueAlign', 'ActPress','interval'};
dirCell = {'L', 'R'};
corrMagN_avgP= zeros(2,6,2);

load([rat '-dateW.mat']);

rateT = rateT*100;
h = figure;
hold on;
   x1 = [0 7.5 7.5 0];
   x2 = [7.5 12 12 7.5];
   
   yy = [0 0 100 100];   
   fill(x1,yy,[1 1 1]);
   fill(x2,yy,[0.9 0.9 0.9]);
   lWidth = 3;
   plot([rateT(1:7),rateT(10:14)],'r','linewidth',lWidth);
%   plot(rateLM,'g','linewidth',lWidth);
 %  plot(rateRM,'b','linewidth',lWidth);
   legend('learning', 'learned', 'total','Location', 'SouthEast');
axis([0 12 0 100])
   titleName = [rat 'behavior correction rate'];
   title(titleName);
   saveas(h,titleName,'jpg');
   
for mi = 1: 1
    mode = modeCell{mi};

corrName =[rat mode num2str(windowLen) 'bar_2']
load(corrName);
corrMagN_avgP = corrMagN(1:2,:);
end

corrMagN_avgLR = corrMagN_avgP/200000;
 mode = modeCell{3};
corrName =['..\incorrectInterval_B\' rat mode num2str(windowLen) 'bar_2']
load(corrName);
corrMagN_interval = corrMagN/200000;
Z1 = zeros(2,12);
Z1(:,2:2:12) = corrMagN_interval;
Z1(:,1:2:11) = corrMagN_avgLR;
Z2 = flipud(Z1);
Z= Z2';
ZB=Z;
  h = figure;

[r,c] = size(Z);            %# Size of Z 
Y = [1 2 5 6 9 10 13 14 17 18 21 22];  %# The positions of bars along the y axis 
C = mat2cell(kron(Z,ones(6,4)),6*r,4.*ones(1,c)).';  %'# Color data for Z 
 
hBar = bar3(Y,Z);           %# Create the bar graph 
set(hBar,{'CData'},C);      %# Add the color data 
set(gca,'YTickLabel',{'AC' 'BT'},'FontSize',7);  %# Modify the y axis tick labels 
set(gca,'XTickLabel',{'LD' 'LG'});  %# Modify the y axis tick labels x1:learned; x2:learning
set(gcf, 'Renderer', 'ZBuffer')


view(-70,30);               %# Change the camera view 
%colorbar;                   %# Add the color bar 
ax=gca;
pos=get(gca,'pos');
set(gca,'pos',[pos(1) pos(2) pos(3) pos(4)*0.95]);
pos=get(gca,'pos');
hc=colorbar('location','eastoutside','position',[pos(1)+pos(3)+0.03 pos(2) 0.03 pos(4)]);

% hc=colorbar('location','eastoutside','position',[pos(1) pos(2)+pos(4) pos(3) 0.03]);
% set(hc,'xaxisloc','top');




x2= 2;
%text(-2,-3,'channels');
text(-x2,1,'5-7');         %# Add "grid1" text 
text(-x2,5,'5-11');         %# Add "grid2" text 
text(-x2,9,'5-16');        %# Add "grid3" text
text(-x2,13,'7-11');         %# Add "grid1" text 
text(-x2,17,'7-16');         %# Add "grid2" text 
text(-x2,21,'11-16');        %# Add "grid3" text
text(-x2,-3,'neuron');        %# Add "grid3" text
text(-x2-0.5,-2.5,'pairs'); 
    titleName = ['B10-Synchrony Strength Comparision'];
 %   title(titleName,'FontSize',16);
    saveas(h, titleName,'jpg');
    
    
%    [p,tbl,stats] = anova2(Z,6);
    
%     [hBT,pBT] = ttest(corrMagN_interval(1,:),corrMagN_interval(2,:))
%     [hAC,pAC] = ttest(corrMagN_avgLR(1,:),corrMagN_avgLR(2,:))
%     [hLG,pLG] = ttest(corrMagN_interval(1,:),corrMagN_avgLR(1,:))
%     [hLD,pLD] = ttest(corrMagN_interval(2,:),corrMagN_avgLR(2,:))
    
    save('B10_Z','ZB');
  
   
    