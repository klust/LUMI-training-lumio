#! /usr/bin/env bash

# Some variables.
slidestack="LUMI-UD-20270303-EasyBuild"

slidealias=( \
    "Title" \
    "Section01" \
    "SoftwareHPC1" \
    "SoftwareHPC2" \
    "SoftwareHPC3" \
    "SoftwareHPC4" \
    "EasybuildOnLUMI" \
    "ExtensibleStacks" \
    "History" \
    "Section02" \
    "InstallationSteps1" \
    "InstallationSteps2" \
    "InstallationImplementation" \
    "InstallationImplementationGraphical" \
    "EasyBuildFramework" \
    "EasyBuildEasyBlock" \
    "EasyBuildEasyConfig" \
    "EasyBuildEnvironmentModules" \
    "EasyBuildDependencies1" \
    "EasyBuildDependencies2" \
    "EasyBuildBundlesExtensions" \
    "EasyBuildToolchain1" \
    "EasyBuildToolchain2" \
    "EasyBuildToolchainLUMIStack" \
    "EasyBuildToolchainEESSI1" \
    "EasyBuildToolchainEESSI2" \
    "EasyBuildToolchainLUMIAI" \
    "EasyConfigModuleNames" \
    "Section03" \
    "EasyConfigIntroParameters" \
    "EasyConfigIntoLibpng1" \
    "EasyConfigIntoLibpng2" \
    "EasyConfigIntoLibpng2" \
    "EasyConfigEasyBlockOrEasyConfig" \
    "Questions" \
)

#
# Automatically set variables
#
training="${PWD##*/LUMI-training-lumio/courses/}"
if [[ "$training" == "$PWD" ]]
then
    echo "Failed to find the name of the course."
    exit
else
    echo "Processing slides in public/$training/img/$slidestack..."
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

