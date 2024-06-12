# LUMI-training-lumio

Scripts to archive the course materials.

## How to use

-   For each course, make a directory in the courses directory. The name should correspond to:
    -   A subdirectory in the public subdirectory with data that should go to LUMI-O and be web-accessible
    -   A subdirectory in the privare subdirectory with data that should go to LUMI-O but not be publicly accessible
    -   The name of a bucket in the LUMI-O training project
    -   The name of a subdirectory in `/appl/local/training` on LUMI.

-   To synchronise to LUMI-O:
    -   Go to the subdirectory in the courses subdirectory for the course.
    -   From this directory, run the `rclone-to-lumio.sh` script from the scripts subdirectory. E.g.,
  
        ```
        ../../scripts/rclone-to-lumio.sh
        ```

    -   It is possible by limiting the bandwidth used by `rclone` for this operation by setting the
        environment variable `RCLONE_BWLIMIT` to a valid argument for the `--bwlimit` flag of
        `rclone`. E.g.,

        ```
        export RCLONE_BWLIMIT=512K
        ```

        On slow connections it is a very good idea to limit the amount of bandwidth that is used
        as we have experienced frequent error messages when running at full speed from a home link
        with a 10 Mbit/s upload limit.


## How to save web pages for future reference?

The course materials from AMD often contain materials on [hackmd.io](https://hackmd.io).

Options to save those for future use:

-   Print to PDF is rarely an option as the pages often use boxes with code that are
    to wide for the saved page format.

-   [MHTML](https://en.wikipedia.org/wiki/MHTML) is a file format to save web sites 
    as a single page, encapsulating pictures in a similar way as in e-mail. It was
    orginally developed by Microsoft, but many Chromium-based browsers support it,
    with Firefox and Safari as notable exceptions.

    The quality of the layout was better in our experiments than the next option.

-   [SingleFile](https://github.com/gildas-lormeau/SingleFile) is a browser extension
    available for several browsers. It also enables saving a web page including the figures
    as a single file. It looks like most if not all browsers can read the files.

    We did notice more layout problems with this option though.

-   Safari has its own format, [webarchive](https://en.wikipedia.org/wiki/Webarchive).
