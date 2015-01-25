
# this function will get resolve the Course Projec
# the parameter is the directory where the download data is located
# in the work directory

MergeData <- function (directory, savefiles = FALSE) {
  
  # get the path for all the test and train files
  dir <- paste(getwd(), directory[1], sep="/")
  xtestfile  <- paste(dir,"test/X_test.txt", sep = "/") 
  ytestfile  <- paste(dir,"test/y_test.txt", sep = "/") 
  xtrainfile <- paste(dir,"train/X_train.txt", sep = "/") 
  ytrainfile <- paste(dir,"train/y_train.txt", sep = "/")
  stestfile  <- paste(dir, "test/subject_test.txt", sep = "/")
  strainfile <- paste(dir, "train/subject_train.txt", sep = "/")
  
  
  # variables names
  mfile <- paste(dir, "features.txt", sep = "/")
  mnames <- read.table(mfile)
  mnames <- as.character(mnames[,2])
  
  # activity names
  afile <- paste(dir, "activity_labels.txt", sep = "/")
  activity_labels <- read.table(afile)
  colnames(activity_labels) <- c("id", "Activity")
  
  # --------------------------------------------------------------------
  # 1. Merges the training and the test sets to create one data set.
  
  xtestdata <- read.table(xtestfile)
  xtraindata <- read.table(xtrainfile)
  # Appropriately labels the xdata set with descriptive variable names.
  xdata <- rbind(xtraindata, xtestdata)
  #xdata <- merge(xtestdata, xtraindata, all=TRUE)
  colnames(xdata) <- c(mnames)
  
  ytestdata <- read.table(ytestfile)
  ytraindata <- read.table(ytrainfile)  
  # Appropriately labels the ydata set with descriptive variable names.
  # ydata <- merge(ytestdata, ytraindata, all=TRUE)
  ydata <- rbind(ytraindata, ytestdata)
  colnames(ydata) <- c("activity")
  
  stestdata <- read.table(stestfile)
  straindata <- read.table(strainfile)
  # Appropriately labels the subject data set with descriptive variable names.
  # sdata <- merge(stestdata, straindata, all=TRUE)
  sdata <- rbind(straindata, stestdata)
  colnames(sdata) <- c("subject")
  
  # to explore the file, it will write the merge ds
  if (savefiles == TRUE) {
    xfile <- paste(getwd(), "xdata.txt", sep = "/")
    write.table(xdata, file = xfile, col.names = TRUE)  
    yfile <- paste(getwd(), "ydata.txt", sep = "/")
    write.table(ydata, file = yfile, col.names = TRUE)
    sfile <- paste(getwd(), "sdata.txt", sep = "/")
    write.table(sdata, file = sfile, col.names = TRUE)    
  }
  
  
  
  #----------------------------------------------------------------------
  # 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  
  # mnames (measurement names) are the names of the fields from features.txt
  mean_measurements <- grep("mean()", mnames)
  std_measurements <- grep("std()", mnames)
  # to keep the original order of the measurements
  meanAndstd_measurements <- sort(c(mean_measurements, std_measurements))
  xdata_meanAndstd <- xdata[,c(meanAndstd_measurements)]
  
  if (savefiles == TRUE) {
    xdata_meanAndstdfile <- paste(getwd(), "xdata_meanAndstd.txt", sep = "/")
    write.table(xdata_meanAndstd, file = xdata_meanAndstdfile, col.names = TRUE)    
  }
    
  #----------------------------------------------------------------------
  # 3. use descriptive activity names to name activities in the data set
  
  ydatabyname <- ydata
  ydatabyname[ydatabyname == "1"] <- "WALKING"
  ydatabyname[ydatabyname == "2"] <- "WALKING_UPSTAIRS"
  ydatabyname[ydatabyname == "3"] <- "WALKING_DOWNSTAIRS"
  ydatabyname[ydatabyname == "4"] <- "SITTING"
  ydatabyname[ydatabyname == "5"] <- "STANDING"
  ydatabyname[ydatabyname == "6"] <- "LAYING"
  
  if (savefiles == TRUE) {
    ydatabynamefile <- paste(getwd(), "ydatabyname.txt", sep = "/")
    write.table(ydatabyname, file = ydatabynamefile, col.names = TRUE)    
  }


  #----------------------------------------------------------------------
  # 4. Appropriately labels the data set with descriptive variable names. 
  
  mnames <- gsub("-mean()","_mean", mnames)
  mnames <- gsub("-std()","_std", mnames)
  mnames <- gsub("-mad()","_mad", mnames)
  mnames <- gsub("-max()","_max", mnames)
  mnames <- gsub("-min()","_min", mnames)
  mnames <- gsub("-sma()","_sma", mnames)
  mnames <- gsub("-energy()","_energy", mnames)
  mnames <- gsub("-iqr()","_iqr", mnames)
  mnames <- gsub("-entropy()","_entropy", mnames)
  mnames <- gsub("()-", "", mnames)
  mnames <- gsub("-", "_", mnames)
  mnames <- gsub(",", "_", mnames)
  mnames <- gsub("()", "", mnames)
  mnames <- gsub("\\(", "_", mnames)
  mnames <- gsub("\\)", "", mnames)
  mnames <- gsub("BodyBody", "Body", mnames)
  
  if (savefiles == TRUE) {
    mnamesfile <- paste(getwd(), "mnames.txt", sep = "/")
    write.table(mnames, file = mnamesfile, col.names = FALSE)    
  }
  
  xdatawithmnames <- xdata
  colnames(xdatawithmnames) <- c(mnames)
  
  if (savefiles == TRUE) {
    xdatawithmnamesfile <- paste(getwd(), "xdatawithmnames.txt", sep = "/")
    write.table(xdatawithmnames, file = xdatawithmnamesfile, col.names = TRUE)    
  }
  
  
  #5. From the data set in step 4, creates a second, independent tidy data set with the average of each
  # variable for each activity and each subject.
  
  all_tidy <- cbind(sdata, ydatabyname, xdatawithmnames)
  
  if (savefiles == TRUE) {
    write.table(sdata, file = sfile, col.names = TRUE)    
    write.table(ydatabyname, file = ydatabynamefile, col.names = TRUE)    
    write.table(xdatawithmnames, file = xdatawithmnamesfile, col.names = TRUE)    
    all_tidyfile <- paste(getwd(), "all_tidy.txt", sep = "/")
    write.table(all_tidy, file = all_tidyfile, col.names = TRUE)    
  }
  
  require(plyr)
  aggregate_tidy <- ddply(all_tidy, c("subject", "activity"), colwise(mean))
  
  
  
  aggregate_tidyfile <- paste(getwd(), "aggregate_tidy.txt", sep = "/")
  write.table(aggregate_tidy, file = aggregate_tidyfile, col.names = TRUE, row.name = FALSE)
  
  


  
  
}
