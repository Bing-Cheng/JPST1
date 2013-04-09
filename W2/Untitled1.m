figure
load tmp.mat

thisto1 = thisto1*20;
h =plot(thisto1*length(txvals1)+offset*1.414,txvals1,'k','color',fc);
xlabel('x')
ylabel('y')
zlabel('z')
axis on;
rotate(h,[0 0 1],45,[0 0 0]);