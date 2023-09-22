#! /usr/bin/env bash

training="${PWD##*/LUMI-training-lumio/courses/}"
if [[ "$training" == "$PWD" ]]
then
    echo "Failed to find the name of the course."
    exit
fi

videodir='/Users/klust/Projects/LUMI-Videoprocessing/$training/Rendered'

###############################################################################
#
# Now do the actual copying to the lumi-o preparation directories.
#

function copy_to_repo {

    # Inmput arguments
    # - 1: Repo: public or private
    # - 2: Video file
    # - 3: Destination file

    repo="$1"
    video="$2"
    dest="$3"

    full_source="$videodir/$video.mp4"
    full_dest="$rootdir/$repo/$training/files/$video.mp4"

    if [ -f "$full_source" ]
    then

        if [ -f "$full_dest" ]
        then

            md5_source="$(md5sum $full_source | cut -d ' ' -f1)"
            md5_dest="$(md5sum $full_dest | cut -d ' ' -f1)"
            #echo "DEBUG: $md5_source $md5_dest."

            if [[ "$md5_source" == "$md5_dest" ]]
            then

                echo "- No change to $source, not refresing $dest."

            else

                echo "- $source has changed, refreshing $dest."
                /bin/cp $full_source $full_dest

            fi

        else

            echo "- $dest does not yet exist, copying from $source"
            /bin/cp $full_source $full_dest

        fi

    else
        echo "- Source file $source does not (yet) exist"
    fi


} # end function copy_to_repo

#
# HPE stuff
#

echo -e "\nProcessing HPE materials..."
copy_to_repo private 1_01_HPE_Cray_EX_Architecture
copy_to_repo private 1_02_Programming_Environment_and_Modules
copy_to_repo private 1_03_Running_Applications
copy_to_repo private 1_05_Compilers_and_Parallel_Programming_Models
copy_to_repo private 1_07_Cray_Scientific_Libraries
copy_to_repo private 1_09_Offload_CCE

copy_to_repo private 2_01_Advanced_Application_Placement
copy_to_repo private 2_03_Debugging_at_Scale

copy_to_repo private 3_01_Introduction_to_Perftools
copy_to_repo private 3_03_Advanced_Performance_Analysis
copy_to_repo private 3_05_Cray_MPI_on_Slingshot

copy_to_repo private  4_01_Performance_Optimization_Improving_Single_Core
copy_to_repo private 4_03_Introduction_to_Python_on_Cray_EX
copy_to_repo private 4_04_IO_Optimization_Parallel_IO

#
# AMD stuff
#

echo -e "\nProcessing AMD materials..."
copy_to_repo public 2_06_Introduction_to_AMD_ROCm_Ecosystem
copy_to_repo public  3_07_AMD_ROCgdb_Debugger
copy_to_repo public  3_09_Introduction_to_Rocprof_Profiling_Tool
copy_to_repo public  4_06_AMD_Ominitrace
copy_to_repo public  4_08_AMD_Ominiperf
copy_to_repo public  4_10_Best_Practices_GPU_Optimization

#
# LUST stuff
#

echo -e "\nProcessing LUST materials..."
copy_to_repo public  1_00_Introduction.mp4
copy_to_repo public 2_05_LUMI_Software_Stacks
copy_to_repo public  4_11_LUMI_Support_and_Documentation
