function [f,P1] = FFT(X,Fs)
    Y = fft(X);
    L = length(Y);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs*(0:(L/2))/L;
end

