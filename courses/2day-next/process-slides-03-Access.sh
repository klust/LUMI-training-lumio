#! /usr/bin/env bash

# Some variables.
slidestack="LUMI-2day-next-03-Access"

slidealias=( \
    "Title" \
    "EuroHPCSupercomputers" \
    "WhoPays" \
    "ProjectsUsers_1" \
    "ProjectsUsers_2" \
    "ProjectManagement" \
    "FileSpacesUser" \
    "FileSpacesProject1" \
    "FileSpacesProject2" \
    "FileSpacesQuota" \
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
    "OpenOnDemand_10" \
    "DataTransfer" \
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

