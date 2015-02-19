## The script assumes .zip file with the data was extracted directly into
## the working directory.
## It groups measurements by subject (1 to 30) and activity (walking,
## walking_upstairs, walking_downstairs, sitting, standing and lying),
## picks values with "mean()" and "std()" in their names and calculates
## average for each group. Then writes the result to a file.

## To include values with "mean" and "Mean" in their names, uncomment
## line 56 and comment out line 59.

library(dplyr)

###################################################################
## 1. Merges the training and the test sets to create one data set.

## reads raw measurement data
raw_train <- read.table("UCI HAR Dataset/train/X_train.txt")
raw_test <- read.table("UCI HAR Dataset/test/X_test.txt")

## reads subject data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

## reads activities data
activities_train <- read.table("UCI HAR Dataset/train/y_train.txt")
activities_test <- read.table("UCI HAR Dataset/test/y_test.txt")

## merges subject, activities and measurements for each set
raw_train <- cbind(subject_train, activities_train, raw_train)
raw_test <- cbind(subject_test, activities_test, raw_test)

## merges train and test data sets
raw <- rbind(raw_train, raw_test)

## clears workspace
rm(raw_train, raw_test, subject_train, subject_test,
   activities_train, activities_test)


########################################################################
## 2. Appropriately labels the data set with descriptive variable names.

## reads column names from file
all_values <- read.table("UCI HAR Dataset/features.txt")
all_values <- as.character(all_values[, 2])

## assigns column names
names(raw) <- c("subject", "activity", all_values)


#######################################################################
## 3. Extracts only the measurements on the mean and standard deviation
## for each measurement. 

## select first two columns and columns whose names contain mean or std
# selected_values <- grep("subject|activity|[Mm]ean|std" , names(raw))

## select first two columns and columns with mean() or std()
selected_values <- grep("subject|activity|mean\\(\\)|std\\(\\)" , names(raw))

## keep subject, activity and mean/std columns
raw <- raw[, selected_values]

## correct object types
raw <- as.data.frame(raw)
raw[, 3:ncol(raw)] <- sapply(raw[, 3:ncol(raw)], as.numeric)
raw$activity <- as.factor(raw$activity)
raw$subject <- as.factor(raw$subject)

############################################################################
## 4. Uses descriptive activity names to name the activities in the data set

## read names from file and rename factor levels
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
levels(raw$activity) <- tolower(activities[, 2])

## 5. From the data set in step 4, creates a second, independent tidy data set
## with the average of each variable for each activity and each subject.

## groups by subject and activity
raw <- group_by(raw, subject, activity)

## calculates mean of each value for each group and writes the result to
## a new data frame
result <- summarise_each(raw, funs(mean))

## writes to file, clears workspace
write.table(result, "UCI HAR Dataset/tidy_data.txt", row.names = FALSE)

rm(raw, result, activities, all_values, selected_values)