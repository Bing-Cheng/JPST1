Z = rand(12,2);              %# Some random sample data 
[r,c] = size(Z);            %# Size of Z 
Y = [1 2 5 6 9 10 13 14 17 18 21 22];  %# The positions of bars along the y axis 
C = mat2cell(kron(Z,ones(6,4)),6*r,4.*ones(1,c)).';  %'# Color data for Z 
 
hBar = bar3(Y,Z,0.25);           %# Create the bar graph 
set(hBar,{'CData'},C);      %# Add the color data 
set(gca,'YTickLabel',{'y1' 'y2'});  %# Modify the y axis tick labels 
set(gca,'XTickLabel',{'x1' 'x2'});  %# Modify the y axis tick labels 

view(-70,30);               %# Change the camera view 
colorbar;                   %# Add the color bar 
text(-2,1,'grid1');         %# Add "grid1" text 
text(-2,5,'grid2');         %# Add "grid2" text 
text(-2,9,'grid3');        %# Add "grid3" text
text(-2,13,'grid1');         %# Add "grid1" text 
text(-2,17,'grid2');         %# Add "grid2" text 
text(-2,21,'grid3');        %# Add "grid3" text

