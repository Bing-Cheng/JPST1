function xcorrHist = cb_xcorrHist(matrix)

xcorrHist = [];   
is = floor(length(matrix)/2);
for i = -is+1:is-1
   xcorrHist(i+is,:) = [i,(sum(diag(matrix,i)))/(is-abs(i))];
end