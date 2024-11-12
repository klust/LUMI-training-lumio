#! /usr/bin/env bash

training="${PWD##*/LUMI-training-lumio/courses/}"
if [[ "$training" == "$PWD" ]]
then
    echo "Failed to find the name of the course."
    exit
fi

videodir="/Users/klust/Projects/LUMI-Videoprocessing/ai-20241126/Rendered"

curdir=$PWD
cd ../..
rootdir=$PWD
cd $curdir

###############################################################################
#
# Now do the actual copying to the lumi-o preparation directories.
#

function copy_to_repo {

    # Input arguments
    # - 1: Repo: public or private
    # - 2: Video file

    repo="$1"
    video="$2"

    full_source="$videodir/$video.mp4"
    full_dest_dir="$rootdir/$repo/$training/recordings"
    full_dest="$full_dest_dir/$video.mp4"

    if [ -f "$full_source" ]
    then

        if [ -f "$full_dest" ]
        then

            md5_source="$(md5sum $full_source | cut -d ' ' -f1)"
            md5_dest="$(md5sum $full_dest | cut -d ' ' -f1)"
            #echo "DEBUG: $md5_source $md5_dest."

            if [[ "$md5_source" == "$md5_dest" ]]
            then

                echo "- No change to $full_source, not refresing $full_dest."

            else

                echo "- $full_source has changed, refreshing $full_dest."
                /bin/cp $full_source $full_dest

            fi

        else

            echo "- $full_dest does not yet exist, copying from $full_source"
            /bin/mkdir -p "$full_dest_dir"
            /bin/cp "$full_source" "$full_dest"

        fi

    else

        echo "- Source file $full_source does not (yet) exist"

    fi


} # end function copy_to_repo

#
# LUST stuff
#

copy_to_repo public 00_Course_Introduction
copy_to_repo public 01_Introduction
copy_to_repo public 02_Webinterface
copy_to_repo public E02_Webinterface
copy_to_repo public 03_FirstJob
copy_to_repo public E03_FirstJob
copy_to_repo public 04_Workarounds
copy_to_repo public E04_Workarounds
copy_to_repo public 05_RunningContainers
copy_to_repo public E05_RunningContainers
copy_to_repo public 06_BuildingContainers
copy_to_repo public 07_VirtualEnvironments
copy_to_repo public 08_MultipleGPUs
copy_to_repo public E08_MultipleGPUs
copy_to_repo public 09_Ray
copy_to_repo public E09_Ray
copy_to_repo public 10_ExtremeScale
copy_to_repo public E10_ExtremeScale
copy_to_repo public 11_LUMIO
copy_to_repo public 12_Coupling
