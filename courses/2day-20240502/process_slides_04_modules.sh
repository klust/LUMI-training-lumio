#! /usr/bin/env bash

# Some variables.
slidestack="LUMI-2day-20240502-04-modules"

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
    "ChangingDisplayStyle" \
    "GettingHelp" \
    "NoteCaching" \
    "NoteOtherCommands" \
)

#
# Not really needed, we'll just check if an ImgXX file exists before
# doing the move.
#
imgalias=( \
    "None" \
    "None" \
    "None" \
    "None" \
    "BenefitsHierarchyDemo" \
    "None" \
    "None" \
    "None" \
    "ModuleSpiderCommand_1" \
    "ModuleSpiderCommand_2" \
    "ModuleSpiderCommand_3" \
    "ModuleSpiderFFTW" \
    "ModuleSpiderFFTWVersion_1" \
    "ModuleSpiderFFTWVersion_2" \
    "None" \
    "ModuleSpiderGnuplot_1" \
    "ModuleSpiderGnuplot_2" \
    "ModuleSpiderGnuplotVersion_1" \
    "ModuleSpiderGnuplotVersion_2" \
    "None" \
    "ModuleSpiderCMake" \
    "ModuleSpiderCMakeVersion_1" \
    "ModuleSpiderCMakeVersion_2" \
    "None" \
    "ModuleKeywordHTTPS_1" \
    "ModuleKeywordHTTPS_2" \
    "ModuleKeywordHTTPS_3" \
    "ModuleKeywordHTTPS_4" \
    "ModuleKeywordHTTPS_5" \
    "None" \
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

