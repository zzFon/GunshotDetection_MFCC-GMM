

% first run FileReading
% so that data_gun, data_explosion ara loaded
% num_gun, num_explosion are defined in FileReading

close all;
% 提取枪声
segments_gun = zeros(num_gun,maxlen_gun);
piece_num_gun = 0;
piece_gun = cell(1,20);
for ii = 1:num_explosion
    
    figure(1);
%     p2 = abs(fft(data_gun(ii,:))/length(data_gun(ii,:)));
%     gun_fft = p2(1:length(data_gun(ii,:))/2+1);
%     gun_fft(2:end-1) = 2*gun_fft(2:end-1);
%     f = fs*(0:(length(data_gun(ii,:))/2))/length(data_gun(ii,:));
%     subplot(4,3,6+ii);plot(f,gun_fft);title('spectrum');xlabel('frequency / Hz');
    subplot(4,3,ii);
    plot(data_gun(ii,:));xlabel('t / s');title('gun');

    % 加窗分帧：短时能量计算 & 短时过零率计算 
    N = 300; % 窗宽（张克刚）
    inc = 100; % 帧移（张克刚）
    win = hamming(N);
    [frameout,t,energy,zcr] = enframe(data_gun(ii,:),win,inc);
    t = t';
    subplot(4,3,6+ii);hold on;plot(energy,'b');title('energy');hold off;
    figure(11);
    subplot(4,3,ii);plot(zcr);title('zcr');
    figure(1);
    
     % 均值滤波
    wnd = 50; % 阶数
    b = (1/wnd)*ones(1,wnd);
    a = 1;
    sm = filter(b,a,energy);
    subplot(4,3,6+ii);hold on;plot(sm,'k');hold off;
    energy = sm;
    sm_zcr = filter(b,a,zcr);
    figure(11);
    subplot(4,3,ii);hold on;plot(sm_zcr,'k');title('zcr');hold off;
    figure(1);
    
    % 自适应短时能量阈值分割
    threshold = min(energy)+0.2*(max(energy)-min(energy));
    processed_energy = energy;
    for i = 1:length(energy)
        processed_energy(i) = 0;
        if energy(i) >= threshold 
            processed_energy(i) = 1;
        end
    end
    
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
            if i == length(processed_energy)
                if cnt < thr
                    processed_energy((i-cnt):i) = 0;
                end
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
    
    hold on;plot(threshold*ones(size(energy)),'g');hold off;
    subplot(4,3,6+ii);hold on;plot(processed_energy*max(energy),'r');hold off;
    %subplot(3,2,5);hold on;plot(processed_energy,'r');hold off;
    
    % 片段分割
    segments = processed_energy.*t;
    min_seg = length(segments);
    max_seg = 0;
    piece_start = 0;
    piece_end = 0;
    for i = 1:length(segments)
        if 0 < segments(i) && segments(i) < min_seg
            min_seg = segments(i);
        end
        if max_seg < segments(i)
            max_seg = segments(i);
        end
        
        if i+1 <= length(segments)
            if segments(i) == 0 && segments(i+1) > 0
                piece_start = segments(i+1);
            end
        end
        if 1 <= i-1
            if  segments(i-1) > 0 && segments(i) == 0
                piece_end = segments(i-1);
                piece_num_gun = piece_num_gun+1;
                piece_gun{1,piece_num_gun} = data_gun(ii,piece_start:piece_end);
                figure(2);
                subplot(4,5,piece_num_gun);
%                 piece_start = ceil(piece_start-N/2);
%                 piece_end = floor(piece_end+N/2);
                plot(data_gun(ii,piece_start:piece_end));
                title('piece');
                fprintf('piece: %d of gun record %d, from %d to %d\n',piece_num_gun,ii,piece_start,piece_end);
                figure(1);
                subplot(4,3,ii);
                hold on;plot(piece_start:piece_end,data_gun(ii,piece_start:piece_end),'r');hold off;
              
