function [Um, info, lh] = scmfs(s,psd,freq)
% fisher scoring algorithm to fit single channel spetrum components model
% generate the approximation of information matrix and the score equation
% Input
%         s ---- model parameters [rou, mu, tau, nu], peak amplitude,
%         position, peak half width, peak exponent
%         freq ---- frequency bins, predictors
%         psd ---- power spectrum density for a single channel (in log scale)
%    freqres ---- frequency resolution
% Output
%         U ---- score equations
%      info ---- approximation to fisher information matrix (Demidenko mixed models pp86)

nf = length(freq);
nk = size(s,1)/4;
lh = zeros(nf,1);
U = zeros(4*nk,nf);
sigmav=zeros(nf,1);

for f=1:nf
    p = psd(f); % sample spectrum
    omg = freq(f);
    sigma = 0;
    g = zeros(4,nk);
    % spectrum reconstruction
    for k=1:nk
        sk = s(4*(k-1)+(1:4));
        rou = sk(1); mu = sk(2); tau = sk(3); nu  = sk(4);
        a = ((omg-mu)/tau)^2+1;
        kxi = rou*(a)^(-nu);
        g(:,k) = [a^(-nu), 2*rou*nu*(omg-mu)*tau^(-2)*a^(-nu-1), 2*rou*nu*(omg-mu)^2*tau^(-3)*a^(-nu-1), -rou*log(a)*a^(-nu)];
        sigma = sigma+kxi;
    end
    % likelihood
    lh(f) = log(sigma)+p/sigma;
    % first derivative
    g = reshape(g,[4*nk,1]);
    if sigma==0, sigma=eps; end % avoid NaN
    U(:,f) = (sigma-p)/sigma^2*g;
    sigmav(f)=sigma;
end

% output
info = cov(U'); % U*U'/n;
Um = mean(U,2);
lh = sum(lh);
% visualization
 plotu; 
end