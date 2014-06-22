run_analysis.R
==============

This is my collection of R scripts and supplementary files making up my 
solution to the project in the "**Getting and Cleaning Data**" unit of the 
"**Data Science**" course run by *__Johns Hopkins University__* on 
[*__Coursera__*](http://www.coursera.org/).

Summary
-------
`run_analysis.R` is a system consisting of two script files that will download and extract raw data from  a set of text files that are available from the internet. These files can be downloaded in a .zip file from    [`https://d396qusza40orc.cloudfront.net/getdata_data_ss06hid.zip`](https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv).      

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

Please see the codebook included in the repository for details on these two files.

What You Will Require
---------------------
To run this system you will need the following:

* An installed version of the R statistical system (preferably v3 or later)
* The 'plyr' R package by Hadley Wickham installed in your version of R
* The two .R script files located in this repository *`run_analysis.R`* and *utilities.R*
* A reliable Internet connection
* access permission to create subfolders in your working directory  

Description of the Script files
-------------------------------
    run_analysis.R consists of the functions that undertake the analyis itself
    utilities.R consists of functions that support the analyis process such as downloading and extracting files

The decision was made to separate out the support functions into their own separate script file as it would be easier to reuse the code inside the file at a later stage. 

To Start the Analysis
---------------------
Make sure that you have the 'run_analysis.R` and `utilities.R' installed in the working directory, then type in the following command at the prompt and press the <ENTER> key
    
    source('run_analysis.R'); run_analysis()
	
The application script will then connect to the Internet, down and extract files, finishing of by analysing and creating the data files mentioned above in the 'data' directory.

You will see a series of information messages displayed on the screen while the scripts are undertaking their tasks. You will see a confirmation message at the end of processing.

What Do the Scripts Do?
-----------------------
On running the command `run_analysis()` at the prompt in your working directory, the scripts will:

1. Check to see if you have all the raw data files already extracted in the `raw` subdirectory

2. If the answer to step 1 is yes then skip to step 4.

3. If files are missing
	
	3.1 Create the `'raw` and `data` subdirectories if they don't exist  

	3.2 archive any existing raw data files (on confirmation from user)
	
	3.3 download the `getdata_data_ss06hid.zip` from the Internet website
	
	3.4 Extract the needed raw data files into the  `raw` subdirectory
4. if all is okay to continue then read each of the raw data files into it's own separate data frame

5. Create temporary variable names based on the details included in the `features.txt` file. Makes it easier to manipulate data later in the analysis

6. Merge the test and training raw data files into one with the subject code and give the combined data set the temporary variable names.

7. Extract the mean and standard deviation columns and give new meaningful variable names

8. Write the cleansed data files out into the `data` subdirectory

9. Calculate the average (mean) of each variable and write the summarised data set out into the `data` directory  

The decision was made to put the raw data and the cleansed data into their own subdirectories as this is good software engineering practise. It keeps the processed data separate from the raw data.

Issues
------
This application has a number of issues that should be resolved before it could be considered "production ready". Time constraints has meant that it has not been possible to resolve these issues.

Notably, these include:

1. Greater error checking support

2. Performance could be increased.

3. The data could be made tidier. I was looking to extract the method of analysis (mean / std deviation) out into their own variable as a factor as well as the type of data analysis done (ie. time domain, fast fourier, angle based) into their own factorial variable. I was investigating the use of the `reshape2` package from Hadley Wickham to do this and whilst the melt function got me to the intermediate stage successfully, I was not able to cast it back into a wide data frame. Despite following several example online, the dcast always wanted to aggregate the data before a stage that I required in the processing. The code for this has been left in an unmerged git branch in an incomplete state.
