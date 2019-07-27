% 
clc;
clear;
close all;

% 
load data_train.mat
y = data_fist(:,1);
s = y(1:64);
Len = length(s);

% dwt �� wavedec �ĶԱ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ����dwt���ֽ⣬���밴�յ�1, 2, 3, ...��ķֽ�˳�򣬽��в�����
[ca1, cd1] = dwt(s, 'db1'); % dwt:1��С���ֽ⣬����db1С�����ֽ�,ca1��Ƶ��cd1��Ƶ
a1 = upcoef('a', ca1, 'db1', 1, Len); % upcoef: ��һ�ع�,��ϵ���õ�����/��Ƶ�ź�
d1 = upcoef('d', cd1, 'db1', 1, Len); % upcoef: ��һ�ع�,��ϵ���õ�ϸ��/��Ƶ�ź�
s1 = a1 + d1; % �ع��źţ��ӵ�1���ع�

[ca2, cd2] = dwt(ca1, 'db1'); % dwt:1��С���ֽ⣬����db1С�����ֽ�,ca2��Ƶ��cd2��Ƶ
a2 = upcoef('a', ca2, 'db1', 2, Len); % upcoef: ��һ�ع�,��ϵ���õ�����/��Ƶ�ź�
d2 = upcoef('d', cd2, 'db1', 2, Len); % upcoef: ��һ�ع�,��ϵ���õ�ϸ��/��Ƶ�ź�
s2 = a2 + d2 + d1; % �ع��ź�,�ӵ�2���ع�

% ��ͼ
figure;
subplot(5, 1, 1); plot(s); title('original signal');
subplot(5, 1, 2); plot(ca1); title('low-frequency information');
subplot(5, 1, 3); plot(cd1); title('high-frequency information');
subplot(5, 1, 4); plot(s1, 'r-'); title('re-constructed signal from levle 1');
subplot(5, 1, 5); plot(s2, 'r-'); title('re-constructed signal from levle 2');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ����wavedec���Դﵽͬ���ķֽ�Ч��������ֱ�Ӵ�ԭʼ�ź�s���ж��ֽ⣬����Ҫ������
[C1,L1] = wavedec(s,1,'db1'); %wavedec����߶�һά��ɢС���任����
CA1 = appcoef(C1,L1,'db1',1); %�������C����ȡ��1��ĵ�Ƶϵ����CA1��ca1��ȫ��ͬ
A1 = wrcoef('a',C1,L1,'db1',1); %�ع���1��ĵ�Ƶ�źţ�A1��a1��ȫ��ͬ
D1 = wrcoef('d',C1,L1,'db1',1); %�ع���1��ĸ�Ƶ�źţ�D1��d1��ȫ��ͬ
S1 = A1 + D1; % �ع��źţ��ӵ�1���ع�

% ��ע�⡿������ֱ�Ӵ�ԭʼ�ź�s���е�2��ֽ⣬û�����õ�1��Ľ��������wavedec�����ƣ�����Ҫ������
[C2,L2] = wavedec(s,2,'db1'); %wavedec����߶�һά��ɢС���任����
CA1_too = appcoef(C2,L2,'db1',1); %�������C����ȡ��1��ĵ�Ƶϵ���������CA1_too��ca1��CA1��ȫ��ͬ
CA2 = appcoef(C2,L2,'db1',2); %�������C����ȡ��2��ĵ�Ƶϵ����CA2��ca2��ȫ��ͬ
A2 = wrcoef('a',C2,L2,'db1',2); %�ع���2��ĵ�Ƶ�źţ�A2��a2��ȫ��ͬ
D2 = wrcoef('d',C2,L2,'db1',2); %�ع���2��ĸ�Ƶ�źţ�D2��d2��ȫ��ͬ
S2 = A2 + D2 + D1; % �ع��źţ��ӵ�2���ع�

% waverec ȫ�ع���������ֱ�ӽ�wavedec�ķֽ����ع�ԭ�ź�
S_waverec1 = waverec(C1,L1,'db1'); %�Ƚ�ͨ����1���ع��ź���ԭʼ�ź�
err1 = max(abs(s-S_waverec1)); %�ع�������
S_waverec2 = waverec(C2,L2,'db1'); %�Ƚ�ͨ����2���ع��ź���ԭʼ�ź�
err2 = max(abs(s-S_waverec2)); %�ع�������

% ��ͼ
figure;
subplot(5, 1, 1); plot(s); title('original signal');
subplot(5, 1, 2); plot(CA1); title('low-frequency information');
subplot(5, 1, 3); plot(CA2); title('high-frequency information');
subplot(5, 1, 4); plot(S_waverec1, 'r-'); title('re-constructed signal from levle 1');
subplot(5, 1, 5); plot(S_waverec2, 'r-'); title('re-constructed signal from levle 2');
