function scoopHist = cb_scoopHist(matrix, scoop)

scoopHist = zeros(1,length(diag(matrix,0)));
for sinx = scoop(1):scoop(2)   
   snx = abs(sinx);
   d =diag(matrix,sinx)';
   scoopHist(snx+1:end) = scoopHist(snx+1:end)+d;
%   scoopHist = JPSTSmooth(scoopHist,1);
end 