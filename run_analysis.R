# Getting and cleaning data
# Peer-graded assignment

library(dplyr)
library(tidyr)
library(reshape2)

rm(list = ls()) # remove anything left over from previous runs

source("./../download_unzip.R")

# File locations
xTest <- "./test/X_test.txt" # X test file location
yTest <- "./test/y_test.txt" 
subjectTest <- "./test/subject_test.txt" 
xTrain <- "./train/X_train.txt"
yTrain <- "./train/y_train.txt"
subjectTrain <- "./train/subject_train.txt"
features <- "./features.txt"

# Checking dimensions of data before merging
dim(read.table(features))       # 561 x 2: (561 variables)
dim(read.table(xTest))          # 2947 x 561 (2947 observations)
dim(read.table(yTest))          # 2947 x 1
dim(read.table(subjectTest))    # 2947 x 1
dim(read.table(xTrain))         # 7352 x 561 (7352 observations)
dim(read.table(yTrain))         # 7352 x 1
dim(read.table(subjectTrain))   # 7352 x 1
# Dimensions match okay.

# Getting variable names from features  
varNames <- read.table(features)[, 2]

# 1. Merges the training and the test sets to create one data set.
#
# Merging the test and training data
testData <- cbind(read.table(subjectTest, col.names = "subject"),
                  read.table(yTest, col.names = "activity"), 
                  read.table(xTest, col.names = varNames))
trainData <- cbind(read.table(subjectTrain, col.names = "subject"),
                   read.table(yTrain, col.names = "activity"),
                   read.table(xTrain, col.names = varNames))
data <- rbind(trainData, testData)
rm(testData, trainData) # Housekeeping: remove unneeded data sets

# 2. Extracts only the measurements on the mean and standard deviation for 
#    each measurement.
#
# Keeping only subject, activity, and variables with mean or standard deviation
data <- select(data, 
               grep("^subject$|^activity$|mean\\.\\.|std\\.\\.", names(data)))

# 3. Uses descriptive activity names to name the activities in the data set
#
# Giving activities more understandable names
activities <- c("walking", "walkingUpstairs", "walkingDownstairs", 
                "sitting", "standing", "laying")
data$activity <- activities[data$activity]

# 4. Appropriately labels the data set with descriptive variable names. 
#
# Renaming variables: removing periods and making them more readable. I largely
# left the variable names the same as before because they were a good balance
# between variable length and descriptiveness. Variable names that are too long
# can be quite cumbersome to type when analysing data. I use capitalisation to
# denote the start of a "new word" in the variable name. This is done to aid
# readability.
names(data) <- gsub("mean\\.\\.", "Mean", names(data))
names(data) <- gsub("std\\.\\.", "Std", names(data))
names(data) <- gsub("\\.", "", names(data))

# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
#
# Using reshape2 and tidyr to create the new tiny data set. Using group_by and
# summarise is a possibility but it takes more programmer time.  
tinyData <- melt(data, id = c("subject", "activity"), 
                 measure.vars = names(data)[-(1:2)])
tinyData <- mutate(tinyData, subject_activity = paste0(subject, "_", activity))
tinyData <- dcast(tinyData, subject_activity ~ variable, mean)
tinyData <- separate(tinyData, col = subject_activity, c("subject", "activity"))
tinyData$subject <- as.numeric(tinyData$subject)
tinyData <- arrange(tinyData, subject, activity)
write.table(tinyData, file = "tinyData.txt", row.names = FALSE)

# Reading the table to check if it works. 
ans <- read.table("tinyData.txt", header = TRUE)