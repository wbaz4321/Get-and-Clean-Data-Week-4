# Get-and-Clean-Data-Week-4
# Breif of the scripts
Initially, the scripts load in a useful package, i.e. dplyr, also reshape2 is loaded in case it will be needed

First step is load in all the train and test data sets, using "read.table()" function. At the same time, variables names and activity labels are also loaded in using the same function

Second, the names are extracted from the "feature" file and "" is applied to choose only features that contain mean or std values. Here "grep()" function comnbined with regular expression is used during searching.

Third, use "cbind()" function to combine suject, activity and the 66 variables in test and train dataset, named as "test_df" and "train_df" respectively. Then, call "cbind()" again to combine these 2 newly developed data frames to form the integrated dataset required by this practice, named as "df".

Create a function called "setActivity()" to label the 6 activities based on the number 1-6, taking use of "which()" function.

Use "group_by()" to group "df" by subject and activity, which results in 180 different groups (6x30).

Use "summarise_if()" or "summarise_at()" function to build a new tidy dataset based on selected columns to show the average value of each variable of each subject and each type of activity. Note in the scripts, "summarise_if()" is used. Therefore a logical vector should be generated first, which is sent to the function as a parameter.
