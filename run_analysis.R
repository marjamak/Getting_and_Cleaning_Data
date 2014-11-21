# Jouni Marjamaki 21.11.2014
# Course Project : Getting and Cleaning Data 
#

# ----- Read data -----

data_feat <- read.table("./UCI HAR Dataset/features.txt")
  
data_train_subj <- read.table("./UCI HAR Dataset/train/subject_train.txt")
data_train_X <- read.table("./UCI HAR Dataset/train/X_train.txt")
data_train_y <- read.table("./UCI HAR Dataset/train/y_train.txt")

data_test_subj <- read.table("./UCI HAR Dataset/test/subject_test.txt")
data_test_X <- read.table("./UCI HAR Dataset/test/X_test.txt")
data_test_y <- read.table("./UCI HAR Dataset/test/y_test.txt")


# ----- Prepare train data with user friendly column names and labes names -----

# Use descriptive activity names to name the activities in the data set.
# In other words, set activity label values according to "./UCI HAR Dataset/activity_labels.txt" file
data_train_y$V1[data_train_y$V1==1] <- "WALKING"
data_train_y$V1[data_train_y$V1==2] <- "WALKING_UPSTAIRS"
data_train_y$V1[data_train_y$V1==3] <- "WALKING_DOWNSTAIRS"
data_train_y$V1[data_train_y$V1==4] <- "SITTING"
data_train_y$V1[data_train_y$V1==5] <- "STANDING"
data_train_y$V1[data_train_y$V1==6] <- "LAYING"

# Add "Subject_" prefix to values in Subject column
data_train_subj$V1 <- sprintf("Subject_%02d", data_train_subj$V1)

# Set descriptive variable names
colnames(data_train_subj) <- "Subject"
colnames(data_train_y) <- "ActivityLabel"
colnames(data_train_X) <- t(data_feat[2])
  

# ----- Prepare test data with user friendly column names and labes names ----- 
  
# Use descriptive activity names to name the activities in the data set.
# In other words, set activity label values according to "./UCI HAR Dataset/activity_labels.txt" file
data_test_y$V1[data_test_y$V1==1] <- "WALKING"
data_test_y$V1[data_test_y$V1==2] <- "WALKING_UPSTAIRS"
data_test_y$V1[data_test_y$V1==3] <- "WALKING_DOWNSTAIRS"
data_test_y$V1[data_test_y$V1==4] <- "SITTING"
data_test_y$V1[data_test_y$V1==5] <- "STANDING"
data_test_y$V1[data_test_y$V1==6] <- "LAYING"

# Add "Subject_" prefix to values of Subject column
data_test_subj$V1 <- sprintf("Subject_%02d", data_test_subj$V1)

# Set descriptive variable names
colnames(data_test_subj) <- "Subject"
colnames(data_test_X) <- t(data_feat[2])
colnames(data_test_y) <- "ActivityLabel"


# ----- Merge train and test data ------

# Merge train data with train labels and test subjects
trainXy <- cbind (data_train_X, data_train_y)
trainXySubj <- cbind (trainXy, data_train_subj)

# Merge test data with test labels and test subjects
testXy <- cbind (data_test_X, data_test_y)
testXySubj <- cbind (testXy, data_test_subj)

# Merge train and test data
allData <- rbind(trainXySubj,testXySubj)


# ----- Find colums of mean, Mean and std -----
q <- grep("Mean", (colnames(allData)))
q <- append(q,grep("mean", (colnames(allData))))
q <- append(q,grep("std", (colnames(allData))))

# ----- include ActivityLabel and Subject columnsd too ------
q <- append(q,grep("ActivityLabel", (colnames(allData))))
q <- append(q,grep("Subject", (colnames(allData))))
q<-sort(q)



# ----- extract required columns from allData -----

extractedData <- allData[,q]


library(plyr)


# Count mean of the extracted columns. 
# The "is.numeric" is included in ddply to exclude ActivityLabel
# because mean of ActivityLabel column values would be "NA"

tidy1 <- ddply(subset(extractedData, ActivityLabel=="WALKING"), .(Subject), colwise(mean, is.numeric))
tidy2 <- ddply(subset(extractedData, ActivityLabel=="WALKING_UPSTAIRS"), .(Subject), colwise(mean, is.numeric))
tidy3 <- ddply(subset(extractedData, ActivityLabel=="WALKING_DOWNSTAIRS"), .(Subject), colwise(mean, is.numeric))
tidy4 <- ddply(subset(extractedData, ActivityLabel=="SITTING"), .(Subject), colwise(mean, is.numeric))
tidy5 <- ddply(subset(extractedData, ActivityLabel=="STANDING"), .(Subject), colwise(mean, is.numeric))
tidy6 <- ddply(subset(extractedData, ActivityLabel=="LAYING"), .(Subject), colwise(mean, is.numeric))


# Now add "ActivityLabel" column back

tidy1[,"ActivityLabel"] <- "WALKING"
tidy2[,"ActivityLabel"] <- "WALKING_UPSTAIRS"
tidy3[,"ActivityLabel"] <- "WALKING_DOWNSTAIRS"
tidy4[,"ActivityLabel"] <- "SITTING"
tidy5[,"ActivityLabel"] <- "STANDING"
tidy6[,"ActivityLabel"] <- "LAYING"



tidy_data <- rbind(tidy1,tidy2,tidy3,tidy4,tidy5,tidy6)

write.table(tidy_data, "./TidyDataSet.txt", sep="\t", row.name=FALSE)