%                 figure(12);subplot(4,5,piece_num_gun);
%                 p2 = abs(fft(data_gun(ii,piece_start:piece_end))/length(data_gun(ii,piece_start:piece_end)));
%                 piece_fft = p2(1:length(data_gun(ii,piece_start:piece_end))/2+1);
%                 piece_fft(2:end-1) = 2*piece_fft(2:end-1);
%                 f = fs*(0:(length(data_gun(ii,piece_start:piece_end))/2))/length(data_gun(ii,piece_start:piece_end));
%                 plot(piece_fft);title('spectrum');xlabel('frequency / Hz');
            end
        end
    end
    figure(1);
    
%     segments_gun = zeros(size(data_gun(ii,:)));
%     segments_gun(floor(min_seg-N/2):ceil(max_seg+N/2)) = 1;
%     seg = data_gun(ii,:).*segments_gun;

%     subplot(4,3,ii);
%     hold on;
%     plot(floor(min_seg-N/2):ceil(max_seg+N/2),data_gun(ii,floor(min_seg-N/2):ceil(max_seg+N/2)),'r');
%     hold off;
%     st = floor(min_seg-N/2);
%     en = ceil(max_seg+N/2);
%     segments_gun(ii,5000:5000+length(data_gun(ii,st:en))-1) = data_gun(ii,st:en);

%     figure(3);
%     subplot(4,3,6+ii);plot(segments_gun(ii,:));
    
end

% 提取爆炸
segments_explosion = zeros(num_explosion,maxlen_explosion);
piece_num_explosion = 0;
piece_explosion = cell(1,30);
for ii = 1:num_explosion
    
    figure(3);
%     p2 = abs(fft(data_explosion(ii,:))/length(data_explosion(ii,:)));
%     explosion_fft = p2(1:length(data_explosion(ii,:))/2+1);
%     explosion_fft(2:end-1) = 2*explosion_fft(2:end-1);
%     f = fs*(0:(length(data_explosion(ii,:))/2))/length(data_explosion(ii,:));
%     subplot(4,3,6+ii);plot(f,explosion_fft);title('spectrum');xlabel('frequency / Hz');
    subplot(4,3,ii);
    plot(data_explosion(ii,:));xlabel('t / s');title('explosion');
    
    
    % 短时能量分析
    N = 300; % 窗宽（张克刚）
    inc = 100; % 帧移（张克刚）
    win = hamming(N);
    [frameout,t,energy,zcr] = enframe(data_explosion(ii,:),win,inc);
    t = t';
    subplot(4,3,6+ii);hold on;plot(energy,'b');title('energy');hold off;
    figure(13);
    subplot(4,3,ii);plot(zcr);title('zcr');
    figure(3);

     % 均值滤波
    wnd = 50; % 阶数
    b = (1/wnd)*ones(1,wnd);
    a = 1;
    sm = filter(b,a,energy);
    subplot(4,3,6+ii);hold on;plot(sm,'k');hold off;
    energy = sm;
    sm_zcr = filter(b,a,zcr);
    figure(13);
    subplot(4,3,ii);hold on;plot(sm_zcr,'k');title('zcr');hold off;
    figure(3);
    
    % 自适应短时能量阈值分割
    threshold = min(energy)+0.2*(max(energy)-min(energy));
    processed_energy = energy;
    for i = 1:length(energy)
        processed_energy(i) = 0;
        if energy(i) >= threshold 
            processed_energy(i) = 1;
        end
    end
    
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
            if i == length(processed_energy)
                if cnt < thr
                    processed_energy((i-cnt):i) = 0;
                end
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
    
    hold on;plot(threshold*ones(size(energy)),'g');hold off;
    subplot(4,3,6+ii);hold on;plot(processed_energy*max(energy),'r');hold off;
    %subplot(3,2,5);hold on;plot(processed_energy,'r');hold off;
    
    % 片段分割
    segments = processed_energy.*t;
    min_seg = length(segments);
    max_seg = 0;
    for i = 1:length(segments)
        if 0 < segments(i) && segments(i) < min_seg
            min_seg = segments(i);
        end
        if max_seg < segments(i)
            max_seg = segments(i);
        end
        
        if i+1 <= length(segments)
            if segments(i) == 0 && segments(i+1) > 0
                piece_start = segments(i+1);
            end
        end
        if 1 <= i-1
            if  segments(i-1) > 0 && segments(i) == 0
                piece_end = segments(i-1);
                piece_num_explosion = piece_num_explosion+1;
                piece_explosion{1,piece_num_explosion} = data_explosion(ii,piece_start:piece_end);
                figure(4);
                subplot(4,5,piece_num_explosion);
