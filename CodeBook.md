## Peer-graded Assignment: Getting and Cleaning Data Course Project : Swastik Patel : July 19'2022


## The original data was modified and updated with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information


1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Information  about R script run_analysis.R
File with R code "run_analysis.R" perform above 5 following steps as mentioned in the project description


## Information about variables used :   
* `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` contain the data from the downloaded files.

* `x_data`, `y_data` and `subject_data` merge the previous datasets to further analysis.

* `features` contains the correct names for the `x_data` dataset, which are applied to the column names stored in
