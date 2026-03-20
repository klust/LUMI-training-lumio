#! /usr/bin/env bash

# Some variables.
slidestack="LUMI-2day-20251020-203-Lustre"

slidealias=( \
    "Title" \
    "FileSystemLumi" \
    "LustreBuildingBlocks1_0_full" \
    "LustreBuildingBlocks1_1_separation" \
    "LustreBuildingBlocks1_2_MDS" \
    "LustreBuildingBlocks1_3_OSS" \
    "LustreBuildingBlocks1_4_client" \
    "LustreBuildingBlocks1_5_network" \
    "LustreBuildingBlocks2" \
    "LustreFileStriping" \
    "LustreFileAccess_0_full" \
    "LustreFileAccess_1_queryMDS" \
    "LustreFileAccess_2_returnMDS" \
    "LustreFileAccess_3_writeOSS" \
    "LustreParallelismKey_1" \
    "LustreParallelismKey_2" \
    "LustreDetermineParameters" \
    "LustreManageStriping1" \
    "LustreManageStriping2_0_full" \
    "LustreManageStriping2_1_dir" \
    "LustreManageStriping2_2_default" \
    "LustreManageStriping2_3_ost" \
    "LustreManageStriping3" \
    "LustreManageStriping4" \
    "LustreMDS_1" \
    "LustreMDS_2" \
    "LumiLustreOnLumi" \
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

