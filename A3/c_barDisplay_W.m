close all;
clear;
rat = 'A5L';
comp = 'norm';
%comp = 'jsig';
windowLen =1800;
chPairArray = [1 2;1 3;1 4;2 3;2 4;3 4];

modeCell = {'cueAlign', 'ActPress'};
dirCell = {'L', 'R'};
% load([rat '-dateW.mat']);
% rateT = dateW(:,2);
% rateL = dateW(:,3);
% rateR = dateW(:,5);
% 
% for j =1 :length(rateT)
% %rateTD(j) = rateT{j} - rateT{j-1};
% rateTM(j) = rateT{j}; 
% rateRM(j) = rateR{j}; 
% rateLM(j) = rateL{j}; 
% end
% h = figure;
% hold on;
%    x1 = [0 9.5 9.5 0];
%    x2 = [9.5 15.5 15.5 9.5];
%    x3 = [15.5 18 18 15.5];
%    yy = [0 0 100 100];
%    fill(x1,yy,[0.6 0.6 0.4]);
%    fill(x2,yy,[0.4 0.6 0.6]);
%    fill(x3,yy,[0.6 0.4 0.6]);
%    plot(rateTM,'r');
%    plot(rateLM,'g');
%    plot(rateRM,'b');
%    legend('left cue learning', 'after learning', 'right cue learning', 'total', 'left', 'right','Location', 'NorthWest');
% 
%    titleName = [rat 'behavior correction rate'];
%    title(titleName);
%    saveas(h,titleName,'jpg');
corrMagN_avgP= zeros(3,6,2);
for mi = 1: 1
    mode = modeCell{mi};
    for di= 1:2
        dir = dirCell{di};

corrName =[rat mode num2str(windowLen) dir 'bar_2']
load(corrName);
corrMagN_avgP(:,:,di) = corrMagN(1:3,:);
% load([rat dir 'trialNo.mat']);
% figure;
% bar(trialNo);
   
%    for pi = 1 : 6
%        h = figure;
% hold on;
%    bar(corrMagN(1:3,pi)/10,'r');
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

corrMagN_avgLR = sum(corrMagN_avgP,3)/100;
  h = figure;

    bar(corrMagN_avgLR','group');
cm2 = [0.4 0.6 0.4; 0.4 0.4 0.6; 0.6 0.4 0.6];
colormap(cm2);
set(gca,'XTick',1:6);
set(gca,'XTickLabel',{'4-5','4-11','4-12','5-11','5-12','11-12'});
legend('left cue learning', 'learned','right cue learning','location','north');
xlabel('neuron pairs');
ylabel('correlation strength');
v= axis;
v(4) = 4;
axis(v);
    titleName = [rat '-' num2str(windowLen)  '-Correlation Strength comparision'];
%    title(titleName);
    saveas(h, titleName,'jpg');