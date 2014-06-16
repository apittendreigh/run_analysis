#-----------------------------------------------------------------------------
#             Module: run_analysis.R
#         Written by: Alex Pittendreigh
#               Date: 8th June 2014
# Relies on Packages: data.table (enhanced data.frame)
#      Other Modules: utilities.R
#            Remarks: This is the main R driver program that will download,
#                   : extract, and process data files as required by the
#                   : project specification for the "Getting and Cleaning 
#                   : Data" unit of the Johns Hopkins University's "Data
#                   : Science" course on Coursera.
#-----------------------------------------------------------------------------

# Load required packages
require(data.table)

# Load required supplmentary modukes
source("utilities.R")

run_analysis <- function() {
    # Names of the raw data files
    RAW_DATA_FILES <- c("raw/activity_labels.txt",
                        "raw/features.txt",
                        "raw/features_info.txt",
                        "raw/subject_test.txt",
                        "raw/subject_train.txt",
                        "raw/X_test.txt",
                        "raw/X_train.txt",
                        "raw/y_test.txt",
                        "raw/y_train.txt" )

    # Declare empty data.tables for the raw data
    activities <- data.table()
    colnames <- data.table()
    testdata <- data.table()
    traindata <- data.table()
    testactivities <- data.table()
    trainactivities <- data.table()
    
    # table for the clean data at the end
    cleandata <- data.table()
    
    
    #   Function: loadRawData
    #      Notes: will load the raw data from text files locaed in the 'raw'
    #           : subdirectory into named data table structures to allow 
    #           : them to be manipulated.
    # Parameters: none
    #    Returns: nothing
    loadRawData <- function() {
        message("Please wait while data tables are loaded...")
        
        activities <<- as.data.table(read.table("raw/activity_labels.txt", 
                                  header = FALSE, 
                                  col.names = c("activitycode", "activityname")))
        
       colnames <<- as.data.table(read.table("raw/features.txt", 
                                  header = FALSE, 
                                  col.names = c("colnumber", "colname")))
       
        testdata <<- as.data.table(read.table("raw/X_test.txt", header = FALSE))
       
        traindata <<- as.data.table(read.table("raw/X_train.txt",
                                               header = FALSE))
       
        testactivities <<- as.data.table(read.table("raw/y_test.txt",
                                                    header = FALSE,
                                                    col.names = c("activitycode")))
       
       trainactivities <<- as.data.frame(read.table("raw/y_train.txt",
                                                     header = FALSE,
                                                     col.names = c("activitycode")))
    }
    

    #   Function: nameColumns
    #      Notes: cleans up the the loaded columns names and then applies the
    #           : names to the raw test and training data tables
    # Parameters: none
    #    Returns: nothing
    nameColumns <- function() {
        # clean up the column names
        colnames$colname <<- gsub(",", "_", colnames$colname)
        colnames$colname <<- gsub("\\()", "", colnames$colname)
        colnames$colname <<- gsub("\\)", "", colnames$colname)
        colnames$colname <<- gsub("\\(", "_", colnames$colname)
        colnames$colname <<- gsub("-", "_", colnames$colname)
        
        # apply column names to the test and training data tables
        
    }
    
    
    ##------------------------------------------------------------------------
    ## MAINLINE OF FUNCTION STARTS BELOW
    ##------------------------------------------------------------------------
    
    # If the files don't exist and/or cant be retrieved
    if ( !checkOrGetFiles( RAW_DATA_FILES )) {
        stop( "Cannot access raw data files." )    # Exit with error message
    } else {
        loadRawData()                              # load data from text files
        nameColumns()                              # name data columns
        print(colnames)
    }
}