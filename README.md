# Getting And Cleaning Data Course Project

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set

the data origin is from Human Activity Recognition Using Smartphone Dataset; the experiment have been carried out with a group of 30 volunteers within age of 19 - 48. each person perform an activity wearing a smartphone (Samsung Galaxy S II) on the waist.

the data can be download from here https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## the repository include the following files:
- ReadMe.md : this current document
- run_analysis.R : an R script to clean and perform some analysis; it use the data located at "UCI HAR Dataset" subdirectory in the work directory
- aggregate_tidy.txt : the output file result of executing the main function in the script.
- codebook.md : code book with the description of the variables and the process done

## running the script
The run_analysis.R script have comments of each of the five sections the project is divide. In order to run the script do the following:

1. set your working directory.
2. install plyr package
3. download and uncompress the data in your work directory.
4. download the file run_analysis.R from https://github.com/rodolfogarzon/GettingAndCleaningData repository.
5. source the file in your R environment using the "source" command.
6. run the MergeData function contain in the script;the function has two parameters
      a. directory : this parameter indicate the name of the directory where the experiment data is located.
      b. savefiles : this parameter will save the result data for each section of the project.
6. the output of the script is a independent tidy data set (aggregate_tidy.txt) with the average of each variable for each activity and each subject.

## how the script works

1. get the working directory and assing the path variables for test, train and subject files
2. get all the variables names in the x files from the "features.txt" located in the subdirectory
3. get the activities names for the y files from the "activity_labels.txt" file located in the subdirectory
4. part 1. merge the training and test data for X, Y and subjects
5. part 2. extract only the measures that contain mean and std; 
      - create a vector with all the variables names with the word "mean()"
      - create a vector with all the variables names with the word "std()"
      - convine and re-order the vector
      - select only variable that contain the index on my vector for the merge data
6. part 3. Assign the text of each activity for the equivalent value in the y data set
7. part 4. clean the labels on the x data set to be decvriptives and eliminate un-necesary characters or words.
8. part 5. calculate the averange of all variables the data set of part 4, base on subject and activity.
      - merge all the datasets (x, y and s)
      - load the plyr package
      - using ddply calculate the maen for each variable base on "subject" and "activity"
9. generate the output file using table.write nad ron.naes = FALSE



