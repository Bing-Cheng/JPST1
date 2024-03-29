close all;
clear;
rat = 'L5L';
comp = 'norm';
%comp = 'jsig';
windowLen =1800;
chPairArray = [1 3;1 4;3 4];

modeCell = {'cueAlign', 'ActPress','interval'};
dirCell = {'L', 'R'};
load([rat '-dateW.mat']);
rateT = dateW(:,2);
rateL = dateW(:,3);
rateR = dateW(:,5);
%[1:5 7:9 11 16], [17:dateN]
%cutW = [ 6 10 12 13 15 23 24];
cutW = [23 24];
for j =1 :length(rateT)
%rateTD(j) = rateT{j} - rateT{j-1};
rateTM(j) = rateT{j}; 
rateRM(j) = rateR{j}; 
rateLM(j) = rateL{j}; 
end
rateTM(cutW) = []; 
rateRM(cutW) = []; 
rateLM(cutW) = []; 
h = figure;
hold on;
divLine = 15.5;
   x1 = [0 divLine divLine 0];
   x2 = [divLine length(rateTM) length(rateTM) divLine];
   
   yy = [0 0 100 100];
   fill(x1,yy,[1 1 1]);
   fill(x2,yy,[0.9 0.9 0.9]);
   lWidth = 3;
 %  plot(rateTM*100,'r','linewidth',lWidth);
   plot(rateLM*100,'g','linewidth',lWidth);
  % plot(rateRM*100,'b','linewidth',lWidth);
   legend('learning', 'after learning', 'left','Location', 'NorthWest');
axis([0 length(rateTM) 0 100])
   titleName = [rat 'behavior correction rate'];
   title(titleName);
   saveas(h,titleName,'jpg');
   
   
    mode = modeCell{1};
  
        dir = dirCell{1};

corrName =[rat mode num2str(windowLen) dir 'bar_2']
load(corrName);

corrMagN_avgLR = corrMagN(1:2,1:3)/100000;
 mode = modeCell{3};
corrName =['..\incorrectInterval_L\' rat mode num2str(windowLen) 'bar_2']
load(corrName);
corrMagN_interval1 = corrMagN/100000;
corrMagN_interval = [corrMagN_interval1(1,:);corrMagN_interval1(2,:)];
Z1 = zeros(2,6);
Z1(:,2:2:6) = corrMagN_interval;
Z1(:,1:2:5) = corrMagN_avgLR;
Z2 = flipud(Z1);
Z= Z2';
ZL = Z;
  h = figure;
%Z(find(Z<0))=0;
[r,c] = size(Z);            %# Size of Z 
Y = [1 2 5 6 9 10];  %# The positions of bars along the y axis 
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
x2= 1;
%text(-2,-3,'channels');
text(-x2,1,'7-13');         %# Add "grid1" text 
text(-x2,5,'7-16');         %# Add "grid2" text 
text(-x2,9,'13-16');        %# Add "grid3" text
% text(-x2,13,'5-11');         %# Add "grid1" text 
% text(-x2,17,'5-12');         %# Add "grid2" text 
% text(-x2,21,'11-12');        %# Add "grid3" text
text(-x2,-1.5,'neuron','FontSize',14);        %# Add "grid3" text
text(-x2-0.5,-0.7,'pairs','FontSize',14);
    titleName = ['L10-Synchrony Strength Comparision'];
    %title(titleName,'FontSize',16);
    saveas(h, titleName,'jpg');
    
    
    [hBT,pBT] = ttest(corrMagN_interval(1,:),corrMagN_interval(2,:))
    [hAC,pAC] = ttest(corrMagN_avgLR(1,:),corrMagN_avgLR(2,:))
    [hLG,pLG] = ttest(corrMagN_interval(1,:),corrMagN_avgLR(1,:))
    [hLD,pLD] = ttest(corrMagN_interval(2,:),corrMagN_avgLR(2,:))
    
    save('L10_Z','ZL');