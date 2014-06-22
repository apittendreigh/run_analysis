Codebook for run_analyis.R
==========================

by Alex Pittendreigh (June 2014)
--------------------------------

###Introduction###

The data has been produced from a set of text files that are available from the internet. These files can be downloaded in a .zip file from [https://d396qusza40orc.cloudfront.net/getdata_data_ss06hid.csv](https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv).      

The run_analysis.R script will automatically download this file and extract the following text files into the **raw** subdirectory before running the main part of the analysis.

* activity_labels.txt
* features.txt
* features_info.txt
* subject_test.txt
* subject_train.txt
* X_test.txt
* X_train.txt
* y_test.txt
* y_train.txt

The files features.txt and features_info,txt constitute the codebook for this data.  

On successful completion of running run_analysis.R the following two comma delimited text files will exist in the **data** directory:

* `cleaned_data.csv` (and `cleaned_data.RData`)       - contains full cleansed data set
* `summary_means.csv` (and `summary_means.RData`)     - contains summary of the means of the above data set by activity and subject

The structure of the two data sets is the same and is detailed in the next section.

###Data Dictionary###

