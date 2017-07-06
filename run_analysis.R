#
library(reshape2)
library(plyr)
library(dplyr)
library(tidyr)
# Reading raw data from train folder
train_body_acc_x<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\body_acc_x_train.txt",header = FALSE,sep = "")
train_body_acc_y<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\body_acc_y_train.txt",header = FALSE,sep = "")
train_body_acc_z<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\body_acc_z_train.txt",header = FALSE,sep = "")
train_body_gyro_x<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\body_gyro_x_train.txt",header = FALSE,sep = "")
train_body_gyro_y<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\body_gyro_y_train.txt",header = FALSE,sep = "")
train_body_gyro_z<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\body_gyro_z_train.txt",header = FALSE,sep = "")
train_total_acc_x<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\total_acc_x_train.txt",header = FALSE,sep = "")
train_total_acc_y<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\total_acc_y_train.txt",header = FALSE,sep = "")
train_total_acc_z<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\total_acc_z_train.txt",header = FALSE,sep = "")
subject_train<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\subject_train.txt",header = FALSE,sep = "")
x_train<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\X_train.txt",header = FALSE,sep = "")
y_train<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\y_train.txt",header = FALSE,sep = "")
# converting to time series object
body_acc_x_ts<-ts(train_body_acc_x)
body_acc_y_ts<-ts(train_body_acc_y)
body_acc_z_ts<-ts(train_body_acc_z)
body_gyro_x_ts<-ts(train_body_gyro_x)
body_gyro_y_ts<-ts(train_body_gyro_y)
body_gyro_z_ts<-ts(train_body_gyro_z)
total_acc_x_ts<-ts(train_total_acc_x)
total_acc_y_ts<-ts(train_total_acc_y)
total_acc_z_ts<-ts(train_total_acc_z)
x_train_ts<-ts(x_train)
#
ts.plot(body_acc_x_ts)
# ts.plot(x_train_ts)
#
subject_train<-as.factor(subject_train$V1)
a<-table(subject_train)
# Activity types
#1 WALKING 2 WALKING_UPSTAIRS 3 WALKING_DOWNSTAIRS 4 SITTING 5 STANDING 6 LAYING
activity_names<-c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
# To create activity variable into training data set
i=1
sub1=""
for(i in 1:21 )
{
sub<-rep(activity_names,c((a[i]/6),(a[i]/6),(a[i]/6),(a[i]/6),(a[i]/6),(a[i]/6)+(a[i]%%6)))
sub1[i]=list(sub)
i=i+1
}
activity_names<-unlist(sub1)
#
# To calculate mean of 128 readings of each variables
train_acc_x<-rowMeans(body_acc_x_ts)
train_acc_y<-rowMeans(body_acc_y_ts)
train_acc_z<-rowMeans(body_acc_z_ts)
train_gyro_x<-rowMeans(body_gyro_x_ts)
train_gyro_y<-rowMeans(body_gyro_y_ts)
train_gyro_z<-rowMeans(body_gyro_z_ts)
train_tot_acc_x<-rowMeans(total_acc_x_ts)
train_tot_acc_y<-rowMeans(total_acc_y_ts)
train_tot_acc_z<-rowMeans(total_acc_z_ts)
#
train<-data.frame(subject=subject_train,activity=activity_names,body_acc_x=train_acc_x,body_acc_y=train_acc_y,body_acc_z=train_acc_z,body_gyro_x=train_gyro_x,body_gyro_y=train_gyro_y,body_gyro_z=train_gyro_z,total_acc_x=train_tot_acc_x,total_acc_y=train_tot_acc_y,total_acc_z=train_tot_acc_z)
#
#
# Reading raw data from test folder
test_body_acc_x<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\test\\body_acc_x_test.txt",header = FALSE,sep = "")
test_body_acc_y<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\test\\body_acc_y_test.txt",header = FALSE,sep = "")
test_body_acc_z<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\test\\body_acc_z_test.txt",header = FALSE,sep = "")
test_body_gyro_x<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\test\\body_gyro_x_test.txt",header = FALSE,sep = "")
test_body_gyro_y<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\test\\body_gyro_y_test.txt",header = FALSE,sep = "")
test_body_gyro_z<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\test\\body_gyro_z_test.txt",header = FALSE,sep = "")
test_total_acc_x<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\test\\total_acc_x_test.txt",header = FALSE,sep = "")
test_total_acc_y<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\test\\total_acc_y_test.txt",header = FALSE,sep = "")
test_total_acc_z<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\test\\total_acc_z_test.txt",header = FALSE,sep = "")
subject_test<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\test\\subject_test.txt",header = FALSE,sep = "")
x_test<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\test\\X_test.txt",header = FALSE,sep = "")
y_test<-read.table("D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\test\\y_test.txt",header = FALSE,sep = "")
#1 WALKING 2 WALKING_UPSTAIRS 3 WALKING_DOWNSTAIRS 4 SITTING 5 STANDING 6 LAYING
test_activity_names<-c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
#
subject_test<-as.factor(subject_test$V1)
b<-table(subject_test)
#
j=1
test_sub1=""
for(j in 1:9 )
{
  test_sub<-rep(test_activity_names,c((b[j]/6),(b[j]/6),(b[j]/6),(b[j]/6),(b[j]/6),(b[j]/6)+(b[j]%%6)))
  test_sub1[j]=list(test_sub)
  j=j+1
}
test_activity_names<-unlist(test_sub1)
# converting to time series object
test_body_acc_x_ts<-ts(test_body_acc_x)
test_body_acc_y_ts<-ts(test_body_acc_y)
test_body_acc_z_ts<-ts(test_body_acc_z)
test_body_gyro_x_ts<-ts(test_body_gyro_x)
test_body_gyro_y_ts<-ts(test_body_gyro_y)
test_body_gyro_z_ts<-ts(test_body_gyro_z)
test_total_acc_x_ts<-ts(test_total_acc_x)
test_total_acc_y_ts<-ts(test_total_acc_y)
test_total_acc_z_ts<-ts(test_total_acc_z)
x_test_ts<-ts(x_test)
#
test_acc_x<-rowMeans(test_body_acc_x_ts)
test_acc_y<-rowMeans(test_body_acc_y_ts)
test_acc_z<-rowMeans(test_body_acc_z_ts)
test_gyro_x<-rowMeans(test_body_gyro_x_ts)
test_gyro_y<-rowMeans(test_body_gyro_y_ts)
test_gyro_z<-rowMeans(test_body_gyro_z_ts)
test_tot_acc_x<-rowMeans(test_total_acc_x_ts)
test_tot_acc_y<-rowMeans(test_total_acc_y_ts)
test_tot_acc_z<-rowMeans(test_total_acc_z_ts)
#
test<-data.frame(subject=subject_test,activity=test_activity_names,body_acc_x=test_acc_x,body_acc_y=test_acc_y,body_acc_z=test_acc_z,body_gyro_x=test_gyro_x,body_gyro_y=test_gyro_y,body_gyro_z=test_gyro_z,total_acc_x=test_tot_acc_x,total_acc_y=test_tot_acc_y,total_acc_z=test_tot_acc_z)
# To combine train and test data
train_test<-rbind(train,test)
# Mean and standard deviation of each measurement
sd_body_acc_x<-sd(train_test$body_acc_x)
mean_body_acc_x<-mean(train_test$body_acc_x)
sd_body_acc_y<-sd(train_test$body_acc_y)
mean_body_acc_y<-mean(train_test$body_acc_y)
sd_body_acc_z<-sd(train_test$body_acc_z)
mean_body_acc_z<-mean(train_test$body_acc_z)
#
sd_body_gyro_x<-sd(train_test$body_gyro_x)
mean_body_gyro_x<-mean(train_test$body_gyro_x)
sd_body_gyro_y<-sd(train_test$body_gyro_y)
mean_body_gyro_y<-mean(train_test$body_gyro_y)
sd_body_gyro_z<-sd(train_test$body_gyro_z)
mean_body_gyro_z<-mean(train_test$body_gyro_z)
#
sd_total_acc_x<-sd(train_test$total_acc_x)
mean_total_acc_x<-mean(train_test$total_acc_x)
sd_total_acc_y<-sd(train_test$total_acc_y)
mean_total_acc_y<-mean(train_test$total_acc_y)
sd_total_acc_z<-sd(train_test$total_acc_z)
mean_total_acc_z<-mean(train_test$total_acc_z)
# **** #
# To create another data set with avg of variables for each suject and activity
s<-select(train_test,-(12:13))
# loop to create avg values
act<-c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
k=factor(1)
l=factor(1)
p=c(1:180)
for(k in 1:30)
{
  for (l in 1:6)
  {
  s1<-filter(s,(subject == k & activity == act[l]))
  s2<-select(s1,-(1:2))
  m[l]<-list(colMeans(s2))
  n[p]<-list(m)
  l=l+1
    }
  k=k+1
}
q<-unlist(n)
r<-matrix(q,nrow = 180,ncol = 9,byrow = TRUE)
library(data.table)
t<-data.table(r)
avg_table<-rename(t,c("V1" = "body_acc_x","V2" = "body_acc_y","V3" = "body_acc_z","V4" = "body_gyro_x","V5" = "body_gyro_y","V6" = "body_gyro_z","V7" = "total_acc_x","V8" = "total_acc_y","V9" = "total_acc_z"))
avg_table$subject<-rep(c(1:30),each=6)
avg_table$activity<-rep(c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"),times=30)
avg_table_final<-data.frame(subject=avg_table$subject,activity=avg_table$activity,body_acc_x=avg_table$body_acc_x,body_acc_y=avg_table$body_acc_y,body_acc_z=avg_table$body_acc_z,body_gyro_x=avg_table$body_gyro_x,body_gyro_y=avg_table$body_gyro_y,body_gyro_z=avg_table$body_gyro_z,total_acc_x=avg_table$total_acc_x,total_acc_y=avg_table$total_acc_y,total_acc_z=avg_table$total_acc_z)
avg_table_final
write.table(avg_table_final,file ="D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\Tidy data_from step5.txt",row.names = FALSE)
# export tidy data set
write.csv(train_test,file = "D:\\Raju\\Data Science Technical\\Courseera certification\\Getting and cleaning data\\project\\Tidy data.csv")