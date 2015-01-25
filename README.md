# Getting And Cleaning Data Course Project

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set

the data origin is from Human Activity Recognition Using Smartphone Dataset; the experiment have been carried out with a group of 30 volunteers within age of 19 - 48. each person perform an activity wearing a smartphone (Samsung Galaxy S II) on the waist.

the data can be download from here https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## the repository include the following files:
- ReadMe.md : this current document
- run_analysis.R : an R script to clean and perform some analysis; it use the data located at "UCI HAR Dataset" subdirectory in the work directory
- aggregate_tidy.txt : the output obtain after run the script in run_analysis.R script
- codebook.md : code book with the description of the variables and the process done

The run_analysis.R script have comments of each of the five sections the project is divide. In order to run the script do the following:

1. set your working directory.
2. download and uncompress the data in your work directory.
3. download the file run_analysis.R from https://github.com/rodolfogarzon/GettingAndCleaningData repository.
4. source the file in your R environment using the "source" command.
5. run the MergeData function contain in the script;the function has two parameters
      a. directory : this parameter indicate the name of the directory where the experiment data is located.
      b. savefiles : this parameter will save the result data for each section of the project.
6. the output of the script is a independent tidy data set (aggregate_tidy.txt) with the average of each variable for each activity and each subject.


