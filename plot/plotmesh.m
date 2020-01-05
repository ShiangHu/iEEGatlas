clean;
load WakefulnessMatlabFile;

% Full normal HmS
options.figname='Normal';
patch.faces=[FacesLeft;FacesRight+size(NodesLeft,1)];
patch.vertices=[NodesLeft;NodesRight];
options.texture=zeros(size(patch.vertices,1),1);
spm_eeg_render(patch,options);

% % Right HmS
% options.figname='Right HmS';
% patch.faces=FacesRight;
% patch.vertices=NodesRight;
% options.texture=rand(size(NodesRight,1),1);
% spm_eeg_render(patch,options);

% Inflated
% options.figname='Inflated';
% patch.faces=[FacesLeft;FacesRight+size(NodesLeftInflated,1)];
% patch.vertices=[NodesLeftInflated;NodesRightInflated];
% options.texture=rand(size(patch.vertices,1),1);
% spm_eeg_render(patch,options);

% % Right Inflated
% options.figname='Right Inflated';
% patch.faces=FacesRight;
% patch.vertices=NodesRightInflated;
% options.texture=rand(size(NodesRightInflated,1),1);
% spm_eeg_render(patch,options);


% create atlas for brainsotrm visualization and simulation
close all;
cortex15002 = load('/home/shu/brainstorm_db/Protocol01/anat/Subject01/tess_cortex_pial_low.mat');
Scouts = cortex15002.Atlas(3).Scouts;
Region = [NodesRegionLeft;NodesRegionRight];
Scouts(40:end) = [];
for i=1:length(RegionName)
    Scouts(i).Vertices = find(Region==i)';
    Scouts(i).Label = RegionName{i};
    Scouts(i).Region = [];
    Scouts(i).Seed = [];
end
clearvars -except Scouts patch cortex15002;
cortex_iEEG = cortex15002;
cortex_iEEG.Vertices = patch.vertices;
cortex_iEEG.Faces = patch.faces;
cortex_iEEG.Atlas = struct('Name','default','Scouts',Scouts);
cortex_iEEG.VertNormals = [];
cortex_iEEG.VertConn = [];
cortex_iEEG.Comment = 'cortex_iEEG';
cortex_iEEG.Curvature = [];
cortex_iEEG.SulciMap = [];
cortex_iEEG.tess2mri_interp = [];
cortex_iEEG.iAtlas = 1;
cortex_iEEG.Reg.Sphere.Vertices=[];
% cortex_iEEG=rmfield(cortex_iEEG,'mrimask');
cortex_iEEG.Reg.Sphere.Vertices=[];
% import cortex_iEEG from MATLAB workspace to Brainstorm subject