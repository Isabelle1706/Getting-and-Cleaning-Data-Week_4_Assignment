## getting and cleaning data week 4 assignment

## data source:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## Goal: 
  # 1.Merges the training and the test sets to create one data set.
  # 2. Extracts only the measurements on the mean and standard deviation for each measurement.
  # 3.Uses descriptive activity names to name the activities in the data set
  # 4.Appropriately labels the data set with descriptive variable names.
  # 5.From the data set in step 4, creates a second, independent tidy data set with the average of each
  #   variable for each activity and each subject.


# clear all objects

rm(list=ls())



# read train data

X_train=read.table("~/R/coursera/UCI HAR Dataset/train/X_train.txt", header=F)

y_train=read.table("~/R/coursera/UCI HAR Dataset/train/y_train.txt", header=F)

subject_train=read.table("~/R/coursera/UCI HAR Dataset/train/subject_train.txt", header=F)

# read test data

X_test=read.table("~/R/coursera/UCI HAR Dataset/test/X_test.txt", header=F)

y_test=read.table("~/R/coursera/UCI HAR Dataset/test/y_test.txt", header=F)

subject_test=read.table("~/R/coursera/UCI HAR Dataset/test/subject_test.txt", header=F)

# read feature data

var_names=read.table("~/R/coursera/UCI HAR Dataset/features.txt", header=F)

# read activity lables data

activity_labels=read.table("~/R/coursera/UCI HAR Dataset/activity_labels.txt", header=F)

# 1. Merges the training and the test sets to create one data set.

X_all=rbind(X_train, X_test)
y_all=rbind(y_train, y_test)
subject_all=rbind(subject_train, subject_test)


# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

selected_var <- var_names[grep("mean\\(\\)|std\\(\\)",var_names[,2]),]

X_all=X_all[,selected_var[,1]]


# 3. Uses descriptive activity names to name the activities in the data set

colnames(activity_labels)=c('activityID', 'activityType')

colnames(y_all)="activityID"

# merge y_all and activity_labels to put activityType into y_all

y_all=merge(y_all, activity_labels, by="activityID")

activityType=y_all[,-1]


# 4. Appropriately labels the data set with descriptive variable names.

colnames(X_all) <- var_names[selected_var[,1],2]

colnames(subject_all)="subjectID"

# create the final data set to put subject, activity type, and measures together

finaldata=cbind(subject_all, activityType, X_all)

# clean up the varaible names of final data

colNames=colnames(finaldata)

for (i in 1:length(colNames)) 
{
        colNames[i] = gsub("\\()","",colNames[i])
        colNames[i] = gsub("-std$","StdDev",colNames[i])
        colNames[i] = gsub("-mean","Mean",colNames[i])
        colNames[i] = gsub("^(t)","time",colNames[i])
        colNames[i] = gsub("^(f)","freq",colNames[i])
        colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
        colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
        colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
        colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
        colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
        colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
        colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

# Reassigning the new descriptive column names to the finaldata set

colnames(finaldata) = colNames;



# 5. From the data set in step 4, creates a second, independent tidy data set with the average
# of each variable for each activity and each subject.




# use dplyr to calculate mean for each measurements by subjectID and activityType

library(dplyr)


tidydatd=finaldata %>%
         group_by(subjectID,activityType) %>%
         summarize_all(funs(mean))

# export the tidydata set

write.table(tidydata, file="~/R/coursera/UCI HAR Dataset/tidydata.txt", row.names=FALSE, col.names=TRUE)

str(tidydata)
