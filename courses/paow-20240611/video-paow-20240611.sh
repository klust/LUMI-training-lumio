#! /usr/bin/env bash

training="${PWD##*/LUMI-training-lumio/courses/}"
if [[ "$training" == "$PWD" ]]
then
    echo "Failed to find the name of the course."
    exit
fi

videodir="/Users/klust/Projects/LUMI-Videoprocessing/$training/Rendered"

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

copy_to_repo public  1_00_Course_Introduction
copy_to_repo private 1_01_HPE_PE
copy_to_repo private E1_01_HPE_PE
copy_to_repo private 1_02_Perftools
copy_to_repo private 1_03_PerformanceOptimization
copy_to_repo private 1_04_ApplicationPlacement
copy_to_repo private 1_05_PerformanceAnalysisAtWork_1
copy_to_repo private 1_06_PerformanceAnalysisAtWork_2
copy_to_repo public  2_01_AMD_tools_1
copy_to_repo public  2_02_AMD_tools_2
copy_to_repo private 2_03_MPI
copy_to_repo private E2_03_MPI
copy_to_repo private 2_04_IO
