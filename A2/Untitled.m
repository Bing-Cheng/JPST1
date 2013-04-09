close all
data = [3, 7, 5, 2;4, 3, 2, 9;6, 6, 1, 4];
figure
b = bar(data);
cm = colormap;
cm1 = cm(1:32,:);
cm2 = [0 0 1; 0 1 0; 1 0 0];
colormap(cm2);