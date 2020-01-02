function s = initialparascm(freq,psd)
% initialize the parameters of spectrum components model by roughly estimating the peaks
% Input
%        freq --- frequency bins
%        psd --- power spectrum density for one channel
%            p --- regularization parameter to localize the peaks
% Output
%          s --- [nk*4 - 1] vector, [rou, mu, tau, nu]
% see fitscm, scmfs


[ppSpline,p] = csaps(freq,psd);
[maxima, minima] = splineMaximaMinima(ppSpline);
s_smooth = csaps(freq,psd,p,freq);

maxima = [freq(1);maxima]; % add Xi
[~,cutloc]=min(abs(psd-1.5));
maxima(maxima>=freq(cutloc))=[];
minima(length(maxima)+1:end)=[];

% visualization
figure,
plot(freq,[s_smooth',psd']); hold on
plot(maxima,ppval(ppSpline,maxima),'r*');
plot(minima,ppval(ppSpline,minima),'gs');
legend({'Fit','Truth','Pks','Tfs'});

nk = length(maxima);
s = zeros(4*nk,1);
for i=1:length(maxima)
    [~,maxloc]=min(abs(freq-maxima(i)));
    [~,minloc]=min(abs(freq-minima(i)));
    rou =psd(maxloc);  % rou
    mu =freq(maxloc);  % mu
    
    [~,phloc] = min(abs(psd-0.5*rou)); % peak half
    tau=abs(freq(phloc)-mu);   % tau
    
    slope = -(psd(maxloc)-psd(minloc))/(freq(maxloc)-freq(minloc));
    nu= 10*abs(-log(slope)/log(1+1/tau)); % nu
    
    if abs(mu-10)<5, tau=2*tau; end
    s(4*i-3:4*i)=[rou mu tau nu];
end