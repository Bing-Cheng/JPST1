clear;

rat = 'L5L';
load([rat '-dateW.mat']);
dateN = size(dateW,1);
sectionCell = {'-apr', '-pos', '-ful'; [1:16], [17:dateN-2] [1:dateN]};
modeCell = {'cueAlign', 'ActPress', 'interval'};
dirCell = {'L', 'R'};
windowLen = 1800;
windowSta = 0;
window = [windowSta+1:windowSta+windowLen];
chPairArray = [1 2;1 3;2 3];
for mi = 3: 3
    mode = modeCell{mi};
    rawDataName = ['rawData_' mode rat '.mat'];
    load(rawDataName); 
    dateN = size(sD,1);

            for si = 1:2
            section = sectionCell{1,si};  

            secRange = sectionCell{2,si};  
            for ci = 1:3
                chPair = chPairArray(ci,:);
                
                xData = [];
                yData = [];

  
                for d = secRange;
  
                       x = sD{d, chPair(1)}.left;
                       y = sD{d, chPair(2)}.left;
                    xData = [xData x(window,:)]; 
                    yData = [yData y(window,:)];
      
                end%date
                    xData(find(xData>1))=1;
                    yData(find(yData>1))=1;
                    fileName1 = [rat mode num2str(windowLen) num2str(chPair(1)) num2str(chPair(2)) '-' section '.mat']
                    save(fileName1, 'xData', 'yData') 
           
            end%chPair
         end%section

end%mode
