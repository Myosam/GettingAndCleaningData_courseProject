
README for Coursera's project work in "Getting and Cleaning Data". R-script name is
**run_analysis.R**. Description of variables can be found from **CodeBook.md** in the same Git-repository.

Scrip reads Train and Test data-sets for the project work. Labels them by subject and by activity label.

Script creates two tables:
First table with all the data above combined
Second table with all the data above with calculated averages by each activity and subject

# run_analysis.R

### 1) Reading data
Provided measure-data X-test and X-train is read and combined to one table
**X_measures**

### 2) Data filtering
Features and Subjects are read and only X_measures variables which have "mean" or "std" in their name are saved. X_measures columns are named accordinly.
```
ind_mean <- grep("*mean*", feat_table$V2)
ind_std <- grep("*std*", feat_table$V2)

X_mean <- X_measures[ , ind_mean]
X_std <- X_measures[ , ind_std]

X_mean_names <- setNames(X_mean, feat_table$V2[ind_mean])
X_std_names <- setNames(X_std, feat_table$V2[ind_std])
X_measures <- cbind(X_mean_names, X_std_names)

```


### 3) Data labeling
Activity labels are mathed to numeric Y-data and catenated to X_measures. Result is assigned to first of result tables
**tidy_data_1**
```
activity_names <- c(WALKING = 1, WALKING_UPSTAIRS = 2, 
                   WALKING_DOWNSTAIRS = 3, SITTING = 4,
                   STANDING =5, LAYING = 6)

Y_labels <- names(activity_names)[match(Y_numeric[,1], activity_names)]
tidy_data_1 <- cbind(Y_labels, X_measures)
```


### 4) Calculating and creating second result table "tidy_data_2"
Calculating mean for all variables and grouping them by subject and by activity. Result is assigned to second of the result tables
**tidy_data_2**
```
tidy_data_2 <- tidy_data_1 %>% group_by(subject, activity) %>% summarise_each(funs(mean))
```
