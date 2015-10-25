library(dplyr)

# Reads feature names
features <- as.vector(read.table("features.txt")[,2])


# Train data

# Reads Train data set
x_train <- read.table("X_train.txt")

# Assigns variable names to the data
colnames(x_train) <- features

# Reads activity column of train data set
y_train <- read.table("y_train.txt")
colnames(y_train) <- "Activity"

# Reads subject column of train data set
subject_train <- read.table("subject_train.txt")
colnames(subject_train) <- "Subject"

# Binds subject, activity and data set into one data frame
train <- cbind(subject_train, y_train, x_train)

#Test data

# Reads Test data set
x_test <- read.table("X_test.txt")

# Assigns variable names to the data
colnames(x_test) <- features

# Reads activity column of test data set
y_test <- read.table("y_test.txt")
colnames(y_test) <- "Activity"

# Reads subject column of test data set
subject_test <- read.table("subject_test.txt")
colnames(subject_test) <- "Subject"

# Binds subject, activity and data set into one data frame
test <- cbind(subject_test, y_test, x_test)


#Total data

# Merges the train and test data sets into one total data
total_data <- rbind(train, test)

# Filters out only the columns containing mean and std measurements of the variables
tomatch <- c("mean()", "std()")
matches <- grep(paste(tomatch,collapse="|"), features, value=TRUE)
remove <- grep("meanFreq", matches, value = TRUE)
matches <- matches[!matches %in% remove]
total_data2 <- total_data[,c("Subject", "Activity", matches)]

# Changes the Activity column to factor
total_data2$Activity <- as.factor(total_data2$Activity)

# Reads the activity labels
activities <- read.table("activity_labels.txt")

# Assigns the descriptive activity labels to activities
levels(total_data2$Activity) <- activities$V2

View(total_data2)

# tidy data set with average of all measures for each subject and each activity
total_data_average <- total_data2 %>% group_by(Subject, Activity) %>% summarize_each(funs(mean))

View(total_data_average)

# Stored the tidy data set in a file named Tidy data
write.table(total_data_average, file = "Tidy data.txt", row.names = FALSE)
