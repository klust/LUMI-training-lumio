#! /usr/bin/env bash

# Adapt the next one by hand!
videodir="/Users/klust/Projects/LUMI-Videoprocessing/20250602-2day-Espoo20250602-2day-Espoo/Rendered"

training="${PWD##*/LUMI-training-lumio/courses/}"
if [[ "$training" == "$PWD" ]]
then
    echo "Failed to find the name of the course."
    exit
fi

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

echo -e "\nProcessing LUST materials..."
#copy_to_repo public Demo1-Fooocus
#copy_to_repo public Demo2-Distributed_learning

copy_to_repo public I01-Introduction
copy_to_repo public 01-Architecture
copy_to_repo public 02-CPE
copy_to_repo public 03-Access
copy_to_repo public 04-Modules
copy_to_repo public 05-SoftwareStacks
copy_to_repo public 06-Support
copy_to_repo public I02-WrapUpDay1
copy_to_repo public I03-IntroductionDay2
copy_to_repo public 07-Slurm
copy_to_repo public 08-Binding
copy_to_repo public 09-Lustre
copy_to_repo public 10-ObjectStorage
copy_to_repo public 11-Containers
copy_to_repo public I04-WhatElse
