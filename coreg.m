% ----------------- User Settings -----------------
main_folder = 'Z:\People\JohnS\SCanD\SemanticAssociation_fmriPrep_fMRI-CPCA\Data_Resliced\Patients';   % <-- CHANGE THIS
output_prefix = 'r_';                       % Prefix for resliced images
spm_path = 'Z:\Manuals and Scripts\MRI\All_fMRI_Steps\Preprocessing with SPM12\spm_25.01.02\spm';            % <-- CHANGE THIS

reference_scan = 'Z:\People\JohnS\SCanD\SemanticAssociation_fmriPrep_fMRI-CPCA\C1_varimax_G.hdr';  % <-- Your reference scan with desired voxel size
% --------------------------------------------------

addpath(spm_path);
spm('Defaults','fMRI');
spm_jobman('initcfg');

subject_dirs = dir(main_folder);
subject_dirs = subject_dirs([subject_dirs.isdir] & ~startsWith({subject_dirs.name}, '.'));

for i = 1:length(subject_dirs)
    subj_path = fullfile(main_folder, subject_dirs(i).name);
    nii_files = dir(fullfile(subj_path, 'sub*.nii'));
    
    fprintf('Processing subject: %s\n', subject_dirs(i).name);

    for j = 1:length(nii_files)
        file_path = fullfile(subj_path, nii_files(j).name);
        fprintf('  Reslicing: %s\n', nii_files(j).name);

        % spm_reslice expects cell arrays of filenames:
        % First is reference, second is source
        flags = struct();
        flags.which = 1;    % write resliced source only
        flags.interp = 4;   % 4th degree spline interpolation
        flags.wrap = [0 0 0];
        flags.mask = 0;
        flags.mean = 0;

        spm_reslice({reference_scan, file_path}, flags);

        % Rename output file with prefix
        resliced_name = fullfile(subj_path, [output_prefix, nii_files(j).name]);
        if exist(resliced_name, 'file')
            delete(resliced_name); % delete if already exists
        end
        movefile(fullfile(subj_path, ['r', nii_files(j).name]), resliced_name);
    end
end

disp('All volumes resliced to external reference.');
