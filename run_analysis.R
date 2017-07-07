#
library(plyr)
library(dplyr)
library(tidyr)
# Reading raw data from train folder
subject_train<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\subject_train.txt",header = FALSE,sep = "")
x_train<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\X_train.txt",header = FALSE,sep = "")
y_train<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\y_train.txt",header = FALSE,sep = "")
## Reading test tables:
subject_test<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\test\\subject_test.txt",header = FALSE,sep = "")
x_test<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\test\\X_test.txt",header = FALSE,sep = "")
y_test<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\test\\y_test.txt",header = FALSE,sep = "")
## Read features and activity labels:
features <- read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\features.txt",header = FALSE,sep = "")
activity_labels <- read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\activity_labels.txt",header = FALSE,sep = "")
## Assign column names:
colnames(activity_labels) <- c("activityID", "activity")
# For train
colnames(x_train) <- features$V2
colnames(y_train) <- "activityID"
colnames(subject_train) <- "subjectID"
# For test
colnames(x_test) <- features$V2
colnames(y_test) <- "activityID"
colnames(subject_test) <- "subjectID"
## Combine all the data
comb_train <- cbind(subject_train,y_train,x_train)
comb_test <- cbind(subject_test,y_test,x_test)
all_data <- rbind(comb_train, comb_test)
## Read all column names:
c_names <- colnames(all_data)
## Logical vector for extracting ID, mean and standard deviation
mean_std <- (grepl("activityID", c_names) | grepl("subjectID", c_names) | grepl("mean..", c_names) | grepl("std..", c_names))
## Subset combined data to keep only the desired columns
mean_std_data <- all_data[mean_std == TRUE]
## Use descriptive activity names to name the activities in the data set:
mean_std_data_activity <- merge(mean_std_data, activity_labels, by = "activityID", all.x = TRUE)
## Create a second, independent tidy data set with the average of each variable for each activity and each subject:
tidy_data <- aggregate(. ~activityID + subjectID, mean_std_data_activity, mean)
tidy_data_final<-select(tidy_data,-82)
write.table(tidy_data_final,file ="D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\Tidy data_from step5.txt",row.names = FALSE)
# export tidy data set
write.csv(tidy_data_final,file = "D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\Tidy data.csv")
