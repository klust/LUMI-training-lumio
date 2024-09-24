#! /usr/bin/env bash

# Some variables.
slidestack="LUMI-4day-20241028-software"

slidealias=( \
    "IntroTitle" \
    "IntroWhatThisTalkIs" \
    "SoftwareStacksDesignConsiderations" \
    "SoftwareStacksTheLUMISolution" \
    "SoftwareStacksPolicies" \
    "SoftwareStacksOrganisation" \
    "SoftwareStacksAccessingCrayPE_1" \
    "SoftwareStacksAccessingCrayPE_2" \
    "SoftwareStacksAccessingCrayPE_3" \
    "LMODExploringModulesLMOD" \
    "LMODModuleSpiderOverview" \
    "LMODModuleSpiderCommand_1" \
    "LMODModuleSpiderCommand_2" \
    "LMODModuleSpiderCommand_3" \
    "LMODModuleSpiderGnuplot_1" \
    "LMODModuleSpiderGnuplot_2" \
    "LMODModuleSpiderCMake_1" \
    "LMODModuleSpiderGnuplotVersion_1" \
    "LMODModuleSpiderGnuplotVersion_2" \
    "LMODModuleSpiderCMakeVersion_1" \
    "LMODModuleKeyword" \
    "LMODModuleKeywordHTTPS_1" \
    "LMODModuleKeywordHTTPS_2" \
    "LMODStickyModules" \
    "LMODModuleAvail_1" \
    "LMODModuleAvail_2" \
    "LMODModuleAvail_3" \
    "LMODModuleAvail_4" \
    "LMODModuleAvail_5" \
    "LMODModuleAvail_6" \
    "LMODModuleAvail_7" \
    "LMODModuleAvail_8" \
    "LMODModuleAvail_9" \
    "LMODModuleAvail_10" \
    "LMODModuleAvail_11" \
    "LMODModuleAvail_12" \
    "LMODModuleAvail_13" \
    "LMODChangingModuleListDisplay" \
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
    "EasyBuildGROMACSDep_01" \
    "EasyBuildGROMACSDep_02" \
    "EasyBuildInstallingStep3_partial_3" \
    "EasyBuildGROMACSInst_01" \
    "EasyBuildGROMACSInst_02" \
    "EasyBuildGROMACSInst_03" \
    "EasyBuildGROMACSInst_04" \
    "EasyBuildGROMACSInst_05" \
    "EasyBuildGROMACSInst_06" \
    "EasyBuildInstallingStep3" \
    "EasyBuildInstallingStep3Note" \
    "EasyBuildAdvanced_1" \
    "EasyBuildAdvanced_2" \
    "EasyBuildAdvanced_3" \
    "EasyBuildTipsTricks" \
    "EasyBuildTraining" \
    "ContainersIntro" \
    "ContainersNotProvide" \
    "ContainersCanDoOnLUMI" \
    "ContainersManaging_1" \
    "ContainersExamplePull_1" \
    "ContainersExamplePull_2" \
    "ContainersExamplePull_3" \
    "ContainersManaging_2" \
    "ContainersInteracting" \
    "ContainersExampleShell" \
    "ContainersExampleExec" \
    "ContainersExampleRun" \
    "ContainersRunning" \
    "ContainersEnvironmentEnhancement_1" \
    "ContainersEnvironmentEnhancement_2" \
    "ContainersExampleWrapper_1" \
    "ContainersExampleWrapper_2" \
    "ContainersExampleWrapper_3" \
    "ContainersExampleWrapper_4" \
    "ContainersExampleWrapper_5" \
    "ContainersExampleWrapper_6" \
    "ContainersEnvironmentEnhancement_3" \
    "ContainersLimitations" \
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

