

% first run FileReading & SegmentExtraction
clear all;
close all;
FileReading;close all;
SegmentExtraction;close all;

Spk_num = 3; %说话人个数
Tra_start = 1;
Tra_end = 6;  %每个说话人用于训练的语音数目

ncentres = 5; %混合成分数目
% fs = 16000; %采样频率


% -- 训练 ---
% load tra_data.mat; 
% load bkg.mat;
% load gun.mat
cnt = 0;
for spk_cyc = 1:Spk_num    % 遍历说话人
  fprintf('training for speaker %i\n',spk_cyc);
  tag1=1;tag2=1; %用于汇总存储mfcc
  
  for sph_cyc = Tra_start:Tra_end  % 遍历语音
     % speech = tdata{spk_cyc}{sph_cyc}; 
     % size(background)
     fprintf('pre-processing data %d\n',sph_cyc);
     if spk_cyc == 1
      	%speech = segments_gun(sph_cyc,:);
%         if sph_cyc <= 6
            speech = piece_gun{1,sph_cyc};
%         else
%             speech = piece_explosion{1,sph_cyc-6};
%         end
        figure(90);
        subplot(3,4,sph_cyc);plot(speech);
     elseif spk_cyc == 2
        %speech = segments_horn(sph_cyc,:);
        speech = piece_explosion{1,sph_cyc};
        figure(91);
        subplot(3,4,sph_cyc);plot(speech);
     elseif spk_cyc == 3
        speech = piece_horn{1,sph_cyc};
        figure(92);
        subplot(3,4,sph_cyc);plot(speech);
     end
     cnt = cnt+1;
%      figure(90);
%      subplot(4,3,cnt);plot(speech);
     
      %---预处理,特征提取--
     %pre_sph=filter([1 -0.97],1,speech); % 预加重
     pre_sph = speech;
     win_type='M'; %汉明窗
     cof_num=20; %倒谱系数个数
     frm_len=fs*0.02; %帧长：20ms
     fil_num=20; %滤波器组个数
     frm_off=fs*0.01; %帧移：10ms
     
%      figure(spk_cyc);
%      subplot(3,2,sph_cyc);plot(speech);
%      player = audioplayer(pre_sph,fs);
%      player.play;
%      pause(3);
     
     c=melcepst(pre_sph,fs,win_type,cof_num,fil_num,frm_len,frm_off); % mfcc特征提取
     %size(c)
     cc=c(:,1:end-1)';
     tag2=tag1+size(cc,2);
     cof(:,tag1:tag2-1)=cc;
     tag1=tag2;
     
     if spk_cyc == 1
        figure(101);
        subplot(3,2,sph_cyc);plot(c);title('MFCC');
     elseif spk_cyc == 2
        figure(102);
        subplot(3,2,sph_cyc);plot(c);title('MFCC');
     elseif spk_cyc == 3
        figure(103);
        subplot(3,2,sph_cyc);plot(c);title('MFCC');
     end
  end
   
  %--- 训练GMM模型---
  kiter=5; %Kmeans的最大迭代次数
  emiter=30; %EM算法的最大迭代次数
  fprintf('initializing GMM...\n');
  max_ncentres = 20;%搜索最有核数目
  mix = gmm_init(ncentres,cof',kiter,'full'); % GMM的初始化
  fprintf('training GMM...\n');
  [mix,post,errlog]=gmm_em(mix,cof',emiter); % GMM的参数估计
  speaker{spk_cyc}.pai=mix.priors;
  speaker{spk_cyc}.mu=mix.centres;
  speaker{spk_cyc}.sigma=mix.covars;

  clear cof mix;
end
fprintf('FINISHED!\n\n',spk_cyc);
save speaker.mat speaker;


% -- 识别 ---
% clear all;
% load rec_data.mat;  % 载入待识别语音
% load speaker.mat;   % 载入训练好的模型
% Spk_num = 3; %说话人个数
Tes_start = 1;
Tes_end = 6;  %每个说话人待识别的语音数目
% fs=16000; %采样频率
% ncentres=16; %混合成分数目

% load bkg.mat;
% load gun.mat;
for spk_cyc=1:Spk_num    % 遍历说话人
  for sph_cyc = Tes_start:Tes_end  % 遍历语音
     fprintf('detecting speaker %i, record %i\n',spk_cyc,sph_cyc); 
     %speech = rdata{spk_cyc}{sph_cyc};
     %speech = background(spk_cyc*sph_cyc,:);
     if spk_cyc == 1
      	%speech = segments_gun(sph_cyc,:);
%         if sph_cyc <= 6
            speech = piece_gun{1,sph_cyc};
%         else
%             speech = piece_explosion{1,sph_cyc-6};
%         end
     elseif spk_cyc == 2
        %speech = segments_horn(sph_cyc,:);
         speech = piece_explosion{1,sph_cyc};
     elseif spk_cyc == 3
         speech = piece_horn{1,sph_cyc};
     end
     
     fprintf('pre-processing...\n');
     %---预处理,特征提取--
     %pre_sph=filter([1 -0.97],1,speech);
     pre_sph = speech;
     win_type='M'; %汉明窗
     cof_num=20; %倒谱系数个数
     frm_len=fs*0.02; %帧长：20ms
     fil_num=20; %滤波器组个数
     frm_off=fs*0.01; %帧移：10ms
     c=melcepst(pre_sph,fs,win_type,cof_num,fil_num,frm_len,frm_off); %(帧数)*(cof_num)
     cof=c(:,1:end-1); %M*D = M*20维矢量, M=10即每个滤波器的输出随10个余弦变换域上的点(广义频率变量)的变化
     
     fprintf('detecting...\n');
     %----识别---
     MLval=zeros(size(cof,1),Spk_num);
     for b=1:Spk_num %说话人循环
         pai=speaker{b}.pai;
         for k=1:ncentres 
           mu=speaker{b}.mu(k,:);
           sigma=speaker{b}.sigma(:,:,k);
           pdf=mvnpdf(cof,mu,sigma);
           %fprintf('GMM = %d, centre = %d, pdf = %d\n',b,k,pdf);
           MLval(:,b)=MLval(:,b)+pdf*pai(k); %计算似然值
           % 每个广义频点上的20个滤波器输出封装成1个向量
           % 所以对于每个声音片段输入，特征是10x20维的(10个广义频点及对应频点上的20个滤波器输出)
         end
    end
    logMLval=log((MLval)+eps);
    sumlog=sum(logMLval,1);
    [maxsl,idx]=max(sumlog); % 判决，将最大似然值对应的序号idx作为识别结果
    %sumlog
    fprintf('cluster likelihood: \n');
    sum(MLval,1)
    fprintf('result: this is speaker %i, ',idx);
    if idx == spk_cyc
        fprintf('Right!\n');
    else
        fprintf('Wrong!\n');
    end
     
  end
end








