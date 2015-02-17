run_analysis <- function(directory, resultfile, summarizedfile) {

#Load data sets
  file <- "/train/X_train.txt"
  filedir <- file.path(directory, file)
  X_train <- read.table(filedir, quote="\"", stringsAsFactors=FALSE)
  file <- "/test/X_test.txt"
  filedir <- file.path(directory, file)
  X_test <- read.table(filedir, quote="\"", stringsAsFactors=FALSE)
  file <- "/train/y_train.txt"
  filedir <- file.path(directory, file)
  y_train <- read.table(filedir, quote="\"", stringsAsFactors=FALSE)
  file <- "/test/y_test.txt"
  filedir <- file.path(directory, file)
  y_test <- read.table(filedir, quote="\"", stringsAsFactors=FALSE)
  file <- "/train/subject_train.txt"
  filedir <- file.path(directory, file)
  subject_train <- read.table(filedir, quote="\"", stringsAsFactors=FALSE)
  file <- "/test/subject_test.txt"
  filedir <- file.path(directory, file)
  subject_test <- read.table(filedir, quote="\"", stringsAsFactors=FALSE)
  file <- "/features.txt"
  filedir <- file.path(directory, file)
  features <- read.table(filedir, quote="\"", stringsAsFactors=FALSE)
  file <- "/activity_labels.txt"
  filedir <- file.path(directory, file)
  activity_labels <- read.table(filedir, quote="\"", stringsAsFactors=FALSE)
  
#Set columns names  
  colnames(X_test)<-features[,2]
  colnames(X_train)<-features[,2]
  
#A new column is added to intermediate data set with the activity description.  
  for (i in 1:nrow(y_test)) y_test[i,2]<-activity_labels[y_test[i,1],2]
  for (i in 1:nrow(y_train)) y_train[i,2]<-activity_labels[y_train[i,1],2]
  
#Building the intemediate data set for test data
#1st column: Activities
  vtest <- y_test[,2]
#2nd column: Subjects  
  vtest <- cbind(vtest,subject_test)
  colnames(vtest)<-c("DescActivity","Subject")
#Including 'mean' variables as next columns
  vtest <- cbind(vtest,X_test[,grep("MEAN",toupper(colnames(X_test)))])
#Including 'standard deviation' variables as last columns  
  vtest <- cbind(vtest,X_test[,grep("STD",toupper(colnames(X_test)))])

#Building the intemediate data set for training data
#1st column: Activities  
  vtrain <- y_train[,2]
#2nd column: Subjects   
  vtrain <- cbind(vtrain,subject_train)
  colnames(vtrain)<-c("DescActivity","Subject")
#Including 'mean' variables as next columns  
  vtrain <- cbind(vtrain,X_train[,grep("MEAN",toupper(colnames(X_train)))])
#Including 'standard deviation' variables as last columns   
  vtrain <- cbind(vtrain,X_train[,grep("STD",toupper(colnames(X_train)))])

#Merging intermediate data sets to obtain a total data set  
  vtotdata <- rbind(vtrain, vtest) 
#Writing de data result to the file in the parameter  
  file <- resultfile
  filedir <- file.path(directory, file)
  write.table(vtotdata,file=filedir, col.names=TRUE, sep=",")

  for (j in 1:30) 
  {
    for (i in 1:nrow(activity_labels)) 
    {
#Select the values to aggregate
      vSubTotalData<-vtotdata[vtotdata$Subject==j,]
      vSubTotalData<- vSubTotalData[vSubTotalData$DescActivity==activity_labels[i,2],]
      find.numeric <- sapply(vSubTotalData, is.numeric)
#Calculate the menas of the columns
      #vMeansColumns<-colMeans(vSubTotalData[, find.numeric])
      vMeansColumns<-colMeans(vSubTotalData[, 3:ncol(vSubTotalData)])
      vAux<-vSubTotalData[1,]
      #vAux[,3:length(vAux)]<-vMeansColumns[2:length(vMeansColumns)]
      vAux[,3:length(vAux)]<-vMeansColumns
#Generate the data frame with the information summarized
      if (j==1 && i==1)
      {
        vSummarizedData <- vAux
      }
      else
      {
        vSummarizedData<-rbind(vSummarizedData,vAux[1,])
      }
    } 
  }
#Writing summarized data result to the file in the third parameter  
    file <- summarizedfile
    filedir <- file.path(directory, file)
    write.table(vSummarizedData,file=filedir, col.names=TRUE,row.name=FALSE, sep=",")
}
