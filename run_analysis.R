
# first read all tables from the relavant files
folder <- "UCI HAR Dataset/"

# reaing subject_test.txt
filePath <- "test/subject_test.txt"
path <- paste(folder, filePath, sep = "")
testSubject <- read.table(path)

# reading X_test.txt
filePath <- "test/X_test.txt"
path <- paste(folder, filePath, sep = "")
testX <- read.table(path)

# reading y_test.txt
filePath <- "test/y_test.txt"
path <- paste(folder, filePath, sep = "")
testY <- read.table(path)

# reading subject_train.txt
filePath <- "train/subject_train.txt"
path <- paste(folder, filePath, sep = "")
trainSubject <- read.table(path)

# reading X_train.txt
filePath <- "train/X_train.txt"
path <- paste(folder, filePath, sep = "")
trainX <- read.table(path)

# reading y_train.txt
filePath <- "train/y_train.txt"
path <- paste(folder, filePath, sep = "")
trainY <- read.table(path)

# reading features.txt
filePath <- "features.txt"
path <- paste(folder, filePath, sep = "")
features <- read.table(path)

# reading activity_labels.txt
filePath <- "activity_labels.txt"
path <- paste(folder, filePath, sep = "")
actLabels <- read.table(path)

# merges the training and the test sets to create one data set
totalSubject <- rbind(trainSubject, testSubject)
totalX <- rbind(trainX, testX)
totalY <- rbind(trainY, testY)
all <- cbind(totalX, totalY, totalSubject)

# extracts only the measurements on the mean and standard deviation for each measurement
cnames <- grep("mean\\(\\)|std\\(\\)", features[["V2"]])
allMeanStd <- all[, c(cnames, length(features[["V2"]]) + 1, length(features[["V2"]]) + 2)]

# name the activities in the data set with descriptive activity names
lookup <- data.frame(actLabels[,1], actLabels[,2])
allMeanStd2 <- allMeanStd
allMeanStd2[, length(allMeanStd2) + 1] <- lookup[allMeanStd2[, length(allMeanStd2) - 1], 2]

# labelling the data set with appropriate descriptive column/variable names
colnames(allMeanStd2) <- c(gsub("[-\\(\\)]", "", features[["V2"]][cnames]), "activityNum", "subject", "activity")

# creating a second, independent tidy data set with the average of each variable for each activity and each subject
allMeanStd2$byEach <- with(allMeanStd2, interaction(allMeanStd2[, 67], allMeanStd2[, 68]))
result <- data.frame(t(rep(NA, length(colnames(allMeanStd2)))))
names(result) <- colnames(allMeanStd2)
result <- result[-1, ]
result2 <- result
currF <- data.frame()
# populate the final table
for (f in levels(allMeanStd2[, 70])) {
  currF <- subset(allMeanStd2, as.character(allMeanStd2[, 70]) == as.character(f))
  newRow <- apply(currF[, 1:66], 2, mean)
  newRow <- data.frame(newRow)
  newRow <- data.frame(t(newRow))
  newRow <- cbind(currF[1, 68:69], newRow[1, 1:66])
  result2 <- rbind(result2, newRow)
}
rownames(result2) <- 1:180
# writing the tidy data to a file
write.table(result2, file = "tidyData.txt", sep = " ", row.names = TRUE, col.names = TRUE)


