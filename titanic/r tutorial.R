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

#---------------------------------------------------------------------------

#see how many women & men there are
summary(train$Sex)

#proportion table of gender vs. survival (divides each by total population)
prop.table(table(train$Sex, train$Survived))

#proportion table row-wise, the proportion of each sex that survived
prop.table(table(train$Sex, train$Survived),1)

#change test's survived category to be 1 if female, 0 if male
test$Survived <- 0
test$Survived [test$Sex == 'female'] <- 1

submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "./out/allmenperish.csv", row.names = FALSE)

#---------------------------------------------------------------------------

#let's look at the age of passengers
summary(train$Age)

#create a new variable, age, to indicate whether the passenger is below age 18
train$Child <- 0
train$Child[train$Age < 18] <- 1

#target Survived, see how sex and child variables affect it, how many Survived
aggregate(Survived ~ Child + Sex, data=train, FUN=sum)

#same, but see how many total in each category double
aggregate(Survived ~ Child + Sex, data=train, FUN=length)

#same, but create custom function to get proportion for each double category
aggregate(Survived ~ Child + Sex, data=train, FUN=function(x) {sum(x)/length(x)})
