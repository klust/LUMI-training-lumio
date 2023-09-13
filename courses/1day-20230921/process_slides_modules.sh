#! /usr/bin/env bash

# Some variables.
slidestack="LUMI-1day-202310XX-03-modules"

slidealias=( \
    "Title" \
    "ModuleEnvironments" \
    "ExploringWithLmod" \
    "BenefitsHierarchy" \
    "BenefitsHierarchyDemo" \
    "ModuleNamesFamilies" \
    "ModuleExtensions" \
    "ModuleSpider" \
    "ModuleSpiderCommand_1" \
    "ModuleSpiderCommand_2" \
    "ModuleSpiderCommand_3" \
    "ModuleSpiderFFTW" \
    "ModuleSpiderFFTWVersion_1" \
    "ModuleSpiderFFTWVersion_2" \
    "ModuleSpiderRegular" \
    "ModuleSpiderGnuplot_1" \
    "ModuleSpiderGnuplot_2" \
    "ModuleSpiderGnuplotVersion_1" \
    "ModuleSpiderGnuplotVersion_2" \
    "ModuleSpiderExtensions" \
    "ModuleSpiderCMake" \
    "ModuleSpiderCMakeVersion_1" \
    "ModuleSpiderCMakeVersion_2" \
    "ModuleKeyword" \
    "ModuleKeywordHTTPS_1" \
    "ModuleKeywordHTTPS_2" \
    "ModuleKeywordHTTPS_3" \
    "ModuleKeywordHTTPS_4" \
    "ModuleKeywordHTTPS_5" \
    "StickyModules" \
    "ModuleAvail_1" \
    "ModuleAvail_2" \
    "ModuleAvail_3" \
    "ModuleAvail_4" \
    "ModuleAvail_5" \
    "ModuleAvail_6" \
    "ChangingDisplayStyle" \
    "GettingHelp" \
    "NoteCaching" \
    "NoteOtherCommands" \
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

