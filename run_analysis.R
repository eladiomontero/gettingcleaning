run_analysis <- function(){ 
     require(plyr)
     #File loading.
     test_raw <- read.table("X_test.txt")
     train_raw <- read.table("X_train.txt")
     test_y <- read.table("y_test.txt")
     train_y <- read.table("y_train.txt")
     subject_test<- read.table("subject_test.txt")
     subject_train<- read.table("subject_train.txt")
     fields <- read.table("features.txt")
     activity_labels <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS",
                          "SITTING", "STANDING", "LAYING")
     
     #Change the activity number for its corresponding label.
     train_acts <- c()
     for (i in 1:length(train_y[,1])){
             train_acts <- c(train_acts, activity_labels[train_y[i,]])
     }
     test_acts <- c()
     for (i in 1:length(test_y[,1])){
             test_acts <- c(test_acts, activity_labels[test_y[i,]])
     }
     # Give each dataset its corresponding field names.
     colnames(test_raw) <- fields[[2]]
     colnames(train_raw) <- fields[[2]]
     
     #Bind the y data with the x data.
     
     test_raw <- cbind(test_raw, activity = test_acts, subject = subject_test[,1])
     train_raw <- cbind(train_raw, activity = train_acts, subject = subject_train[,1])
     
     #find all the fields with mean() and std()
     
     fields_merge <- sort(c(grep("mean\\(.*\\)", fields[[2]], value=T), 
                            grep("std\\(.*\\)", fields[[2]], value=T)))
     fields_merge <- c(fields_merge,"activity", "subject")
     
     #merge the train and the test datasets, with the fields found.
     merged_dataset = rbind(test_raw, train_raw)[,fields_merge]
     
     #give human readable variable names
     
     colnames(merged_dataset) <- tolower(colnames(merged_dataset))
     regex_from <- c("^t", "bodybody", "bodyacc", "mag", "^f","-",
                     "std\\(.*\\)", "mean\\(.*\\)", "gravityacc")
     regex_to <- c("time", "body", "bodyacceleration", "magnitude", "frequency", "",
                   "std", "mean", "gravityacceleration")
     for (i in 1:length(regex_from)){
        colnames(merged_dataset) <- gsub(regex_from[i],regex_to[i],
                                         colnames(merged_dataset))      
     }
     
     #Write both files into a text file.
     
     write.table(merged_dataset, "tidy.txt")
     write.table(ddply(merged_dataset, .(activity), numcolwise(mean)), "second.txt")
}