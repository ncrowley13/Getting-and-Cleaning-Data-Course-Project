Getting and Cleaning Data: Course Project

This repository contains the course project for the Coursera course "Getting and Cleaning data".

Raw Data:
The features (561 of them) are unlabeled and can be found in the x_test.txt. The activity labels are in the y_test.txt file. The test subjects are in the subject_test.txt file.

Script and Tidy Datasets: 
I created a script called run_analysis.R which merges the test and training sets together. Prerequisites for this script:
    the UCI HAR Dataset mextracted
    the UCI HAR Dataset must be availble in a directory called "UCI HAR Dataset"

After merging testing and training, labels are added and only columns that have to do with mean and standard deviation are kept.

The script creates a tidy data set containing the means of all the columns per test subject and per activity. 

Codebook:
The CodeBook.md file explains the transformations performed and the resulting data and variables.
