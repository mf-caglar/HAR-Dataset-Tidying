# Human Activity Recognition Using Smartphones Dataset - Tidy Data
This repository contains the tidy dataset created from the Human Activity Recognition Using Smartphones Dataset. This project is part of the "Getting and Cleaning Data" course in the Data Science Specialization by John Hopkins University.

## Overview
The dataset was processed to extract mean and standard deviation measurements from raw accelerometer and gyroscope data. The resulting tidy dataset includes the average of these measurements for each activity and subject.

## Files
raw data/: Contains the original data files. 
summary_data.txt: The summarized dataset with average measurements for each activity and subject.
tidy_data.txt: The tidy data.
courseProjectScript.R: R script for processing the data. 
codebook.txt: Detailed descriptions of the variables in summary_data.csv.

## Analysis Script
```
features <- read.table("data/features.txt")
features <- features$V2
X_test <- read.table("data/test/X_test.txt")
X_train <- read.table("data/train/X_train.txt")
y_test <- read.table("data/test/y_test.txt")
y_train <- read.table("data/train/y_train.txt")
subject_test <- read.table("data/test/subject_test.txt")
subject_train <- read.table("data/train/subject_train.txt")
names(X_test) <- features
names(X_train) <- features
activity_labels <- read.table("data/activity_labels.txt")
tidy_data <- rbind(X_test,X_train)
cond <- sapply(names(tidy_data),function(x){grepl("mean", x) | grepl("std", x)})
mean_std_measurements <- names(tidy_data)[cond]
tidy_data <- tidy_data[mean_std_measurements]
subject_data <- rbind(subject_test,subject_train)
y_data <- rbind(y_test,y_train)
tidy_data <- cbind(tidy_data,subject_data)
tidy_data <- cbind(tidy_data,y_data)
names(tidy_data)[c(80,81)] <- c("Subject","Activity")
tidy_data$Activity <- sapply(tidy_data$Activity,function(x){activity_labels$V2[x]})
library(dplyr)
summary_data <- tidy_data %>%
    group_by(Activity,Subject) %>%
    summarise(across(everything(),mean))
write.table(summary_data,"summary_data.txt",row.name = FALSE)
write.table(tidy_data,"tidy_data.txt",row.name = FALSE)
```

## Repository Structure
```
.
├── raw data/
│   ├── features.txt
│   ├── activity_labels.txt
│   ├── train/
│   └── test/
├── README.md
├── codebook.txt
├── courseProjectScript.R
├── summary_data.csv
└── tidy_data.csv
```

## Original Dataset
The data was collected by the Smartlab at the Università degli Studi di Genova. It includes data from 30 subjects performing six activities using a Samsung Galaxy S II smartphone.

For detailed information on the original dataset and the feature extraction process, refer to the codebook.txt file.
