# Getting-and-Cleaning-Data-project

In this project an analysis is done on the Human Activity Recognition Using Smartphones Dataset
Source link of the Dataset : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This repo consists of the following:

1.run_analysis.R (Rscript)

2.tidydata.txt (final tidied data) #open in Note++

3.CodeBook.md (which has the list of all variables and descripion of the same in the tidydata.txt)

4.README.md (which explains this project)

Overview of the Project:

The analysis has the following steps:.

1.Merges the training and the test sets to create one data set.

2.Extracts only the measurements on the mean and standard deviation for each measurement.

3.Uses descriptive activity names to name the activities in the data set

4.Appropriately labels the data set with descriptive variable names.

5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

Explanation of the analysis done in this project.

libraries loaded 

 1.reshape2
 
 2.plyr
 
First,

->Downloaded the zip file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

->The Dataset has the UCI HAR Dataset

->Unzip the UCI HAR Dataset

 files used in this project
 
  1.train    -(x_train,y_train,subject_train)
  
  2.test     -(x_test,y_test,subject_test)
  
  3.activity_labels- (has id and activity types
  
  4.features- measurment variables
  

next,Read the test data,train data,activity_labels,features and stored it in variables.

Step1:Merged the  training and test sets and assigned to the variable data_train_test

step2:extracted only the mean()and std() variables,along with Subject and Activity  and assigned to the variable 
required_mean_std_data

***Here I  extracted only the variables ending like mean() and std()  .

step3:Uses descrptive activity name for the activity variable in the dataset.for that
factor Activity  in required_mean_std_data to levels and labels and assign to required_mean_std_data$Activity.
factor the Subject also.

step4:gave descriptive names for the measurement variables.

Step:5 created a second tidy dataset with the average of measurement variables.

In this,used melt() to get the long data format

and assigned to tidy_data.melted

next used dcast() to get the wide data format of the tidy data with average of variables

step6:using write.table()created a file "tidydata.txt" which is the tidied data

Use the following code to read the "tidydata.txt" in R

tidy_data_read<- read.table("tidydata.txt", header = TRUE)

View(tidy_data_read) 


variables description:

data_train_test  -merged training and test data

required_mean_std_data   -has the variables Subject,Activity,measurement variables ending in mean()and std()

tidy_data.melted -melted second tidy data 

tidy_data_mean - dcast tidy data with mean of the measured variables.
