GettingAndCleaningProject
=========================

Coursera - Getting and Cleaning Data Course Project

***note that this script assumes the folder "UCI HAR Dataset" and all contents have been unzipped from below file location into the working directory.

file location:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

run_analysis.R script performs the following functions:
- takes training and test data from UCI Human Activity Recognition data set and combines them
- adds subject and activity identifiers
- adds column headings
- adds descriptive activity indicators
- subsets only the columns related to mean and standard deviation values
- calculates column means grouped by subject and activity
- returns a tidy data set with only the column mean values for selected columns
- exports the tidy data set as tidy_data.txt file in working directory
