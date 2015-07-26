##Coursera "Data Science Track", 2015
##"Getting and Cleaning Data" Course Project
##Nick Crowley

## Instructions
## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subjec

setwd("/home/ncrowley/Documents/R/Getting_Data/UCI HAR Dataset")

train = read.csv("/home/ncrowley/Documents/R/Getting_Data/UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
train[,562] = read.csv("/home/ncrowley/Documents/R/Getting_Data/UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
train[,563] = read.csv("/home/ncrowley/Documents/R/Getting_Data/UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

test = read.csv("/home/ncrowley/Documents/R/Getting_Data/UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
test[,562] = read.csv("/home/ncrowley/Documents/R/Getting_Data/UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
test[,563] = read.csv("/home/ncrowley/Documents/R/Getting_Data/UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

activityLabels = read.csv("/home/ncrowley/Documents/R/Getting_Data/UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

# Read features and make the feature names better suited for R with some substitutions
features = read.csv("/home/ncrowley/Documents/R/Getting_Data/UCI HAR Dataset/features.txt", sep="", header=FALSE)
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])

# Merge train and test sets 
mergeData = rbind(train, test)

# Get only the data on mean and std. dev.
colsNeeded <- grep(".*Mean.*|.*Std.*", features[,2])
# First reduce the features table to what we want
features <- features[colsNeeded,]
# Now add the last two columns (subject and activity)
colsNeeded <- c(colsNeeded, 562, 563)
# And remove the unwanted columns from allData
mergeData <- mergeData[,colsNeeded]
# Add the column names (features) to allData
colnames(mergeData) <- c(features$V2, "Activity", "Subject")
colnames(mergeData) <- tolower(colnames(mergeData))

currentActivity = 1
for (currentActivityLabel in activityLabels$V2) {
  mergeData$activity <- gsub(currentActivity, currentActivityLabel, mergeData$activity)
  currentActivity <- currentActivity + 1
}

mergeData$activity <- as.factor(allData$activity)
mergeData$subject <- as.factor(allData$subject)

tidy = aggregate(mergeData, by=list(activity = mergeData$activity, subject=mergeData$subject), mean)
# Remove the subject and activity column, since a mean of those has no use
tidy[,90] = NULL
tidy[,89] = NULL
write.table(tidy, "tidy.txt", sep="\t")


