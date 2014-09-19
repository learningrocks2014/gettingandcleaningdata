<h1> Codebook for the mergedsubset.txt and tidydata.txt</h1>
=========================================
<p> This codebook describes the variables, the data, transformations and work that was required to clean up the source data provided for a project assignment related to the Getting and Cleaning Data course. The goal of the project is to prepare a tidy data that can be used for later analysis. </p>

<h2>Source data </h2>

The source data relates to the field of wearable computing. The source data is linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 

A full description is available at the site where the data was obtained: 

<p> <a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones</a></p>


Here are the data (UCI HAR Dataset) for the project: 
<p> <a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip">https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip</a></p>

<p> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.</p> 

<p> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. </p> 



<h2>Details of the source data </h2>
<p> The dataset includes the following files: </p>


<ul>
<li> 'README.txt' </li>

<li> 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample for the training data. Its range is from 1 to 30. </li>

<li> 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample for the test data. Its range is from 1 to 30. </li>

<li> 'features_info.txt': Shows information about the variables used on the feature vector. </li>

<li> 'features.txt': List of all features. </li>

<li> 'activity_labels.txt': Links the class labels with their activity name. </li>

<li> 'train/X_train.txt': Training set. </li>

<li> 'train/y_train.txt': Training labels. </li>

<li> 'test/X_test.txt': Test set. </li>

<li> 'test/y_test.txt': Test labels. </li>

</ul>


<h2>Creating the Tidy data - cleaning and transformation </h2>
<p> The Tidy dataset 'tidydata.txt' was created as a result of the extraction and transformation of the source data.</p> 
<p> The following steps were taken to create the 'tidydata.txt':</p> 


<p> STEP 1: Merge the training and the test sets to create one data set.</p> 
<ul>
<li> The raw datasets features.txt, X_test.txt, Y_test.txt, subject_test.txt, X_train.txt, Y_train.txt, subject_train.txt were read into R using read.table into their own data frames. </li>
<li> The feature labels from the features.txt were applied to the column names for the dataframes related to X_test.txt and X_train.txt. </li>
<li> The label "activity" was applied as the column name for the dataframe related to Y_test.txt and Y_train.txt. </li>
<li> The label "subjectid" was applied as the column name for the dataframe related to  the subject_test.txt and subject_train.txt. </li>
<li> The test datasets were combined into a dataframe called testdata i.e. dataframes related to X_test.txt, Y_test.txt and subject_test.txt. </li>
<li> The training datasets were combined into a dataframe called training data i.e. dataframes related to X_train.txt, Y_train.txt and subject_train.txt. </li>
<li> The testdata and trainingdata dataframes were merged into a dataframe called mergeddata. </li>
</ul>

<p> STEP 2: Extract only the measurements on the mean and standard deviation for each measurement. </p> 

<ul>
<li> A dataframe called mergedsubset was created from dataframe mergeddata which contained the subjectid, activity and all variables with mean or std in their column names. </li>
</ul>

<p> STEP3: Used descriptive activity names to name the activities in the data set.  </p>

<ul>
<li> The numbers in the activity column within the mergedsubset dataframe were replaced by descriptions of the activity i.e. WALKING = 1, WALKING_UPSTAIRS = 2, WALKING_DOWNSTAIRS = 3, SITTING = 4, STANDING = 5,  LAYING = 6</li>
</ul>

<p> STEP 4: Appropriately labels the data set with descriptive variable names. </p>
<p> The following changes were made to column names in the mergedsubset dataframe: </p> 
<ul>
<li> The string -mean was replaced by .mean </li>
<li> The string -std was replaced by .std </li>
<li> The brackets () were removed </li>
<li> Some column names had the string Body twice so BodyBody was replaced by Body </li>
</ul>

<p> The first dataset mergedsubset.txt was created after these data transformations.   </p>


<p> STEP 5: From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject and involved the following: </p>

<ul>
<li> The data was reshaped using the libary reshape2 and functions melt and dcast. </li>
<li> An average was calculated for each variable for each activity and subject. </li>
<li> The string '.subj.act.mean' was appended to the column names for all the variables except subjectid and activity for the tidy dataset since the variables were means of the original variables from the mergedsubset for each pair of subject and activity and hence different. </li>
<li> The data was exported to tidydata.txt using write.table. </li> 
<li> The tidydata consists of the subjectid, activity and 79 variables which were derived by taking an average (for each activity and subject) of each of the mean and standard deviation variables which were estimated from 3-axial time and frequency domain signals in the X, Y and Z directions in the UCI HAR Dataset for 30 volunteers within an age bracket of 19-48 years. 
</ul>

<p></p>