%                 piece_start = ceil(piece_start-N/2);
%                 piece_end = floor(piece_end+N/2);
                plot(data_explosion(ii,piece_start:piece_end));
                title('piece');
                fprintf('piece: %d of explosion record %d, from %d to %d\n',piece_num_explosion,ii,piece_start,piece_end);
                figure(3);
                subplot(4,3,ii);
                hold on;plot(piece_start:piece_end,data_explosion(ii,piece_start:piece_end),'r');hold off;
              
%                 figure(14);subplot(4,5,piece_num_explosion);
%                 p2 = abs(fft(data_explosion(ii,piece_start:piece_end))/length(data_explosion(ii,piece_start:piece_end)));
%                 piece_fft = p2(1:length(data_explosion(ii,piece_start:piece_end))/2+1);
%                 piece_fft(2:end-1) = 2*piece_fft(2:end-1);
%                 f = fs*(0:(length(data_explosion(ii,piece_start:piece_end))/2))/length(data_explosion(ii,piece_start:piece_end));
%                 plot(piece_fft);title('spectrum');xlabel('frequency / Hz');
            end
        end
    end
    figure(3);
    
%     segments_gun = zeros(size(data_gun(ii,:)));
%     segments_gun(floor(min_seg-N/2):ceil(max_seg+N/2)) = 1;
%     seg = data_gun(ii,:).*segments_gun;

%     subplot(4,3,ii);
%     hold on;
%     plot(floor(min_seg-N/2):ceil(max_seg+N/2),data_explosion(ii,floor(min_seg-N/2):ceil(max_seg+N/2)),'r');
%     hold off;
%     st = floor(min_seg-N/2);
%     en = ceil(max_seg+N/2);
%     segments_explosion(ii,5000:5000+length(data_explosion(ii,st:en))-1) = data_explosion(ii,st:en);

%     figure(3);
%     subplot(4,3,6+ii);plot(segments_explosion(ii,:));
    
end

% 提取喇叭
segments_horn = zeros(num_horn,maxlen_horn);
piece_num_horn = 0;
piece_horn = cell(1,30);
for ii = 1:num_horn
    
    figure(5);
