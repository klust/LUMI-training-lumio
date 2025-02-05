#! /usr/bin/env bash

# ID of the training project on LUMI.
projectid="465001707"

# Subdirectories as these have not been consistent across courses
SLIDES="slides"
#EXERCISES="Exercises"
# Additional variables
# - Pack the exercises in a tar file
#   This requires that the GitHub tag is made.
pack_exercises=1

#
# Regular code
#
training="${PWD##*/LUMI-training-lumio/courses/}"
if [[ "$training" == "$PWD" ]]
then
    echo "Failed to find the name of the course."
    exit
fi

echo "Processing data for the training '$training' to LUMI-O."

cd ../..
rootdir="$PWD"
mkdir -p "work/$training"
cd       "work/$training"

#
# First pull in the data from the training project
#

remoteroot="/project/project_$projectid"
connection="lumik"

#for subdir in $SLIDES $EXERCISES
#do
#    rsync -aPh --delete --exclude '.git' -e ssh "$connection:$remoteroot/$subdir/" "$PWD/$subdir"
#done
rsync -aPh --delete --exclude '.git' -e ssh "$connection:$remoteroot/$SLIDES/" "$PWD/$SLIDES"

#
# Get the GitHub release file.
#

if [ "$pack_exercises" = "1" ]  # Change variable at its definition to 1 after the course.
then 
    wget https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/archive/refs/tags/${training}.tar.gz
    gunzip ${training}.tar.gz
    mv ${training}.tar ${training}-Getting_Started_with_AI_workshop.tar
    bzip2 -k -9 ${training}-Getting_Started_with_AI_workshop.tar
fi

###############################################################################
#
# Now do the actual copying to the lumi-o preparation directories.
#

function copy_to_repo {

    # Input arguments
    # - 1: Repo: public or private
    # - 2: Source file
    # - 3: Destination file

    repo="$1"
    source="$2"
    dest="$3"

    full_source="$rootdir/work/$training/$source"
    full_dest="$rootdir/$repo/$training/files/$dest"

    if [ -f "$full_source" ]
    then

        if [ -f "$full_dest" ]
        then

            md5_source=$(md5sum "$full_source"| cut -d ' ' -f1)
            md5_dest=$(md5sum "$full_dest" | cut -d ' ' -f1)
            #echo "DEBUG: $md5_source $md5_dest."

            if [[ "$md5_source" == "$md5_dest" ]]
            then

                echo "- No change to '$source', not refreshing '$dest'."

            else

                echo "- '$source' has changed, refreshing '$dest'."
                /bin/cp "$full_source" "$full_dest"

            fi

        else

            echo "- '$dest' does not yet exist, copying from '$source'"
            /bin/mkdir -p "$rootdir/$repo/$training/files"
            /bin/cp "$full_source" "$full_dest"

        fi

    else
        echo "- Source file '$source' does not (yet) exist"
    fi


} # end function copy_to_repo

#
# Now process all materials.
#

echo -e "\nProcessing materials..."

copy_to_repo public "01_Introduction_to_LUMI/1-lumi-intro.pdf"                                                                                      "LUMI-$training-01-Lumi_intro.pdf"
copy_to_repo public "02_Using_the_LUMI_web-interface/Using LUMI web UI.pdf"                                                   "LUMI-$training-02-Using_LUMI_web_UI.pdf"
copy_to_repo public "03_Your_first_AI_training_job_on_LUMI/First AI job on LUMI.pdf"                                          "LUMI-$training-03-First_AI_job.pdf"
copy_to_repo public "04_Understanding_GPU_activity_and_checking_jobs/Session-04-Understanding GPU activity.pdf"               "LUMI-$training-04-Understanding_GPU_activity.pdf"
#copy_to_repo public "$SLIDES/AMD/Session-04-Understanding GPU activity.pdf"                                                   "LUMI-$training-04-Understanding_GPU_activity.pdf"
copy_to_repo public "05_Running_containers_on_LUMI/Running_containers_on_LUMI_espoo.pdf"                                      "LUMI-$training-05-Running_containers_on_LUMI.pdf"
copy_to_repo public "06_Bulding_containers_from_conda_pip_environments/6-Building_containers_from_conda_pip_environments.pdf" "LUMI-$training-06-Building_containers_from_conda_pip_environments.pdf"
copy_to_repo public "07_Extending_containers_with_virtual_environments_for_faster_testing/LUMI_07_virtual_environments.pdf"   "LUMI-$training-07-Extending_containers.pdf"
copy_to_repo public "08_Scaling_to_multiple_GPUs/Scaling AI to multiple GPUs.pdf"                                             "LUMI-$training-08-Scaling_multiple_GPUs.pdf"
copy_to_repo public "09_Extreme_scale_AI/Session-09- Extreme scale AI training on LUMI.pdf"                                   "LUMI-$training-09-Extreme_scale_AI.pdf"
#copy_to_repo public "$SLIDES/AMD/Session-09- Extreme scale AI training on LUMI.pdf"                                           "LUMI-$training-09-Extreme_scale_AI.pdf"
copy_to_repo public "09b_Loading_training_data/Training_Data_on_LUMI.pdf"                                                     "LUMI-$training-10-Training_Data_on_LUMI.pdf"
copy_to_repo public "10_Coupling_AI_and_Simulation/Coupling_Simulation_and_AI.pdf"                                            "LUMI-$training-11-Coupling_Simulation_and_AI.pdf"

copy_to_repo public "${training}-Getting_Started_with_AI_workshop.tar"               "${training}-Getting_Started_with_AI_workshop.tar"
copy_to_repo public "${training}-Getting_Started_with_AI_workshop.tar.bz2"           "${training}-Getting_Started_with_AI_workshop.tar.bz2"
