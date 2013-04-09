
%[num,den] = butter(9,1000/24414);
close all;
%     [b,a] = butter(9,1000/24414);   

% %     h1 = fvtool(b,a); 
% %     [h2, f2] = freqz(b, a, 1024);
% % plot(f2, 20*log10(h2), 'b');
% % grid on;
% %y = filter(b,a,X)
% %set(gca ,'xscale', 'log');
% data = [1:0.2:4]';
% windowSize = 5;
% y=filter(b,a,data)
% figure
% plot(data);
% figure
% plot(y);
b = fir1(30,1000/24414);
fvtool(b,1);
clear all
clc
fm=100;  % signal freq
fs=800;  % sampling feq
fn=2*fm; %Nyquist rate
t=0:1/fs:0.1;
X = 2*sin(2*pi*fm*t) ;
% Here I created 100 hz sine wave
% addes some noise to it
Y=X+randn(1,length(X));
figure
plot(t,X)
hold on
plot(t,Y,'r')
% I need to have passband of the signal
% between 80Hz to 120 Hz
% So normalized frequencies are
fw1=fm/fn-0.1; % 80 Hz
fw2=fm/fn+0.1; % 120 Hz
% Coefficents for fir filter within passband
b = fir1(12,[fw1 fw2]);
figure
freqz(b,1,128)
% I convolved filter coefficients with noised signal
Filt_out=conv(b,Y);
figure
plot(Filt_out)
% Filtered Signal output