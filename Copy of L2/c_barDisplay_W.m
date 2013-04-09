close all;
clear;
rat = 'L5L';
comp = 'norm';
%comp = 'jsig';
windowLen =1800;
chPairArray = [1 3;1 4;3 4];

modeCell = {'cueAlign', 'ActPress'};
dirCell = {'L', 'R'};
load([rat '-dateW.mat']);
rateT = dateW(:,2);
rateL = dateW(:,3);
rateR = dateW(:,5);
cutW = [ 6 7 8 10 12 13 23];
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
   x1 = [0 9.5 9.5 0];
   x2 = [9.5 length(rateTM) length(rateTM) 9.5];
   
   yy = [0 0 100 100];
   fill(x1,yy,[1 1 1]);
   fill(x2,yy,[0.8 0.8 0.8]);
   lWidth = 3;
 %  plot(rateTM*100,'r','linewidth',lWidth);
   plot(rateLM*100,'g','linewidth',lWidth);
  % plot(rateRM*100,'b','linewidth',lWidth);
   legend('learning', 'after learning', 'left','Location', 'NorthWest');
axis([0 length(rateTM) 0 100])
   titleName = [rat 'behavior correction rate'];
   title(titleName);
   saveas(h,titleName,'jpg');
corrMagN_avgP= zeros(2,3,2);
for mi = 1: 1
    mode = modeCell{mi};
    for di= 1:2
        dir = dirCell{di};

corrName =[rat mode num2str(windowLen) dir 'bar_2']
load(corrName);
corrMagN_avgP(:,:,di) = corrMagN(1:2,1:3);

   
%    for pi = 1 : 3
%        h = figure;
% hold on;
%    bar(corrMagN(:,pi)/10,'r');
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
set(gca,'XTick',1:3);
set(gca,'XTickLabel',{'4-13','4-16','13-16'});
legend('learning', 'learned','location','north');
xlabel('neuron pairs');
ylabel('correlation strength');
v= axis;
v(4) = 4;
axis(v);
    titleName = [rat '-' num2str(windowLen)  '-Correlation Strength comparision'];
%    title(titleName);
    
    saveas(h, titleName,'jpg');