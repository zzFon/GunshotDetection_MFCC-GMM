
maxlen_background = 0;
maxlen_gun = 0;
maxlen_explosion = 0;
maxlen_horn = 0;
num_background = 6;
num_gun = 6;
num_explosion = 6;
num_horn = 6;
for i = 1:num_background
    file_name = strcat('dataset_background',num2str(i));
    file_name = strcat(file_name,'.wav');
    fprintf('checking %s...\n',file_name);
    [y1,fs] = audioread(file_name);
    if maxlen_background < length(y1(:,1))
        maxlen_background = length(y1(:,1));
    end
end
for i = 1:num_gun
    file_name = strcat('dataset_gun',num2str(i));
    file_name = strcat(file_name,'.wav');
    fprintf('checking %s...\n',file_name);
    [y1,fs] = audioread(file_name);
    if maxlen_gun < length(y1(:,1))
        maxlen_gun = length(y1(:,1));
    end
end
for i = 1:num_explosion
    file_name = strcat('dataset_explosion',num2str(i));
    file_name = strcat(file_name,'.wav');
    fprintf('checking %s...\n',file_name);
    [y2,fs] = audioread(file_name);
    if maxlen_explosion < length(y2(:,1))
        maxlen_explosion = length(y2(:,1));
    end
end
for i = 1:num_horn
    file_name = strcat('dataset_horn',num2str(i));
    file_name = strcat(file_name,'.wav');
    fprintf('checking %s...\n',file_name);
    [y3,fs] = audioread(file_name);
    if maxlen_horn < length(y3(:,1))
        maxlen_horn = length(y3(:,1));
    end
end
fprintf('\n');

close all;
data_background = 0.02*rand(num_background,maxlen_background+400);
for i = 1:num_gun   
    file_name = strcat('dataset_background',num2str(i));
    file_name = strcat(file_name,'.wav');
    fprintf('reading %s...\n',file_name);
    [y1,fs] = audioread(file_name);  
    sz = size(y1);
    data_background(i,300:300+(length(y1(:,1))-1)) = data_background(i,300:300+(length(y1(:,1))-1))+(y1(:,1))'; % 单声道
    figure(1);subplot(3,2,i);plot(data_background(i,:));
end

data_gun = 0.02*rand(num_gun,maxlen_gun+400);
for i = 1:num_gun   
    file_name = strcat('dataset_gun',num2str(i));
    file_name = strcat(file_name,'.wav');
    fprintf('reading %s...\n',file_name);
    [y1,fs] = audioread(file_name);  
    sz = size(y1);
    data_gun(i,300:300+(length(y1(:,1))-1)) = data_gun(i,300:300+(length(y1(:,1))-1))+(y1(:,1))'; % 单声道
    figure(2);subplot(3,2,i);plot(data_gun(i,:));
end

data_explosion = 0.02*rand(num_explosion,maxlen_explosion+400);
for i = 1:num_explosion
    file_name = strcat('dataset_explosion',num2str(i));
    file_name = strcat(file_name,'.wav');
    fprintf('reading %s...\n',file_name);
    [y2,fs] = audioread(file_name);  
    sz = size(y2);
    data_explosion(i,300:300+(length(y2(:,1))-1)) = data_explosion(i,300:300+(length(y2(:,1))-1))+(y2(:,1))'; % 单声道
    figure(3);subplot(3,2,i);plot(data_explosion(i,:));
end

data_horn = 0.02*rand(num_horn,maxlen_horn+400);
for i = 1:num_horn
    file_name = strcat('dataset_horn',num2str(i));
    file_name = strcat(file_name,'.wav');
    fprintf('reading %s...\n',file_name);
    [y3,fs] = audioread(file_name);  
    sz = size(y3);
    data_horn(i,300:300+(length(y3(:,1))-1)) = data_horn(i,300:300+(length(y3(:,1))-1))+(y3(:,1))'; % 单声道
    figure(4);subplot(3,2,i);plot(data_horn(i,:));
end
fprintf('\n');

fprintf('size of data_gun: ');
size(data_gun)
fprintf('\n');
fprintf('size of data_explosion: ');
size(data_explosion)
fprintf('\n');
fprintf('size of data_horn: ');
size(data_explosion)
fprintf('\n');



