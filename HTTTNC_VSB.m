Num1 = load('bandpass_5000_5500.mat','Num');
bp = Num1.Num;
fs=48000;

n = 0:1023;
mt = sin(2*pi*50*n/fs) + sin(2*pi*80*n/fs) + sin(2*pi*150*n/fs) + sin(2*pi*300*n/fs);
ct = sin(2*pi*5000*n/fs);
dsb = mt.*ct;
vsb=filter(bp,1,dsb);
k = -1023:1023; 
w = (pi/1023)*k;  

% frequency between -pi and +pi
Mt = mt*(exp(-1i*pi/1023)).^(n'*k);  % DTFT of mt
Ct = ct*(exp(-1i*pi/1023)).^(n'*k);  % DTFT of ct
DSB = dsb*(exp(-1i*pi/1023)).^(n'*k);  % DTFT of dsb
VSB = vsb*(exp(-1i*pi/1023)).^(n'*k);  % DTFT of vsb

% Tín hiệu ngõ vào điều chế 
subplot(2,2,1); plot(w*fs/(2*pi),abs(Mt)); grid; 
xlabel('Frequency'); ylabel('|Mt|');
title('Magnitude of Mt');
axis([0 6000 0 600])

 % Tín hiệu sóng mang 
subplot(2,2,3); plot(w*fs/(2*pi),abs(Ct)); grid;
xlabel('Frequency'); ylabel('|Ct|');
title('Magnitude of Ct');
axis([0 6000 0 600])

 % Tín hiệu DSB
subplot(2,2,2); plot(w*fs/(2*pi),abs(DSB)); grid;
xlabel('Frequency'); ylabel('|DSB|');
title('Magnitude of DSB');
axis([0 6000 0 300])

 % Tính hiệu VSB
subplot(2,2,4); plot(w*fs/(2*pi),abs(VSB)); grid;
xlabel('Frequency'); ylabel('|VSB|');
title('Magnitude of VSB');
axis([0 6000 0 300])
