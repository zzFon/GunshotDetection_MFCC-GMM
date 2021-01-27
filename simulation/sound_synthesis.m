

% 先运行 files_reading.m

bkg = background(1,1:end/5); % 源背景声太长了

figure(1);
p2 = abs(fft(bkg/length(bkg)));
bkg_fft = p2(1:length(bkg)/2+1);
bkg_fft(2:end-1) = 2*bkg_fft(2:end-1);
subplot(3,2,1);plot(bkg(1,:));subplot(3,2,2);plot(bkg_fft);
fprintf('length of bkg = %f\n',length(bkg(1,:)));
insert = floor((length(bkg(1,:)-4*length(gun0)))*rand(1));
fprintf('length of gun0 = %f\n',length(gun0));
fprintf('insert = %f\n',insert);
mixed = bkg(1,:);
for i = 1:1:length(bkg(1,:))
    if 0 < i-insert && i-insert <= length(gun0)
        mixed(i) = mixed(i)+gun0(i-insert);
    end
end
p2 = abs(fft(gun0/length(gun0)));
gun0_fft = p2(1:length(gun0)/2+1);
gun0_fft(2:end-1) = 2*gun0_fft(2:end-1);
subplot(3,2,3);plot(gun0);subplot(3,2,4);plot(gun0_fft);
p2 = abs(fft(mixed/length(gun0)));
mixed_fft = p2(1:length(mixed)/2+1);
mixed_fft(2:end-1) = 2*mixed_fft(2:end-1);
subplot(3,2,5);plot(mixed);subplot(3,2,6);plot(mixed_fft);
player = audioplayer(mixed,fs);
player.play;

% audiowrite('s1.wav',mixed,fs);