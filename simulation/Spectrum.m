
% first run FileReading & SegmentExtraction

close all;
for i = 1:num_gun
    figure(1);
    subplot(4,3,i);plot(segments_gun(i,:),'r');
    
    subplot(4,3,6+i);
    spectrogram(segments_gun(i,:),256,128,256,16000,'yaxis');
    xlabel('时间(s)');
    ylabel('频率(Hz)');
    title('background');
    %colorbar;
end

for i = 1:num_explosion
    figure(2);
    subplot(4,3,i);plot(segments_explosion(i,:),'r');
    
    subplot(4,3,6+i);
    spectrogram(segments_explosion(i,:),256,128,256,16000,'yaxis');
    xlabel('时间(s)');
    ylabel('频率(Hz)');
    title('background');
    %colorbar;
end

for i = 1:num_horn
    figure(3);
    subplot(4,3,i);plot(segments_horn(i,:),'r');
    
    subplot(4,3,6+i);
    spectrogram(segments_horn(i,:),256,128,256,16000,'yaxis');
    xlabel('时间(s)');
    ylabel('频率(Hz)');
    title('background');
    %colorbar;
end