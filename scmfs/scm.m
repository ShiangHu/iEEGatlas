% single channel spctrum components model
clean;
dbstop if error
% dbstop at 42 in initialparascm if nu<0 
data = importdata('E:\E-disk\QEEG\SCM\iEEGgtm/results.mat'); % spectrum of one subject
% psd = data.spect(importdata('postc hn.mat'),:);% occipital channels
% lp = data.F<=40; % filtering
freq = data.F;
% psd = psd(41,lp); %23, 25, 35, 38, 41, 47, 129, 132
% figure, plot(freq,(psd));

% simulation
% freq = 0.0039*(1:20000);
psd = importdata('simpsd1.mat');
nk=3;
% s = initialparascm(freq,psd);

% para = zeros(4*nk+1,ne);
maxIt = 200;

para = fitscm(psd,freq,nk,maxIt);