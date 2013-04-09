close all;
clear;

beName =['..\W2\W5L-dateW.mat'];
load(beName);
rateT = dateW(:,2);
for j =1 :length(rateT)
rateTMW(j) = rateT{j}; 
end

beName =['..\A2\A5L-dateW.mat'];
load(beName);
rateT = dateW(:,3);
for j =1 :length(rateT)-3
rateTMA(j) = rateT{j}; 
end

beName =['..\L2\L5L-dateW.mat'];
load(beName);
rateT = dateW(:,3);
for j =1 :length(rateT)-2
rateTML(j) = rateT{j}*100; 
end

beName =['..\B2\B5L-dateW.mat'];
load(beName);
rateTMB = rateT*100; 

% beName =['..\code_event_tag_for_cue_3chs\Q5L-dateW.mat'];
% load(beName);
% rateT = dateW(:,2);
% for j =1 :length(rateT)
% rateTMQ(j) = rateT{j}; 
% end

h = figure;
hold on;
   lWidth = 2;
   plot(rateTMW,'r','linewidth',lWidth);
   plot(rateTMA,'g','linewidth',lWidth);
   plot(rateTML,'b','linewidth',lWidth);
   plot(rateTMB,'m','linewidth',lWidth);
   lWidth = 3;
   plot(23.5, (rateTMW(23)+rateTMW(24))/2,'ro','linewidth',lWidth);
   plot(9.5, (rateTMA(9)+rateTMA(10))/2,'go','linewidth',lWidth);
   plot(15.5,(rateTML(15)+rateTML(16))/2,'bo','linewidth',lWidth);
   plot(7.5,(rateTMB(7)+rateTMB(8))/2,'mo','linewidth',lWidth);
   lWidth = 2;
   plot(32, rateTMW(32),'rs','linewidth',lWidth,'MarkerSize',10);
   plot(15, rateTMA(15),'gs','linewidth',lWidth,'MarkerSize',10);
   plot(22,rateTML(22),'bs','linewidth',lWidth,'MarkerSize',10);
   plot(12,rateTMB(12),'ms','linewidth',lWidth,'MarkerSize',10);
   
   legend('W09', 'A09', 'L10', 'B10','location','southeast');
axis([0 length(rateTMW) 0 100])
   titleName = ['Behavior Correction Rate'];
   title(titleName);
   saveas(h,titleName,'jpg');
   

   
    