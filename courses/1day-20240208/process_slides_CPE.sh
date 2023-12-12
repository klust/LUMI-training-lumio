#! /usr/bin/env bash

# Some variables.
slidestack="LUMI-1day-20230921-02-CPE"

slidealias=( \
    "Title" \
    "WhyKnow" \
    "OperatingSystem" \
    "ProgrammingModels" \
    "DevelopmentEnvironment" \
    "CrayComplingEnv" \
    "ScientificLibraries" \
    "CrayMPI" \
    "Lmod" \
    "CompilerWrappers" \
    "SelectingCPEVersion" \
    "TargetModules" \
    "PrgEnvCompilerModules" \
    "GettingHelp" \
    "ChatGPT" \
    "OtherModules" \
    "WarningLibraryPath" \
    "WarningOrderMatters" \
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

