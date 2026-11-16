#! /usr/bin/env bash

# Some variables.
slidestack="LUMI-2day-20261109-202-Binding"

slidealias=( \
    "Title" \
    "WhatAbout" \
    "WhenDone" \
    "WhyNeedThis" \
    "CheckBindings" \
    "CoreNumbering" \
    "GPUNumbering_1" \
    "GPUNumbering_2" \
    "GPUNumberingRemarks" \
    "SlurmTaskDistribution_1" \
    "SlurmTaskDistribution_2" \
    "SlurmTaskDistribution_3" \
    "SlurmTaskCPUWhy" \
    "SlurmTaskCPUHow" \
    "SlurmTaskCPUMasks" \
    "SlurmTaskCPUExamples" \
    "MPICHRankRedistribution1" \
    "MPICHRankRedistribution2" \
    "MPICHNICSelection" \
    "OpenMPBinding" \
    "OpenMPBindingPlaces" \
    "OpenMPBindingProcBind" \
    "GPUBindingSlurm" \
    "GPUBindingROCR" \
    "GPUMap_1" \
    "GPUMap_2" \
    "GPUMapRing" \
    "GPUBindingMechanism" \
    "MapLinearGCDSlurm" \
    "MapLinearGCDWrapperSingleCores" \
    "MapLinearGCDWrapperMasks" \
    "MapLinearCCDSlurm" \
    "MapLinearCCDWrapperSingleCores" \
    "MapLinearCCDWrapperMasks" \
    "MapLinearCCDWrapperCPTOpenMP" \
    "MapGreenRingStructure" \
    "MapGreenRingWrapperSingleCores" \
    "MapGreenRingWrapperMasks" \
    "GPUBindingAllocateByResource" \
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

