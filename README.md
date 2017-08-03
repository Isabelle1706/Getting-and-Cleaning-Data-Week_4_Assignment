# Getting-and-Cleaning-Data-Week_4_Assignment

This repo was created to finish the assignment for week 4 of Getting and Cleaning Data Coursera course.

Data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This Assigmment goals: 
  1.Merges the training and the test sets to create one data set.
  2.Extracts only the measurements on the mean and standard deviation for each measurement.
  3.Uses descriptive activity names to name the activities in the data set
  4.Appropriately labels the data set with descriptive variable names.
  5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each     subject
  
Data description

The variables in the data X are sensor signals measured with waist-mounted smartphone from 30 subjects. Variable names can be find in the file of features.txt. The data y contains information about activity type. the descpritive activity type can be find in the file of activity_labels.txt. The subject data includes information about subject ID. X data, y data and subject data all include two parts: test and train.

Making modifications to this script

Once you have obtained and unzipped the source files, you will need to make one modification to the R file before you can process the data. Note that on line 26 of run_analysis.R, you will set the path of the working directory to relect the location of the source files in your own directory.

New dataset

The new generated dataset contained variables calculated based on the mean and standard deviation. Each row of the dataset is an average of each activity type for each subjects. Variable names can be found in CodeBook.md
