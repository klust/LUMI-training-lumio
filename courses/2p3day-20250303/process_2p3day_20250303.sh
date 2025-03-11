#! /usr/bin/env bash

# ID of the training project on LUMI.
projectid="465001726"

# Subdirectories as these have not been consistent across courses
SLIDES="Slides"
EXERCISES="Exercises"

# Additional variables
# - Add overwrites for lumi_c.sh and lumi_g.sh in exercises/HPE
overwrite=1
# - Pack the exercises in a tar file for HPE and one for AMD
pack_exercises=1

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

popd

mkdir -p overwrite/$EXERCISES/HPE/day3/VH1-io
pushd overwrite/$EXERCISES/HPE/day3/VH1-io

gtar -xf ../../../../../$EXERCISES/HPE/day3/VH1-io/VH1-io.tar
sed -e 's/-s \${STRIPE_SIZE}/-S \${STRIPE_SIZE}/' -i '' VH1-io/README
gtar -cf VH1-io.tar VH1-io
/bin/rm -rf VH1-io

# Need to set the timestamp of the file as otherwise we'll get
# a different tar file everytime the script runs.
touch -r ../../../../../$EXERCISES/HPE/day3/VH1-io/VH1-io.tar VH1-io.tar

popd

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
    pushd $EXERCISES/AMD/HPCTrainingExamples/HIP/jacobi ; make -f Makefile.cray clean ; popd
    find . -name "*.swp" -exec /bin/rm -f '{}' \;

    #
    # Create the tar files
    #
    if [ -d "$EXERCISES/HPE" ]
    then
        echo -e "\nCreating tar-file with HPE exercises..."
        gtar -cf exercises_HPE.tar $EXERCISES/HPE
        if [ "$overwrite" = "1" ]; 
        then
            cd overwrite
            gtar -rf ../exercises_HPE.tar $EXERCISES/HPE
            cd ..
        fi
        # Compress but use --keep to preserve the input file also
        bzip2 -f --keep --best exercises_HPE.tar
    fi
    if [ -d "$EXERCISES/AMD" ]
    then
        echo -e "\nCreating tar-file with AMD exercises..."
        gtar -cf exercises_AMD.tar $EXERCISES/AMD
        # Compress but use --keep to preserve the input file also
        bzip2 -f --keep --best exercises_AMD.tar
    fi
fi

if [ -d "$EXERCISES/AMD/Pytorch" ]
then
    echo -e "\nCreating tar-file with AMD demo scripts..."

    mkdir -p $SLIDES/AMD
    pushd $EXERCISES/AMD
    demo_scripts="session-6-scripts"
    gtar -cf "../../$SLIDES/AMD/$demo_scripts.tar" --exclude=.git Pytorch
    bzip2 -f --keep --best "../../$SLIDES/AMD/$demo_scripts.tar"
    touch -r Pytorch "../../$SLIDES/AMD/$demo_scripts.tar"
    touch -r Pytorch "../../$SLIDES/AMD/$demo_scripts.tar.bz2"
    popd
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

            md5_source="$(md5sum "$full_source" | cut -d ' ' -f1)"
            md5_dest="$(md5sum "$full_dest" | cut -d ' ' -f1)"
            #echo "DEBUG: $md5_source $md5_dest."

            if [[ "$md5_source" == "$md5_dest" ]]
            then

                echo "- No change to $source, not refreshing $dest."

            else

                echo "- $source has changed, refreshing $dest."
                /bin/cp "$full_source" "$full_dest"

            fi

        else

            echo "- $dest does not yet exist, copying from $source"
            /bin/mkdir -p "$rootdir/$repo/$training/files"
            /bin/cp "$full_source" "$full_dest"

        fi

    else
        echo "- Source file $source does not (yet) exist"
    fi


} # end function copy_to_repo

#
# HPE stuff
#

