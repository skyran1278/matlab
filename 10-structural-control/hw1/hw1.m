clc; clear; close all;

% El50AXBS_FILEID = fopen('El50AXBS.txt', 'r');
EL50RFA_FILEID = fopen('EL50RFA.txt', 'r');

formatSpec = '%f';
% El50AXBS = fscanf(El50AXBS_FILEID, formatSpec);
EL50RFA = fscanf(EL50RFA_FILEID, formatSpec);

EL50RFA_length = length(EL50RFA);

EL50RFA_fft = fft(EL50RFA);
% EL50RFA_fft_shift = fftshift(EL50RFA_fft);

EL50RFA_fft_abs = abs(EL50RFA_fft / EL50RFA_length);
% EL50RFA_fft_shift_abs = abs(EL50RFA_fft_shift / EL50RFA_length);

EL50RFA_fft_abs_half = EL50RFA_fft_abs(1 : fix(EL50RFA_length / 2 + 1));

EL50RFA_fft_abs_half(2 : end - 1) = 2 * EL50RFA_fft_abs_half(2 : end - 1);

time_interval = 0.0125;

frequency = 1 / time_interval * (0 : fix(EL50RFA_length / 2) ) / EL50RFA_length;

[EL50RFA_fft_abs_half_max, EL50RFA_fft_abs_half_max_index] = max(EL50RFA_fft_abs_half);

figure('Name','EL50RFA Spectrum')
plot(frequency , EL50RFA_fft_abs_half);
hold on;
plot(frequency(EL50RFA_fft_abs_half_max_index), EL50RFA_fft_abs_half(EL50RFA_fft_abs_half_max_index), 'r*');
period = ['Period = ', num2str(1 / frequency(EL50RFA_fft_abs_half_max_index))];
text(frequency(EL50RFA_fft_abs_half_max_index) + 0.5, EL50RFA_fft_abs_half(EL50RFA_fft_abs_half_max_index), period);
title('EL50RFA Spectrum');
xlabel('f (Hz)');
ylabel('|Accel(g)|');


% plot(EL50RFA_fft_abs)

% 此範例展示一個簡單正弦波的傅立葉轉換，以雙邊頻譜來顯示
% 此正弦波的頻率恰巧是 freqStep 的整數倍，所以雙邊頻譜應該只有兩個非零點

% N = 256;			% 點數
% fs = 8000;			% 取樣頻率
% freqStep = fs/N;		% 頻域的頻率的解析度
% f = 10*freqStep;		% 正弦波的頻率，恰是 freqStep 的整數倍
% time = (0:N-1)/fs;		% 時域的時間刻度
% y = cos(2*pi*f*time);		% Signal to analyze
% Y = fft(y);			% Spectrum
% Y = fftshift(Y);		% 將頻率軸的零點置中

% % Plot time data
% subplot(3,1,1);
% plot(time, y, '.-');
% title('Sinusoidal signals');
% xlabel('Time (seconds)'); ylabel('Amplitude');
% axis tight

% % Plot spectral magnitude
% freq = freqStep*(-N/2:N/2-1);	% 頻域的頻率刻度
% subplot(3,1,2);
% plot(freq, abs(Y), '.-b'); grid on
% xlabel('Frequency)');
% ylabel('Magnitude (Linear)');

% % Plot phase
% subplot(3,1,3);
% plot(freq, angle(Y), '.-b'); grid on
% xlabel('Frequency)');
% ylabel('Phase (Radian)');

