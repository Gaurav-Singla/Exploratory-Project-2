-- Installs the package 'dplyr'  
library(dplyr)

-- Following code reads the names of the variables from 'features.txt' file and stores it in a variable named features

features <- as.vector(read.table("features.txt")[,2])


-- At first, the following code reads the train data set and then assigns column names stored in 'features' variable. Then it reads the activity and subject data for train data. In the end , it combines all the data frames to provide a cleaner train data set

x_train <- read.table("X_train.txt")  
colnames(x_train) <- features  
y_train <- read.table("y_train.txt")  
colnames(y_train) <- "Activity"  
subject_train <- read.table("subject_train.txt")  
colnames(subject_train) <- "Subject"  
train <- cbind(subject_train, y_train, x_train)  


-- At first, the following code reads the test data set and then assigns column names stored in 'features' variable. Then it reads the activity and subject data for test data. In the end , it combines all the data frames to provide a cleaner test data set

x_test <- read.table("X_test.txt")  
colnames(x_test) <- features  
y_test <- read.table("y_test.txt")  
colnames(y_test) <- "Activity"  
subject_test <- read.table("subject_test.txt")  
colnames(subject_test) <- "Subject"  
test <- cbind(subject_test, y_test, x_test)  


-- At first, the following code merges the train and test data to give a total data set. Then it filters the columns with mean and std values for various measures. For this I have used grep to store the required column names in a vector named 'matches'. I was getting the mean frequency variables as well in the list. For removing these columns I created another vector 'remove' which contains mean frequency column names. Then I removed these column names from 'matches' vector. After this, I filtered out the required columns from our total data set and named it as 'total_data2'.

-- In the end, to assign the descriptive names to activities, I converted 'Activity' column to factor and assigned the factor labels using 'activities' data frame which has the activity names stored in it. 

total_data <- rbind(train, test)  
tomatch <- c("mean()", "std()")  
matches <- grep(paste(tomatch,collapse="|"), features, value=TRUE)  
remove <- grep("meanFreq", matches, value = TRUE)  
matches <- matches[!matches %in% remove]  
total_data2 <- total_data[,c("Subject", "Activity", matches)]  
total_data2$Activity <- as.factor(total_data2$Activity)  
activities <- read.table("activity_labels.txt")  
levels(total_data2$Activity) <- activities$V2  
   
-- Following code summarizes each variable for each subject and activity. And then it creates a file named 'Tidy data' containing this tidy data.

total_data_average <- total_data2 %>% group_by(Subject, Activity) %>% summarize_each(funs(mean))  
View(total_data_average)  
write.table(total_data_average, file = "Tidy data.txt", row.names = FALSE)

