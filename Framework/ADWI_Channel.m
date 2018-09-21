function [x] = ADWI_Framework_Channel(txsignal,fsample,bitspersample)
%
%   Channel definition. Output is delivered to receiver
%   so the block should include all channel effects: noise,
%   interference and fading. Output is an analog signal.
%
%   Output:
%   x : Channel output.
%

carrier_frequency = fsample;
doppler = 0;

delay_profile = [.3 .35 .4 .45 .8;
                 .4 .2 .1 .1 .04]';

x_i = zeros(length(delay_profile),1);

for i = 1:length(delay_profile)
    tau_i = delay_profile(i,1);
    phi_i = 2*pi*carrier_frequency*tau_i-doppler;
    x_i(i) = sum(delay_profile(1,i:end)*exp(-1i*phi_i));
end

txsignal = conv(ifft(x_i),fft(txsignal));


x=txsignal;