%     p2 = abs(fft(data_horn(ii,:))/length(data_horn(ii,:)));
%     horn_fft = p2(1:length(data_horn(ii,:))/2+1);
%     horn_fft(2:end-1) = 2*horn_fft(2:end-1);
%     f = fs*(0:(length(data_horn(ii,:))/2))/length(data_horn(ii,:));
%     subplot(4,3,6+ii);plot(f,explosion_fft);title('spectrum');xlabel('frequency / Hz');
    subplot(4,3,ii);
    plot(data_horn(ii,:));xlabel('t / s');title('horn');

    % 短时能量分析
    N = 300; % 窗宽（张克刚）
    inc = 100; % 帧移（张克刚）
    win = hamming(N);
    [frameout,t,energy,zcr] = enframe(data_horn(ii,:),win,inc);
    t = t';
    subplot(4,3,6+ii);hold on;plot(energy,'b');title('energy');hold off;
    figure(15);
    subplot(4,3,ii);plot(zcr);title('zcr');
    figure(5);
    
     % 均值滤波
    wnd = 30; % 阶数
    b = (1/wnd)*ones(1,wnd);
    a = 1;
    sm = filter(b,a,energy);
    subplot(4,3,6+ii);hold on;plot(sm,'k');hold off;
    energy = sm;
    sm_zcr = filter(b,a,zcr);
    figure(15);
    subplot(4,3,ii);hold on;plot(sm_zcr,'k');title('zcr');hold off;
    figure(5);
    
    % 自适应短时能量阈值分割
    threshold = min(energy)+0.4*(max(energy)-min(energy));
    processed_energy = energy;
    for i = 1:length(energy)
        processed_energy(i) = 0;
        if energy(i) >= threshold 
            processed_energy(i) = 1;
        end
    end
    
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
            if i == length(processed_energy)
                if cnt < thr
                    processed_energy((i-cnt):i) = 0;
                end
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
    
    hold on;plot(threshold*ones(size(energy)),'g');hold off;
    subplot(4,3,6+ii);hold on;plot(processed_energy*max(energy),'r');hold off;
    %subplot(3,2,5);hold on;plot(processed_energy,'r');hold off;
    
    % 片段分割
    segments = processed_energy.*t;
    min_seg = length(segments);
    max_seg = 0;
    for i = 1:length(segments)
        if 0 < segments(i) && segments(i) < min_seg
            min_seg = segments(i);
        end
        if max_seg < segments(i)
            max_seg = segments(i);
        end
        
        if i+1 <= length(segments)
            if segments(i) == 0 && segments(i+1) > 0
                piece_start = segments(i+1);
            end
        end
        if 1 <= i-1
            if  segments(i-1) > 0 && segments(i) == 0
                piece_end = segments(i-1);
                piece_num_horn = piece_num_horn+1;
                piece_horn{1,piece_num_horn} = data_horn(ii,piece_start:piece_end);
                figure(6);
                subplot(4,5,piece_num_horn);
%                 piece_start = ceil(piece_start-N/2);
%                 piece_end = floor(piece_end+N/2);
                plot(data_horn(ii,piece_start:piece_end));
                title('piece');
                fprintf('piece: %d of horn record %d, from %d to %d\n',piece_num_horn,ii,piece_start,piece_end);
                figure(5);
                subplot(4,3,ii);
                hold on;plot(piece_start:piece_end,data_horn(ii,piece_start:piece_end),'r');hold off;
              
%                 figure(16);subplot(4,5,piece_num_horn);
%                 p2 = abs(fft(data_horn(ii,piece_start:piece_end))/length(data_horn(ii,piece_start:piece_end)));
%                 piece_fft = p2(1:length(data_explosion(ii,piece_start:piece_end))/2+1);
%                 piece_fft(2:end-1) = 2*piece_fft(2:end-1);
%                 f = fs*(0:(length(data_horn(ii,piece_start:piece_end))/2))/length(data_horn(ii,piece_start:piece_end));
%                 plot(piece_fft);title('spectrum');xlabel('frequency / Hz');
            end
        end
    end
    figure(5);
    
%     segments_gun = zeros(size(data_gun(ii,:)));
%     segments_gun(floor(min_seg-N/2):ceil(max_seg+N/2)) = 1;
%     seg = data_gun(ii,:).*segments_gun;

%     subplot(4,3,ii);
%     hold on;
%     plot(floor(min_seg-N/2):ceil(max_seg+N/2),data_horn(ii,floor(min_seg-N/2):ceil(max_seg+N/2)),'r');
%     hold off;
%     st = floor(min_seg-N/2);
%     en = ceil(max_seg+N/2);
%     segments_horn(ii,5000:5000+length(data_horn(ii,st:en))-1) = data_horn(ii,st:en);

%     figure(3);
%     subplot(4,3,6+ii);plot(segments_explosion(ii,:));
    
end
