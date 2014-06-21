#-----------------------------------------------------------------------------
#             Module: run_analysis.R
#         Written by: Alex Pittendreigh
#               Date: 8th June 2014
# Relies on Packages: plyr, reshape2, stringr
#      Other Modules: utilities.R
#            Remarks: This is the main R driver program that will download,
#                   : extract, and process data files as required by the
#                   : project specification for the "Getting and Cleaning 
#                   : Data" unit of the Johns Hopkins University's "Data
#                   : Science" course on Coursera.
#-----------------------------------------------------------------------------

# Load required packages
library( plyr )
library( stringr )
library( reshape2 )

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
    activities <- data.frame()
    colnames <- data.frame()
    testdata <- data.frame()
    traindata <- data.frame()
    testactivities <- data.frame()
    trainactivities <- data.frame()
    testsubjects <- data.frame()
    trainsubjects <- data.frame()
    rawdata <- data.frame()
    
    # table for the tidy data at the end
    tidydata <- data.frame()
    
    
    #   Function: loadRawData
    #      Notes: will load the raw data from text files locaed in the 'raw'
    #           : subdirectory into named data table structures to allow 
    #           : them to be manipulated.
    # Parameters: none
    #    Returns: nothing
    loadRawData <- function() {
        message("Please wait while data tables are loaded...")
        
        activities <<- read.table("raw/activity_labels.txt", 
                                  header = FALSE, 
                                  col.names = c("activitycode", "activityname"))
        
        colnames <<- read.table("raw/features.txt", 
                               header = FALSE, 
                               col.names = c("colnumber", "colname"))
       
        testdata <<- read.table("raw/X_test.txt", header = FALSE)
       
        traindata <<- read.table("raw/X_train.txt", header = FALSE)
       
        testactivities <<- read.table("raw/y_test.txt",
                                      header = FALSE,
                                      col.names = c("activitycode"))
       
        trainactivities <<- read.table("raw/y_train.txt",
                                       header = FALSE,
                                       col.names = c("activitycode"))
        
        testsubjects <<- read.table("raw/subject_test.txt", 
                                    header = FALSE,
                                    col.names = c("subjectid"))
        
        trainsubjects <<- read.table("raw/subject_train.txt",
                                     header = FALSE,
                                     col.names = c("subjectid"))
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
        names(testdata) <<- colnames$colname
        names(traindata) <<- colnames$colname
    }
    

    #   Function: mergeData
    #      Notes: Combines the raw data tables into a single data
    #           : table that can be processed. 
    # Parameters: none
    #    Returns: nothing
    mergeData <- function() {
        message("Merging raw data...")
        
        # combine data
        testactivities <<- merge(testactivities, activities)
        trainactivities <<- merge(trainactivities, activities)
        testdata <<- cbind(testdata, 
                           activity = testactivities$activityname)
        testdata <<- cbind(testdata,
                           subject = testsubjects$subjectid)
        traindata <<- cbind(traindata, 
                            activity = trainactivities$activityname)
        traindata <<- cbind(traindata, 
                            subject = trainsubjects$subjectid)
        rawdata <<- testdata
        rawdata <<- rbind(rawdata, traindata)
    }
    
    
    #   Function: extractData
    #      Notes: Extracts columns from the combined raw data frame to
    #           : be consolidated into a tidy data frame with new 
    #           : variable (column) names. 
    # Parameters: none
    #    Returns: nothing
    extractData <- function() {
        message('Compiling first clean data set...')
        
        # get the needed variables from the raw data frame
        tempdata <- data.frame(activity = rawdata$activity,
                               subject = rawdata$subject,
                               time_mean_x_axis_body_accel = rawdata$tBodyAcc_mean_X,
                               time_mean_y_axis_body_accel = rawdata$tBodyAcc_mean_Y,
                               time_mean_z_axis_body_accel = rawdata$tBodyAcc_mean_Z,
                               time_sdev_x_axis_body_accel = rawdata$tBodyAcc_std_X,
                               time_sdev_y_axis_body_accel = rawdata$tBodyAcc_std_Y,
                               time_sdev_z_axis_body_accel = rawdata$tBodyAcc_std_Z,
                               time_mean_x_axis_gravity_accel = rawdata$tGravityAcc_mean_X,
                               time_mean_y_axis_gravity_accel = rawdata$tGravityAcc_mean_Y,
                               time_mean_z_axis_gravity_accel = rawdata$tGravityAcc_mean_Z,
                               time_sdev_x_axis_gravity_accel = rawdata$tGravityAcc_std_X,
                               time_sdev_y_axis_gravity_accel = rawdata$tGravityAcc_std_Y,
                               time_sdev_z_axis_gravity_accel = rawdata$tGravityAcc_std_Z,
                               time_mean_x_axis_body_accel_jerk = rawdata$tBodyAccJerk_mean_X,
                               time_mean_y_axis_body_accel_jerk = rawdata$tBodyAccJerk_mean_Y,
                               time_mean_z_axis_body_accel_jerk = rawdata$tBodyAccJerk_mean_Z,
                               time_sdev_x_axis_body_accel_jerk = rawdata$tBodyAccJerk_std_X,
                               time_sdev_y_axis_body_accel_jerk = rawdata$tBodyAccJerk_std_Y,
                               time_sdev_z_axis_body_accel_jerk = rawdata$tBodyAccJerk_std_Z, 
                               time_mean_x_axis_body_gyro = rawdata$tBodyGyro_mean_X,
                               time_mean_y_axis_body_gyro = rawdata$tBodyGyro_mean_Y,
                               time_mean_z_axis_body_gyro = rawdata$tBodyGyro_mean_Z,
                               time_sdev_x_axis_body_gyro = rawdata$tBodyGyro_std_X,
                               time_sdev_y_axis_body_gyro = rawdata$tBodyGyro_std_Y,
                               time_sdev_z_axis_body_gyro = rawdata$tBodyGyro_std_Z,
                               time_mean_x_axis_body_gyro_jerk = rawdata$tBodyGyroJerk_mean_X,
                               time_mean_y_axis_body_gyro_jerk = rawdata$tBodyGyroJerk_mean_Y,
                               time_mean_z_axis_body_gyro_jerk = rawdata$tBodyGyroJerk_mean_Z,
                               time_sdev_x_axis_body_gyro_jerk = rawdata$tBodyGyroJerk_std_X,
                               time_sdev_y_axis_body_gyro_jerk = rawdata$tBodyGyroJerk_std_Y,
                               time_sdev_z_axis_body_gyro_jerk = rawdata$tBodyGyroJerk_std_Z,
                               time_mean_body_accel_magnification = rawdata$tBodyAccMag_mean,
                               time_sdev_body_accel_magnification = rawdata$tBodyAccMag_std,
                               time_mean_gravity_accel_magnification = rawdata$tGravityAccMag_mean,
                               time_sdev_gravity_accel_magnification = rawdata$tGravityAccMag_std,
                               ffor_mean_x_axis_body_accel = rawdata$fBodyAcc_mean_X,
                               ffor_mean_y_axis_body_accel = rawdata$fBodyAcc_mean_Y,
                               ffor_mean_z_axis_body_accel = rawdata$fBodyAcc_mean_Z,
                               ffor_sdev_x_axis_body_accel = rawdata$fBodyAcc_std_X,
                               ffor_sdev_y_axis_body_accel = rawdata$fBodyAcc_std_Y,
                               ffor_sdev_z_axis_body_accel = rawdata$fBodyAcc_std_Z,
                               ffor_mean_x_axis_body_accel_jerk = rawdata$fBodyAccJerk_mean_X,
                               ffor_mean_y_axis_body_accel_jerk = rawdata$fBodyAccJerk_mean_Y,
                               ffor_mean_z_axis_body_accel_jerk = rawdata$fBodyAccJerk_mean_Z,
                               ffor_sdev_x_axis_body_accel_jerk = rawdata$fBodyAccJerk_std_X,
                               ffor_sdev_y_axis_body_accel_jerk = rawdata$fBodyAccJerk_std_Y,
                               ffor_sdev_z_axis_body_accel_jerk = rawdata$fBodyAccJerk_std_Z, 
                               ffor_mean_x_axis_body_gyro = rawdata$fBodyGyro_mean_X,
                               ffor_mean_y_axis_body_gyro = rawdata$fBodyGyro_mean_Y,
                               ffor_mean_z_axis_body_gyro = rawdata$fBodyGyro_mean_Z,
                               ffor_sdev_x_axis_body_gyro = rawdata$fBodyGyro_std_X,
                               ffor_sdev_y_axis_body_gyro = rawdata$fBodyGyro_std_Y,
                               ffor_sdev_z_axis_body_gyro = rawdata$fBodyGyro_std_Z,
                               ffor_mean_body_accel_magnification = rawdata$fBodyAccMag_mean,
                               ffor_sdev_body_accel_magnification = rawdata$fBodyAccMag_std,
                               ffor_mean_body_accel_jerk_magnification = rawdata$fBodyBodyAccJerkMag_mean,
                               ffor_sdev_body_accel_jerk_magnification = rawdata$fBodyBodyAccJerkMag_std,
                               ffor_mean_body_gyro_magnification = rawdata$fBodyBodyGyroMag_mean,
                               ffor_sdev_body_gyro_magnification = rawdata$fBodyBodyGyroMag_std,
                               ffor_mean_body_gyro_jerk_magnification = rawdata$fBodyBodyGyroJerkMag_mean,
                               ffor_sdev_body_gyro_jerk_magnification = rawdata$fBodyBodyGyroJerkMag_std
        )
        
        # sort data frame by activity and then by subject
        tempdata <- arrange(tempdata, activity, subject)
        
        # write the tidy data to the data directory in the form of a .RData
        # file as well as a .csv (comman delimited) file
        message("Writing cleansed data to disk in 'data' directory...")
        write.tabView le( tempdata, 
                     file = "data/tidy_data.csv", 
                     sep = ",",
                     row.names = FALSE)
        save( tempdata, file = "data/tidy_data.RData")        
    }
    
    
    #   Function: summarizeData
    #      Notes: Creates a second data frame from the clean data giving 
    #           : averages for each indicator grouped by activity and then
    #           : by subject
    # Parameters: none
    #    Returns: nothing
    summarizeData <- function() {
        message("Summarizing data to the 'data' directory...")
        
        averages <- ddply(tidydata, .(activity, subject), colwise(mean))
        averages <- arrange(averages, activity, subject)
        
        # Write out the summarized data to disk
        write.table(averages, 
                    file = "data/summary_means.csv",
                    sep = ",",
                    row.names = FALSE)
        save( averages, file = "data/summary_means.RData")
    } 
    
    
    ##------------------------------------------------------------------------
    ## MAINLINE OF FUNCTION run_anaylis() STARTS BELOW
    ##------------------------------------------------------------------------
    
    # If the files don't exist and/or cant be retrieved
    if ( !checkOrGetFiles( RAW_DATA_FILES )) {
        stop( "Cannot access raw data files." )    # Exit with error message
    } else {
        loadRawData()                              # load data from text files
        nameColumns()                              # name data columns
        mergeData()                                # Merge needed tables together
        extractData()                              # Extract into tidy data set
        # summarizeData()                            # summaize avg for clean data
        message("Analysis is completed!")
    }
}