% clear
% clc
% %reading data
% [aEL]=textread('El50AXBS.TXT','%f','headerlines',0);
% [aELRFA]=textread('El50RFA.TXT','%f','headerlines',0);
% [aELRFD]=textread('El50RFD.txt','%f','headerlines',0);
% [NCERB_L NCERB_T NCERB_V]=textread('NCERB.TXT','%f%f%f','headerlines',1);
% [TzuChi_L TzuChi_T TzuChi_V]=textread('TzuChi.TXT','%f%f%f','headerlines',1);
% %time matrix produce
% t=zeros(length(aELRFA),1);
% tt=zeros(length(aELRFD),1);
% ttt=zeros(length(aEL),1);
% T=0;
% TT=0;
% TTT=0;
% for i=1:length(aELRFA)
%  t(i)=T;
%  T=T+0.0125;
% end
% for i=1:length(aELR
%  tt(i)=TT;
%  TT=TT+0.0125;
% end
% for i=1:length(aEL)
%  ttt(i)=TTT;
%  TTT=TTT+0.0125;
% end
% %% 3%
% %roof acce
% T=xlsread('C:\Users\USER\Desktop\123.xlsx','123','B12:B3084');
% A=xlsread('C:\Users\USER\Desktop\123.xlsx','123','C12:C3084');
% figure(11)
% plot(t,aELRFA*9.81,'-G')
% hold on
% plot(T,A,'R-')
% title('EL50 roof acce. 3%','FontSize',14);
% xlabel('time(s)','FontSize',12);
% ylabel('acce. (gal)','FontSize',12);
% legend('ELRFA','SAP2000');
% %roof disp
% TT=xlsread('C:\Users\USER\Desktop\456.xlsx','B12:B3083');
% D=xlsread('C:\Users\USER\Desktop\456.xlsx','C12:C3083');
% figure(12)
% plot(tt,aELRFD,'G-')
% hold on
% plot(TT,D*1000,'R-')
% title('EL50 roof disp. 3%','FontSize',14);
% xlabel('time(s)','FontSize',12);
% ylabel('disp. (mm)','FontSize',12);
% legend('ELRFA','SAP2000');
% %base acce
% TTT=xlsread('C:\Users\USER\Desktop\789.xlsx','B12:B3083');
% AA=xlsread('C:\Users\USER\Desktop\789.xlsx','C12:C3083');
% figure(13)
% plot(TTT,AA,'R-')
% hold on;
% plot(ttt,aEL*9.81,'--G')
% title('EL50 base acce. 3%','FontSize',14);
% xlabel('time(s)','FontSize',12);
% ylabel('acce. (gal)','FontSize',12);
% legend('SAP2000','ELRFA');
% %?e??-n?`·N????°??D
% %% 5%
% %roof acce
% T5=xlsread('C:\Users\USER\Desktop\5123.xlsx','B12:B3084');
% A5=xlsread('C:\Users\USER\Desktop\5123.xlsx','C12:C3084');
% figure(14)
% plot(t,aELRFA*9.81,'-G')
% hold on
% plot(T5,A5,'R-')
% title('EL50 roof acce. 5%','FontSize',14);
% xlabel('time(s)','FontSize',12);
% ylabel('acce. (gal)','FontSize',12);
% legend('ELRFA','SAP2000');
% %roof disp
% TT5=xlsread('C:\Users\USER\Desktop\5456.xlsx','B12:B3083');
% D5=xlsread('C:\Users\USER\Desktop\5456.xlsx','C12:C3083');
% figure(15)
% plot(tt,aELRFD,'-G')
% hold on;
% plot(TT5,D5*1000,'R-')
% title('EL50 roof disp. 5%','FontSize',14);
% xlabel('time(s)','FontSize',12);
% ylabel('disp. (mm)','FontSize',12);
% legend('ELRFA','SAP2000');
% %base acce
% TTT5=xlsread('C:\Users\USER\Desktop\5789.xlsx','B12:B3083');
% AA5=xlsread('C:\Users\USER\Desktop\5789.xlsx','C12:C3083');
% figure(16)
% plot(TTT5,AA5,'R-')
% hold on;
% plot(ttt,aEL*9.81,'--G')
% title('EL50 base acce. 5%','FontSize',14);
% xlabel('time(s)','FontSize',12);
% ylabel('acce. (gal)','FontSize',12);
% legend('SAP2000','ELRFA');
% %% 2%
% %roof acce
% T=xlsread('C:\Users\USER\Desktop\2123.xlsx','B12:B3084');
% A=xlsread('C:\Users\USER\Desktop\2123.xlsx','C12:C3084');
% figure(91)
% plot(t,aELRFA*9.81,'-G')
% hold on
% plot(T,A,'R-')
% title('EL50 roof acce. 2%','FontSize',14);
% xlabel('time(s)','FontSize',12);
% ylabel('acce. (gal)','FontSize',12);
% legend('ELRFA','SAP2000');
% %roof disp
% TT=xlsread('C:\Users\USER\Desktop\2456.xlsx','B12:B3083');
% D=xlsread('C:\Users\USER\Desktop\2456.xlsx','C12:C3083');
% figure(92)
% plot(tt,aELRFD,'G-')
% hold on
% plot(TT,D*1000,'R-')
% title('EL50 roof disp. 2%','FontSize',14);
% xlabel('time(s)','FontSize',12);
% ylabel('disp. (mm)','FontSize',12);
% legend('ELRFA','SAP2000');
% %base acce
% TTT=xlsread('C:\Users\USER\Desktop\2789.xlsx','B12:B3083');
% AA=xlsread('C:\Users\USER\Desktop\2789.xlsx','C12:C3083');
% figure(93)
% plot(TTT,AA,'R-')
% hold on;
% plot(ttt,aEL*9.81,'--G')
% title('EL50 base acce. 2%','FontSize',14);
% xlabel('time(s)','FontSize',12);
% ylabel('acce. (gal)','FontSize',12);
% legend('SAP2000','ELRFA');
% %% predtic
% %NAX
% PT=xlsread('C:\Users\USER\Desktop\NAX.xlsx','B12:B18012');
% PA=xlsread('C:\Users\USER\Desktop\NAX.xlsx','C12:C18012');
% figure(21)
% plot(PT,PA,'R-')
% title('NCERB roof acce. X dir. 3%','FontSize',14);
% xlabel('time(s)','
% plot(PTY,PAY,'R-')
% title('NCERB roof acce. Y dir. 3%','FontSize',14);
% xlabel('time(s)','FontSize',12);
% ylabel('acce. (gal)','FontSize',12);
% legend('SAP2000 NCERB');
% %NDY
% PTY=xlsread('C:\Users\USER\Desktop\NDY.xlsx','B12:B18012');
% PDY=xlsread('C:\Users\USER\Desktop\NDY.xlsx','C12:C18012');
% figure(26)
% plot(PTY,PDY*10,'R-')
% title('NCERB roof disp. Y dir. 3%','FontSize',14);
% xlabel('time(s)','FontSize',12);
% ylabel('disp. (mm)','FontSize',12);
% legend('SAP2000 NCERB');
% %TAY
% TPTY=xlsread('C:\Users\USER\Desktop\TAY.xlsx','B12:B18012');
% TPAY=xlsread('C:\Users\USER\Desktop\TAY.xlsx','C12:C18012');
% figure(27)
% plot(TPTY,TPAY,'R-')
% title('TzuChi roof acce. Y dir. 3%','FontSize',14);
% xlabel('time(s)','FontSize',12);
% ylabel('acce. (gal)','FontSize',12);
% legend('SAP2000 TzuChi');
% %TDY
% TPTY=xlsread('C:\Users\USER\Desktop\TDY.xlsx','B12:B18012');
% TPDY=xlsread('C:\Users\USER\Desktop\TDY.xlsx','C12:C18012');
% figure(28)
% plot(TPTY,TPDY*10,'R-')
% title('TzuChi roof disp. Y dir. 3%','FontSize',14);
% xlabel('time(s)','FontSize',12);
% ylabel('disp. (mm)','FontSize',12);
% legend('SAP2000 TzuChi');
% %% ?U???°FFT??§O
% %% ??3 B2.993
% Fs = 80; % Sampling frequency
% T = 1/Fs; % Sampling period
% L = length(aELRFA)+1; % Length of signal
% t = (0:L-1)*T; % Time vector
% S =aELRFA;
% f = Fs*(0:(L/2))/L;
% Y = fft(S);
% P2 = abs(Y/L);
% P1 = P2(1:L/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% figure(6)
% plot(f,P1)
% title('EL50XBS frequency spectrum')
% xlabel('f (Hz)')
% ylabel('Acce(g)')
% %%
% A=xlsread('C:\Users\USER\Desktop\123.xlsx','123','C12:C3084');
% Fs = 80; % Sampling frequency
% T = 1/Fs; % Sampling period
% L = length(A)+1; % Length of signal
% t = (0:L-1)*T; % Time vector
% S =A;
% f3 = Fs*(0:(L/2))/L;
% Y = fft(S);
% P2 = abs(Y/L);
% P13 = P2(1:L/2+1);
% P13(2:end-1) = 2*P13(2:end-1);
% figure(41)
% plot(f,P1*9.81,'-G')
% hold on
% plot(f3,P13,'R-')
% title('EL50 roof acce. FFT 3%','FontSize',14);
% xlabel('Hz','FontSize',12);
% ylabel('acce. (g)','FontSize',12);
% legend('ELRFA','SAP2000');
% %%
% A5=xlsread('C:\Users\USER\Desktop\5123.xlsx','C12:C3084');
% Fs = 80; % Sampling frequency
% T = 1/Fs; % Sampling period
% L = length(A5)+1; % Length of signal
% t = (0:L-1)*T; % Time vector
% S =A5;
% f4 = Fs*(0:(L/2))/L;
% Y = fft(S);
% P2 = abs(Y/L);
% P15 = P2(1:L/2+1);
% P15(2:end-1) = 2*P15(2:end-1);
% figure(42)
% plot(f,P1*9.81,'-G')
% hold on
% plot(f4,P15,'R-')
% title('EL50 roof acce. FFT 5%','FontSize',14);
% xlabel('Hz','FontSize',12);
% ylabel('acce. (g)','FontSize',12);
% legend('ELRFA','SAP2000');
% %%
% A2=xlsread('C:\Users\USER\Desktop\2123.xlsx','C12:C3084');
% Fs = 80; % Sampling frequency
% T = 1/Fs; % Sampling period
% L = length(A2)+1; % Length of signal
% t = (0:L-1)*T; % Time vector
% S =A2;
% f2 = Fs*(0:(L/2))/L;
% Y = fft(S);
% P2 = abs(Y/L);
% P12 = P2(1:L/2+1);
% P12(2:end-1) = 2*P12(2:end-1);
% figure(43)
% plot(f,P1*9.81,'-G')
% hold on
% plot(f2,P12,'R-')
% title('EL50 roof acce. FFT 2%','FontSize',14);
% xlabel('Hz','FontSize',12);
% ylabel('acce. (g)','FontSize',12);
% legend('ELRFA','SAP2000');
