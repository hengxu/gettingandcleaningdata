
This file describes how the R script "run_analysis.R" works

1. first, I read all tables from the input files, there are 8 files
   read in, in the following order

	1) "UCI HAR Dataset/test/subject_test.txt"
		this file gives the subject id of all the observations
		from the test data set

	2) "UCI HAR Dataset/test/X_test.txt"
		this file gives all 561 features of all the observations
		from the test data set

	3) "UCI HAR Dataset/test/y_test.txt"
		this file gives all activity id of all the observations
		from the test data set

	4) "UCI HAR Dataset/train/subject_train.txt"
		this file gives the subject id of all the observations
		from the train data set

	5) "UCI HAR Dataset/train/X_train.txt"
		this file gives all 561 features of all the observations
		from the train data set

	6) "UCI HAR Dataset/train/y_train.txt"
		this file gives all activity id of all the observations
		from the train data set

	7) "UCI HAR Dataset/features.txt"
		this file gives a name list of all 561 features

	8) "UCI HAR Dataset/activity_labels.txt"
		this file gives a name list of all 6 kinds of activities

	the files in both "UCI HAR Dataset/test/Inertial Signals" and 
	"UCI HAR Dataset/train/Inertial Signals" are not used by the script

2. I merge the training and test data sets to create on data set.

	1) I append/merge the test subject ids and the train subject ids
	to create a single table contains all the subject ids

	2) I append/merge the test X data and the train X data to
	create a single table contains all the observations on the
	561 features

	3) I append/merge the test activity ids and the train activity
	ids to create a single table contains all the activity ids

	4) I create a single table combines all the information from 
	the previous 3 steps

3. I extract only the measures on the mean and standard deviation for 
each measurement, this step gives 66 filtered features

	1) I use regular expression to extract all the features names
	from the features.txt that measures only on mean or standard
	deviations, this steps gives a list of columns that fits the
	description

	2) I then subset all the observations on only the columns 
	filtered by the results of previous step

4. I name the activities in the data set with descriptive activity names

	1) I created a map from number to activity names from the
	file activity_labels.txt

	2) I replace all the number (1-6) from that column with the
	corresponding name string from the map

5. I label the data set with appropriate descriptive column/variable
names by removing '-', '(', and ')' characters from the filtered 
feature names from features.txt file, then assigned these names to be
the column names of the resulting table

6. I create a second, independent tidy data set with the average of
each variable for each activity and each subject, this gives a
6 * 30 = 180 observations contains all the averages of filtered features
by the combinations of subject ids and activity ids

	1) I create a new factor variable as a new column to get the 
	combined factor with 30 * 6 = 180 levels (combinations of 
	subject ids and activity ids)

	2) then I create an empty table (data frame) contains 66
	filter features and the two factor levels

	3) I used a loop to compute the 30 * 6 = 180 rows, first
	filter out each different levels first, and then compute
	the average of all the fields (columns) of the resulting
	subset table

7. I write the table to a file called "tidyData.txt" with appropriate
row names and column names


