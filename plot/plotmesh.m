clean;
load WakefulnessMatlabFile;

% Full normal HmS
options.figname='Normal';
patch.faces=[FacesLeft;FacesRight+size(NodesLeft,1)];
patch.vertices=[NodesLeft;NodesRight];
options.texture=rand(size(patch.vertices,1),1);
spm_eeg_render(patch,options);

% % Right HmS
% options.figname='Right HmS';
% patch.faces=FacesRight;
% patch.vertices=NodesRight;
% options.texture=rand(size(NodesRight,1),1);
% spm_eeg_render(patch,options);

% Inflated
options.figname='Inflated';
patch.faces=[FacesLeft;FacesRight+size(NodesLeftInflated,1)];
patch.vertices=[NodesLeftInflated;NodesRightInflated];
options.texture=rand(size(patch.vertices,1),1);
spm_eeg_render(patch,options);

% % Right Inflated
% options.figname='Right Inflated';
% patch.faces=FacesRight;
% patch.vertices=NodesRightInflated;
% options.texture=rand(size(NodesRightInflated,1),1);
% spm_eeg_render(patch,options);

