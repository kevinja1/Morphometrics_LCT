This code provides an example of how longitudinal cortical thickness is estimated using ANTs.

Useage:
./scripts/LCT_example.sh

Relevant packages:
	ANTs
		Borel location: /mnt/local/gdrive/public/TOOLS/ANTs/bin/
		This code uses ANTs (https://github.com/ANTsX/ANTs) to estimate cortical thickness. For ANTs installation instructions, see this blog post (https://brianavants.wordpress.com/2012/04/13/updated-ants-compile-instructions-april-12-2012/).
	c3d
		Borel location: /mnt/local/gdrive/public/TOOLS/c3d
		For a simple package that can give you .nii file information, resize images, and perform other basic manipulations check out c3d.
		https://sourceforge.net/p/c3d/git/ci/master/tree/doc/c3d.md
	On Borel
		To get these packages on borel, you can edit ~/.bashrc
		vim ~/.bashrc
		export ANTSPATH=/gdrive/public/TOOLS/ANTs/bin/
		export PATH=${ANTSPATH}:$PATH
		export PATH="$PATH:/gdrive/public/TOOLS"

Date Note:
All information in the dataset has been dateshifted to protect patient privacy. The central event is the patient's operation, which occurs 12/31/2000. All images from 2000 onward are postoperative images, which images from 1999 and earlier are preoperative images. A word of caution, when looking at preoperative images (1999 or earlier) make sure the patient doesn't have electrodes implanted. Patients often recieve an MRI during the sEEG/ECoG localization period. Electrodes are typically implanted 6 months before surgery so choose images that are from before then.

OS Note:
Depending on your system, you may need to use dos2unix on the scripts prior to running to eliminate incosistencies between OS interpretation. You may also need to change permissions to make the code executable via chmod. Something similar to the below commands should get the job done.
dos2unix ./scripts/*
chmod +x ./scripts/*

nice Note:
You may notice some commands have "nice -n 1 " prepended to them. This lowers the priority of the job to insure that other users can access the server. It's important to lower your priority when you're running really long jobs, otherwise you block users from accessing CPUs when they need them.
https://www.howtoforge.com/linux-nice-command/

Thomas Campbell Arnold
tcarnold@seas.upenn.edu
8/11/2020 - created

Kevin Mathew
kevinja1@wharton.upenn.edu
8/28/2020 Update

Currently, scripts/LCT_example works if you configure your paths correctly. I have started working on scripts/LCT_multiple.sh to process multiple subjects at once. Currently, it throws an error as the dates for the scans for each patient is different. The script can be run by ./scripts/LCT_multiple.sh 

The ultimate goal of the script is to use the LCT to build a model that predicts surgical outcome for epilepsy patients. Here are the future steps that need to be conducted:

1) Finish generalized code to run for multiple subjects
2) Extract annualized change in cortical thickness for brain regions in ./tools/atlases/AAL116_origin_MNI_T1.nii
3) Use extracted features to predict surgical outcomes (good vs poor)

The surgical outcomes for specific patients is listed in a spreadsheet in the folder called HUP_outcomes. I have also attached a presentation and summary for my work over summer 2020.