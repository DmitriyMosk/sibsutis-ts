syms t

sin1 = sin(2 * pi * 1 * t); % Frequency 1 Hz
sin2 = sin(2 * pi * 2 * t + pi/4); % Frequency 2 Hz, Phase shift pi/4

t_values = 0:0.01:20; % From 0 to 1 seconds, with a step of 0.01

y1 = double(subs(sin1, t, t_values));
y2 = double(subs(sin2, t, t_values));

figure;
subplot(3,1,1);
    plot(t_values, y1, 'r');
    hold on;
    plot(t_values, y2, 'b');
    title('Individual Sinusoids');
    xlabel('Time (s)');
    ylabel('Amplitude');
    legend('Sinusoid 1', 'Sinusoid 2');

combined_signal = y1 + y2;

subplot(3,1,2);
    plot(t_values, combined_signal, 'k');
    title('Combined Sinusoid');
    xlabel('Time (s)');
    ylabel('Amplitude');

max_value = max(abs(combined_signal));
normalized_signal = round((combined_signal / max_value) * 128);

subplot(3,1,3);
    plot(t_values, normalized_signal, 'g');
    title('Normalized Combined Signal');
    xlabel('Time (s)');
    ylabel('Amplitude');
    
fileID = fopen('combined_signal.txt', 'w');
fprintf(fileID, '%d\n', normalized_signal);
fclose(fileID);
