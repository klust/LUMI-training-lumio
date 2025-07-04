#! /usr/bin/env bash

# Some variables.
slidestack="LUMI-2day-20250602-106-Support"

slidealias=( \
    "Title" \
    "DistributedNature1" \
    "L0Training" \
    "L0ReadTheDocs1" \
    "L0ReadTheDocs2" \
    "L0ReadTheDocs3" \
    "L0ReadTheDocs4" \
    "L0ReadTheDocs5" \
    "L0Colleagues" \
    "LUST1" \
    "LUST2" \
    "LUST3" \
    "TicketsHowNot" \
    "TicketsImprovedLogin" \
    "Tickets1issue1ticket" \
    "TicketsSubject" \
    "TicketsThinkWithUs1" \
    "TicketsThinkWithUs2" \
    "TicketsXY" \
    "HelpdeskRestrictions" \
    "HelpdeskCanCannot1" \
    "HelpdeskCanCannot2" \
    "HelpdeskCanCannot3" \
    "HelpdeskCanCannot4" \
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

