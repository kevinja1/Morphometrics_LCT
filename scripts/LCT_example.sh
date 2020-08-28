#!/bin/bash
#
# This wrapper script copies a subjects files to your directory, processes them
# using LCT_processing.sh, and deletes irrelevant output files.
#
# Usage:	./scripts/LCT_example.sh
#
# Thomas Campbell Arnold
# tcarnold@seas.upenn.edu
# 
# 8/10/2020 - created

# copy data to directory
mkdir -p ./data/sub-RID0018/
filenames[0]=sub-RID0018_ses-clin19960802_acq-3D_T1w.nii.gz
filenames[1]=sub-RID0018_ses-clin19990728_acq-3D_T1w.nii.gz
cp /mnt/local/gdrive/public/DATA/Human_Data/BIDS/sub-RID0018/ses-clin19960802/anat/${filenames[0]} ./data/sub-RID0018/
cp /mnt/local/gdrive/public/DATA/Human_Data/BIDS/sub-RID0018/ses-clin19990728/anat/${filenames[1]} ./data/sub-RID0018/

# resample to 1/8th of image size so example runs fast
# NOTE: DO NOT DO THIS TO REAL DATA. THIS IS SOLEY DONE SO THE EXAMPLE PROCESSES
# QUICKLY. DATA QUALITY IS SEVERLY DIMINISHED BY THIS STEP.
# c3d ./data/sub-RID0018/${filenames[0]} -resample 12.5% -o ./data/sub-RID0018/${filenames[0]}
# c3d ./data/sub-RID0018/${filenames[1]} -resample 12.5% -o ./data/sub-RID0018/${filenames[1]}

# process subjects cortical thickness
nice -n 1 ./scripts/LCT_processing.sh sub-RID0018

# filenames without extenstions
filenames_no_ext[0]="${filenames[0]%.*.*}"
filenames_no_ext[1]="${filenames[1]%.*.*}"

# delete many of the intermediate files
for i in 0 1
do
	mkdir ./data/sub-RID0018/tmp
	fname=${filenames_no_ext[$i]}
	cp ./analysis/sub-RID0018/${fname}_${i}/${fname}BrainNormalizedToTemplate.nii.gz ./data/sub-RID0018/tmp/
	cp ./analysis/sub-RID0018/${fname}_${i}/${fname}BrainSegmentation.nii.gz ./data/sub-RID0018/tmp/
	cp ./analysis/sub-RID0018/${fname}_${i}/${fname}BrainSegmentation0N4.nii.gz ./data/sub-RID0018/tmp/
	cp ./analysis/sub-RID0018/${fname}_${i}/${fname}CorticalThickness.nii.gz ./data/sub-RID0018/tmp/
	cp ./analysis/sub-RID0018/${fname}_${i}/${fname}CorticalThicknessNormalizedToTemplate.nii.gz ./data/sub-RID0018/tmp/
	cp ./analysis/sub-RID0018/${fname}_${i}/${fname}SubjectToTemplate0GenericAffine.mat ./data/sub-RID0018/tmp/
	cp ./analysis/sub-RID0018/${fname}_${i}/${fname}SubjectToTemplate1Warp.nii.gz ./data/sub-RID0018/tmp/
	rm -r ./analysis/sub-RID0018/${fname}_${i}/
	mv ./data/sub-RID0018/tmp/ ./analysis/sub-RID0018/${fname}_${i}/
done
