# Mod-3-Getting-and-Cleaning-Data---Course-Project
Repository for the Course Project for Module 3/Getting and Cleaning Data Course 



## Tasks

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



## Contents of the repository:

* a README.md file, you are reading this right now.
* tidyData.txt file which is the final product/result of transformations done in the given original data.
* CodeBook.md file that serves like a cookbook that details the information on the original data set and the transformation that the author did which resulted to the new dataset, tidyData.txt, and
* run_analysis.R, the R script that was used to create the new data set- tidyData.txt




## run_analysis.R

Upon close inspection of the script, one will see that it was actually composed of 5 parts. The following are the description of what they do: 

###Part 1
Set-up the packages first then downloaded the data and then finally unzipped the folder. 

###Part 2
The files specifically pertaining to activity labels and features were read and loaded into R, undergone subsetting, and then cleaned.

###Part3
The train datasets were read and loaded and then combined via cbinding

###Part4
The test datasets were read and loaded and then combined via cbinding.
The two datasets: test and train, was merged into one big table and 
The classLabels were converted to ActivityNames to make them self-describing.

###Part5
Finally, mergedDT (our data)  was reshaped and transformed according to the  specifications stated in the instructions. Here, tidyData.txt was created.
