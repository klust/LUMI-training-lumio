#! /usr/bin/env bash

# Some variables.
slidestack="LUMI-2day-20241210-10-ObjectStorage"

slidealias=( \
    "Title" \
    "WhyKnow" \
   "LUMIOWhatIs_1" \
    "LUMIOWhatIs_2" \
    "LustreVsLUMIO_1" \
    "LustreVsLUMIO_2" \
    "LustreVsLUMIO_3" \
    "LUMIOAccessing" \
    "LUMIOCredentialWebOverview" \
    "LUMIOCredentialsWebCreate_01" \
    "LUMIOCredentialsWebCreate_02" \
    "LUMIOCredentialsWebCreate_03" \
    "LUMIOCredentialsWebCreate_04" \
    "LUMIOCredentialsWebCreate_05" \
    "LUMIOCredentialsWebExtend" \
    "LUMIOCredentialsWebToolConfig_01" \
    "LUMIOCredentialsWebToolConfig_02" \
    "LUMIOCredentialsOODCreate_01" \
    "LUMIOCLIToolConfig" \
    "LUMIOCLIToolConfigRclone" \
    "TipsAndTricks_01" \
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

