# Training materials from the next 2-day course

## Restructuring after the Amsterdam 2024 2-day training

-   Unifying the structure of all file names:
    -   Note pages
    -   Video pages
    -   PPTX files
    -   Video files
-   Proposed names, including capitalisation:
    -   Main notes:
        -   00-Introduction
        -   01-Architecture
        -   02-CPE
        -   03-Access
        -   04-Modules
        -   05-SoftwareStacks
        -   06-WrapUpDay1
        -   07-IntroductionDay2
        -   06-Slurm
        -   07-Binding
        -   08-Lustre
        -   09-Containers
        -   10-Support
    -   Corresponding exercises have the same name, but with an `E` added in front of the name
    -   Introductions: Name starts with an I
        -   I01-IntroductionCourse
        -   I02-WrapUpDay1
        -   I03-IntroductionDay2
        -   I04-WhatElse
    -   Materials overview pages have the same name but with a `M` added to the front of it.


## Scripts

-   `prepare-software.sh`: Commands to execute on LUMI to install some software used
    during the course in the course training archive project (`/appl/local/training`).

-   `proces-slides-*.sh`: Change the names of the exported slides (PNG 1920x1080) 
    in `public/2day-next/img/LUMI-2day-next-*` from `DiaXX.png` to the names
    used in the notes markdown document.

-   `video-2day-next.sh`: Get the videos from the video processing directory on my local
    computer and put them in the right place for pushing to LUMI-O.
