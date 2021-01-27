

close all;
clear all;

for i = 1:6
    % 取信号
    file_name = strcat('gun',num2str(i));
    file_name = strcat(file_name,'.wav');
    fprintf('reading %s...\n',file_name);
    [y,fs] = audioread(file_name);   
    sz = size(y);
    gun = (y(:,1))'; % 单声道
    
    % 原信号
    figure(i);
    p2 = abs(fft(gun)/length(gun));
    size(gun)
    size(1:length(gun)/2+1)
    gun_fft = p2(1:length(gun)/2+1);
    gun_fft(2:end-1) = 2*gun_fft(2:end-1);
    f = fs*(0:(length(gun)/2))/length(gun);
    subplot(3,2,1);plot(gun);xlabel('t / s');
    subplot(3,2,2);plot(f,gun_fft);title('spectrum');xlabel('frequency / Hz');

    % 低通滤波
    fc = 1000; % 截止频率
    [b,a] = butter(3,fc/(fs/2));
    figure(10);
    freqz(b,a);
    figure(i);
    gun_filtered = filter(b,a,gun);
    
    subplot(3,2,3);plot(gun_filtered);
    p2 = abs(fft(gun_filtered)/length(gun_filtered));
    filter_fft = p2(1:length(gun_filtered)/2+1);
    filter_fft(2:end-1) = 2*filter_fft(2:end-1);
    f = fs*(0:(length(gun_filtered)/2))/length(gun_filtered);
    subplot(3,2,4);plot(f,filter_fft);
    
    % 均值滤波
    wnd = 1000; % 阶数
    b = (1/wnd)*ones(1,wnd);
    a = 1;
    figure(i);
    sm = filter(b,a,gun);
    
    subplot(3,2,5);plot(sm);
    p2 = abs(fft(sm)/length(sm));
    sm_fft = p2(1:length(sm)/2+1);
    sm_fft(2:end-1) = 2*sm_fft(2:end-1);
    f = fs*(0:(length(sm)/2))/length(sm);
    subplot(3,2,6);plot(f,sm_fft);

end