#! /usr/bin/env bash

# Some variables.
slidestack="LUMI-2day-20240502-08-lustre"

slidealias=( \
    "Title" \
    "FileSystemLumi" \
    "LustreBuildingBlocks1" \
    "LustreBuildingBlocks2" \
    "LustreFileStriping" \
    "LustreFileAccess" \
    "LustreParallelismKey_1" \
    "LustreParallelismKey_2" \
    "LustreDetermineParameters" \
    "LustreManageStriping1" \
    "LustreManageStriping2" \
    "LustreManageStriping3" \
    "LustreManageStriping4" \
    "LustreMDS" \
    "LumiLustreOnLumi" \
    "LumiStorageAreas" \
    "LumiObjectStorage" \
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