echo -e "\nProcessing HPE materials..."
copy_to_repo public  "$EXERCISES/HPE/day1/ProgrammingModels/ProgrammingModelExamples_SLURM.pdf"  "LUMI-$training-302-ProgrammingModelExamples_SLURM.pdf"
copy_to_repo private "$SLIDES/HPE/01_Architecture_PE_modules_slurm.pdf"                  "LUMI-$training-301-HPE_Cray_EX_Architecture.pdf"
copy_to_repo private "$SLIDES/HPE/02_Compilers_and_Programming_Models.pdf"               "LUMI-$training-302-Compilers_and_Parallel_Programming_Models.pdf"
copy_to_repo private "$SLIDES/HPE/03_Libraries.pdf"                                      "LUMI-$training-303-Cray_Scientific_Libraries.pdf"
copy_to_repo private "$SLIDES/HPE/04_Directives_Programming.pdf"                         "LUMI-$training-304-Offload_CCE.pdf"
#copy_to_repo private "$SLIDES/HPE/12_2_GPU_porting.pdf"                                  "LUMI-$training-305-Porting_to_GPU.pdf"
copy_to_repo private "$SLIDES/HPE/06_debugging_at_scale.pdf"                             "LUMI-$training-306-Debugging_at_Scale.pdf"
copy_to_repo private "$SLIDES/HPE/07_introduction_to_perftools.pdf"                      "LUMI-$training-401-Introduction_to_Perftools.pdf"
copy_to_repo private "$SLIDES/HPE/08_cpu_performance_optimization.pdf"                   "LUMI-$training-402-Performance_Optimization_Improving_Single_Core.pdf"
copy_to_repo private "$SLIDES/HPE/09_advanced_performance_analysis_merged.pdf"           "LUMI-$training-403-Advanced_Performance_Analysis.pdf"
copy_to_repo private "$SLIDES/HPE/10_cray_mpi_short.pdf"                                 "LUMI-$training-404-Cray_MPI_on_Slingshot.pdf"
copy_to_repo private "$SLIDES/HPE/05_GPU_porting.pdf"                                    "LUMI-$training-501-Porting_to_GPU.pdf"
copy_to_repo private "$SLIDES/HPE/11_Python_Frameworks.pdf"                              "LUMI-$training-502-Introduction_to_Python_on_Cray_EX.pdf"
copy_to_repo private "$SLIDES/HPE/12_IO_short_LUMI.pdf"                                  "LUMI-$training-503-IO_Optimization_Parallel_IO.pdf"

#copy_to_repo public  "$SLIDES/HPE/Exercises.pdf"                                         "LUMI-$training-1_Exercises_day1.pdf"
#copy_to_repo public  "$SLIDES/HPE/Exercises.pdf"                                         "LUMI-$training-2_Exercises_day2.pdf"
#copy_to_repo public  "$SLIDES/HPE/Exercises.pdf"                                         "LUMI-$training-3_Exercises_day3.pdf"
copy_to_repo private "$SLIDES/HPE/Exercises.pdf"                                         "LUMI-$training-Exercises_HPE.pdf"

# Files that are generated by this script
copy_to_repo private "exercises_HPE.tar"                                                 "LUMI-$training-Exercises_HPE.tar"
copy_to_repo private "exercises_HPE.tar.bz2"                                             "LUMI-$training-Exercises_HPE.tar.bz2"

#
# AMD stuff
#

echo -e "\nProcessing AMD materials..."
copy_to_repo public "$SLIDES/AMD/session 01a - HIP and ROCm.pdf"                                 "LUMI-$training-305-Introduction_to_AMD_ROCm_Ecosystem.pdf"
#copy_to_repo public "$SLIDES/AMD/session 01b - HIP Optimization.pdf"                             "LUMI-$training-305-Extra_HIP_Optimization.pdf"
copy_to_repo public "$SLIDES/AMD/session 02 - Debugging with rocgdb.pdf"                         "LUMI-$training-405-AMD_ROCgdb_Debugger.pdf"
copy_to_repo public "$SLIDES/AMD/session 03 - introduction to rocprof.pdf"                       "LUMI-$training-406-Introduction_to_Rocprof_Profiling_Tool.pdf"
copy_to_repo public "$SLIDES/AMD/session 04 - omnitrace.pdf"                                     "LUMI-$training-504-AMD_Omnitrace.pdf"
copy_to_repo public "$SLIDES/AMD/session 05 - omniperf.pdf"                                      "LUMI-$training-505-AMD_Omniperf.pdf"
copy_to_repo public "$SLIDES/AMD/session 06 - ToolsInActionPytorchExample-LUMI-2025-sfantao.pdf" "LUMI-$training-506-Best_Practices_GPU_Optimization.pdf"

# Files that are generated by this script
copy_to_repo public "$SLIDES/AMD/session-6-scripts.tar"                                  "LUMI-$training-506-scripts.tar"
copy_to_repo public "$SLIDES/AMD/session-6-scripts.tar.bz2"                              "LUMI-$training-506-scripts.tar.bz2"

copy_to_repo public "exercises_AMD.tar"                                                  "LUMI-$training-Exercises_AMD.tar"
copy_to_repo public "exercises_AMD.tar.bz2"                                              "LUMI-$training-Exercises_AMD.tar.bz2"

#
# LUST stuff
#

echo -e "\nProcessing LUST materials..."
#copy_to_repo public "$SLIDES/LUST/LUMI-4day-20241028-software.pdf"                       "LUMI-4day-20241028-2_07_software_stacks.pdf"
#copy_to_repo public "$SLIDES/LUST/LUMI-4day-20231003-LUMI_Support_and_Documentation.pdf" "LUMI-4day-20241028-4_12_LUMI_Support_and_Documentation.pdf"
