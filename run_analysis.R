setwd('Documents/Coursera/Rfiles/Data Cleaning/')#Set working directory
library(reshape2) #read in necessary package

#------- STEP 0: READ IN APPROPRIATE RAW INFORMATION
#read in test data and relevant extra columns
testData<-read.table('UCI HAR Dataset/test/X_test.txt')
testData_y<-read.table('UCI HAR Dataset/test/y_test.txt')
testData_subject<-read.table('UCI HAR Dataset/test/subject_test.txt')

#read in training data and relevant extra columns
trainData<-read.table('UCI HAR Dataset/train/X_train.txt')
trainData_y<-read.table('UCI HAR Dataset/train/y_train.txt')
trainData_subject<-read.table('UCI HAR Dataset/train//subject_train.txt')

featureNames<-read.table("UCI HAR Dataset/features.txt",stringsAsFactors=F)
activityLabels<-read.table('UCI HAR Dataset/activity_labels.txt',stringsAsFactors=F)

#------- Merge the training and the test sets to create one data set.
#merge all columns of test data set, add identifier for test rows 
testMerged<-cbind(rep("test",nrow(testData)),testData_y, testData_subject, testData)
colnames(testMerged)<-c("testOrTrain","Activity","Subject",featureNames[,2]) #label variable names

#merge all columns of train data set, add identifier for train rows
trainMerged<-cbind(rep("train",nrow(trainData)),trainData_y, trainData_subject, trainData)
colnames(trainMerged)<-c("testOrTrain","Activity","Subject",featureNames[,2]) #label variable names that match testing data set

#merge two data sets together
allDataMerged<-rbind(testMerged, trainMerged)

#------- Extract only the measurements on the mean and standard deviation for each measurement.
allDataSub<-allDataMerged[,c(1:3,which((grepl("mean\\(\\)",colnames(allDataMerged))==T | grepl("std\\(\\)",colnames(allDataMerged))==T)))] #keep only columns that contain either "mean" or "std" along with the identifying variable columns.

#------- Use descriptive activity names to name the activities in the data set
allDataSub$Activity<-activityLabels[as.numeric(allDataSub$Activity),2]

#------- From the previous data set, create a second, independent tidy data set with the average of each variable for each activity and each subject.
allDataMeans<-allDataSub[,c(2:3, which(grepl("mean\\(\\)",colnames(allDataSub))==T))]
colnames(allDataMeans)<-gsub("-mean\\(\\)","",colnames(allDataMeans)) #eliminate the "mean()" character string from the column names
colnames(allDataMeans)<-gsub("-","",colnames(allDataMeans)) #eliminate the "mean()" character string from the column names

meansMelted<-melt(allDataMeans, id=c("Activity","Subject"))
meanTable<-tapply(meansMelted$value, meansMelted[,-4],mean)
meanTable<-data.frame(ftable(meanTable))
colnames(meanTable)<-c("Activity","Subject","Variable","Mean")
write.table(meanTable,"testTable.txt",row.names=F)
