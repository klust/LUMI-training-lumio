#! /usr/bin/env bash

# Some variables.
slidestack="LUMI-2day-20240502-03-access"

slidealias=( \
    "Title" \
    "WhoPays" \
    "ProjectsUsers_1" \
    "ProjectsUsers_2" \
    "ProjectManagement" \
    "FileSpacesUser" \
    "FileSpacesProject" \
    "FileSpacesFurtherInfo" \
    "Access" \
    "OpenOnDemand_01" \
    "OpenOnDemand_02" \
    "OpenOnDemand_03" \
    "OpenOnDemand_04" \
    "OpenOnDemand_05" \
    "OpenOnDemand_06" \
    "OpenOnDemand_07" \
    "OpenOnDemand_08" \
    "OpenOnDemand_09" \
    "DataTransfer" \
    "LUMIOWhatIs" \
    "LUMIOAccessing" \
    "LUMIOAccessingKeyGeneration" \
    "LUMIOCredentialsWeb_01" \
    "LUMIOCredentialsWeb_02" \
    "LUMIOCredentialsWeb_03" \
    "LUMIOCredentialsWeb_04" \
    "LUMIOCredentialsWeb_05" \
    "LUMIOCredentialsWeb_06" \
    "LUMIOCredentialsWeb_07" \
    "LUMIOConfiguringTools" \
    "LUMIORclone" \
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

