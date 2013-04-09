close all;
clear;
rat = 'Q5L';
comp = 'norm';
%comp = 'jsig';
windowLen =1800;
chPairArray = [1 2;1 3;1 4;2 3;2 4;3 4];


corrName =[rat 'resting' num2str(windowLen) 'bar_2']
load(corrName);
corrMagN_resting= corrMagN;

corrName =['E:\bcheng\work\code\code_event_tag_for_cue_3chs\' rat 'cueAlign' num2str(windowLen) 'L' 'bar_2']
load(corrName);
corrMagN_cue= corrMagN(3,1:3);
   

corrMagN_avgLR = [corrMagN_cue;corrMagN_resting]/100000;
  h = figure;

    bar(corrMagN_avgLR','group');
cm2 = [0.4 0.6 0.4; 0.4 0.4 0.6];
colormap(cm2);
set(gca,'XTick',1:3);
set(gca,'XTickLabel',{'9-10','9-14','10-14'});
legend('learning', 'resting','location','north');
xlabel('neuron pairs');
ylabel('correlation strength');
% v= axis;
% v(4) = 4;
% axis(v);
    titleName = [rat '-' num2str(windowLen)  '-Correlation Strength comparision'];
    title(titleName);
    saveas(h, titleName,'jpg');