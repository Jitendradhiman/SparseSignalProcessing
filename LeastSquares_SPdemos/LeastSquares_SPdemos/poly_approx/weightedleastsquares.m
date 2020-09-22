%% Least square polynomial approximation
% This example illustrates the fitting of a low-order polynomial to data by
% weighted least squares and least squares and compare them.

%% Start

clear all;
close all

%% Load data

 t = [1:13]';         % time index
 y = t.^2;            % data value


%% Display data

figure(1)
clf
plot(t, y, '.')
title('Data')

%% Polynomial approximation (degree = 2)
% A is a matrix of size 100 rows, 3 columns
A = bsxfun(@power, t, [2 1 0]);       % Raise t to powers 2, 1, 0

% Solve the system A'*A*p = A'*y for p
% using the backslash.
% p is a vector of length 3.

p = (A'*A) \ (A'*y);

% Display polynomial approximation
figure;
plot(t, polyval(p, t), t, y, '.')
title('Polynomial approximation with least squares(without outliers) (degree = 2)')
xlim([0 15]);ylim([0 200]);
%% Polynomial approximation (degree = 3)
%{
A = bsxfun(@power, t, [3 2 1 0]);
p = (A'*A) \ (A'*y);
figure;
plot(t, polyval(p, t), t, y, '.')
title('Polynomial approximation (degree = 3)');xlim([0 15]);ylim([0 200]);
%}
%% Polynomial approximation (degree = 4)
%{
A = bsxfun(@power, t, [4 3 2 1 0]);
p = (A'*A) \ (A'*y);
figure;
plot(t, polyval(p, t), t, y, '.')
title('Polynomial approximation (degree = 4)');xlim([0 15]);ylim([0 200]);
%}


%% put some outliers and use least squares

% Load data
 t1 = [1:13]';         % time index
 y1 = [t1(1:10).^2;t1(11:13)];            % data value


% Display data

figure
plot(t1, y1, '.')
title('Data')
xlim([0 15]);ylim([0 200]);
% Polynomial approximation (degree = 2)
% A is a matrix of size 100 rows, 3 columns

A1 = bsxfun(@power, t1, [2 1 0]);       % Raise t to powers 2, 1, 0

 
% Solve the system A'*A*p = A'*y for p
% using the backslash.
% p is a vector of length 3.

p1 = (A1'*A1) \ (A1'*y1);

% Display polynomial approximation
figure;
plot(t1, polyval(p1, t1), t1, y1, '.')
title('Polynomial approximation without weighted least squares(outlier case)(degree = 2)')
xlim([0 15]);ylim([0 200]);
%% choose some weights and do weighted least squares
w1=ones(10,1)*(1/10);       % Give more weights to first 10 data points
w2=[1/1000 1/1000 1/1000]'; % Give less weight to last 3 data pints
% note that choosing weights is completely manual based on my knowledge
% about data
w3=[w1;w2];
W=diag(w3);

p2= (A1'*W*A1) \ (A1'*W*y1); % this solves weighted least square problem

figure;
plot(t1,polyval(p2,t1),t1,y1,'.');
title('Polynomial approximation with weighted least squares(outlier case)(degree = 2)')
xlim([0 15]);ylim([0 200]);

%% Comments about figures to gain more insights about the demo:

% Figure1 and Figure3: are the plots of data points without and with outliers respectively. 

% Figure2: is the fit using least squares without any outlier.

% Figure4: is the fit using least squares with outliers. compare it with
% Figure 2 we don't get a good fit bcz of outliers, the solution is using
% weighted least squares.

% Figure5: is the fit using weighted least squares with outliers. compare
% it with figure 4.







