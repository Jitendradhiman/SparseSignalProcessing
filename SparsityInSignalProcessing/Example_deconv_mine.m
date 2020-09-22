clear all;close all;
randn('state',0);
N = 100
s = zeros(N,1);
k = [20 45 70];
a = [2 -1 1];
s(k) = a;
L = 4;
h = ones(L,1)/L;
M = N + L - 1
w = 0.03*randn(M,1);
y1 = conv(h,s);
y = conv(h,s) + w;
H = sparse(M,N);
e = ones(N,1);
for i = 0:L-1
    H = H + spdiags(h(i+1)*e,-i,M,N);
end
issparse(H)
lambda1 = 0.4;
x_L2 = (H'*H + lambda1*speye(N)) \ (H'*y);
% BPD
lambda2 = 0.2;
Nit = 50;
mu = 0.2;
[x_BPD,cost]=bpd_salsa_sparsemtx(y,H,lambda2,mu,Nit);


figure;
subplot(311)
stem(s,'marker','none');
ylim1 = [-1.5 2.5];
ylim(ylim1);
subplot(312)
plot(y1,'marker','none');title('moving averaged clean signal ');
ylim([-0.5 1]);
subplot(313);
plot(y,'marker','none');title('moving averaged noisy signal ');
xlim([0 M]);
figure;
spy(H(1:34,1:30));
figure;
stem(x_L2,'marker','none');
title('deconvolution using leats square');
figure;
stem(x_BPD, 'marker', 'none');
ylim(ylim1);
title('Deconvolution (BPD solution)');
xlabel(' ')
printme('BPD')


