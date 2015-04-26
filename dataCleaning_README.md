##Description of run_analysis.R script
### Steps of run_analysis.R: 

* Read in both testing and training data sets, assign them the correct column names (from the features file of the data set)
* Merge the two data sets so that they make one data set with the same column names
* Extract only the mean and standard deviation measurements (found by searching column names for the strings “mean()” and “std()”
* Attach activity name strings to the numerics by matching with the activity labels file
* Create a new intermediate data set that only contains the mean columns (remove the standard deviations) and rename the columns so that “mean()” is no longer in the column names (it is now redundant)
* Melt the data set and find the mean by Activity/Subject/Value
* Create a data frame of the resulting data set (which is now tidy with one line per observation in the fourth column and three columns with qualitative descriptors about the observations)
* Write data to a file



### Feature names
In this data set, the first column refers to the activity being performed (Laying, Sitting, Standing, Walking, Walking Upstairs, Walking Downstairs). The second refers to the subject number performing the activity.The third column of the data set corresponds to the name of the measurement taken from the original data set (possible values listed below) and each row of the fourth column refers to the mean of the variable/activity   : 

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag