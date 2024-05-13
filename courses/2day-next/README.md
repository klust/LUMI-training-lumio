# Training materials from the next 2-day course

## Restructuring after the Amsterdam 2024 2-day training

-   Unifying the structure of all file names:
    -   Note pages
    -   Video pages
    -   PPTX files
    -   Video files
-   Proposed names, including capitalisation:
    -   00-Introduction
    -   01-Architecture
    -   02-CPE
    -   03-Access
    -   04-Modules
    -   05-SoftwareStacks
    -   06-WrapUpDay1
    -   07-IntroductionDay2
    -   08-Slurm
    -   09-Binding
    -   10-Lustre
    -   11-Containers
    -   12-Support
    -   13-WhatElse

## Scripts

-   `prepare_software.sh`: Commands to execute on LUMI to install some software used
    during the course in the course training archive project (`/appl/local/training`).

-   `proces_slides_*.sh`: Change the names of the exported slides (PNG 1920x1080) 
    in `public/2day-20240502/img/LUMI-2day-20240502-*` from `DiaXX.png` to the names
    used in the notes markdown document.

<!-- 
-   `video_4day_20240502.sh`: Get the videos from the video processing directory on my local
    computer and put them in the right place for pushing to LUMI-O.
-->