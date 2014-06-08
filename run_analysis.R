#-----------------------------------------------------------------------------
#             Module: run_analysis.R
#         Written by: Alex Pittendreigh
#               Date: 8th June 2014
# Relies on Packages:
#      Other Modules: utilities.R
#            Remarks: This is the main R driver program that will download,
#                   : extract, and process data files as required by the
#                   : project specification for the "Getting and Cleaning 
#                   : Data" unit of the Johns Hopkins University's "Data
#                   : Science" course on Coursera.
#-----------------------------------------------------------------------------

# Load required packages

# Load required supplmentary modukes
source("utilities.R")

# Mainline - Entry point for the module
run_analysis <- function() {
    # Name of the data files
    RAW_DATA_FILES <- c()
    
    # If the files don't exist and/or cant be retrieved
    if ( !checkOrGetFiles( RAW_DATA_FILES )) {
        stop( "Cannot access raw data files." )    # Exit with error message
    }
}