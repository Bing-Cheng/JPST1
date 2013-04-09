close all;
clear;
rat = 'Q5L';
comp = 'norm';
%comp = 'jsig';
windowLen =1800;
chPairArray = [1 2;1 3;2 3];
%core = ones(100,1)/100;
core = ones(1,1);
corrName =[rat 'cueAlign' num2str(windowLen) 'shuffle']
load(corrName);
scoopshuffle= scoopM;

dir = '..\code_resting_3chs\';
corrName =[dir rat 'resting' num2str(windowLen) 'bar_2']
load(corrName);
scoopResting= scoopM;
corrMagN_resting= corrMagN;
corrName =[rat 'cueAlign' num2str(windowLen) 'bar_2']
load(corrName);
scoop= scoopM;
corrMagN_cue= corrMagN;

cm1 = [1 1 0; 0 1 1; 1 0 1;];   
cm2 = [1 0 0; 0 1 0; 0 0 1;];
for i = 1:3
h = figure;
set(gca,'FontSize',14);
axis([0 1600 -1 5]);
    set(gca, 'YTick', [-1 0 1 2 3 4 5]);
hold on;
coins = scoop(i,:);
smoothed = conv(coins,core,'same');
learning_var(i) = var(smoothed);

restingcoins = scoopResting(i,:);
restingsmoothed = conv(restingcoins,core,'same');
resting_var(i) = var(restingsmoothed);

shufflecoins = scoopshuffle(i,:);
shufflesmoothed = conv(shufflecoins,core,'same');
cScale = 100;
plot(smoothed(101:end-100)/cScale,'r');%,'Color', cm1(i,:));
plot(restingsmoothed(101:end-100)/cScale,'g');%,'Color', cm1(i,:));
plot(shufflesmoothed(101:end-100)/cScale,'b');%'color', cm2(i,:));
legend('Learning','Resting','Shuffled');
xlabel('Time (ms)');
ylabel('Coincidence Mesurement');
    titleName = [rat '-learning comparision with resting and shuffled data' '-pair-' num2str(chPairArray(i,1)) '-' num2str(chPairArray(i,2))];
 %   title(['Neuron pair: ' num2str(chPairArray(i,1)) '-' num2str(chPairArray(i,2))]);
    saveas(h, titleName,'jpg');
end

save([rat 'var_mean'], 'learning_var', 'resting_var');

comStr = [learning_var; resting_var]/1000;

h = figure;
set(gca,'FontSize',14);
bar(comStr','group');
cm2 = [0.4 0.6 0.4; 0.4 0.4 0.6];
colormap(cm2);
set(gca,'XTick',1:3);
set(gca,'YTick',0:4);
set(gca,'XTickLabel',{'9-10','9-14','10-14'});
legend('Learning', 'Resting','location','north');
xlabel('Neuron pairs');
ylabel('Variance of coincidence histogram');

    titleName = [rat '-' num2str(windowLen)  '-Structure comparision'];
   % title(titleName);
    saveas(h, titleName,'jpg');
    

   

corrMagN_avgLR = [corrMagN_cue;corrMagN_resting]/120000;
  h = figure;
set(gca,'FontSize',14);
    bar(corrMagN_avgLR','group')    

cm2 = [0.4 0.6 0.4; 0.4 0.4 0.6];
colormap(cm2);
set(gca,'XTick',1:3);
set(gca,'XTickLabel',{'9-10','9-14','10-14'});
legend('Learning', 'Resting','location','north');
xlabel('Neuron pairs');
ylabel('Coincidence Mesurement');

    titleName = [rat '-' num2str(windowLen)  '-sychrony strength comparision'];
   % title(titleName);
    saveas(h, titleName,'jpg');