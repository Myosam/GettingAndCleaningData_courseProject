---
title: "CodeBbook.md"
output: html_document
---

### DataCleaning project work
CodeBook for Coursera's project work in "Getting and Cleaning Data". Codebook is for **run_analysis.R** script in the same Git-repository.

Reads Train and Test data-sets for the project work. Labels them by subject and by activity label.

Creates two tables:
First table with all the data above combined
Second table with all the data above with calculated averages by each activity and subject

### Provided data for the project:
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

### I/O
- Input: Reads data from unzipped folder
- Outputs: Two tables **"tidy_data_1"** and **"tidy_data_2"**

### Script Variables
- **feat_table:**   Names/features of all measured variables
- **X_measures:**   X-Train, X-Test and Subject sets combined, with variable names which contain "mean" or "std" 
- **Y_labels:**     Y-Train and Y-Test sets combined with matched activity name
- **tidy_data_1:**  All above combined. Measures with subcjects and activity-names
- **tidy_data_2:**  Mean-calcultaions of all tidy_data_1 varibles, grouped by subject and activity

