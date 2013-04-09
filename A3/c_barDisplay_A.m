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
   x1 = [0 23.5 23.5 0];
   x2 = [23.5 length(rateT) length(rateT) 23.5];
   
   yy = [0 0 100 100];
   fill(x1,yy,[0.4 0.6 0.4]);
   fill(x2,yy,[0.4 0.4 0.6]);
   lWidth = 3;
   plot(rateTM,'r','linewidth',lWidth);
   plot(rateLM,'g','linewidth',lWidth);
   plot(rateRM,'b','linewidth',lWidth);
   legend('learning', 'after learning', 'total', 'left', 'right','Location', 'SouthEast');
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
corrMagN_avgP(:,:,di) = [(corrMagN(1,:)+corrMagN(3,:))/2;corrMagN(2,:)];

   
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
 mode = modeCell{3};
corrName =['..\incorrectInterval_A\' rat mode num2str(windowLen) 'bar_2']
load(corrName);
corrMagN_interval1 = corrMagN/100000;
corrMagN_interval = [(corrMagN_interval1(1,:)+corrMagN_interval1(3,:))/2;corrMagN_interval1(2,:)];
Z1 = zeros(2,12);
Z1(:,2:2:12) = corrMagN_interval;
Z1(:,1:2:11) = corrMagN_avgLR;
Z2 = flipud(Z1);
Z= Z2';
  h = figure;

[r,c] = size(Z);            %# Size of Z 
Y = [1 2 5 6 9 10 13 14 17 18 21 22];  %# The positions of bars along the y axis 
C = mat2cell(kron(Z,ones(6,4)),6*r,4.*ones(1,c)).';  %'# Color data for Z 
 
hBar = bar3(Y,Z);           %# Create the bar graph 
set(hBar,{'CData'},C);      %# Add the color data 
set(gca,'YTickLabel',{'y1' 'y2'});  %# Modify the y axis tick labels 
set(gca,'XTickLabel',{'x1' 'x2'});  %# Modify the y axis tick labels 

view(-70,30);               %# Change the camera view 
colorbar;                   %# Add the color bar 
x2= 3;
%text(-2,-3,'channels');
text(-x2,1,'4-5');         %# Add "grid1" text 
text(-x2,5,'4-11');         %# Add "grid2" text 
text(-x2,9,'4-12');        %# Add "grid3" text
text(-x2,13,'5-11');         %# Add "grid1" text 
text(-x2,17,'5-12');         %# Add "grid2" text 
text(-x2,21,'11-12');        %# Add "grid3" text
    titleName = [rat  '-Correlation Strength comparision'];
    title(titleName);
    saveas(h, titleName,'jpg');
    
    
    [p,tbl,stats] = anova2(Z,6);
    
    [hi,pi] = ttest(corrMagN_interval(1,:),corrMagN_interval(2,:))
    [hc,pc] = ttest(corrMagN_avgLR(1,:),corrMagN_avgLR(2,:))
    [hicing,picing] = ttest(corrMagN_interval(1,:),corrMagN_avgLR(1,:))
    [hiced,piced] = ttest(corrMagN_interval(2,:),corrMagN_avgLR(2,:))