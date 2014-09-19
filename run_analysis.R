#1. Merges the training and the test sets to create one data set.
library(reshape2)

#Read the files
#Labels
features = read.table('./UCI HAR Dataset/features.txt', header = FALSE)

#Test datasets
xtest = read.table('./UCI HAR Dataset/test/X_test.txt', header = FALSE)
ytest = read.table('./UCI HAR Dataset/test/Y_test.txt', header = FALSE)
subjecttest = read.table('./UCI HAR Dataset/test/subject_test.txt', header = FALSE)

#Training datasets
xtrain = read.table('./UCI HAR Dataset/train/X_train.txt', header = FALSE)
ytrain = read.table('./UCI HAR Dataset/train/Y_train.txt', header = FALSE)
subjecttrain = read.table('./UCI HAR Dataset/train/subject_train.txt', header = FALSE)

#Get the label names from features and apply then to xtest and apply to xtest and xtrain
flabels <- features$V2
names(xtest) <- flabels
names(xtrain) <- flabels

#Apply label names to ytest and ytrain
names(ytest) <- "activity"
names(ytrain) <- "activity"

#Link the subject who performed the activity, the activity they performed and measurements on the test datasets
names(subjecttest) <- "subjectid"
testdata <- cbind(subjecttest, ytest, xtest)

#Link the subject who performed the activity, the activity they performed and measurements on the training datasets
names(subjecttrain) <- "subjectid"
trainingdata <- cbind(subjecttrain, ytrain, xtrain)

#Merge the test and training datasets
mergeddata <- rbind(trainingdata, testdata)



#2. Extracts only the measurements on the mean and standard deviation for each measurement.

#get the subject_id and activity
subcols <- names(mergeddata)[1:2]


# Function that gets a list of column names using regular expression that
# matches column name
get_cols <- function(x,y) names(y[grep(x, names(y))])

#Get the column names with the string mean and std 
meancols <- get_cols("mean", mergeddata)
sdcols <- get_cols("std", mergeddata)

#Combine all columns required and create a subset 
mergedsubset <- mergeddata[, c(subcols,meancols,sdcols)]


#3. Uses descriptive activity names to name the activities in the data set

activitycodes <- c(WALKING = 1, WALKING_UPSTAIRS = 2, WALKING_DOWNSTAIRS = 3, SITTING = 4, STANDING = 5,
                   LAYING = 6)

mergedsubset$activity <- names(activitycodes)[match(mergedsubset $activity, activitycodes)]


#4. Appropriately labels the data set with descriptive variable names.
names(mergedsubset) <- gsub("-mean", ".mean", names(mergedsubset))
names(mergedsubset) <- gsub("-std", ".std", names(mergedsubset))
names(mergedsubset) <- gsub("\\(\\)","",names(mergedsubset))
names(mergedsubset) <- gsub("BodyBody","Body",names(mergedsubset))

#create the first dataset
write.table(mergedsubset, "mergedsubset.txt", sep="\t", row.names=FALSE, col.names=TRUE) 

#5. From the data set in step 4, creates a second, 
#independent tidy data set with the average of each variable for each activity and each subject.

# for the melted data set the id variables have to separated from the measured variables

# the first 2 variables in mergedsubset i.e. subjectid and activity are id variables
# this statement gets the measured variables i.e. all the variables in mergedsubset except the first 2
measurevars <- setdiff(names(mergedsubset), names(mergedsubset)[1:2])

# reshape the data
# first melt the data - i.e. each row becomes a unique id-measured variable combination
meltedsubset <- melt(mergedsubset, id=c("subjectid", "activity"),measure.vars = measurevars )

#create an independent dataset from the melted dataset
# second - cast the data into a dataframe that gives the average of each variable for each activity and each subject
tidydata <- dcast(meltedsubset, subjectid + activity ~ variable,mean)

# add a subj.act.mean suffix to the column labels of the tidy dataset
# so that it is clear that it is a mean of the mergedsubset variables by subject and activity
names(tidydata)[-(1:2)]  <- paste(names(tidydata)[-(1:2)] , ".subj.act.mean")

#export the tidy dataset to a txt file
write.table(tidydata, "tidydata.txt", sep="\t", row.names=FALSE, col.names=TRUE) 




