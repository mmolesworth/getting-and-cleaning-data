Getting and Cleaning Data Course Project
Version 1.0
Mark Molesworth
Coursera
m.molesworth@gmail.com

This project contains the Human Activity Recognition Using Smartphones Data Set from the UCI Machinie Learning Repository (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The source data contains measurements from the embedded accelerometer and gyroscope of a SmartPhone. Test and training measurements were performed by 30 participants for six different activities: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS.

The R script, run_analysis.R, extracts data from the source and transforms it into a 'tidy dataset' displaying the average of each 'mean' or 'std' variable for each subject and activity.

The following steps are performed to transform the original dataset:
1. Training and test sets are merged into one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names, obtained from the 'activity_lables.txt' source file, to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. These are taken from the 'features.txt' file.
5. Returns a tidy data set with the average of each variable for each activity and each subject.
