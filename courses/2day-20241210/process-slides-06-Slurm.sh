#! /usr/bin/env bash

# Some variables.
slidestack="LUMI-2day-20241210-06-Slurm"

slidealias=( \
    "Title" \
    "WhatIsSlurm" \
    "SlurmConceptsPhys" \
    "SlurmConceptsLog" \
    "BatchScheduler" \
    "BatchScript" \
    "Partitions_1" \
    "Partitions_2" \
    "PartitionsPerNode" \
    "PartitionsByResources" \
    "PartitionsCommands" \
    "PartitionsCommandsSinfo" \
    "Accounting" \
    "Fairness" \
    "ManageJob" \
    "CreateJob" \
    "PassingOptions" \
    "SpecifyingOptions" \
    "SpecifyingCommonOptions" \
    "SpecifyingOutput" \
    "RequestingCPUsGPUs" \
    "PerNode" \
    "PerNodeCPU" \
    "PerNodeGPU" \
    "PerNodeJobStep_1" \
    "PerNodeJobStep_2" \
    "PerNodeJobstepWarningGPU" \
    "PerNodeHardwareThreading" \
    "PerNodeHardwareThreadingExample_1" \
    "PerNodeHardwareThreadingExample_2" \
    "PerCoreWhenUse" \
    "PerCoreResources_1" \
    "PerCoreResources_2" \
    "PerCoreResources_3" \
    "PerCoreWarningSocket" \
    "PerCoreJobstep_1" \
    "PerCoreJobstep_2" \
    "JobEnvironment" \
    "PassingArguments" \
    "PassingArgumentsExample" \
    "AutomaticRequeueing" \
    "JobDependencies" \
    "JobInteractiveSalloc" \
    "JobInteractiveSrun" \
    "JobInteractiveAttach" \
    "JobArrays" \
    "HeterogeneousJobs" \
    "HeterogeneousJobsExampleSBATCH" \
    "HeterogeneousJobsExampleSrun" \
    "SimultaneousJobSteps" \
    "MonitoringSstat_1" \
    "MonitoringSstat_2" \
    "MonitoringSacct_1" \
    "MonitoringSacct_2" \
    "MonitoringSacct_3" \
    "MonitoringSreport" \
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

