#! /usr/bin/env bash

projectid="462000265"

training="${PWD##*/LUMI-training-lumio/courses/}"
if [[ "$training" == "$PWD" ]]
then
    echo "Failed to find the name of the course."
    exit
fi

echo "Pushing data for the training '$training' to LUMI-O."

#
# Push public data
# 
directory="../../public/$training"
repo="lumi-${projectid}-public"
if [ -d $directory ]
then
    echo "Found public data for training '$training', pushing now."
    find . -name ".DS_Store" -exec /bin/rm '{}' \;
    rclone mkdir "$repo:$training"
    rclone copy --bwlimit ${RCLONE_BWLIMIT:-0} "$directory" "$repo:$training"
else
    echo "No public data found for training '$training'."
fi

#
# Push private data
# 
directory="../../private/$training"
repo="lumi-${projectid}-private"
if [ -d $directory ]
then
    echo "Found private data for training '$training', pushing now."
    find . -name ".DS_Store" -exec /bin/rm '{}' \;
    rclone mkdir "$repo:$training"
    rclone copy --bwlimit ${RCLONE_BWLIMIT:-0} "$directory" "$repo:$training"
else
    echo "No private data found for training '$training'."
fi
