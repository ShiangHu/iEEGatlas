function [para, U, lhv] = fitscm(psd,freq,nk,maxIt)
% fit spectrum components model with student-t type curves
% Input
%        psd --- [1-nf], spectrum of one channel over nf frequency bins (in log scale)
%        freq --- [nf-1], frequency bins
%           nk --- number of spectrum components
%      maxIt --- maximum iteration times
% Output
%        para --- [(rou,mu,tau,nu)*nk+1,1]; para(end)=1(successfully fitted) or 0(fail to fit)

% Shiang Hu, Jun. 2018

if nargin<4
    maxIt=200;
end
if nargin<3
    nk=2;
end

% intializaling paras
r=1;
lhv=zeros(maxIt,1);
U=zeros(nk*4,maxIt+1);
sv = zeros(nk*4,maxIt);
% sv(:,1)= [15, 0, 40, 25, 2.5, 5, 1.5, 30, 7, 10, 5, 20]; %oracle paras
% sv(:,1) = [7, 10, 8, 20];
sv(:,1)= [15, 0, 40, 25, 2.5, 5, 1.5, 30, 7, 10, 5, 20];

% regularization parameter
lmd=0.1;
% dbstop in scmfs at 29 if

while r<=maxIt
    
    [U(:,r), info,lhv(r)] = scmfs(sv(:,r),psd,freq);
    
    if sum(abs(U(:,r)))<eps % sv(:,r+1))-abs(sv(:,r)
        break;
    else
        sv(:,r+1)=sv(:,r)+(info+lmd*eye(nk*4))\U(:,r); %(info+lmd*eye(nk*4))\U
        sv=sign(sv).*sv;
        if sum(sv(:,r+1))>500
            sv(sv(:,r+1)>100,r+1)=sv(sv(:,r+1)>500,1); % constrains
        end
        r=r+1;
        disp(r);
    end
    
end

% if r<=maxIt, plotmtp; end

label = sum(abs(U(:,r)))<eps; % 1 fit, 0 unfitted
para=[sv(:,r); label];

end