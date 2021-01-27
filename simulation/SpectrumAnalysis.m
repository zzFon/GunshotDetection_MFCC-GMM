


for i = 1:6
%     file_name = strcat('dataset_horn',num2str(i));
%     file_name = strcat(file_name,'.wav');
%     fprintf('reading %s...\n',file_name);
%     [y,fs] = audioread(file_name);   
%     sz = size(y);
%     if sz(2) > 1
%         gun = ((y(:,1)+y(:,2))/2)'; % 多声道，只要一个
%     elseif sz(1) == 1
%         gun = (y(:,1))'; % 单声道
%     end
    gun = data_gun(1,:);
    
    %figure(i);
    figure(1);
    p2 = abs(fft(gun)/length(gun));
    gun_fft = p2(1:length(gun)/2+1);
    gun_fft(2:end-1) = 2*gun_fft(2:end-1);
    f = fs*(0:(length(gun)/2))/length(gun);
    %subplot(1,2,1);plot(gun);xlabel('t / s');
    %subplot(1,2,2);
    subplot(3,2,i);plot(gun_fft);title('spectrum');xlabel('frequency / Hz');
end