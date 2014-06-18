#-----------------------------------------------------------------------------
#             Module: utilities.R
#         Written by: Alex Pittendreigh
#               Date: 8th June 2014
# Relies on Packages: 
#      Other Modules:
#            Remarks: This is the file of supplementary routines required by 
#                   : the run_analysis.R module.
#                   :
#                   : It contains functions that are needed to do the house-
#                   : keeping rather than having them embedded in the main 
#                   : module which controlls the processing. This module
#                   : has routines for creating directories and files, 
#                   : downloading of files, unarchiving files etc. Each
#                   : function has a short description to it's purpose.
#-----------------------------------------------------------------------------


#   Function: checkOrGetFiles
#      Notes: This iteration of the function simply checks to see if the named 
#           : file is located in the working directory. If this is the case  
#           : then returns TRUE else will attempt to download and extract the 
#           : file. Can be enhanced for better error checking, date checks etc.
# Parameters: filesToCheck - chara array with names of the requested files
#    Returns: boolean indicating if the files exists or not
checkOrGetFiles <- function( filesToCheck ) {
    allOK <- TRUE
    
    # cycle through the names checking to make sure that all exist
    for ( fileName in filesToCheck ) {
        if ( !file.exists( fileName )) {
            allOK <- FALSE                # current file doesn't exist
        }
    }
    
    # If at least one of the named files doesn't exist
    if ( !allOK ) {
        okayToDownload <- FALSE
        
        if ( file.exists( "raw" )) {
            # Assume this has been run before & ask if cleanup required
            # Clean up all text files in working directory first so we
            # start with a clean slate as far as data is conerned
            cleanUpIsOkay <- prompter( "Do you wish to archive and refresh the existing raw data files? (y/n) ")
            if ( toupper( cleanUpIsOkay ) == "Y" ) {
                archiveAndRemoveRawDataFiles()
                okayToDownload <- TRUE
            }
        } else {
            # make sure the required data directories exist
            dir.create( "raw" )       # Already know this doesn't exit so create it
            if ( !file.exists( "data" )) { dir.create( "data" ) }
            okayToDownload <- TRUE
        }
        
        if ( okayToDownload ) {
            # Attempt to donload the data file from the web
            fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
            downloadAndExtract( fileUrl )
        }
        
        # Check that there are data files in the 'raw folder for processing
        if ( file.exists( "raw/X_test.txt" )) {
            allOK <- TRUE   # Assume all files there ready for processing
        }
    }
    
    return( allOK )
}


#   Function: archiveAndCleanupRawDataFiles
#      Notes: will archive all raw data files into a zip file with the 
#           : current date as a name and then delete the raw data files 
#           : when done.
# Parameters: none
#    Returns: nothing
archiveAndRemoveRawDataFiles <- function() {
    # make sure the "raw" and "data" directories exists and
    # create then if needed
    if ( !file.exists( "raw" )) { dir.create( "raw" ) }
    if ( !file.exists( "data" )) { dir.create( "data" ) }
    
    # zip up all *.txt files into a ZIP file with current data
    zipFile <- format( Sys.time(), "raw/%b_%d_%Y_%X_%Z.zip" )
    textFiles <- c("raw/activity_labels.txt",
                   "raw/features.txt",
                   "raw/features_info.txt",
                   "raw/subject_test.txt",
                   "raw/subject_train.txt",
                   "raw/X_test.txt",
                   "raw/X_train.txt",
                   "raw/y_test.txt",
                   "raw/y_train.txt" )
    zip( zipFile, textFiles )
    
    # If the zip file was created then delete the text files
    if ( file.exists( zipFile )) {
        file.remove( textFiles )
    }
}


#   Function: prompter
#      Notes: Displays the prompter and optionally the vector of
#           : valid responses. Keeps displaying the prompt to the
#           : user until a valid response is entered. 
#           :
#           : This could be made more eloquent but does the job
# Parameters: prompt - string to be disokayed to user
#           : valid_reponses - vector of valid responses. Defaults
#           : to c("y", "Y", "n", "N")
#    Returns: character string matching a valid response
prompter <- function( prompt, valid_response = c( "Y", "y", "N", "n" )) {
    response <- "GigO001"     # garbage so loop is entered

    while ( !response %in% valid_response ) {
        response <- readline( prompt )
    }

    return( response )
}


#   Function: downLoadAndExtract
#      Notes: Will attempt to download the named file from the 
#           : Internet and extract its contents. 
# Parameters: fileUrl - URI for file to be downloaded
#    Returns: nothing
downloadAndExtract <- function( fileUrl ) {
    message( "Starting download... please be patient" )
    download.file( fileUrl, 
                   dest = "getdata_projectfiles_UCI HAR Dataset.zip", 
                   method = "curl",
                   quiet = TRUE )
    
    # Now to extract the raw data
    message( "Downloading finished... now extracting the contents" )
    extractFiles <- c( "UCI HAR Dataset/test/subject_test.txt",
                       "UCI HAR Dataset/test/X_test.txt",
                       "UCI HAR Dataset/test/y_test.txt",
                       "UCI HAR Dataset/train/subject_train.txt",
                       "UCI HAR Dataset/train/X_train.txt",
                       "UCI HAR Dataset/train/y_train.txt", 
                       "UCI HAR Dataset/activity_labels.txt",
                       "UCI HAR Dataset/features.txt",
                       "UCI HAR Dataset/features_info.txt" )
    unzip( "getdata_projectfiles_UCI HAR Dataset.zip",
           files = extractFiles,
           exdir = "raw",
           junkpaths = TRUE )
    
    # message to user indicated data is downloaded and extracted.
    message( "Raw data has now been downloaded and extracted to the 'raw' directory" )
}