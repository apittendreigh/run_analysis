Codebook for run_analyis.R
==========================

by Alex Pittendreigh (June 2014)
--------------------------------

###Introduction###

The data has been produced from a set of text files that are available from the internet. These files can be downloaded in a .zip file from https://d396qusza40orc.cloudfront.net/getdata_data_ss06hid.csv(https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv).      

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

    1. activity                                       The activity the subject was performing when the measurement was recorded
                                                           Factor of six levels
                                                                LAYING
                                                                SITTING
                                                                STANDING
                                                                WALKING
                                                                WALKING_DOWNSTAIRS
                                                                WALKING_SUPSTAIRS     

    2. subject                                        The code number identifying the subject using the appliance
                                                           integer in the range 1 to 30

    3. body_accel_mean_x_axis                         Mean of the X axis recording of body accelerometer
                                                           numeric  

    4. body_accel_mean_y_axis                         Mean of the Y axis recording of body accelerometer                                             
                                                           numeric

    5. body_accel_mean_z_axis                         Mean of the Z axis recording of body accelerometer                                         				   
                                                           numeric
		                                                         
    6. body_accel_stddev_x_axis                       Std deviation of the X axis recording of body accelerometer
                                                           numeric

    7. body_accel_stddev_y_axis                       Std deviation of the Y axis recording of body  accelerometer  
                                                           numeric                                                                                                                         

    8. body_accel_stddev_z_axis                       Std deviation of the Z axis recording of body accelerometer                             
                                                           numeric

    9. gravity_accel_mean_x_axis                      Mean of the X axis recording of gravity accelerometer 
                                                           numeric

    10. gravity_accel_mean_y_axis                     Mean of the Y axis recording of gravity accelerometer
                                                           numeric
		
    11. gravity_accel_mean_z_axis                     Mean of the Z axis recording of gravity accelerometer
                                                           numeric
		
    12. gravity_accel_stddev_x_axis                   Std deviation of the X axis recording of gravity accelerometer
                                                           numeric
		
    13. gravity_accel_stddev_y_axis                   Std deviation of the Y axis recording of gravity accelerometer            
                                                           numeric

    14. gravity_accel_stddev_z_axis                   Std deviation of the Z axis recording of gravity accelerometer            
                                                           numeric
		
    15. body_accel_jerk_mean_x_axis                   Mean of the X axis recording of body linear (jerk)  accelerometer            
                                                           numeric
		
    16. body_accel_jerk_mean_y_axis                   Mean of the Y axis recording of body linear (jerk)  accelerometer            
                                                           numeric
		
    17. body_accel_jerk_mean_z_axis                   Mean of the Z axis recording of body linear (jerk)_ accelerometer            
                                                           numeric
		
    18. body_accel_jerk_stddev_x_axis                 Std deviation of the X axis recording of body linear (jerk)  accelerometer            
                                                           numeric
		
    19. body_accel_jerk_stddev_y_axis                 Std deviation of the Y axis recording of body linear (jerk) accelerometer           
                                                           numeric
		
    20. body_accel_jerk_stddev_z_axis                 Std deviation of the Z axis recording of body linear (jerk) accelerometer        
                                                           numeric
		
    21. body_gyro_mean_x_axis                         Mean of the X axis recording of the body gyroscope            
                                                           numeric
		
    22  body_gyro_mean_y_axis                         Mean of the Y axis recording of the body gyroscope     
                                                           numeric
		
    23. body_gyro_mean_z_axis                         Mean of the Z axis recording of the body hyroscope            
                                                           numeric
		
    24. body_gyro_stddev_x_axis                       Std deviation of the X axis recording of the body gyroscope           
                                                           numeric
		
    25. body_gyro_stddev_y_axis                       Std deviation of the Y axis recording of the body gyroscope            
                                                           numeric
		
    26. body_gyro_stddev_z_axis                       Std deviation of the Z axis recording of the body gyroscope            
                                                           numeric
		
    27. body_gyro_jerk_mean_x_axis                    Mean of the X axis recording of body linear (jerk) of the gyroscope            
                                                           numeric
		
    28. body_gyro_jerk_mean_y_axis                    Mean of the Y axis recording of body linear (jerk) of the gyroscope             
                                                           numeric
		
    29. body_gyro_jerk_mean_z_axis                    Mean of the Z axis recording of body liner (jerk) of the gyroscope            
                                                           numeric
		
    30. body_gyro_jerk_stddev_x_axis                  Std deviation of the X axis recording of body linear (jerk) of the gyroscope            
                                                           numeric
		
    31. body_gyro_jerk_stddev_y_axis                  Std deviation of the Y axis recording of body linear (jerk) of the gyroscope            
                                                           numeric
		
    32. body_gyro_jerkstddev_z_axis                   Std deviation of the Z axis recording of body linear (jerk) of the gyroscope            
                                                           numeric
		
    33. body_accel_magnification_mean                 Mean of the magnitude of XYZ signals on body acceleration calculated using the Euclidean norm            
                                                           numeric
		
    34. body_accel_magnification_stddev               Std deviation of the magnitude of XYZ signals on body acceleration calculated using the Euclidean norm            
                                                           numeric
		
    35. gravity_accel_magnification_mean              Mean of the magnitude of XYZ signals  for gravity acceleration calculated using the Euclidean norm     
                                                           numeric
		
    36. gravity_accel_magnification_stddev            Std deviation of the magnitude of XYZ signals  for gravity acceleration calculated using the Euclidean norm            
                                                           numeric
		
    37. ff_body_accel_mean_x_axis                     Fast fourier transformation  of mean of body acceleration on the X axis          
                                                           numeric
		
    38. ff_body_accel_mean_y_axis                     Fast fourier transformation  of mean of body acceleration on the Y axis            
                                                           numeric
		
    39. ff_body_accel_mean_z_axis                     Fast fourier transformation  of mean of body acceleration on the Z axis            
                                                           numeric
		
    40. ff_body_accel_stddev_x_axis                   Fast fourier transformation  of std deviation of body acceleration on the X axis          
                                                           numeric
		
    41. ff_body_accel_stddev_y_axis                   Fast fourier transformation  of std deviation of body acceleration on the Y axis            
                                                           numeric
		
    42. ff_body_accel_stddev_z_axis                   Fast fourier transformation  of std deviation of body acceleration on the Z axis            
                                                           numeric
		
    43. ff_body_accel_jerk_mean_x_axis               Fast fourier transformation  of mean of body linear (jerk) on the X axis          
                                                           numeric
		
    44. ff_body_accel_jerk_mean_y_axis               Fast fourier transformation  of mean of body linear (jerk) on the Y axis             
                                                           numeric
		
    45. ff_body_accel_jerk_mean_z_axis               Fast fourier transformation  of mean of body linear (jerk) on the Z axis             
                                                           numeric
		
    46. ff_body_accel_jerk_stddev_x_axis             Fast fourier transformation  of std deviation of body linear (jerk) on the X axis             
                                                           numeric
		
    47. ff_body_accel_jerk_stddev_y_axis             Fast fourier transformation  of std deviation of body linear (jerk) on the Y axis             
                                                           numeric

    48. ff_body_accel_jerk_stddev_z_axis             Fast fourier transformation  of std deviation of body linear (jerk) on the Z axis             
                                                           numeric

    49. ff_body_gyro_mean_x_axis                     Fast fourier transformation of the mean of the X axis recording of the body gyroscope             
                                                           numeric
		
    50. ff_body_gyro_mean_y_axis                     Fast fourier transformation of the mean of the Y axis recording of the body gyroscope             
                                                           numeric
	
    51. ff_body_gyro_mean_z_axis                     Fast fourier transformation of the mean of the Z axis recording of the body gyroscope             
                                                           numeric
		
    52. ff_body_gyro_stddev_x_axis                   Fast fourier transformation of the std deviation of the X axis recording of the body gyroscope             
                                                           numeric
		
    53. ff_body_gyro_stddev_y_axis                   Fast fourier transformation of the std deviation of the Y axis recording of the body gyroscope             
                                                          numeric
		
    54. ff_body_gyro_stddev_z_axis                   Fast fourier transformation of the std deviation of the Z axis recording of the body gyroscope            
                                                          numeric
		
    55. ff_body_accel_magnification_mean              Fast fourier transformation of the mean of the magnitude of XYZ signals on body acceleration calculated using the Euclidean norm            
                                                          numeric
		
    56. ff_body_accel_magnification_stddev            Fast fourier transformation of the std deviation of the magnitude of XYZ signals on body acceleration calculated using the Euclidean norm           
                                                          numeric
		
    57. ff_body_accel_jerk_magnification_mean         Fast fourier transformation of the mean of the magnitude of XYZ signals on body linear (jerk) calculated using the Euclidean norm           
                                                          numeric
		
    58. ff_body_accel_jerk_magnification_stddev        Fast fourier transformation of the std deviation of the magnitude of XYZ signals on body linear (jerk) calculated using the Euclidean norm          
                                                          numeric
		
    59. ff_body_gyro_magnification_mean                Fast fourier transformation of the mean of the magnifcation on body gyroscope          
                                                          numeric
		
    60. ff_body_gyro_magnification_stddev              Fast fourier transformation of the std deviation of the magnifcation on body gyroscope          
                                                          numeric
		
    61. ff_body_gyro_jerk_magnification_mean           Fast fourier transformation of the mean of the magnifcation on body linear (jerk) on the gyroscope          
                                                          numeric
		
    62. ff_body_gyro_jerk_magnification_stddev         Fast fourier transformation of the std deviation of the magnifcation on body linear (jerk) on the gyroscope          
                                                          numeric
		
    63. angle_body_accel_mean                          Mean of the body acceleration based on the angle      
                                                          numeric
		
    64. angle_body_accel_jerk_mean                     Mean of the body linear (jerk) acceleration based on the angle          
                                                          numeric
		
    65. angle_body_gyro_mean                           Mean of the bodys gyroscope based on the angle          
                                                          numeric
		
    66. angle_body_gyro_jerk_mean                      Mean of the body linear gyroscope based on the angle          
                                                          numeric
		
    67. angle_x_gravity_mean                           Mean of the X axis gravity based on the angle          
                                                          numeric
		
    68. angle_y_gravity_mean                           Mean of the Y axis gravity based on the angle          
                                                          numeric
		
    69. angle_z_gravity_mean                           Mean of the Z axis gravity based on the angle          
                                                          numeric