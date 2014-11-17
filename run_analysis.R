library(plyr)
X_test <- read.table(".../Getting and Cleaning Data/UCI HAR Dataset/test/X_test.txt")
X_train <- read.table(".../Getting and Cleaning Data/UCI HAR Dataset/train/X_train.txt")
y_test <- read.table(".../Getting and Cleaning Data/UCI HAR Dataset/test/y_test.txt")
y_train <- read.table(".../Getting and Cleaning Data/UCI HAR Dataset/train/y_train.txt")
activity_labels <- read.table(".../Getting and Cleaning Data/UCI HAR Dataset/activity_labels.txt")
features <- read.table(".../Getting and Cleaning Data/UCI HAR Dataset/features.txt")
n_mean <- grep("mean",features[,2])
n_std <- grep("std",features[,2])
n <- sort(c(n_mean, n_std))
X_data <- rbind(X_test, X_train)
colnames(X_data) <- features[,2]
data_set <- X_data[, n]
y_labels <- rbind(y_test, y_train)
act_names <- join(y_labels, activity_labels, "V1")
data_set <- cbind(activity-name = act_names[,2], data_set)
aver_act <- apply(data_set[,2:length(data_set)],2,mean)
aver_act <- c(activity = "all",aver_act)
for(i in activity_labels[,2]){
	aver <- apply(data_set[data_set[,1] == i,2:length(data_set)],2,mean)
	aver <- c(activity = i,aver)
	aver_act <- rbind(aver_act, aver)
}
