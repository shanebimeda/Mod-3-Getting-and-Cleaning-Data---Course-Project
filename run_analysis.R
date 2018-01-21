## Getting and Cleaning Data Course Project
## This is a script for running an analysis in the given data. 
## We will be using the r packages data.table and reshape2 as these
## will make things easier for us.

##So for the preliminaries, we have to set-up our packages first, get our data and 
##unzip them.
##Part 1

packages <- c("data.table", "reshape2")
sapply(packages, require, character.only = TRUE)
filepath <- getwd()
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, file.path(filepath, "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")


## Here we are loading the activity labels and the features
##Part 2

actLabels <- fread(file.path(filepath, "UCI HAR Dataset/activity_labels.txt")
                        , col.names = c("classLabels", "activityName"))
features <- fread(file.path(filepath, "UCI HAR Dataset/features.txt")
                  , col.names = c("index", "featureNames"))
neededfeatures <- grep("(mean|std)\\(\\)", features[, featureNames])
measurements <- features[neededfeatures, featureNames]
measurements <- gsub('[()]', '', measurements)


## Here we are loading the train datasets
##Part 3

train <- fread(file.path(filepath, "UCI HAR Dataset/train/X_train.txt"))[, neededfeatures, with = FALSE]
data.table::setnames(train, colnames(train), measurements)
trainActs <- fread(file.path(filepath, "UCI HAR Dataset/train/Y_train.txt")
                         , col.names = c("Activity"))
trainSubjects <- fread(file.path(filepath, "UCI HAR Dataset/train/subject_train.txt")
                       , col.names = c("SubjectNum"))
train <- cbind(trainSubjects, trainActs, train)


## Here we are loading the test datasets
##Part 4

test <- fread(file.path(filepath, "UCI HAR Dataset/test/X_test.txt"))[, neededfeatures, with = FALSE]
data.table::setnames(test, colnames(test), measurements)
testActs <- fread(file.path(filepath, "UCI HAR Dataset/test/Y_test.txt")
                        , col.names = c("Activity"))
testSubjects <- fread(file.path(filepath, "UCI HAR Dataset/test/subject_test.txt")
                      , col.names = c("SubjectNum"))
test <- cbind(testSubjects, testActs, test)


## Here we are merging the two datasets: test and train, into one big table

mergedDT <- rbind(train, test)

## Here we are converting the classLabels to ActivityNames to make them self-describing.

mergedDT[["Activity"]] <- factor(mergedDT[, Activity]
                                 , levels = actLabels[["classLabels"]]
                                 , labels = actLabels[["activityName"]])

## Finally, here we are reshaping our mergedDT (our data) and transforming it according to the said specifications 
## and making/writing a new data table called tidyData.txt.
## On a side note, I am really  so amazed of the melt and dcast functions from the reshape2 package. 
##Part 5 

mergedDT[["SubjectNum"]] <- as.factor(mergedDT[, SubjectNum])
mergedDT <- reshape2::melt(data = mergedDT, id = c("SubjectNum", "Activity"))
mergedDT <- reshape2::dcast(data = mergedDT, SubjectNum + Activity ~ variable, fun.aggregate = mean)


data.table::fwrite(x = mergedDT, file = "tidyData.txt", quote = FALSE)






