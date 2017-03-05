## COURSERA: DATACLEANING, COURSE PROJECT, 2017-MAR-03
#
# Reads Train and test sets. Labels them with by subject and activity label.
#
# Creates two tables:
# First table with all the data above combined
# Second table with all the data above with calculated averages by each activity and subject
#
# Data sources:
# - 'activity_labels.txt': Links the class labels with their activity name.
# - 'train/X_train.txt': Training set
# - 'train/y_train.txt': Training labels.
# - 'test/X_test.txt': Test set.
# - 'test/y_test.txt': Test labels.
#
filepath_workdir <- getwd()


### 1) DATA READING ###

# Read data measure-files and subject-files and catenates them
Xtrain_filepath <- file.path(filepath_workdir, "/train/X_train.txt")
Xtrain_measure <- read.table(Xtrain_filepath)
Xtrain_subject_filepath <- file.path(filepath_workdir, "/train/subject_train.txt")
Xtrain_subject <- read.table(Xtrain_subject_filepath)

Xtest_filepath <- file.path(filepath_workdir, "/test/X_test.txt")
Xtest_measure <- read.table(Xtest_filepath)
Xtest_subject_filepath <- file.path(filepath_workdir, "/test/subject_test.txt")
Xtest_subject <- read.table(Xtest_subject_filepath)

# Read data label-files
Ytrain_filepath <- file.path(filepath_workdir, "/train/y_train.txt")
Ytrain_numeric <- read.table(Ytrain_filepath)

Ytest_filepath <- file.path(filepath_workdir, "/test/y_test.txt")
Ytest_numeric <- read.table(Ytest_filepath)

# Combine test and train data
X_measures <- rbind(Xtrain_measure, Xtest_measure)


### 2) DATA FILTERING  ###

# Read features and take only mean- and std-values from X_measures
feat_filepath <- file.path(filepath_workdir, "/features.txt")
feat_table <- read.table(feat_filepath)
ind_mean <- grep("*mean*", feat_table$V2)
ind_std <- grep("*std*", feat_table$V2)

X_mean <- X_measures[ , ind_mean]
X_std <- X_measures[ , ind_std]

# Set names for X_mean and X_std according to feature table
X_mean_names <- setNames(X_mean, feat_table$V2[ind_mean])
X_std_names <- setNames(X_std, feat_table$V2[ind_std])
X_measures <- cbind(X_mean_names, X_std_names)
# Add subjects
X_subject <- rbind(Xtrain_subject, Xtest_subject)
X_subject <- setNames(X_subject, "subject")
# Combine measures and subjects
X_measures <- cbind(X_subject, X_measures)


### 3) DATA LABELING ###

# Catenate train and test numeric labels
Y_numeric <- rbind(Ytrain_numeric, Ytest_numeric)

# Map numeric values to labels
activity_names <- c(WALKING = 1, WALKING_UPSTAIRS = 2, 
                   WALKING_DOWNSTAIRS = 3, SITTING = 4,
                   STANDING =5, LAYING = 6)

Y_labels <- names(activity_names)[match(Y_numeric[,1], activity_names)]

# Add activity and create first result table "tidy_data_1"
tidy_data_1 <- cbind(Y_labels, X_measures)
colnames(tidy_data_1)[1] <- "activity"


### 4) CALCULATING AND CREATING SECOND RESULT TABLE "tidy_data_2"

# Load dplyr-libraray
library(dplyr)


# Create second result table "tidy_data_2"
# Calculate averages of each mean- and std-variable by using dplyr
# Group table by subject and activity, run mean-calculation for all columns.
# Using pipeline-operator to reduce number of new variables
tidy_data_2 <- tidy_data_1 %>% group_by(subject, activity) %>% summarise_each(funs(mean))


### X) IF USER WANTS TO WRITE OUTPUT, UNCOMMENT THE BELOW AND DEFINE PATH-VARIABLE "writepath_workdir"
# 
# writepath_workdir <- ""
# 
# write_filepath <- file.path(filepath_workdir, "dataCleaning_courseProject.txt")
# write.table(tidy_data_2, write_filepath, row.name = FALSE)
