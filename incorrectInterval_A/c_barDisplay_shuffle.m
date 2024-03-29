close all;
clear;
rat = 'Q5L';
comp = 'norm';
%comp = 'jsig';
windowLen =1800;
chPairArray = [1 2;1 3;1 4;2 3;2 4;3 4];
core = ones(100,1)/100;

corrName =[rat 'cueAlign' num2str(windowLen) 'shuffle']
load(corrName);
scoopshuffle= scoopM;

corrName =[rat 'cueAlign' num2str(windowLen) 'bar_2']
load(corrName);
scoop= scoopM;
cm1 = [1 1 0; 0 1 1; 1 0 1;];   
cm2 = [1 0 0; 0 1 0; 0 0 1;];
for i = 1:3
h = figure;
hold on;
coins = scoop(i,:);
smoothed = conv(coins,core,'same');
learning_var(i) = var(smoothed);
shufflecoins = scoopshuffle(i,:);
shufflesmoothed = conv(shufflecoins,core,'same');
plot(smoothed(101:end-100),'r');%,'Color', cm1(i,:));
plot(shufflesmoothed(101:end-100),'b');%'color', cm2(i,:));
legend('unshuffled','shuffled');
    titleName = [rat '-' num2str(windowLen)  '-learning comparision with shuffled data' '-pair-' num2str(chPairArray(i,1)) '-' num2str(chPairArray(i,2))];
    title(titleName);
    saveas(h, titleName,'jpg');
end
save([rat 'learning_var_mean'], 'learning_var');
load('..\code_resting_3chs\Q5Lresting_var_mean.mat');
comStr = [learning_var; resting_var];

h = figure;
bar(comStr','group');
cm2 = [0.4 0.6 0.4; 0.4 0.4 0.6];
colormap(cm2);
set(gca,'XTick',1:3);
set(gca,'XTickLabel',{'9-10','9-14','10-14'});
legend('learning', 'resting','location','north');
xlabel('neuron pairs');
ylabel('Structure Index');

    titleName = [rat '-' num2str(windowLen)  '-Structure comparision'];
    title(titleName);
    saveas(h, titleName,'jpg');