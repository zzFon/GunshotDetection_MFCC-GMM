

for ii = 1:24 % 7 8 wav分别为背景声和背景+枪声，21-24是爆炸声
    if 8 < ii &&  ii < 21
        continue;
    end
    
    % 取信号
    file_name = strcat('gun',num2str(ii));
    file_name = strcat(file_name,'.wav');
    fprintf('reading %s...\n',file_name);
    [y,fs] = audioread(file_name);   
    sz = size(y);
    gun = (y(:,1))'; % 单声道
    
    % 原信号
    figure(ii);
    p2 = abs(fft(gun)/length(gun));
    % size(gun)
    % size(1:length(gun)/2+1)
    gun_fft = p2(1:length(gun)/2+1);
    gun_fft(2:end-1) = 2*gun_fft(2:end-1);
    f = fs*(0:(length(gun)/2))/length(gun);
    subplot(3,2,1);plot(gun);xlabel('t / s');title('signal');
    subplot(3,2,2);plot(f,gun_fft);title('spectrum');xlabel('frequency / Hz');
        
    % 短时能量分析
    N = 300; % 窗宽（张克刚）
    inc = 100; % 帧移（张克刚）
    win = hamming(N);
    % frameout: num x N 
    % t: num x 1, centers of frames
    % energy: 1 x num
    [frameout,t,energy]=enframe(y,win,inc);
    t = t';
    
    % 自适应短时能量阈值分割
    %size(energy)
    threshold = min(energy)+0.2*(max(energy)-min(energy));
    processed_energy = energy;
    for i = 1:length(energy)
        processed_energy(i) = 0;
        if energy(i) >= threshold 
            processed_energy(i) = 1;
        end
        %fprintf('%d: %f > %f = %d\n',ii,energy(i),threshold,processed_energy(i));
    end
    
    subplot(3,2,3); plot(energy,'b');title('energy');
    hold on;plot(threshold*ones(size(energy)),'g');
    subplot(3,2,5); plot(processed_energy);title('binarized energy')
    
    % 持续时间分析
    thr = 30; % 持续采样点
    cnt = 0;
    for i = 1:length(processed_energy)
        if processed_energy(i) == 1
            if cnt > 0
                cnt = cnt+1; %计数器累加
            elseif cnt == 0
                cnt = 1; %初始化计数器
            end
            if i == length(processed_energy) && cnt < thr
                processed_energy((i-cnt):i) = 0;
            end
        elseif processed_energy(i) == 0
            if cnt > 0
                if cnt < thr
                    processed_energy((i-cnt):i) = 0;
                end
            end
            cnt = 0;
        end
        %fprintf('%f, %f\n',i,processed_energy(i));
    end
    
    subplot(3,2,3);hold on;plot(processed_energy*max(energy),'r');hold off;
    subplot(3,2,5);hold on;plot(processed_energy,'r');hold off;

end
