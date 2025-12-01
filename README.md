# matlab_reslice

This MATLAB script uses SPM functions to perform reslicing on MRI data using the voxel sizes and matrix dimensions from a reference file.

# Instructions for Use: `reslice.m`

## Folder Organization

To use this script, your folder organization should roughly follow the following convention:

```
main_directory
├──data
│   ├──sub-01
│   │   ├──sub*_001.nii
│   │   ├──sub*_002.nii
│   │   ├──sub*_003.nii
│   │   └──...
│   ├──sub-02
│   │   ├──sub*_001.nii
│   │   ├──sub*_002.nii
│   │   ├──sub*_003.nii
│   │   └──...
│   └──...
├──spm_25.01.02
├──reference_scan.hdr
└──reference_scan.img
```

In the folder organization above, the `data` folder can be renamed to any name. Within this folder, the individual subject folders (ei. `sub-01`, `sub-02`, etc) can also be named freely. Within each subject's folder, the scans to be resliced must have a common filename format. For instance, in this example, the common file name root is `sub*.nii`. These scans must also be as separate 3D .nii volumes, and not concatenated 4D .nii files. `spm_25.01.02` is the location of the SPM software folder, which can be downloaded here: https://github.com/spm/spm/releases/tag/25.01.02. `reference_scan.hdr` and `reference_scan.img` are the img/hdr pairs for the reference scan, which contains the desired voxel sizes and image dimensions. This file can also be named freely as needed.

The output of this script will be placed in each subject's folder in the `data` folder with an added prefix. The original scans will be preserved. By default, the prefix added to each scan's name is `r_`, but this can be changed, as described below.

## Modifying Script Parameters

Before running the script, please modify the following input parameters in the `reslice.m` script:

`line 2`: Paste the path to your `data` folder with the scans that are to be resliced. Eg. `main_folder = 'Z:\People\JohnS\SemanticAssociation_fmriPrep_fMRI-CPCA\Data';`

`line 3`: If you would like a different prefix added to the resliced scans, then you may modify this line. The default setting is for the resliced scans to have a prefix of `r_`, but you may modify this. Eg. `output_prefix = 'resliced_';` if you would like the prefix to be `resliced_` for all the resliced scans.

`line 4`: Paste the path to the SPM software folder.

`line 5`: Paste the path to the reference scan with the desired voxel size and image dimensions. Eg. `reference_scan = 'Z:\People\JohnS\SemanticAssociation_fmriPrep_fMRI-CPCA\mask_used.hdr';` if your reference scan hdr/img pair is named `mask_used`.

`line 17`: This line should only be modified if your scans to be resliced do not follow the naming convention of `sub*.nii`. Eg. If your scans to be resliced contain the naming convention of A*.nii (`A01_scan01.nii`, `A01_scan02.nii`, etc), then you should modify this line to the following: `nii_files = dir(fullfile(subj_path, 'A*.nii'));`

## After Running the Script

The resliced scans will be placed in each subjects corresponding folder within the main `data` folder. The original scans will be preserved.

# Version Information

Version: 27August_2025
