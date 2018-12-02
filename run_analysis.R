library(reshape2)
library(plyr)

if(!file.exists("./data")){dir.create("./data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",mode="wb")
unzip(zipfile="./data/Dataset.zip",exdir="./data")

##to list the files

path <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path, recursive=TRUE)
files

##reading test data
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

##reading train dataset

x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("./data/UCI HAR Dataset/train/subject_train.txt")

##reading activity_labels

activitylabels<-read.table("./data/UCI HAR Dataset/activity_labels.txt")

##reading features

features<-read.table("./data/UCI HAR Dataset/features.txt")

##1.Merges the training and the test sets to create one data set.

##merging the train and test files into one 

merge_subject_train_test<-rbind(subject_train,subject_test)
merge_x_train_test<-rbind(x_train,x_test)
merge_y_train_test<-rbind(y_train,y_test)

##set column names to variables
names(merge_subject_train_test)<-c("Subject")
names(merge_y_train_test)<-c("Activity")
names(merge_x_train_test)<-features$V2
##combine all data
combine_merge_subject_y<-cbind(merge_subject_train_test,merge_y_train_test)
data_train_test<-cbind(merge_x_train_test,combine_merge_subject_y)


##2.Extracts only the measurements on the mean and standard deviation for each measurement.
##get the column names of data_train_test
col_names<-colnames(data_train_test)
##get the mean, std,Subject,Activity columns
mean_std_data<-(grepl("Activity" , col_names) | 
                  grepl("Subject" , col_names) | 
                  grepl("mean\\(\\)" , col_names) | 
                  grepl("std\\(\\)" , col_names) 
)

##this is the data with measurements on mean ,std subject and activity
required_mean_std_data<-data_train_test[,mean_std_data==TRUE]

##3.Uses descriptive activity names to name the activities in the data set

## factor Activity  column into levels and labels
## use as.factor to Subject column
required_mean_std_data$Activity<-factor(required_mean_std_data$Activity,levels = activitylabels[,1],labels = activitylabels[,2])
required_mean_std_data$Subject<-as.factor(required_mean_std_data$Subject)

##4.Appropriately labels the data set with descriptive variable names.
## giving descriptive names to the variables
names(required_mean_std_data)<-gsub("^t","time",names(required_mean_std_data))
names(required_mean_std_data)<-gsub("^f","frequency",names(required_mean_std_data))
names(required_mean_std_data)<-gsub("Acc","Accelerometer",names(required_mean_std_data))
names(required_mean_std_data)<-gsub("Gyro","Gyroscope",names(required_mean_std_data))
names(required_mean_std_data)<-gsub("Mag","Magnitude",names(required_mean_std_data))
names(required_mean_std_data)<-gsub("BodyBody","Body",names(required_mean_std_data))

##5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## second tidy data.Used melt().This is a long data format

tidy_data.melted<-melt(required_mean_std_data,id=c("Subject","Activity"))
##TO see the data looks like.##displays the first 6 rows
head(tidy_data.melted)
##Average the measurements ie,mean
##used dcast ()on melted data to get the wide format and it has the mean of measurement variables .
tidy_data_mean<-dcast(tidy_data.melted,Subject+Activity ~variable,mean)
##to see how the data looks like.##displays the first 6 rows
head(tidy_data_mean)

##use write .table () to create tidydata.txt which has the tidy_data_mean
write.table(tidy_data_mean,file="tidydata.txt",row.name=FALSE)


##code for reading the tidy_data_mean in R

##tidy_data_read<- read.table("tidydata.txt", header = TRUE)
##View(tidy_data_read)
