% 
clc;
clear;
close all;

% �����ź�
Fs = 1000;
t_list = 0:512;
t_list = t_list/Fs;
y1_list = [zeros(1,256),cos(0.2*t_list(257:end))]; % Ƶ��Ϊ0.2������Ϊ5
y2_list = sin(60*t_list); % Ƶ��Ϊ60
y3_list = sin(180*t_list); % Ƶ��Ϊ180
y4_list = sin(350*t_list); % Ƶ��Ϊ350
y_list = y1_list + y2_list + y3_list + y4_list;

% 
s = y_list;
Len = length(s);

% ����dwt���ֽ�

[ca1, cd1] = dwt(s, 'db1'); % dwt:1��С���ֽ⣬����db1С�����ֽ�,ca1��Ƶ��cd1��Ƶ
a1 = upcoef('a', ca1, 'db1', 1, Len); % upcoef: ��һ�ع�,��ϵ���õ�����/��Ƶ�ź�,0-250HZ
d1 = upcoef('d', cd1, 'db1', 1, Len); % upcoef: ��һ�ع�,��ϵ���õ�ϸ��/��Ƶ�ź�,250-500HZ
s1 = a1 + d1; % �ع��źţ���1���ع��õ���s1��s��ȫһ��,0-500HZ

[ca2, cd2] = dwt(ca1, 'db1'); % dwt:1��С���ֽ⣬����db1С�����ֽ�,ca2��Ƶ��cd2��Ƶ
a2 = upcoef('a', ca2, 'db1', 2, Len); % upcoef: ��һ�ع�,��ϵ���õ�����/��Ƶ�ź�,0-125HZ
d2 = upcoef('d', cd2, 'db1', 2, Len); % upcoef: ��һ�ع�,��ϵ���õ�ϸ��/��Ƶ�ź�,125-250HZ
s2 = a2 + d2; % �ع��ź�,��2���ع�, 0-250HZ

[ca3, cd3] = dwt(ca2, 'db1'); % dwt:1��С���ֽ⣬����db1С�����ֽ�,ca3��Ƶ��cd3��Ƶ
a3 = upcoef('a', ca3, 'db1', 3, Len); % upcoef: ��һ�ع�,��ϵ���õ�����/��Ƶ�ź�,0-62.5HZ
d3 = upcoef('d', cd3, 'db1', 3, Len); % upcoef: ��һ�ع�,��ϵ���õ�ϸ��/��Ƶ�ź�,62.5-125HZ
s3 = a3 + d3; % �ع��ź�,��3���ع�, 0-125HZ

[ca4, cd4] = dwt(ca3, 'db1'); % dwt:1��С���ֽ⣬����db1С�����ֽ�,ca4��Ƶ��cd4��Ƶ
a4 = upcoef('a', ca4, 'db1', 4, Len); % upcoef: ��һ�ع�,��ϵ���õ�����/��Ƶ�ź�,0-31.25HZ
d4 = upcoef('d', cd4, 'db1', 4, Len); % upcoef: ��һ�ع�,��ϵ���õ�ϸ��/��Ƶ�ź�,31.25-62.5HZ
s4 = a4 + d4; % �ع��ź�,��4���ع�, 0-62.5HZ

[ca5, cd5] = dwt(ca4, 'db1'); % dwt:1��С���ֽ⣬����db1С�����ֽ�,ca5��Ƶ��cd5��Ƶ
a5 = upcoef('a', ca5, 'db1', 5, Len); % upcoef: ��һ�ع�,��ϵ���õ�����/��Ƶ�ź�,0-15.625HZ
d5 = upcoef('d', cd5, 'db1', 5, Len); % upcoef: ��һ�ع�,��ϵ���õ�ϸ��/��Ƶ�ź�,15.625-31.25HZ
s5 = a5 + d5; % �ع��ź�,��5���ع�,0-31.25HZ

% ��С���任ϵ��ͼ
figure
subplot(7,1,1);
plot(y_list);title('Origin')
subplot(7,1,2);
plot(cd1);title('250-500HZ')
subplot(7,1,3);
plot(cd2);title('125-250HZ')
subplot(7,1,4);
plot(cd3);title('62.5-125HZ') 
subplot(7,1,5);
plot(cd4);title('31.25-62.5HZ')
subplot(7,1,6);
plot(cd5);title('15.625-31.25HZ')
subplot(7,1,7);
plot(ca5);title('0-15.625HZ')

% ��С���任�ع�ͼ
figure
subplot(7,1,1);
plot(y_list);title('Origin')
subplot(7,1,2);
plot(d1);title('250-500HZ')
subplot(7,1,3);
plot(d2);title('125-250HZ')
subplot(7,1,4);
plot(d3);title('62.5-125HZ') 
subplot(7,1,5);
plot(d4);title('31.25-62.5HZ')
subplot(7,1,6);
plot(d5);title('15.625-31.25HZ')
subplot(7,1,7);
plot(a5);title('0-15.625HZ')
