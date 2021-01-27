

% close all;
% for ii = 1:6
%     figure(1);
%     subplot(3,2,ii);
%     filename = strcat('dataset_gun',num2str(ii));
%     filename = strcat(filename,'.wav');
%     [Y,fs]=audioread(filename);  %读取音频文件lantian.wav
%         %Y为读到的双声道数据
%         %fs为采样频率
%     info=audioinfo(filename)      %audioinfo 函数返回音频的信息情况。
%     sound(Y,fs)   %播放语音
% 
%     Y1 = Y(:,1);        %Y为双声道数据，取第2通道
%     figure(1)
%     plot(Y1)          %画Y1波形图
%     title('gun')
%     grid on;
% 
%     figure(2)
%     subplot(3,2,ii);
%     spectrogram(Y1,256,128,256,16000,'yaxis');
%     %[S,F,T,P]=spectrogram(x,window,noverlap,nfft,fs)
%     % [S,F,T,P]=spectrogram(x,window,noverlap,F,fs)
%     %x---输入信号的向量。默认情况下，即没有后续输入参数，x将被分成8段分别做变换处理，
%     % 如果x不能被平分成8段，则会做截断处理。默认情况下，其他参数的默认值为
%     % window---窗函数，默认为nfft长度的海明窗Hamming,如果window为一个整数，每段长度为window，每段使用Hamming窗函数加窗。
%     % noverlap---每一段的重叠样本数，默认值是在各段之间产生50%的重叠,它必须为一个小于window或length(window)的整数
%     % nfft---做FFT变换的长度，默认为256和大于每段长度的最小2次幂之间的最大值。
%     % 另外，此参数除了使用一个常量外，还可以指定一个频率向量F
%     % fs---采样频率，默认值归一化频率
%     % spectrogram(...,'freqloc')使用freqloc字符串可以控制频率轴显示的位置。
%     % 当freqloc=xaxis时，频率轴显示在x轴上，当freqloc=yaxis时，频率轴显示在y轴上，默认是显示在x轴上。如果在指定freqloc的同时，又有输出变量，则freqloc将被忽略。
%     % F---在输入变量中使用F频率向量，函数会使用Goertzel方法计算在F指定的频率处计算频谱图。
%     % 指定的频率被四舍五入到与信号分辨率相关的最近的DFT容器(bin)中。而在其他的使用nfft
%     % 语法中，短时傅里叶变换方法将被使用。对于返回值中的F向量，为四舍五入的频率，其长度
%     % 等于S的行数。
%     % T---频谱图计算的时刻点，其长度等于上面定义的k，值为所分各段的中点。
%     % P---能量谱密度PSD(Power Spectral Density)，对于实信号，P是各段PSD的单边周期估计；
%     xlabel('时间(s)');
%     ylabel('频率(Hz)');
%     title('gun');
% end
% 
% for ii = 1:6
%     figure(3);
%     subplot(3,2,ii);
%     filename = strcat('dataset_explosion',num2str(ii));
%     filename = strcat(filename,'.wav');
%     [Y,fs]=audioread(filename);  %读取音频文件lantian.wav
%         %Y为读到的双声道数据
%         %fs为采样频率
%     info=audioinfo(filename)      %audioinfo 函数返回音频的信息情况。
%     sound(Y,fs)   %播放语音
% 
%     Y1 = Y(:,1);        %Y为双声道数据，取第2通道
%     figure(3)
%     plot(Y1)          %画Y1波形图
%     title('explosion')
%     grid on;
% 
%     figure(4);
%     subplot(3,2,ii);
%     spectrogram(Y1,256,128,256,16000,'yaxis');
%     %[S,F,T,P]=spectrogram(x,window,noverlap,nfft,fs)
%     % [S,F,T,P]=spectrogram(x,window,noverlap,F,fs)
%     %x---输入信号的向量。默认情况下，即没有后续输入参数，x将被分成8段分别做变换处理，
%     % 如果x不能被平分成8段，则会做截断处理。默认情况下，其他参数的默认值为
%     % window---窗函数，默认为nfft长度的海明窗Hamming,如果window为一个整数，每段长度为window，每段使用Hamming窗函数加窗。
%     % noverlap---每一段的重叠样本数，默认值是在各段之间产生50%的重叠,它必须为一个小于window或length(window)的整数
%     % nfft---做FFT变换的长度，默认为256和大于每段长度的最小2次幂之间的最大值。
%     % 另外，此参数除了使用一个常量外，还可以指定一个频率向量F
%     % fs---采样频率，默认值归一化频率
%     % spectrogram(...,'freqloc')使用freqloc字符串可以控制频率轴显示的位置。
%     % 当freqloc=xaxis时，频率轴显示在x轴上，当freqloc=yaxis时，频率轴显示在y轴上，默认是显示在x轴上。如果在指定freqloc的同时，又有输出变量，则freqloc将被忽略。
%     % F---在输入变量中使用F频率向量，函数会使用Goertzel方法计算在F指定的频率处计算频谱图。
%     % 指定的频率被四舍五入到与信号分辨率相关的最近的DFT容器(bin)中。而在其他的使用nfft
%     % 语法中，短时傅里叶变换方法将被使用。对于返回值中的F向量，为四舍五入的频率，其长度
%     % 等于S的行数。
%     % T---频谱图计算的时刻点，其长度等于上面定义的k，值为所分各段的中点。
%     % P---能量谱密度PSD(Power Spectral Density)，对于实信号，P是各段PSD的单边周期估计；
%     xlabel('时间(s)');
%     ylabel('频率(Hz)');
%     title('explosion');
% end
% 
for ii = 1:6
%     figure(5);
%     subplot(3,2,ii);
%     filename = strcat('a',num2str(ii));
%     filename = strcat(filename,'.wav');
    filename = 'horn.wav'
    [Y,fs]=audioread(filename);  %读取音频文件lantian.wav
        %Y为读到的双声道数据
        %fs为采样频率
    info=audioinfo(filename)      %audioinfo 函数返回音频的信息情况。
    sound(Y,fs)   %播放语音

    Y1 = Y(:,1);        %Y为双声道数据，取第2通道
    figure(5)
    plot(Y1)          %画Y1波形图
    title('background')
    grid on;

    figure(6);
    subplot(3,2,ii);
    spectrogram(Y1,256,128,256,16000,'yaxis');
    %[S,F,T,P]=spectrogram(x,window,noverlap,nfft,fs)
    % [S,F,T,P]=spectrogram(x,window,noverlap,F,fs)
    %x---输入信号的向量。默认情况下，即没有后续输入参数，x将被分成8段分别做变换处理，
    % 如果x不能被平分成8段，则会做截断处理。默认情况下，其他参数的默认值为
    % window---窗函数，默认为nfft长度的海明窗Hamming,如果window为一个整数，每段长度为window，每段使用Hamming窗函数加窗。
    % noverlap---每一段的重叠样本数，默认值是在各段之间产生50%的重叠,它必须为一个小于window或length(window)的整数
    % nfft---做FFT变换的长度，默认为256和大于每段长度的最小2次幂之间的最大值。
    % 另外，此参数除了使用一个常量外，还可以指定一个频率向量F
    % fs---采样频率，默认值归一化频率
    % spectrogram(...,'freqloc')使用freqloc字符串可以控制频率轴显示的位置。
    % 当freqloc=xaxis时，频率轴显示在x轴上，当freqloc=yaxis时，频率轴显示在y轴上，默认是显示在x轴上。如果在指定freqloc的同时，又有输出变量，则freqloc将被忽略。
    % F---在输入变量中使用F频率向量，函数会使用Goertzel方法计算在F指定的频率处计算频谱图。
    % 指定的频率被四舍五入到与信号分辨率相关的最近的DFT容器(bin)中。而在其他的使用nfft
    % 语法中，短时傅里叶变换方法将被使用。对于返回值中的F向量，为四舍五入的频率，其长度
    % 等于S的行数。
    % T---频谱图计算的时刻点，其长度等于上面定义的k，值为所分各段的中点。
    % P---能量谱密度PSD(Power Spectral Density)，对于实信号，P是各段PSD的单边周期估计；
    xlabel('时间(s)');
    ylabel('频率(Hz)');
    title('background');
end


