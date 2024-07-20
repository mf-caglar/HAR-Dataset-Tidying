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
write.table(summary_data,"summary_data.txt",row.names = FALSE)
write.table(tidy_data,"tidy_data.txt",row.names = FALSE)