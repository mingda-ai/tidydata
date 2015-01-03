# this is the course project of Getting and Cleaning Data
# It contains two functions. 
# run_tidy is the entry point. You should call it.
# do_tidy is called by run_tidy. It load train/test data each time and put the the loaded data into a dataset.

library(dplyr)
library(tidyr)

# Usage:
#   run_tidy()
# Details:
#   the work folder should be at the folder of "UCI HAR Dataset".
run_tidy<-function() {
    #load train data and put it into trainData.
    trainData<-do_tidy(TRUE)
    #load test data and put it into testData.
    testData<-do_tidy(FALSE)
    #merge the train data and test data into a single dataset: AllData.
    AllData<-rbind(trainData,testData)
    # Generate the second tidy dataset.
    # We describe the orginal observations by 3 variables: sensor, statFUN, axis. 
    # for example, tBodyAcc-std()-X means the sensor is tBodyAcc, statFUN is std(), axis is X.
    # the value of the observation is stored in "value".
    AllData %>%
    gather(sensor_statFUN_axis, value, -subject, -activity) %>%
    separate(sensor_statFUN_axis, into=c("sensor","statFUN", "axis"), sep="-", extra="merge") %>%
    group_by(subject, activity, sensor, statFUN, axis) %>%
    summarise(average=mean(value)) 
}

do_tidy<-function(IsTrain) {
    if(IsTrain)
    {
        #loading train data
        featureTable<-read.table("train/X_train.txt", header=FALSE, sep="")
        activityNumber<-read.table("train/y_train.txt", header=FALSE)
        subject<-read.table("train/subject_train.txt", header=FALSE)
    }
    else
    {
        #loading test data
        featureTable<-read.table("test/X_test.txt", header=FALSE, sep="")
        activityNumber<-read.table("test/y_test.txt", header=FALSE)
        subject<-read.table("test/subject_test.txt", header=FALSE)
    }
    # load the feature names as the column names of the data set.
    feature_names<-read.table("features.txt")
    names(featureTable)<-feature_names[,2]
    
    # only keep the features with mean or std in their names.
    featureTable2<-featureTable[,grep("mean|std",feature_names[,2])]
    
    #add the subject to the data set.
    featureTable2$subject<-subject$V1
    
    #add activity to the data set.
    activityLabel<-read.table("activity_labels.txt", header=FALSE)
    activity<-left_join(activityNumber, activityLabel,by="V1")
    featureTable2$activity<-activity$V2
    featureTable2
}