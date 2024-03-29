close all;
clear;
rat = 'W5L';
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
   x1 = [0 23.5 23.5 0];
   x2 = [23.5 length(rateT) length(rateT) 23.5];
   
   yy = [0 0 100 100];   
   fill(x1,yy,[1 1 1]);
   fill(x2,yy,[0.9 0.9 0.9]);
   lWidth = 3;
   plot(rateTM,'r','linewidth',lWidth);
%   plot(rateLM,'g','linewidth',lWidth);
 %  plot(rateRM,'b','linewidth',lWidth);
   legend('learning', 'learned', 'total', 'left', 'right','Location', 'SouthEast');
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

corrMagN_avgLR = sum(corrMagN_avgP,3)/200000;
 mode = modeCell{3};
corrName =['..\incorrectInterval_W\' rat mode num2str(windowLen) 'bar_2']
load(corrName);
corrMagN_interval = corrMagN/100000;
Z1 = zeros(2,12);
Z1(:,2:2:12) = corrMagN_interval;
Z1(:,1:2:11) = corrMagN_avgLR;
Z2 = flipud(Z1);
Z= Z2';
ZW=Z;
  h = figure;

[r,c] = size(Z);            %# Size of Z 
Y = [1 2 5 6 9 10 13 14 17 18 21 22];  %# The positions of bars along the y axis 
C = mat2cell(kron(Z,ones(6,4)),6*r,4.*ones(1,c)).';  %'# Color data for Z 
 
hBar = bar3(Y,Z);           %# Create the bar graph 
set(hBar,{'CData'},C);      %# Add the color data 
set(gca,'YTickLabel',{'AC' 'BT'},'FontSize',8);  %# Modify the y axis tick labels 
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
text(-x2,1,'2-3');         %# Add "grid1" text 
text(-x2,5,'2-12');         %# Add "grid2" text 
text(-x2,9,'2-13');        %# Add "grid3" text
text(-x2,13,'3-12');         %# Add "grid1" text 
text(-x2,17,'3-13');         %# Add "grid2" text 
text(-x2,21,'12-13');        %# Add "grid3" text
text(-x2,-3.2,'neuron','FontSize',14);        %# Add "grid3" text
text(-x2-0.9,-2.1,'pairs','FontSize',14); 
    titleName = ['W09-Synchrony Strength Comparision'];
 %   title(titleName,'FontSize',16);
    saveas(h, titleName,'jpg');
    
    
%    [p,tbl,stats] = anova2(Z,6);
    
%     [hBT,pBT] = ttest(corrMagN_interval(1,:),corrMagN_interval(2,:))
%     [hAC,pAC] = ttest(corrMagN_avgLR(1,:),corrMagN_avgLR(2,:))
%     [hLG,pLG] = ttest(corrMagN_interval(1,:),corrMagN_avgLR(1,:))
%     [hLD,pLD] = ttest(corrMagN_interval(2,:),corrMagN_avgLR(2,:))
    
    save('W09_Z','ZW');
    ZZ = ZW;
    load('..\A2\A09_Z.mat');
    ZZ=[ZZ;ZA];
    load('..\L2\L10_Z.mat');
    ZZ=[ZZ;ZL];
    load('..\B2\B10_Z.mat');
    ZZ=[ZZ;ZB];
    hLen = size(ZZ,1);
    AC_LD = ZZ(1:2:hLen,1);
    AC_LG = ZZ(1:2:hLen,2);
    BT_LD = ZZ(2:2:hLen,1);
    BT_LG = ZZ(2:2:hLen,2);
    [hLG,pLG,ci,stats] = ttest(AC_LG,BT_LG)
    [hLD,pLD,ci,stats] = ttest(AC_LD,BT_LD)
    [hAC,pAC,ci,stats] = ttest(AC_LD,AC_LG)
    [hBT,pBT,ci,stats] = ttest(BT_LD,BT_LG)
    
    
    
    aX =[BT_LD,BT_LG,AC_LD,AC_LG];
    [p,table,stats] = anova1(aX);
    
    h = figure;
    boxplot([AC_LD,AC_LG,BT_LD,BT_LG],{'AC_LD' 'AC_LG' 'BT_LD' 'BT_LG'});
    titleName = ['Synchrony Strength Statistics'];
xlabel('date window - learning stage','FontSize',14);
    ylabel('Coincidence Mesurement','FontSize',14);
    %title(titleName);%,'FontSize',16);
    saveas(h, titleName,'jpg');
   
    
    h = figure;
    hold on;
    plot(AC_LG, 'b*');
    plot(AC_LD, 'ro');
  plot(AC_LG, 'b');
     plot(AC_LD, 'r');
    
    titleName = ['Synchrony Strength Statistics LD vs LG'];
    set(gca,'FontSize',11);
    legend('AC\_LG', 'AC\_LD','location','southeast');
 xlabel('neuron pair - rat','FontSize',14);
    ylabel('Coincidence Mesurement','FontSize',14);
    %title(titleName);%,'FontSize',16);
    saveas(h, titleName,'jpg');
        h = figure;
    hold on;
  plot(AC_LG, 'b*');
  plot(BT_LG, 'ro');
    plot(AC_LG, 'b');
     plot(BT_LG, 'r');
   
    set(gca,'FontSize',11);
    axis([0 25 -0.5 2.5]);
    set(gca, 'YTick', [-0.5 0.0 0.5 1.0 1.5 2.0 2.5]);
    legend('AC\_LG', 'BT\_LG','location','southeast');
    xlabel('neuron pair - rat','FontSize',14);
    ylabel('Coincidence Mesurement','FontSize',14);
    titleName = ['Synchrony Strength Statistics AC vs BT'];
    %title(titleName);%,'FontSize',16);
    saveas(h, titleName,'jpg');
    