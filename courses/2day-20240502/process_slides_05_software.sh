#! /usr/bin/env bash

# Some variables.
slidestack="LUMI-2day-20240502-05-software"

slidealias=( \
    "Title" \
    "SoftwareStacksDesignConsiderations" \
    "SoftwareStacksTheLUMISolution" \
    "SoftwareStacksPolicies" \
    "SoftwareStacksOrganisation" \
    "SoftwareStacksAccessingCrayPE_1" \
    "SoftwareStacksAccessingCrayPE_2" \
    "SoftwareStacksAccessingCrayPE_3" \
    "EasyBuildInstallingSoftwareHPC" \
    "EasyBuildExtendingLUMIStack" \
    "EasyBuildEasyConfig" \
    "EasyBuildToolchain_1" \
    "EasyBuildToolchain_2" \
    "EasyConfigModuleNames" \
    "EasyBuildInstallingStep1 "\
    "EasyBuildInstallingStep2_1" \
    "EasyBuildInstallingStep2_2" \
    "EasyBuildInstallingStep3_partial_1" \
    "EasyBuildGROMACSSoftLib" \
    "EasyBuildGROMACSSearch_1" \
    "EasyBuildGROMACSSearch_2" \
    "EasyBuildInstallingStep3_partial_2" \
    "EasyBuildGROMACS_01" \
    "EasyBuildGROMACS_02" \
    "EasyBuildInstallingStep3_partial_3" \
    "EasyBuildGROMACS_03" \
    "EasyBuildGROMACS_04" \
    "EasyBuildGROMACS_05" \
    "EasyBuildGROMACS_06" \
    "EasyBuildGROMACS_07" \
    "EasyBuildGROMACS_08" \
    "EasyBuildInstallingStep3" \
    "EasyBuildInstallingStep3Note" \
    "EasyBuildAdvanced_1" \
    "EasyBuildAdvanced_2" \
    "EasyBuildAdvanced_3" \
    "EasyBuildTipsTricks" \
    "EasyBuildTraining" \
)

#
# Automatically set variables
#
training="${PWD##*/LUMI-training-lumio/courses/}"
if [[ "$training" == "$PWD" ]]
then
    echo "Failed to find the name of the course."
    exit
fi

#
# Do the actual work of renaming the slides
#

cd "../../public/$training/img/$slidestack"

number=0
for name in ${slidealias[@]}
do 
    number=$((number+1))
    echo "Moving Dia${number}.png to ${name}.png"
    /bin/mv -f "Dia${number}.png" "${name}.png"
done

