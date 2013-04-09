function cbJPSTH_show(Version, matrix, xHist, yHist, xcorrHist, scoopHist, saveF, discale)

h0 = figure(   'Name',[Version ],'Position',[50 100 560 420]);
colormap(jet);
PosMatrix = [.25 .33 .376 .33];
PosXCorScoop = [.62 .33 .5 .66];
PosXHist = [.25 .168 .25 .159];
PosYHist = [.128 .33 .119 .33];

%%%%%%%%%%%%%%%%%%%%%%%%%%%cb JSPH
drawnow

subplot('position',PosMatrix);	% matrix
axis([ 1 50 1 50]);
axis off

% em = colormap;
% scale = size(em,1);
% %m = max(max(abs(matrix)));
% me = sort(abs(matrix(:)));
% m = me( floor(length(me)*0.95) );
% if ~m m = 1; end;			% if all zeros
% dMatrix = ceil((m+matrix)*scale/(2*m));	% colors will map from -max to max
% dMatrix(find(dMatrix < 1)) = 1; 			% make any zeros a one
% dMatrix(find(dMatrix  > scale)) = scale;	% make any above scale equal to scale
% 
% dMatrix(:,end+1) = 1;  % pcolor does not plot the last col or row
% dMatrix(end+1,:) = scale;
% drawnow
% dMatrix = dMatrix/scale;
%pcolor(dMatrix);
%pcolor(matrix);
vec2 = reshape(matrix, size(matrix,1)^2,1);
 mean1 = mean(vec2);
 variance1 = var(vec2);
 disRange = [mean1+discale*variance1,max(vec2)];
imagesc(matrix,disRange);
axis xy;
%shading flat
colorbar;
%axis square
axis tight
axis off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%cb plot x and y histo
%fc = [0.7 0.7 0.7];
fc = [0 0 0.5];

subplot('position',PosXHist);	% xhist plot or raster plot

xvals = 1:size(matrix,1);
txvals = sort([xvals+0.5, xvals-0.5]);
txvals = [txvals(1), txvals, txvals(end), txvals(1)];
thisto = zeros(1,2*length(xHist));
thisto(1:2:end) = xHist;
thisto(2:2:end) = xHist;
thisto = [0, thisto, 0, 0];
fill(txvals,-thisto,fc,'EdgeColor',fc);
axis tight
axis off

subplot('position',PosYHist);	% yhist plot or raster plot
  
xvals = 1:size(matrix,1);
txvals = sort([xvals+0.5, xvals-0.5]);
txvals = [txvals(1), txvals, txvals(end), txvals(1)];
thisto = zeros(1,2*length(yHist));
thisto(1:2:end) = yHist;
thisto(2:2:end) = yHist;
thisto = [0, thisto, 0, 0];
fill(-thisto, txvals,fc,'EdgeColor',fc);
axis tight
axis off

subplot('position',PosXCorScoop);	% x corr plot


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%display the xcorr histo
fc = [0.5 0 0];
xvals = xcorrHist(:,1)';
txvals = sort([xvals+0.5, xvals-0.5]);
txvals = -[txvals(1), txvals, txvals(end), txvals(1)];
thisto = zeros(1,2*length(xcorrHist(:,2)));
thisto(1:2:end-1) = xcorrHist(:,2);
thisto(2:2:end) = xcorrHist(:,2);
thisto = [0, thisto, 0, 0];
%while max(thisto)*length(alignList)/length(txvals) > 0.1*1.414		% scaling plot
m = max(abs(xcorrHist(:,2)));
   thisto =(thisto*0.1414)/m;
%   thisto =thisto/2;
%end
%while max(thisto)*length(alignList)/length(txvals) < 0.049*1.414		% scaling plot
%   thisto =thisto*2;
%end
offset = length(yHist) + 0.1*length(yHist);
txvals1 = txvals(501:end-500);
thisto1 = thisto(501:end-500)*20;%cb scale o.w. show a line;
h =plot(thisto1*length(txvals1)+offset*1.414,txvals1,'k','color',fc);
rotate(h,[0, 90],45,[0 0 0]);
xtemp = get(h,'xdata');
ytemp = get(h,'ydata');
fill(xtemp,ytemp,fc,'EdgeColor',fc);
%pause(.1);
drawnow
%axis([1 length(txvals) 1 length(txvals)]);
axis manual
hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%display the scoop histo
fc = [0 0.5 0];
xvals = 1:length(scoopHist);
txvals = sort([xvals+0.5, xvals-0.5]);
txvals = [txvals(1), txvals, txvals(end), txvals(1)];
thisto = zeros(1,2*length(scoopHist));
thisto(1:2:end-1) = scoopHist;
thisto(2:2:end) = scoopHist;
thisto = [0, thisto, 0, 0];
%if max(thisto)*length(alignList)/length(txvals) > 0.1*1.414		% scaling plot
m = max(scoopHist);
if m < abs(min(scoopHist))
   m = min(scoopHist);
end   
   thisto =(thisto*0.1414)/m;
%end
%if max(thisto)*length(alignList)/length(txvals) < 0.049*1.414		% scaling plot
%   thisto =thisto*;
%end
h =plot(txvals*1.414,thisto*length(txvals),'k','color',fc);
rotate(h,[0, 90],45,[0 0 0]);
xtemp = get(h,'xdata');
ytemp = get(h,'ydata');
fill(xtemp,ytemp,fc,'EdgeColor',fc);
%pause(.1);
drawnow
%axis manual
axis([0 length(txvals)-3 0 length(txvals)-3]);
axis off
hold off
if saveF == 1
 saveas(h,['jpsth-' Version],'tif');
end