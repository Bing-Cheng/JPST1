close all;
clear;
rat = 'W5L';
comp = 'norm';
%comp = 'jsig';
windowLen =1800;
chPairArray = [1 2;1 3;1 4;2 3;2 4;3 4];
core = ones(1,1);

corrName =[rat 'cueAlign' num2str(windowLen) 'shuffle1']
load(corrName);
scoopshuffle= scoopM;

corrName =[rat 'cueAlign' num2str(windowLen) 'bar_2']
load(corrName);
scoop= scoopM;

corrName =[rat 'cueAlign' '-pos' num2str(windowLen) 'shuffle1']
load(corrName);
scoopshufflepos= scoopM;

corrName =[rat 'cueAlign' '-pos' num2str(windowLen) 'bar_2']
load(corrName);
scooppos= scoopM;

cm1 = [1 1 0; 0 1 1; 1 0 1;];   
cm2 = [1 0 0; 0 1 0; 0 0 1;];
for i = 1:6
h = figure;
hold on;
smoothed = conv(scoop(i,:),core,'same');
shufflesmoothed = conv(scoopshuffle(i,:),core,'same');
plot(smoothed,'r');%,'Color', cm1(i,:));
plot(shufflesmoothed,'b');%'color', cm2(i,:));

smoothedpos = conv(scooppos(i,:),core,'same');
shufflesmoothedpos = conv(scoopshufflepos(i,:),core,'same');
plot(smoothedpos,'g');%,'Color', cm1(i,:));
plot(shufflesmoothedpos,'y');%'color', cm2(i,:));

legend('unshuffled','shuffled','unshuffledpos','shuffledpos');
    titleName = [rat '-' num2str(windowLen)  '-comparision with shuffled data' '-pair-' num2str(chPairArray(i,1)) '-' num2str(chPairArray(i,2))];
%    title(titleName);
    saveas(h, titleName,'jpg');
end