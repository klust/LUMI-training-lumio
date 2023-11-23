#! /usr/bin/env bash

# Some variables.
slidestack="LUMI-4day-20231003-software"

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
    "LMODModuleSpiderCMakeVersion_2" \
    "LMODModuleKeyword" \
    "LMODModuleKeywordHTTPS_1" \
    "LMODModuleKeywordHTTPS_2" \
    "LMODModuleKeywordHTTPS_3" \
    "LMODModuleKeywordHTTPS_4" \
    "LMODModuleKeywordHTTPS_5" \
    "LMODStickyModules" \
    "LMODModuleAvail_1" \
    "LMODModuleAvail_2" \
    "LMODModuleAvail_3" \
    "LMODModuleAvail_4" \
    "LMODModuleAvail_5" \
    "LMODModuleAvail_6" \
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
    "EasyBuildInstallingStep3" \
    "EasyBuildGROMACS_01" \
    "EasyBuildGROMACS_02" \
    "EasyBuildGROMACS_03" \
    "EasyBuildGROMACS_04" \
    "EasyBuildGROMACS_05" \
    "EasyBuildGROMACS_06" \
    "EasyBuildGROMACS_07" \
    "EasyBuildGROMACS_08" \
    "EasyBuildGROMACS_09" \
    "EasyBuildGROMACS_10" \
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

