setwd("~/git/kaggle/titanic")
train <- read.csv("~/git/kaggle/titanic/data/train.csv")
test <- read.csv("~/git/kaggle/titanic/data/test.csv")

###train <- read.csv("train.csv", stringsAsFactors=FALSE)

#table listing how many fall into each value of Survived
table(train$Survived)

#table listing proporitions of above
prop.table(table(train$Survived))

#add survived property to test as well, with value 0
test$Survived <- rep(0, 418)

#make a CSV file predicting that everybody dies
submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "./out/theyallperish.csv", row.names = FALSE)