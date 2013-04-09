clear;
close all;
rat = 'W5L';
load([rat '-dateW.mat']);
dateN = size(dateW,1);
sectionCell = {'-apr', '-pos', '-ful'; [1:23], [24:32] [1:32]};
modeCell = {'cueAlign', 'ActPress'};
dirCell = {'L', 'R'};
windowLen = 1800;
window = [1:windowLen];
chPairArray = [1 2;1 3;1 4;2 3;2 4;3 4];
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
            for ci = 1:1
                chPair = chPairArray(ci,:);
                
                xData = [];
                yData = [];

  
                for d = secRange;
                    
                    
                    if dir == 'R';
                       x = sD{d, chPair(1)}.right;
                       y = sD{d, chPair(2)}.right;
                    else
                       x = sD{d, chPair(1)}.left;
                       y = sD{d, chPair(2)}.left;
                    end
                    xData = [xData x(window,:)]; 
                    yData = [yData y(window,:)];
      
                end%date
                    xData(find(xData>1))=1;
                    yData(find(yData>1))=1;
                    for j=1:10:400
                    trainWindow = [j:j+10];

%         h = figure;
%         hold on;
        for i = trainWindow
           
      
        sTrail1 = xData(:,i);
        sTrail2 = yData(:,i);
        core = ones(1,1);
        sTrail1F = conv(sTrail1,core,'same');
        sTrail1F(find(sTrail1F>=1))=1;
        sTrail2F = conv(sTrail2,core,'same');
        sTrail2F(find(sTrail2F>=1))=1;
        coinci = sTrail1F.*sTrail2F;
%          Icoinci = find(coinci==1);
%         IsTrail1 = find(sTrail1==1);
%         IsTrail2 = find(sTrail2==1);
%         plot(IsTrail1,i,'b.');
%          plot(IsTrail2,i+0.2,'g.');
%          if ~isempty(Icoinci)
%          plot(Icoinci,i+0.1,'rs');
%          else
%              tmp=1;
%          end

        end
        coincidiff(si,j) = sum(coinci);
                    end
                    fileName1 = [rat mode num2str(windowLen) dir num2str(chPair(1)) num2str(chPair(2)) '-' section '.mat']
                    save(fileName1, 'xData', 'yData') 
           
            end%chPair
         end%section
         figure
         plot(coincidiff(1,:)-coincidiff(2,:));
    end%dir
end%mode
