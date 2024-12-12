#! /usr/bin/env bash

# Some variables.
slidestack="LUMI-2day-next-04-Modules"

slidealias=( \
    "Title" \
    "ModuleEnvironments" \
    "ExploringWithLmod" \
    "BenefitsHierarchy" \
    "BenefitsHierarchyDemo" \
    "ModuleNamesFamilies" \
    "ModuleExtensions" \
    "ModuleSpiderPartial1" \
    "ModuleSpiderCommand_1" \
    "ModuleSpiderCommand_2" \
    "ModuleSpiderCommand_3" \
    "ModuleSpiderPartial2" \
    "ModuleSpiderFFTW" \
    "ModuleSpider" \
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
    "ModuleKeyword" \
    "ModuleKeywordHTTPS_1" \
    "ModuleKeywordHTTPS_2" \
    "StickyModules" \
    "ModuleAvail_1" \
    "ModuleAvail_2" \
    "ModuleAvail_3" \
    "ModuleAvail_4" \
    "ModuleAvail_5" \
    "ModuleAvail_6" \
    "ModuleAvail_7" \
    "ModuleAvail_8" \
    "ModuleAvail_9" \
    "ModuleAvail_10" \
    "ModuleAvail_11" \
    "ModuleAvail_12" \
    "ChangingDisplayStyle" \
    "GettingHelp" \
    "NoteCaching" \
    "NoteOtherCommands" \
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
    if [ -f "Dia$number.png" ]
    then
        echo "Moving Dia${number}.png to ${name}.png"
        /bin/mv -f "Dia${number}.png" "${name}.png"
    fi
done

#
# Do the actual work of renaming the images.
#

#cd "../${slidestack}-img"
#
#number=0
#for name in ${slidealias[@]}
#do 
#    number=$((number+1))
#    if [ -f "img$number.png" ]
#    then
#        echo "Moving img${number}.png to img-${name}.png"
#        /bin/mv -f "img${number}.png" "img-${name}.png"
#    fi
#done

