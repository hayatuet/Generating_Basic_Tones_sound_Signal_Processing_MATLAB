clc; close all; clear all;

% Sampling Frequency (Samples/sec)
fs = 5e4;
% Time Period (sec)
T = 1/500;
% Frequency of the signals (Cycles/)
f = 1/T;
% Total time (duration) of signal
t0 = 5;
% time vector
t = 0:1/fs:t0;
% cosine wave
y1 = cos(2*pi*f*t);
% Sawtooth Wave
y2 = mod(2/T*t, 2) - 1;

% f = cycles/sec & fs = samples per sec,
% fs/f = samples per cycle.
% half number of sample be on positive cycle,
% half be on negative cycle, i.e. (fs/f)/2

% one cycle of the Square wave be:
sq_cycle = [ones(1, (fs/f)/2) -ones(1, (fs/f)/2)];
y3 = [];

% By def: Time period = Number cycles / total time
% => number of cycles = total time / time period
for i = 1:t0/T          
    y3 = [y3 sq_cycle]; % concatenate cycles
end 

%% plotting the Waves:
% Here we consider just plotting 500 samples (from 1001 to 5000)

subplot(311);
plot(t(1001:1500), y1(1001:1500), 'LineWidth', 1.5);
xlabel('Time, sec');
ylabel('Amplitude');
title('Cosine Wave');
grid on
grid minor

subplot(312);
plot(t(1001:1500), y2(1001:1500), 'LineWidth', 1.5);
xlabel('Time, sec');
ylabel('Amplitude');
title('Sawtooth Wave');
grid on
grid minor

subplot(313);
plot(t(1001:1500), y3(1001:1500), 'LineWidth', 1.5);
xlabel('Time, sec');
ylabel('Amplitude');
title('Square Wave');
grid on
grid minor

%% Play the sound files
disp('Playing Cosine Wave');
sound(y1, fs);
pause(t0);
disp('Playing Done');
pause(0.5)

%-------------------------------------
disp('Playing Sawtooth Wave');
sound(y2, fs);
pause(t0);
disp('Playing Done');
pause(0.5)

%-------------------------------------

disp('Playing Square Wave');
sound(y3, fs);
pause(t0);
disp('Playing Done');
pause(0.5)

% In case of cosine, signle tone was heard,
% but in case of sawtooth and square waves, 
% multiple tones were heard.
% 
% Reason: According to Fourier Series, cosine is single frequency,
%         while sawtooth & square waves are result of different sinusoids,
%         (Harmonics of the fundamental frequency with varying amplitude).

if isdir('audio_files')
    rmdir("audio_files", 's')
end
mkdir('audio_files');
audiowrite('audio_files\cosine.wav', y1, fs);
audiowrite('audio_files\sawtooth.wav', y2, fs);
audiowrite('audio_files\square.wav', y3, fs);