close all

Tab = readtable('data2.xlsx');
A = table2array(Tab);
%A = A(1:2000,:);
L = size(A,1);
Fs = 500;
T = 1/Fs;
time = T:T:T*L;
NewA = detrend(A(:,2));



[pks,locs] = findpeaks(NewA,Fs,'MinPeakDistance',0.5);
Per =locs*Fs;
Per =Per-Per(1);

plot(time,NewA)
%xline(chunks/500);



%%%VISUAL%%%%  ONE PERIOD  %%%%%%
figure(2)
curr = 1;
for i =1:length(pks)-1
    plot(NewA(curr:Per(i+1)))
    curr = Per(i+1)+1;
    hold on
end

%%% INTEGRAL%%%  ONE PERIOD  %%%%%%
h = 0.002;
figure(3)
curr = 1;
for i =1:length(pks)-1
    iv = integrate_trapz(NewA(curr:Per(i+1)),0e-4,h);
    plot(iv)
    curr = Per(i+1)+1;
    hold on
end

figure(4)
integ = integrate_trapz(NewA,0e-4,h);
plot(integ)
