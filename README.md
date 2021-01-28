# 室外公共场所突发安全事件声学检测系统
基于MFCC+GMM的声学事件检测(SED), MATLAB实现, 课程设计, 2020夏
## 介绍 - Introduction
本项目针对街道与交通道路场景，设计了一套用于突发公共安全事件识别的声学检测算法(以枪击、爆炸为例)。依次通过信号滤波、能量分析、MFCC特征提取、GMM分类器等环节实现声学事件检测。更多细节请查看文件：课题报告-室外公共场所突发安全事件声学检测系统.pdf  
**项目名称**：室外公共场所突发安全事件声学检测系统   
**课题来源**：检测技术及系统设计(seminar)，2020夏季学期，东南大学/仪器科学与工程学院  
**完成人**：招梓枫，林涵  
**指导老师**：李煊鹏博士  
<img src="https://github.com/zzFon/GunshotDetection_MFCC-GMM/blob/main/Presentation%26Report/GunDivision.png" width = "200" height = "200" alt="" align=center />
<img src="https://github.com/zzFon/GunshotDetection_MFCC-GMM/blob/main/Presentation%26Report/ExplosionDivision.png" width = "200" height = "200" alt="" align=center />
<img src="https://github.com/zzFon/GunshotDetection_MFCC-GMM/blob/main/Presentation%26Report/HornDivision.png" width = "200" height = "200" alt="" align=center />

## MATLAB程序 - Programmes
**以下程序建议按所列顺序运行**  
**FileReading.m**：音频文件读入，依次载入环境背景声、枪声、爆炸声、车鸣声  
**sound_synthesis.m**：按一定信噪比随机混合环境背景声、枪声、爆炸声、车鸣声，得到的混合声用于模型的测试   
**SpectrumAnalysis.m & LowpassAnalysis.m**：频谱分析，设计用于预处理的Butterworth滤波器  
**EnergyAnalysis.m**：能量分析，定位大功率前景信号(枪声、爆炸声、车鸣声)  
**SegmentExtraction.m**：在能量分析基础上做端点检测，实现大功率前景声(枪声/爆炸声/车鸣声)和环境背景声(干扰)的分离  
**TrainingGMM**：计算MFCC特征，并训练3个GMM分别对枪声(目标)、爆炸声(干扰)、车鸣声(干扰)进行识别  
**recog.m**：用先前获得的混合声对训练好的GMM进行测试

## 参考文献 - Reference
* **Mesaros, Annamaria , T. Heittola , and T. Virtanen . "TUT database for acoustic scene classification and sound event detection." Signal Processing Conference IEEE, 2016.** 
* **APimentel, B. A. , & André C.P.L.F. de Carvalho. (0). A meta-learning approach for recommending the number of clusters for clustering algorithms - sciencedirect. Knowledge-Based Systems, 195.**
* **张克刚, & 叶湘滨. (2015). 基于短时能量和小波去噪的枪声信号检测方法. 电磁测量与仪表学术发展方向主题研讨会.**
* 蒋小为等. 枪声信号分析与预处理[C]// 中国声学学会第十一届青年学术会议会议论文集. 中国声学学会, 2015.
* 吴松林, 杨杰, 林晓东,等. 声定位系统中的弹道波信号分析及弹道矢量计算[J]. 探测与控制学报, 2009, 31(2):54-58.  
* 朱强强. 公共场所下的枪声检测研究[D].
* Chacon-Rodriguez, Alfonso, Julian, Pedro, Castro, & Liliana, et al. (2011). Evaluation of gunshot detection algorithms. IEEE Transactions on Circuits & Systems. Part I: Regular Papers.
* 王俊丰, 贾晓霞, 李志强. 基于K-means算法改进的短文本聚类研究与实现[J]. 信息技术, 2019, v.43;No.337(12):84-88.

## 文件组织 - Files
/PaperReading：参考文献  
/Presentation&Report：报告&答辩附件材料  
/simulation：MATLAB算法程序  
/课题报告-室外公共场所突发安全事件声学检测系统.pdf：课题报告pdf终稿  
/课题答辩-PresentationPPT.pdf：课题答辩PPT终稿  



