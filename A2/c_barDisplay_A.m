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
dateN = 15;
h = figure;
hold on;
   x1 = [0 9.5 9.5 0];
   x2 = [9.5 15 15 9.5];
 
   yy = [0 0 100 100];
   fill(x1,yy,[1 1 1]);
   fill(x2,yy,[0.9 0.9 0.9]);

   lWidth = 3;
  % plot(rateTM(1:dateN),'r','linewidth',lWidth);
   plot(rateLM(1:dateN),'g','linewidth',lWidth);
   %plot(rateRM(1:dateN),'b','linewidth',lWidth);
   legend('learning', 'learned', 'left','Location', 'NorthWest');
axis([0 dateN 0 100])
   titleName = [rat 'behavior correction rate'];
   title(titleName);
   saveas(h,titleName,'jpg');
   

    mode = modeCell{1};
  
        dir = dirCell{1};

corrName =[rat mode num2str(windowLen) dir 'bar_2']
load(corrName);

corrMagN_avgLR = corrMagN/100000;
 mode = modeCell{3};
corrName =['..\incorrectInterval_A\' rat mode num2str(windowLen) 'bar_2']
load(corrName);
corrMagN_interval1 = corrMagN/100000;
corrMagN_interval = [corrMagN_interval1(1,:);corrMagN_interval1(2,:)];
Z1 = zeros(2,12);
Z1(:,2:2:12) = corrMagN_interval;
Z1(:,1:2:11) = corrMagN_avgLR;
Z2 = flipud(Z1);
Z= Z2';
ZA = Z;
  h = figure;
Z(find(Z<0))=0;
[r,c] = size(Z);            %# Size of Z 
Y = [1 2 5 6 9 10 13 14 17 18 21 22];  %# The positions of bars along the y axis 
C = mat2cell(kron(Z,ones(6,4)),6*r,4.*ones(1,c)).';  %'# Color data for Z 
 
hBar = bar3(Y,Z);           %# Create the bar graph 
set(hBar,{'CData'},C);      %# Add the color data 
set(gca,'YTickLabel',{'AC' 'BT'},'FontSize',8);  %# Modify the y axis tick labels 
set(gca,'XTickLabel',{'LD' 'LG'});  %# Modify the y axis tick labels 
set(gcf, 'Renderer', 'ZBuffer')

view(-70,30);               %# Change the camera view 
ax=gca;
pos=get(gca,'pos');
set(gca,'pos',[pos(1) pos(2) pos(3) pos(4)*0.95]);
pos=get(gca,'pos');
hc=colorbar('location','eastoutside','position',[pos(1)+pos(3)+0.03 pos(2) 0.03 pos(4)]);                   %# Add the color bar 
x2= 2;
%text(-2,-3,'channels');
text(-x2,1,'4-5');         %# Add "grid1" text 
text(-x2,5,'4-11');         %# Add "grid2" text 
text(-x2,9,'4-12');        %# Add "grid3" text
text(-x2,13,'5-11');         %# Add "grid1" text 
text(-x2,17,'5-12');         %# Add "grid2" text 
text(-x2,21,'11-12');        %# Add "grid3" text
text(-x2,-3.2,'neuron','FontSize',14);        %# Add "grid3" text
text(-x2-0.9,-2.1,'pairs','FontSize',14);
    titleName = ['A09-Synchrony Strength Comparision'];
    %title(titleName,'FontSize',16);
    saveas(h, titleName,'jpg');
    
    
    [hBT,pBT] = ttest(corrMagN_interval(1,:),corrMagN_interval(2,:))
    [hAC,pAC] = ttest(corrMagN_avgLR(1,:),corrMagN_avgLR(2,:))
    [hLG,pLG] = ttest(corrMagN_interval(1,:),corrMagN_avgLR(1,:))
    [hLD,pLD] = ttest(corrMagN_interval(2,:),corrMagN_avgLR(2,:))
    
    save('A09_Z','ZA');