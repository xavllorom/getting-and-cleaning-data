Code Book
This code book describes the variables, data, and transformations performed to clean up the data for the project Getting and Cleaning Data in the Coursera Data Science course.

Raw data collection
Collection
Raw data are obtained from UCI Machine Learning repository:http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.
Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
Attribute Information:
For each record in the dataset it is provided:
Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
Triaxial Angular velocity from the gyroscope. 
A 561-feature vector with time and frequency domain variables. 
Its activity label. 
An identifier of the subject who carried out the experiment.
See Readme file for more information.

Raw Data transformation
The raw data sets are processed with the script run_analysis.R script to create a tidy data set. 
The script receives three parameters:
The directory where the input files are located
The name of the file where the tidy data set have to be saved
The name of the file where the tidy data set corresponding to the summarized information have to be saved

The steps followed were:
Load training, test , features, subjects and activity sets 
Set features labels to training and test data sets columns names 
Add a new column to activity data set with the description
Extract mean and standard deviation variables from training and test sets to create two new data sets  
Merge training and test sets As test and training data have the same structure and as we know that the subjects were ‘randomly separated’ actually is not a merge but the files were concatenated
Writes a tidy data set with the structure processed
From the new data set calculates the summarized information by subject and activity creating a new data set
Writes a second data set with the summarized information


Tidy data set
Observations
The observations consist on :
an identifier of the subject who carried out the experiment (Subject). Its range is from 1 to 30. 
an activity label (Activity): WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING 
a series of measurements collected from the sensor’s signals

Variables
The name convention for the variables included in the first tidy data set is like the following:
prefix: ‘t’, to denote time, ‘f’, to denote frequency
measurement: what was calculated. The name is composed by parts:
Body or Gravity
(Acc)elerometer or (Gyro)scope
Not derived in time or derived in time (Jerk) or (Mag)nitude
-mean/std: mean or standard deviation of the measurement
-X/Y/Z: one direction of a 3-axial signal 
The first tidy data set is written to the file indicated in the second parameter.

The second tidy data set contains :
an identifier of the subject who carried out the experiment (Subject). Its range is from 1 to 30. 
an activity label (Activity): WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING 
mean of all other variables are measurement collected from the accelerometer and gyroscope 3-axial raw signal (numeric value)
The variable name convention follows the rules described above.

The resulting data set is written to the file indicated in the third parameter.
