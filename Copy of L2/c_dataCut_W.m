clear;

rat = 'L5L';
load([rat '-dateW.mat']);
dateN = size(dateW,1);
sectionCell = {'-apr', '-pos', '-ful'; [1:16], [17:dateN] [1:dateN]};
sectionCell = {'-apr', '-pos', '-ful'; [1:5 9 11 14 15], [16:22 24] [1:dateN]};
modeCell = {'cueAlign', 'ActPress'};
dirCell = {'L', 'R'};
windowLen = 1800;
window = [1:windowLen];
chPairArray = [1 2;1 3;1 4;2 3;2 4;3 4];

load([rat '-rateTDremoved']);
h=figure
bar(rateTDremoved);
saveas(h,[rat '-rate difference'],'jpg');
for mi = 1: 1
    mode = modeCell{mi};
    rawDataName = ['rawData_' mode rat '.mat'];
    load(rawDataName); 
    dateN = size(sD,1);
    for di= 1:1
        dir = dirCell{di};
            for si = 1:2
            section = sectionCell{1,si};  

            secRange = sectionCell{2,si};  
            for ci = 1:6
                chPair = chPairArray(ci,:);
                
                xData = [];
                yData = [];

  
                for d = secRange;
                   if (rateTDremoved(d)>-0.1)
                    
                    if dir == 'R';
                       x = sD{d, chPair(1)}.right;
                       y = sD{d, chPair(2)}.right;
                    else
                       x = sD{d, chPair(1)}.left;
                       y = sD{d, chPair(2)}.left;
                    end
                    xData = [xData x(window,:)]; 
                    yData = [yData y(window,:)];
                   end
      
                end%date
                    xData(find(xData>1))=1;
                    yData(find(yData>1))=1;
                    fileName1 = [rat mode num2str(windowLen) dir num2str(chPair(1)) num2str(chPair(2)) '-' section '.mat']
                    save(fileName1, 'xData', 'yData') 
           
            end%chPair
         end%section
    end%dir
end%mode
