load('W5LcueAlign1800shuffle.mat');
corrShuffled = corrMagN;
load('W5LcueAlign1800bar_2.mat');
for i = 1 : 6
    data = corrShuffled(:,i);
    [muhat,sigmahat] = normfit(data);
    X = corrMagN(1,i);
    P(i) = normcdf(X,muhat,sigmahat);
end