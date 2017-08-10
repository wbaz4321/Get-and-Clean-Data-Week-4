
run_analysis <- function()
{
## load useful packages in
library(dplyr)
library(reshape2)

## load all train dataset
train_x <- read.table("./train/X_train.txt")
train_y <- read.table("./train/y_train.txt")
train_sub <- read.table("./train/subject_train.txt")
colnames(train_sub)<-"subject"
colnames(train_y)<-"activity"

## load all test dataset
test_x <- read.table("./test/X_test.txt")
test_sub <- read.table("./test/subject_test.txt")
test_y <- read.table("./test/y_test.txt")
colnames(test_sub)<-"subject"
colnames(test_y)<-"activity"

## get the names
feature <- read.table("./features.txt") 
ini_names<-as.character(feature[,2])
t1<-grep("mean[^a-zA-Z]",ini_names)
t2<-grep("std[^a-zA-Z]",ini_names)

train_x_mean<-select(train_x,t1)
names(train_x_mean)<-ini_names[t1]
train_x_std <- select(train_x,t2)
names(train_x_std)<-ini_names[t2]
train_df <- cbind(train_sub,train_x_mean,train_x_std,train_y)
train_df$subject <- as.character(train_df$subject)

test_x_mean<-select(test_x,t1)
names(test_x_mean)<-ini_names[t1]
test_x_std <- select(test_x,t2)
names(test_x_std)<-ini_names[t2]
test_df<-cbind(test_sub,test_x_mean,test_x_std, test_y)
test_df$subject <- as.character(test_df$subject)

## combine the two data set together (10299x66)
df <- rbind(train_df,test_df)

##label activities
input<-df$activity
setActivity <- function(input)
{
	index_1 <- which(input==1)
	index_2 <- which(input==2)
	index_3 <- which(input==3)
	index_4 <- which(input==4)
	index_5 <- which(input==5)
	index_6 <- which(input==6)
	input[index_1] <- "WALKING"
	input[index_2] <- "WALKING_UPSTAIRS"
	input[index_3] <- "WALKING_DOWNSTAIRS"
	input[index_4] <- "SITTING"
	input[index_5] <- "STANDING"
	input[index_6] <- "LAYING"

	return(input)
}
df$activity <- setActivity(input)
rm(input)

## extract mean and std value for each variable
df_group<-group_by(df,subject,activity)

## take use of the "summarise_if()" function, very handy when we need to summarise columns given some conditions
## create a logical vetor
create_tidy <- function(df)
{
	temp_names <- names(df)
	temp_names <- temp_names[c(-1,-68)]
	com_names <- temp_names
	com_names[length(com_names)]<-"lastcol"
	logic<-com_names==temp_names	
}

tidy_df<- summarise_if(df_group,create_tidy(df_group),mean)

## alternatively, we can use "summarise_at()" to do this in a more convenient way

## demonstrate and write the result into a txt file called "result.txt" in the current working directory
View(tidy_df)
write.table(tidy_df, "./result.txt",row.name = FALSE)
}