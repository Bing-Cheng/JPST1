cc = colormap;
c=zeros(4,3);
for i = 1 : 4 
ii = 40+i*4
c(i,:) = cc(ii,:);
ci = floor(cc(ii,:)*256)
end
x=[1:4];
pie(x);
colormap(c);
figure
pie(x);
colormap jet;
floor(c)