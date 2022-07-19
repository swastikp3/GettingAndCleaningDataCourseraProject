#############################################################
## Assignment: Getting and Cleaning Data Course Project 
##            SWASTIK PATEL 

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average 
#    of each variable for each activity and each subject.

#############################################################

# This function merges the training & test data sets
cleaningData <- function(){
  
  # Setting the GITHub Directory LOcation
  setwd("/Users/spatel6/datascience/getting-and-cleaning-data/ProjectLatest/GettingAndCleaningDataCourseraProject")
  
  # Loading the dplyr package
  library(dplyr)
  
  # Fetching, downloading, Checking storing the data set
  
  if (!file.exists("data")) {
    datadirectory <- dir.create("data")
  
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    
    datafile <- download.file(fileURL,destfile = "data/coursera-uci-datafile.zip" , method = "curl")
    
    unzip(zipfile = "data/coursera-uci-datafile.zip" , exdir = "data" )
  }
  
  ###########################################
  ## Creating all the required data frames
  ###########################################
  
  features <- read.table("data/UCI HAR Dataset/features.txt", col.names = c("n","functions"))
  #View(features)
  activities <- read.table("data/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
  #View(activities)
  
  x_test <- read.table("data/UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
  #View(x_test)
  y_test <- read.table("data/UCI HAR Dataset/test/y_test.txt", col.names = "code")
  #View(y_test)
  
  x_train <- read.table("data/UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
  #View(x_train)
  y_train <- read.table("data/UCI HAR Dataset/train/y_train.txt", col.names = "code")
  #View(y_train)
  
  subject_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
  #View(subject_test)
  subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
  #View(subject_train)
  
  
  ###########################################
  # 1. Merges the training and the test sets to create one data set.
  ###########################################
  
  XMergedDataset <- rbind(x_train, x_test)
  #View(XMergedDataset)
  YMergedDataset <- rbind(y_train, y_test)
  #View(YMergedDataset)
  SubjectMergedDataset <- rbind(subject_train, subject_test)
  #View(SubjectMergedDataset)
  
  MergedData <- cbind(  SubjectMergedDataset ,  YMergedDataset , XMergedDataset )
  #View(MergedData)
  
  ###########################################
  # 2. Extracts only the measurements on the mean and standard deviation for each measurement.
  ###########################################
  TidyData <- MergedData %>% select(subject, code, contains("mean"), contains("std"))
  #View(TidyData)
  
  ###########################################
  # 3. Uses descriptive activity names to name the activities in the data set
  ###########################################
  TidyData$code <- activities[TidyData$code, 2]
  #View(TidyData)
  
  ###########################################
  # 4. Appropriately labels the data set with descriptive variable names.
  ###########################################
  names(TidyData)[2] = "activity"
  names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
  names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
  names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
  names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
  names(TidyData)<-gsub("^t", "Time", names(TidyData))
  names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
  names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
  names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
  names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
  names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
  names(TidyData)<-gsub("angle", "Angle", names(TidyData))
  names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))
  
  ###########################################
  # 5. From the data set in step 4, creates a second, independent tidy data set with the average 
  #    of each variable for each activity and each subject.
  ###########################################

  ResultData <- TidyData %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))
  View(ResultData)
  
  write.table(ResultData, "ResultTidyData.txt", row.name=FALSE)
  
}