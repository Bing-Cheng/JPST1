close all;
clear;
rat = 'Q5L';
comp = 'norm';
%comp = 'jsig';
windowLen =1800;
chPairArray = [1 2;1 3;1 4;2 3;2 4;3 4];
core = ones(100,1)/100;

corrName =[rat 'resting' num2str(windowLen) 'shuffle']
load(corrName);
scoopshuffle= scoopM;

corrName =[rat 'resting' num2str(windowLen) 'bar_2']
load(corrName);
scoop= scoopM;
cm1 = [1 1 0; 0 1 1; 1 0 1;];   
cm2 = [1 0 0; 0 1 0; 0 0 1;];
for i = 1:3
h = figure;
hold on;
coins = scoop(i,:);
smoothed = conv(coins,core,'same');
resting_var(i) = var(smoothed);
shufflecoins = scoopshuffle(i,:);
shufflesmoothed = conv(shufflecoins,core,'same');
plot(smoothed,'r');%,'Color', cm1(i,:));
plot(shufflesmoothed,'b');%'color', cm2(i,:));
legend('unshuffled','shuffled');
    titleName = [rat '-' num2str(windowLen)  '-resting comparision with shuffled data' '-pair-' num2str(chPairArray(i,1)) '-' num2str(chPairArray(i,2))];
    title(titleName);
    saveas(h, titleName,'jpg');
end
save([rat 'resting_var_mean'], 'resting_var');