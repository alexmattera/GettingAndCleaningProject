##this is a script to merge the test and train data from the UCI Human Activity Recognition
##data set, add subject and activity identifiers, add column headings, add descriptive activity
##indicators, calculate mean grouped by subject and activity and ultimately return a smaller
##tidy data set with these mean values.

##retrieve data files
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt",colClasses="numeric",header=FALSE)
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt",colClasses="character",header=FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt",colClasses="character",header=FALSE)
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt",colClasses="numeric",header=FALSE)
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt",colClasses="character",header=FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt",colClasses="character",header=FALSE)
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",colClasses="character",header=FALSE)
features <- read.table("./UCI HAR Dataset/features.txt",colClasses="character",header=FALSE)

##combine data files
test_data = cbind(subject_test,Y_test,X_test)
train_data = cbind(subject_train,Y_train,X_train)
all_data = rbind(test_data,train_data)

##rename columns
colnames <- c("Subject","Activity",as.vector(features[,2]))
names(all_data) <- colnames

##find columns with mean and standard deviation
selected_columns <- c(1,2,grep("mean|std", colnames))

##extract columns with mean and standard deviation
selected_data <- all_data[,selected_columns]

##add descriptive activity indicators
names(activity_labels) <- c("Activity","Activity_Description")
descriptive_data <- merge(activity_labels,selected_data, by = "Activity")

##calculate mean of all columns by Subject and Activity
tidy_data <- aggregate(descriptive_data[,4:ncol(descriptive_data)],by=list(descriptive_data$Subject,descriptive_data$Activity_Description),FUN="mean",na.rm=TRUE)

##rename columns
tidy_colnames <- c("Subject","Activity_Description",paste("mean of ",names(tidy_data[,3:ncol(tidy_data)])))
names(tidy_data) <- tidy_colnames

##sort data by groupings
attach(tidy_data)
tidy_data <- tidy_data[order(Subject,Activity_Description),] 
detach(tidy_data)

##write to .txt file
write.table(tidy_data,"./tidy_data.txt",row.name=FALSE)
