#! /usr/bin/env bash

training="${PWD##*/LUMI-training-lumio/courses/}"
if [[ "$training" == "$PWD" ]]
then
    echo "Failed to find the name of the course."
    exit
fi

#videodir="/Users/klust/Projects/LUMI-Videoprocessing/$training/Rendered"
videodir="/Users/klust/Projects/LUMI-Videoprocessing/20250303-2p3day-Stockholm/Rendered"

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
# HPE stuff
#

echo -e "\nProcessing HPE materials..."
copy_to_repo private 301-HPE_Cray_EX_Architecture
copy_to_repo private 302-Compilers_and_Parallel_Programming_Models
copy_to_repo private 303-Cray_Scientific_Libraries
copy_to_repo private 304-Offload_CCE
copy_to_repo private 305-Porting_to_GPU
copy_to_repo private 307-Debugging_at_Scale

copy_to_repo private 401-Introduction_to_Perftools
copy_to_repo private 402-Performance_Optimization_Improving_Single_Core
copy_to_repo private 403-Advanced_Performance_Analysis
copy_to_repo private 404-Cray_MPI_on_Slingshot

copy_to_repo private 501-Introduction_to_Python_on_Cray_EX
copy_to_repo private 503-IO_Optimization_Parallel_IO

#
# AMD stuff
#

echo -e "\nProcessing AMD materials..."
copy_to_repo public 306-Introduction_to_AMD_ROCm_Ecosystem
copy_to_repo public 405-AMD_ROCgdb_Debugger
copy_to_repo public 406-Introduction_to_Rocprof_Profiling_Tool
copy_to_repo public 503-AMD_Omnitrace
copy_to_repo public 504-AMD_Omniperf
copy_to_repo public 505-Best_Practices_GPU_Optimization

#
# LUST stuff
#

echo -e "\nProcessing LUST materials..."
#copy_to_repo public Demo1-Fooocus
#copy_to_repo public Demo2-Distributed_learning

copy_to_repo public I101-Introduction
copy_to_repo public 101-Architecture
copy_to_repo public 102-CPE
copy_to_repo public 103-Access
copy_to_repo public 104-Modules
copy_to_repo public 105-SoftwareStacks
copy_to_repo public 106-Support
copy_to_repo public I102-WrapUpDay1
copy_to_repo public I201-IntroductionDay2
copy_to_repo public 201-Slurm
copy_to_repo public 202-Binding
copy_to_repo public 203-Lustre
copy_to_repo public 204-ObjectStorage
copy_to_repo public 205-Containers
copy_to_repo public I202-WhatElse
