export ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS=2

antsCorticalThickness.sh -d 3 \
                         -o /Users/ntustison/Data/Public/ADNI/Templates/Normal/ants \
                         -p /Users/ntustison/Data/Public/Kirby/MultivariateTemplate/SymmetricTemplate/Priors2/priors%d.nii.gz \
                         -m /Users/ntustison/Data/Public/Kirby/MultivariateTemplate/SymmetricTemplate/S_template_BrainCerebellumProbabilityMask.nii.gz \
                         -e /Users/ntustison/Data/Public/Kirby/MultivariateTemplate/SymmetricTemplate/S_template3.nii.gz \
                         -a /Users/ntustison/Data/Public/ADNI/Templates/Normal/T_template0.nii.gz
