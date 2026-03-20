# Commands to execute on LUMI to prepare the software used in the 
# Amsterdam training of May 2024.
#
# These notes assume that the EasyConfig that will be used is already
# on the system in the contributed repository.
#
# Software is installed in the main LUMI training materials project so
# that it remains available for a while after the course.
#

training="2day-20251020"

umask 002

mkdir -p "/appl/local/training/EasyBuild/$training"
mkdir -p "/appl/local/training/modules/$training"

module --force purge
export EBU_USER_PREFIX="/appl/local/training/EasyBuild/$training"
module load init-lumi

module load LUMI/24.03 partition/common EasyBuild-user

eb lumi-training-tools-20241210.eb

cd "/appl/local/training/modules/$training"
ln -s "$EASYBUILD_INSTALLPATH_MODULES/lumi-training-tools"
