library(plyr)
X_test <- read.table("D:/test/X_test.txt",header = FALSE)
X_train <- read.table("D:/train/X_train.txt",header = FALSE)
y_test <- read.table("D:/test/y_test.txt",header = FALSE)
y_train <- read.table("D:/train/y_train.txt",header = FALSE)
subject_test <- read.table("D:/test/subject_test.txt",header = FALSE)
subject_train <- read.table("D:/train/subject_train.txt",header = FALSE)
all_data <- cbind(rbind(y_test,y_train),rbind(subject_test,subject_train))
all_data <- cbind(all_data,rbind(X_test,X_train))
all_mean <- apply(all_data[,3:length(all_data)],2,mean)
all_sd <- apply(all_data[,3:length(all_data)],2,sd)
activity_labels <- read.table("C:/Users/Administrator/Desktop/Getting and Cleaning Data/UCI HAR Dataset/activity_labels.txt",header = FALSE)
names(all_data)[1:2] <- c("activity","subject")
names(activity_labels)[1] <- "activity"
all_data <- join(activity_labels, all_data, "activity")
all_data <- all_data[,-1]
names(all_data)[1] <- "activity"
for(i in 3:length(all_data)){
	x <- tapply(all_data[,i],all_data$activity,mean)
	y <- tapply(all_data[,i],all_data$subject,mean)
	if(i == 3){
		activity_mean <- x
		subject_mean <- y
	}
	else{
		activity_mean <- rbind(activity_mean,x)
		subject_mean <- rbind(subject_mean,y)
	}
}
rownames(activity_mean) <- NULL
rownames(subject_mean) <- NULL
