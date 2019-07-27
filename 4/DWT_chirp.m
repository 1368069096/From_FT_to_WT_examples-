% 
clc;
clear;
close all;

w = 0:1:1000;
t = 0:0.001:10;
y = chirp(t,0,1,200);

feature = [];
wave_type = 'db1';

% case_1
Fs = 1000;
s = y(1:256);
Len = length(s);

% ����dwt���ֽ�
% ��1��ֽ�
[ca1, cd1] = dwt(s, wave_type);
a1 = upcoef('a', ca1, wave_type, 1, Len);
d1 = upcoef('d', cd1, wave_type, 1, Len); 
% ��ȡ����
cd1_max = max(cd1);
cd1_min = min(cd1);
d1_energy = sum(d1.^2)/(Fs/2)*2^1; % ��λƵ�ʵ�����
cd1_energy = sum(cd1.^2)/(Fs/2)*2^1; % ��λƵ�ʵ���������'db1'����d1_energy��ͬ(�����غ㶨��)����'db5'���в���
feature = [feature,cd1_max,cd1_min,d1_energy];

% ��2��ֽ�
[ca2, cd2] = dwt(ca1, wave_type); 
a2 = upcoef('a', ca2, wave_type, 2, Len);
d2 = upcoef('d', cd2, wave_type, 2, Len);
% ��ȡ����
cd2_max = max(cd2);
cd2_min = min(cd2);
d2_energy = sum(d2.^2)/(Fs/2)*2^2; % ��λƵ�ʵ�����
cd2_energy = sum(cd2.^2)/(Fs/2)*2^2; % ��λƵ�ʵ�����
feature = [feature,cd2_max,cd2_min,d2_energy];

% ��3��ֽ�
[ca3, cd3] = dwt(ca2, wave_type); 
a3 = upcoef('a', ca3, wave_type, 3, Len); 
d3 = upcoef('d', cd3, wave_type, 3, Len); 
% ��ȡ����
cd3_max = max(cd3);
cd3_min = min(cd3);
d3_energy = sum(d3.^2)/(Fs/2)*2^3; % ��λƵ�ʵ�����
cd3_energy = sum(cd3.^2)/(Fs/2)*2^3; % ��λƵ�ʵ�����
feature = [feature,cd3_max,cd3_min,d3_energy];

% ��4��ֽ�
[ca4, cd4] = dwt(ca3, wave_type); 
a4 = upcoef('a', ca4, wave_type, 4, Len); 
d4 = upcoef('d', cd4, wave_type, 4, Len); 
% ��ȡ����
cd4_max = max(cd4);
cd4_min = min(cd4);
d4_energy = sum(d4.^2)/(Fs/2)*2^4; % ��λƵ�ʵ�����
feature = [feature,cd4_max,cd4_min,d4_energy];

% ��5��ֽ�
[ca5, cd5] = dwt(ca4, wave_type); 
a5 = upcoef('a', ca5, wave_type, 5, Len);
d5 = upcoef('d', cd5, wave_type, 5, Len);
% ��ȡ����
cd5_max = max(cd5);
cd5_min = min(cd5);
d5_energy = sum(d5.^2)/(Fs/2)*2^5; % ��λƵ�ʵ�����
feature = [feature,cd5_max,cd5_min,d5_energy];

% ��ȡ����
ca5_max = max(ca5);
ca5_min = min(ca5);
a5_energy = sum(a5.^2)/(Fs/2)*2^5; % ��λƵ�ʵ�����
ca5_energy = sum(ca5.^2)/(Fs/2)*2^5; % ��λƵ�ʵ�����
feature = [feature,ca5_max,ca5_min,a5_energy];

% ��С���任ϵ��ͼ
figure;
subplot(7,1,1);plot(s);title('original'); %ԭʼ�ź�
subplot(7,1,2);plot(cd1);title('Level 1: cd1');
subplot(7,1,3);plot(cd2);title('Level 2: cd2');
subplot(7,1,4);plot(cd3);title('Level 3: cd3');
subplot(7,1,5);plot(cd4);title('Level 4: cd4');
subplot(7,1,6);plot(cd5);title('Level 5: cd5');
subplot(7,1,7);plot(ca5);title('Level 5: ca5');

% ��С���任�ع�ͼ
figure;
subplot(7,1,1);plot(s);title('original'); %ԭʼ�ź�
subplot(7,1,2);plot(d1);title('Level 1: d1');
subplot(7,1,3);plot(d2);title('Level 2: d2');
subplot(7,1,4);plot(d3);title('Level 3: d3');
subplot(7,1,5);plot(d4);title('Level 4: d4');
subplot(7,1,6);plot(d5);title('Level 5: d5');
subplot(7,1,7);plot(a5);title('Level 5: a5');

