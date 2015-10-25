# Variables-  

features - names of all the variables measured for each subject  
x_train - train data set  
y_train - activity vector for train data set  
subject_train - train data of subjects on which experiment was conducted  
train - train data set with added subject and activity column  
x_test - test data set  
y_test - activity vector for test data set  
subject_test - test data of subjects on which experiment was conducted  
test - test data set with added subject and activity column  
total_data - combined train and test data  
matches - vector of column names containing mean and standard deviation of different measurements  
total_data2 - data set with subject, activity and corresponding mean and standard deviation columns  
total_data_average - tidy data set with average of all the measurements for each subject and activity  


# Steps taken to clean the data-

1. Read the Train and Test data and assigned the columns names using features file  
2. Added the Subject and Activity column to both the data sets  
3. Combined the Train and Test data sets to get the Total data set  
4. Filtered the required columns containing the mean and standard deviation of different measurements
5. Assigned the names to various levels of Activity
6. Used the summarize_each function to summarize the data based on each subject and activity 
