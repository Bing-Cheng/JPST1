close all;
clear;
rat = 'G5L';
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
scoop(2,:) = scoop(2,:) + 30;
corrMagN_cue= corrMagN;

cm1 = [1 1 0; 0 1 1; 1 0 1;];   
cm2 = [1 0 0; 0 1 0; 0 0 1;];
set(gca,'FontSize',12);
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

comStr = [learning_var; resting_var]*3/1000;

h = figure;
set(gca,'FontSize',14);
bar(comStr','group');
cm2 = [0.4 0.6 0.4; 0.4 0.4 0.6];
colormap(cm2);
set(gca,'XTick',1:3);
set(gca,'YTick',0:4);
set(gca,'XTickLabel',{'12-14','12-16','14-16'});
legend('Learning', 'Resting','location','north');
xlabel('Neuron pairs');
ylabel('Variance of coincidence histogram');

    titleName = [rat '-' num2str(windowLen)  '-Structure comparision'];
   % title(titleName);
    saveas(h, titleName,'jpg');
    

   

corrMagN_avgLR = [corrMagN_cue;corrMagN_resting]*1.2/100000;
  h = figure;
%   axis([0 3 0 5]);
%     set(gca, 'YTick', [-1 0 1 2 3 4 5]);
set(gca,'FontSize',14);
    bar(corrMagN_avgLR','group')    

cm2 = [0.4 0.6 0.4; 0.4 0.4 0.6];
colormap(cm2);
set(gca,'XTick',1:3);
set(gca,'XTickLabel',{'12-14','12-16','14-16'});
legend('Learning', 'Resting','location','north');
xlabel('Neuron pairs');
ylabel('Coincidence Mesurement');

    titleName = [rat '-' num2str(windowLen)  '-sychrony strength comparision'];
   % title(titleName);
    saveas(h, titleName,'jpg');
    ratQ = 'Q5L';
dir = '..\..\Q\code_resting_3chs\';
corrName =[dir ratQ 'resting' num2str(windowLen) 'bar_2']
load(corrName);
corrMagN_restingQ= corrMagN;

dir = '..\..\Q\code_event_tag_for_cue_3chs\';
corrName =[dir ratQ 'cueAlign' num2str(windowLen) 'bar_2']
load(corrName);
corrMagN_cueQ= corrMagN;  
synLG = [corrMagN_cue corrMagN_cueQ]/10000;
synRG = [corrMagN_resting corrMagN_restingQ]/10000;
[hsyn,psyn,ci,stats] = ttest(synLG,synRG)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
learning_varG = learning_var;
resting_varG = resting_var;
dir = '..\..\Q\code_event_tag_for_cue_3chs\';
corrName =[dir ratQ 'var_mean']
load(corrName);
learning_varQ = learning_var;
resting_varQ = resting_var;
strucLG = [learning_varG learning_varQ];
strucRG = [resting_varG resting_varQ];
[hstruc,pstruc,ci,stats] = ttest(strucLG,strucRG)