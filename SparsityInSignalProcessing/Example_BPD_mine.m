clear all;close all
addpath('/Users/apple/Documents/Learning/IntroductionToSparseSignalProcNotes/SparsityInSignalProcessing/matlab_sparse_SP_intro/');
addpath('/Users/apple/Documents/Learning/IntroductionToSparseSignalProcNotes/SparsityInSignalProcessing/matlab_sparse_SP_intro/data/');
randn('state',0);
[sp1,fs]=audioread('sp1.wav');
M =500;
s = sp1(5500+(1:M));
w = 0.1*randn(M,1);
y = s + w;
N =2^10;
Y = (1/N)*fft(y,N);
subplot(411);
plot(s);
subplot(412);
plot(y)
ylim([-0.5 0.7])
subplot(413);
plot(abs(Y));title('fft of noisy signal')
xlim([0 N/2]);
H =@(x) A(x,M,N);
HT = @(x) AT(x,M,N);
p = N;
lambda = 7;
Nit = 50;
mu = 500;
[c,cost]=bpd_salsa(y,H,HT,p,lambda,mu,Nit);
it1 = 5;
del = cost(it1) - min(cost);
ylim([min(cost) - 0.1*del cost(it1)]);
xlim([0 Nit]);
figure;
subplot(211);
plot(abs(c));title('fft coefficiemt using BPD');
xlim([0 N/2]);
subplot(212);
plot(cost);
g = H(c);
g = real(g);
figure;plot(g);
