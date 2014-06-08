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
        # Clean up all text files in working directory first so we
        # start with a clean slate as far as data is conerned
        archiveAndRemoveTextFiles()
        
    }
    
    return( allOK )
}


#   Function: archiveAndCleanupTextFiles
#      Notes: will archive all text files into a zip file with the 
#           : current date as a name and then delete the text files 
#           : when done.
#    WARNING: THIS WILL DELETE FILES WITHOUT CONFIRMATION. TREAT WITH
#           : CARE.
# Parameters: none
#    Returns: nothing
archiveAndRemoveTextFiles <- function() {
    
}