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
    
    # table for the clean data at the end
    cleandata <- data.frame()
    
    
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
        cleandata <<- data.frame(activity = rawdata$activity,
                                 subject = rawdata$subject,
                                 body_accel_mean_x_axis = rawdata$tBodyAcc_mean_X,
                                 body_accel_mean_y_axis = rawdata$tBodyAcc_mean_Y,
                                 body_accel_mean_z_axis = rawdata$tBodyAcc_mean_Z,
                                 body_accel_stddev_x_axis = rawdata$tBodyAcc_std_X,
                                 body_accel_stddev_y_axis = rawdata$tBodyAcc_std_Y,
                                 body_accel_stddev_z_axis = rawdata$tBodyAcc_std_Z,
                                 gravity_accel_mean_x_axis = rawdata$tGravityAcc_mean_X,
                                 gravity_accel_mean_y_axis = rawdata$tGravityAcc_mean_Y,
                                 gravity_accel_mean_z_axis = rawdata$tGravityAcc_mean_Z,
                                 gravity_accel_stddev_x_axis = rawdata$tGravityAcc_std_X,
                                 gravity_accel_stddev_y_axis = rawdata$tGravityAcc_std_Y,
                                 gravity_accel_stddev_z_axis = rawdata$tGravityAcc_std_Z,
                                 body_accel_jerk_mean_x_axis = rawdata$tBodyAccJerk_mean_X,
                                 body_accel_jerk_mean_y_axis = rawdata$tBodyAccJerk_mean_Y,
                                 body_accel_jerk_mean_z_axis = rawdata$tBodyAccJerk_mean_Z,
                                 body_accel_jerk_stddev_x_axis = rawdata$tBodyAccJerk_std_X,
                                 body_accel_jerk_stddev_y_axis = rawdata$tBodyAccJerk_std_Y,
                                 body_accel_jerk_stddev_z_axis = rawdata$tBodyAccJerk_std_Z, 
                                 body_gyro_mean_x_axis = rawdata$tBodyGyro_mean_X,
                                 body_gyro_mean_y_axis = rawdata$tBodyGyro_mean_Y,
                                 body_gyro_mean_z_axis = rawdata$tBodyGyro_mean_Z,
                                 body_gyro_stddev_x_axis = rawdata$tBodyGyro_std_X,
                                 body_gyro_stddev_y_axis = rawdata$tBodyGyro_std_Y,
                                 body_gyro_stddev_z_axis = rawdata$tBodyGyro_std_Z,
                                 body_gyro_jerk_mean_x_axis = rawdata$tBodyGyroJerk_mean_X,
                                 body_gyro_jerk_mean_y_axis = rawdata$tBodyGyroJerk_mean_Y,
                                 body_gyro_jerk_mean_z_axis = rawdata$tBodyGyroJerk_mean_Z,
                                 body_gyro_jerk_stddev_x_axis = rawdata$tBodyGyroJerk_std_X,
                                 body_gyro_jerk_stddev_y_axis = rawdata$tBodyGyroJerk_std_Y,
                                 body_gyro_jerkstddev_z_axis = rawdata$tBodyGyroJerk_std_Z,
                                 body_accel_magnification_mean = rawdata$tBodyAccMag_mean,
                                 body_accel_magnification_stddev = rawdata$tBodyAccMag_std,
                                 gravity_accel_magnification_mean = rawdata$tGravityAccMag_mean,
                                 gravity_accel_magnification_stddev = rawdata$tGravityAccMag_std,
                                 ff_body_accel_mean_x_axis = rawdata$fBodyAcc_mean_X,
                                 ff_body_accel_mean_y_axis = rawdata$fBodyAcc_mean_Y,
                                 ff_body_accel_mean_z_axis = rawdata$fBodyAcc_mean_Z,
                                 ff_body_accel_stddev_x_axis = rawdata$fBodyAcc_std_X,
                                 ff_body_accel_stddev_y_axis = rawdata$fBodyAcc_std_Y,
                                 ff_body_accel_stddev_z_axis = rawdata$fBodyAcc_std_Z,
                                 ff_body_accel_jerk_mean_x_axis = rawdata$fBodyAccJerk_mean_X,
                                 ff_body_accel_jerk_mean_y_axis = rawdata$fBodyAccJerk_mean_Y,
                                 ff_body_accel_jerk_mean_z_axis = rawdata$fBodyAccJerk_mean_Z,
                                 ff_body_accel_jerk_stddev_x_axis = rawdata$fBodyAccJerk_std_X,
                                 ff_body_accel_jerk_stddev_y_axis = rawdata$fBodyAccJerk_std_Y,
                                 ff_body_accel_jerk_stddev_z_axis = rawdata$fBodyAccJerk_std_Z, 
                                 ff_body_gyro_mean_x_axis = rawdata$fBodyGyro_mean_X,
                                 ff_body_gyro_mean_y_axis = rawdata$fBodyGyro_mean_Y,
                                 ff_body_gyro_mean_z_axis = rawdata$fBodyGyro_mean_Z,
                                 ff_body_gyro_stddev_x_axis = rawdata$fBodyGyro_std_X,
                                 ff_body_gyro_stddev_y_axis = rawdata$fBodyGyro_std_Y,
                                 ff_body_gyro_stddev_z_axis = rawdata$fBodyGyro_std_Z,
                                 ff_body_accel_magnification_mean = rawdata$fBodyAccMag_mean,
                                 ff_body_accel_magnification_stddev = rawdata$fBodyAccMag_std,
                                 ff_body_accel_jerk_magnification_mean = rawdata$fBodyBodyAccJerkMag_mean,
                                 ff_body_accel_jerk_magnification_stddev = rawdata$fBodyBodyAccJerkMag_std,
                                 ff_body_gyro_magnification_mean = rawdata$fBodyBodyGyroMag_mean,
                                 ff_body_gyro_magnification_stddev = rawdata$fBodyBodyGyroMag_std,
                                 ff_body_gyro_jerk_magnification_mean = rawdata$fBodyBodyGyroJerkMag_mean,
                                 ff_body_gyro_jerk_magnification_stddev = rawdata$fBodyBodyGyroJerkMag_std,
                                 angle_body_accel_mean = rawdata$angle_tBodyAccMean_gravity,
                                 angle_body_accel_jerk_mean = rawdata$angle_tBodyAccJerkMean_gravityMean,
                                 angle_body_gyro_mean = rawdata$angle_tBodyGyroMean_gravityMean,
                                 angle_body_gyro_jerk_mean = rawdata$angle_tBodyGyroJerkMean_gravityMean,
                                 angle_x_gravity_mean = rawdata$angle_X_gravityMean,
                                 angle_y_gravity_mean = rawdata$angle_Y_gravityMean,
                                 angle_z_gravity_mean = rawdata$angle_Z_gravityMean
        )
        
        # write the clean data to the data directory in the form of a .RData
        # file as well as a .csv (comman delimited) file
        message("Writing cleansed data to disk in 'data' directory...")
        write.table( cleandata, file="data/cleaned_data.csv", 
                     sep = ",",
                     row.names = FALSE)
        save( cleandata, file = "data/cleaned_data.RData")        
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
        View(cleandata); View(table(cleandata$subject)); print(dim(cleandata))
        message("Analysis is completed!")
    }
}