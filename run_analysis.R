#You should create one R script called run_analysis.R that does the following.

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


  library(dplyr)
  
  setwd("/home/mark/Data_Science/Data_Cleaning/course_project/UCI_HAR/")
  
  ##Load dataframes
  #Reference data
  activities <- read.csv("activity_labels.txt", sep = " ", header = FALSE)
  features <- read.csv("features.txt", sep = "", header = FALSE)
  
  #Training data
  subject_train <- read.csv("train/subject_train.txt", sep = "", header = FALSE)
  X_train <- read.csv("train/X_train.txt", sep = "", header = FALSE)
  Y_train <- read.csv("train/y_train.txt", sep = "", header = FALSE)

  #Testing data
  subject_test <- read.csv("test/subject_test.txt", sep = "", header = FALSE)
  X_test <- read.csv("test/X_test.txt", sep = "", header = FALSE)
  Y_test <- read.csv("test/y_test.txt", sep = "", header = FALSE)
  
  ##Assign appropriate column names
  names(activities) <- c("activity_id", "activity")
  names(subject_train) <- c("subject_id")
  names(subject_test) <- c("subject_id")
  
  #Use the 'features' vector as the column headers for the X_train/test dataframes
  names(features) <- c("feature_id", "feature")
  names(X_train) <-  as.vector(features$feature)
  names(X_test) <-  as.vector(features$feature)
  
  #The 'activity_id' is the column header for the Y_train dataframe
  names(Y_train) <- c("activity_id")
  names(Y_test) <- c("activity_id")
  
  ##Reduce the columns of 'X_test' and 'Y_test' to only those with 'mean' or 'std'
  #regex for pulling mean and std -- "mean\\(\\)|std\\(\\)"
  test_good_columns <- grep("mean\\(\\)|std\\(\\)", names(X_test))
  train_good_columns <- grep("mean\\(\\)|std\\(\\)", names(X_train))
  
  X_test <- X_test[ , test_good_columns]
  X_train <- X_train[ , train_good_columns]
  
  ##Combine into one dataframe for 'test' & 'train'
  #Create a dummy column that shows whether the data originally came from 'test' or 'train'
  train <- cbind(c("train"), subject_train, Y_train, X_train)
  test <- cbind(c("test"), subject_test, Y_test, X_test)
  
  #Re-name the dummy variable as 'result_type'
  names(train)[1] <- "result_type"
  names(test)[1] <- "result_type"
  
  ##Combine the 'train' and 'test data into one dataframe
  combined <- rbind(train, test)
  
  #Join 'combined' with 'activities' to get the activity label ('WALKING', 'LAYING', etc.) into the dataframe
  final <- merge(activities, combined, by.x = "activity_id", by.y = "activity_id")
  
  ##Create the tiday dataset
  #Select all columns except 1 (activity_id) and 3 (result_type) (these are not needed)
  #Group by activity and subject_id
  #Compute the average for the remaining variables using the 'summarize_all' function
  tidyset <- final %>% select(-1, -3) %>% group_by(activity, subject_id) %>% summarize_all(funs(average = mean))

 

