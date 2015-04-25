features <- read.table('UCI HAR Dataset/features.txt')[, 2]
mean_std_features <- features[grepl('mean', features) | grepl('std', features)]
x_train <- read.table('UCI HAR Dataset/train/X_train.txt', col.names = features)[, mean_std_features]
subject_train <- read.table('UCI HAR Dataset/train/subject_train.txt')
y_train <- read.table('UCI HAR Dataset/train/y_train.txt')
train <- cbind(x_train, subject_train, y_train)
x_test <- read.table('UCI HAR Dataset/test/X_test.txt', col.names = features)[, mean_std_features]
subject_test <- read.table('UCI HAR Dataset/test/subject_test.txt')
y_test <- read.table('UCI HAR Dataset/test/y_test.txt')
test <- cbind(x_test, subject_test, y_test)
m <- rbind(train, test)
activity_labels <- read.table('UCI HAR Dataset/activity_labels.txt')
m[, 81] <- activity_labels[m[, 81], 2]
colnames(m)[80] <- 'subject'
colnames(m)[81] <- 'activity'
#install.packages('dplyr')
library(dplyr)
activity_subject <- group_by(m, activity, subject)
tidy <- summarise_each(activity_subject, funs(mean))
write.table(tidy, file='tidy_data.txt', row.names=FALSE)