#!/bin/bash
#
# This file is used to process a single subject using the ANTs Longitudinal Cortical Thickness 
# pipeline with the ADNI normal Template. The output contains a SST, cortical thickness maps, relevant priors and transformations
#
# Usage:    ./scripts/LCT_processing.sh ./data/sub-RID0018/
# 
#
# Command Template:
# antsLongitudinalCorticalThickness.sh -d imageDimension
#              -e brainTemplate
#              -m brainExtractionProbabilityMask
#              -p brainSegmentationPriors
#              <OPTARGS>
#              -o outputPrefix
#              ${anatomicalImages[@]}
#
# Data: Subject data is located here
# /mnt/local/gdrive/public/DATA/Human_Data/BIDS/sub-RID$$$$
#
# Thomas Campbell Arnold
# tcarnold@seas.upenn.edu
# 
# 5/23/2019 - created
# 10/3/2019 - updated for ADNI template, and renamed
# 8/10/2020 - updated for Kevin
# 

DATA_DIR=./data/${1}/
TEMPLATE_DIR=./tools/ADNI_normal_atlas/

# setup output directory
OUT_DIR=./analysis/${1}/
mkdir $OUT_DIR

# get number of files (used to determine number of cores to use)
img_N=$(ls -l ${DATA_DIR}*.nii* | wc -l)

antsLongitudinalCorticalThickness.sh -d 3 \
              -c 2 \
              -j ${img_N} \
              -e ${TEMPLATE_DIR}T_template0.nii.gz \
              -m ${TEMPLATE_DIR}T_template0_BrainCerebellumProbabilityMask.nii.gz \
              -p ${TEMPLATE_DIR}Priors/priors%d.nii.gz \
              -f ${TEMPLATE_DIR}T_template0_BrainCerebellumExtractionMask.nii.gz \
              -o ${OUT_DIR} \
              ${DATA_DIR}*.nii* 
              