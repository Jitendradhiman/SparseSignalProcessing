clear all;close all;
addpath('/Users/apple/Documents/Learning/IntroductionToSparseSignalProcNotes/SparsityInSignalProcessing/matlab_sparse_SP_intro/');
I = sqrt(-1);
%printme = @(txt) print('-dpdf', sprintf('figures/Example_BP_%s',txt));
type A;
type AT;
M = 100;
N = 256;
y = rand(M,1);
c = (1/N) * AT(y,M,N);
y2 = A(c,M,N);
recon_err = y2 - y;
fprintf('Maximum reconstruction error : %g\n',max(recon_err));
M =100;
m = (0:M-1)';
f1 = 10.5;
x = exp(I*2*pi*f1/M*m);
%figure;
%plot(m,real(x),m,imag(x),'--');%grid on;
%xlabel('Time (samples)');
%ylabel('Signal');
%legend('Real part','Imaginary part');
%box off;
%ylim1 = [-1.4 1.8];
%ylim(ylim1);
%printme('signal')
X = fft(x);
figure;
subplot(3,1,1);
stem(m,abs(X),'marker','none');
title('DFT');
X = (1/N)*AT(x,M,N)
subplot(312);
stem(abs(X),'marker','none');
title('DFT LS solution');
err = x - A(X,M,N);
err_max = max(abs(err));
fprintf('LS reconstruction error = %g\n',err_max);
H = @(x) A(x,M,N);
HT = @(x) AT(x,M,N);
p = N;
Nit = 100;
mu = 5;
[c,cost]=bp_salsa(x,H,HT,p,mu,Nit);
err = x - A(c,M,N);
err_max = max(abs(err));
fprintf('BP reconstruction max error = %g\n',err_max);

subplot(313);
stem(0:N-1,abs(c),'marker','none');
title('BP FFT');
figure;
plot(cost);
title('Cost function history');
 it1 = 6;
 del = cost(it1) - min(cost);
 ylim([min(cost) - 0.1*del cost(it1)]);
%ylim([min(cost) cost(it1)]);
 xlim([0 Nit])









