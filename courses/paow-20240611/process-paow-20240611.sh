#! /usr/bin/env bash

# ID of the training project on LUMI.
projectid="465001154"

# Subdirectories as these have not been consistent across courses
SLIDES="Slides"
EXERCISES="Exercises"

# Additional variables
# - Add overwrites for lumi_c.sh and lumi_g.sh in exercises/HPE
overwrite=1
# - Pack the exercises in a tar file for HPE and one for AMD
pack_exercises=1

# Programs
GNUTAR=tar
#GNUTAR=gtar

################################################################################

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

for subdir in $SLIDES $EXERCISES
do
    rsync -aPh --delete --exclude '.git' -e ssh "$connection:$remoteroot/$subdir/" "$PWD/$subdir"
done

#
# Overwrite some scripts (activate only after the course)
#

if [ "$overwrite" = "1" ]  # Change variable at its definition to 1 after the course.
then 

    echo -e "\nOverwriting scripts to set the environment for the exercises..."

    mkdir -p overwrite/$EXERCISES/HPE
    pushd overwrite/$EXERCISES/HPE

    sed -e 's|\(export SLURM_ACCOUNT=project\)_.*|\1_46YXXXXXX|' \
        -e 's|export SLURM_RESERVATION=.*|unset SLURM_RESERVATION|' \
        ../../../$EXERCISES/HPE/lumi_c.sh > lumi_c_after.sh
    sed -e 's|\(export SLURM_ACCOUNT=project\)_.*|\1_46YXXXXXX|' \
        -e 's|export SLURM_RESERVATION=.*|unset SLURM_RESERVATION|' \
        ../../../$EXERCISES/HPE/lumi_g.sh > lumi_g_after.sh

    # Need to set the timestamp of the file as otherwise we'll get
    # a different tar file everytime the script runs.
    touch -r ../../../$EXERCISES/HPE/lumi_c.sh lumi_c_after.sh
    touch -r ../../../$EXERCISES/HPE/lumi_g.sh lumi_g_after.sh

    popd # from pushd overwrite/$EXERCISES/HPE

fi

#
# Create some tar files with the exercises and software as these need to be copied
# by the user anyway.
#

if [ "$pack_exercises" = "1" ]
then
    #
    # Do some clean-up
    #
    echo -e "\nDoing some cleanup of the exercises directories before packing..."
    #pushd $EXERCISES/AMD/HPCTrainingExamples/HIP/jacobi ; make -f Makefile.cray clean ; popd
    find . -name "*.swp" -exec /bin/rm -f '{}' \;

    #
    # Create the tar files
    #
    if [ -d "$EXERCISES/HPE" ]
    then
        echo -e "\nCreating tar-file with HPE exercises..."
        $GNUTAR -cf exercises_HPE.tar $EXERCISES/HPE
        if [ "$overwrite" = "1" ]; 
        then
            cd overwrite
            $GNUTAR -rf ../exercises_HPE.tar $EXERCISES/HPE
            cd ..
        fi
        # Compress but use --keep to preserve the input file also
        bzip2 -f --keep --best exercises_HPE.tar
    fi
    if [ -d "$EXERCISES/AMD" ]
    then
        echo -e "\nCreating tar-file with AMD exercises..."
        $GNUTAR -cf exercises_AMD.tar $EXERCISES/AMD
        # Compress but use --keep to preserve the input file also
        bzip2 -f --keep --best exercises_AMD.tar
    fi
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

            md5_source="$(md5sum $full_source | cut -d ' ' -f1)"
            md5_dest="$(md5sum $full_dest | cut -d ' ' -f1)"
            #echo "DEBUG: $md5_source $md5_dest."

            if [[ "$md5_source" == "$md5_dest" ]]
            then

                echo "- No change to $source, not refreshing $dest."

            else

                echo "- $source has changed, refreshing $dest."
                /bin/cp $full_source $full_dest

            fi

        else

            echo "- $dest does not yet exist, copying from $source"
            /bin/mkdir -p "$rootdir/$repo/$training/files"
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

# Temporary - to delete after the course
#copy_to_repo public  "$EXERCISES/HPE/03_mpi/ProgrammingModelExamples_SLURM.pdf"               "LUMI-$training-E-2-03-ProgrammingModelExamples_SLURM.pdf"
#copy_to_repo public  "$SLIDES/HPE/Exercises.pdf"                                              "LUMI-$training-Exercises_HPE_Day1.pdf"
#copy_to_repo public  "$SLIDES/HPE/Exercises.pdf"                                              "LUMI-$training-Exercises_HPE_Day2.pdf"

copy_to_repo private "$SLIDES/HPE/01_Architecture_PE_modules_slurm.pdf"                       "LUMI-$training-1_01_Architecture_PE_modules_slurm.pdf"
copy_to_repo private "$SLIDES/HPE/02_introduction_to_performance_analysis_with_perftools.pdf" "LUMI-$training-1_02_introduction_to_performance_analysis_with_perftools.pdf"
copy_to_repo private "$SLIDES/HPE/03_cpu_performance_optimization.pdf"                        "LUMI-$training-1_03_cpu_performance_optimization.pdf"
copy_to_repo private "$SLIDES/HPE/04_Application_Placement.pdf"                               "LUMI-$training-1_04_Application_Placement.pdf"
copy_to_repo private "$SLIDES/HPE/05_Demo.pdf"                                                "LUMI-$training-1_05_Demo.pdf"
copy_to_repo private "$SLIDES/HPE/06_cray_mpi_short.pdf"                                      "LUMI-$training-2_03_cray_mpi.pdf"
copy_to_repo private "$SLIDES/HPE/07_IO_short_LUMI.pdf"                                       "LUMI-$training-2_04_IO_LUMI.pdf"

copy_to_repo private "$SLIDES/HPE/Exercises.pdf"                                              "LUMI-$training-Exercises_HPE.pdf"
copy_to_repo private "exercises_HPE.tar"                                                      "LUMI-$training-Exercises_HPE.tar"
copy_to_repo private "exercises_HPE.tar.bz2"                                                  "LUMI-$training-Exercises_HPE.tar.bz2"

#
# AMD stuff
#

echo -e "\nProcessing AMD materials..."
copy_to_repo public "$SLIDES/AMD/AMD-session-1a-profiler-tools-overview.pdf"           "LUMI-$training-2_01_profiler-tools-overview.pdf"
copy_to_repo public "$SLIDES/AMD/AMD-session-1b-omnitrace-by-example.pdf"              "LUMI-$training-2_01_omnitrace-by-example.pdf"
copy_to_repo public "$SLIDES/AMD/AMD-session-2-omiperf.pdf"                            "LUMI-$training-2_02_omiperf.pdf"

# No files for the AMD exercises this time.
#copy_to_repo public "exercises_AMD.tar"                                                "LUMI-$training-Exercises_AMD.tar"
#copy_to_repo public "exercises_AMD.tar.bz2"                                            "LUMI-$training-Exercises_AMD.tar.bz2"
