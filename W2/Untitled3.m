% x = normrnd(0,10,1,1000);
% y = normrnd(0.1,10,1,1000);
% 
% 
% [h1,p1,ci] = ttest2(smoothed,shufflesmoothed,[],[],'unequal')
% [h2,p2,ci] = ttest2(shufflesmoothedpos,shufflesmoothed,[],[],'unequal')
% [h3,p3,ci] = ttest2(smoothedpos,smoothed,[],[],'unequal')
% 
% [u1,s1]=normfit(shufflesmoothed)
% [u2,s2]=normfit(shufflesmoothedpos)
% 
% [h0,p0,ci] = ttest2(x,y,[],[],'unequal')
% figure
% hold on;
% plot(x,'r');
% plot(y,'b')
X1 = [shufflesmoothedpos',shufflesmoothed';smoothedpos',smoothed'];
X=X1;
p = anova2(X,1800)
