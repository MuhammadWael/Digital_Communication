% Number of bits
N = 1e6;

% Define SNR range
snr_db = -20:2:20;

% Generate random binary data vector
data = randi([0, 1], 1, N);

% Calculate signal power
signal_power = sum(data.^2) / N;

% Linearize the SNR
snr_linear = 10.^(snr_db/10);

% Calculate noise power
noise_power = signal_power ./ snr_linear;

% Generate AWGN for all SNR values
noise = sqrt(noise_power') .* randn(numel(snr_db), N); % Transpose noise

% Received signal for all SNR values
Rx_sequence = data + noise;

% Decide whether Rx is zero or one for all SNR values
threshold = 0.5;
decoded_data = Rx_sequence >= threshold;

% Compare received and original data for all SNR values
bit_error = sum(data ~= decoded_data, 2);

% Calculate bit error rate (BER) for all SNR values
ber = bit_error / N;

% Plot BER vs SNR curve using semilogy
figure;
semilogy(snr_db, ber, 'o-');
xlabel('SNR (dB)');
ylabel('Bit Error Rate (BER)');
title('BER vs. SNR');
grid on;
