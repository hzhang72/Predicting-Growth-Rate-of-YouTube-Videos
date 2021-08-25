## Load data

youtube1 <- read.csv("training.csv")
dim(youtube1)
test <- read.csv("test.csv")

set.seed(12)
youtube <- youtube1[sample(1:nrow(youtube1), 0.7*nrow(youtube1)),]
dim(youtube)

test <- youtube1[-(sample(1:nrow(youtube1), 0.7*nrow(youtube1))),]
dim(test)

## Preprocessing

library(tidyverse)
library(lubridate)
library(caret)
library(lubridate)
youtube$PublishedDate <- mdy_hm(youtube$PublishedDate)

# Range of data is from 2020-04-11 to 2020-09-01, don't need to save the year value
PublishedMonth <- month(youtube$PublishedDate)
PublishedDay <- day(youtube$PublishedDate)
PublishedHour <- hour(youtube$PublishedDate)
PublishedMinute <- minute(youtube$PublishedDate)
youtube <- youtube[, -2]
youtube <- cbind("id" = youtube[, 1], PublishedMonth, PublishedDay, 
                 PublishedHour, PublishedMinute, youtube[, 2:ncol(youtube)])

# Split timestamp for test data
test$PublishedDate <- mdy_hm(test$PublishedDate)
PublishedMonth <- month(test$PublishedDate)
PublishedDay <- day(test$PublishedDate)
PublishedHour <- hour(test$PublishedDate)
PublishedMinute <- minute(test$PublishedDate)
test <- test[, -2]
test <- cbind("id" = test[, 1], PublishedMonth, PublishedDay, 
              PublishedHour, PublishedMinute, test[, 2:ncol(test)])

# Remove columns with only 0's
zero_cols <- which(colSums(youtube) == 0)
youtube_no0 <- youtube[ , -zero_cols]

# Exclude binary columns, id and growth2_6 columns
numeric_youtube <- youtube_no0[, -c(1, 239:251)]

# Find variables that have an absolute correlation of 0.9 or above
high_cor <- findCorrelation(cor(numeric_youtube), cutoff = 0.9)
youtube_no0_cor <- youtube_no0[, -high_cor]

## Bagging on whole cleaned training dataset to get important variables

library(randomForest)
# Bagging on cleaned dataset to get the top 25 most important variables
bag_model <- randomForest(growth_2_6 ~ ., data = youtube_no0_cor[, -1], 
                          mtry = ncol(youtube_no0_cor[, -1]) - 1, importance = TRUE)
bag_importance <- importance(bag_model)
bag_importance[order(bag_importance[,1], decreasing = TRUE), ][1:25,]

## Bagging on top 25 most important variables
youtube_new <- cbind(youtube_no0_cor[, row.names(bag_importance[order(bag_importance[,1], 
                                                                      decreasing = TRUE), ][1:25,])],
                     "growth_2_6" = youtube$growth_2_6)

bag_model_new <- randomForest(growth_2_6 ~ ., data = youtube_new,
                              mtry = ncol(youtube_new) - 1, importance = TRUE)

bag_pred <- predict(bag_model_new, test)
ssr <- sum((test$growth_2_6 - bag_pred)^2)
sst <- sum((test$growth_2_6 - mean(test$growth_2_6))^2)
r2 <- 1 - ssr/sst
r2

bag_output <- data.frame("id" = test[,1], "growth_2_6" = bag_pred)
dim(bag_output)
head(bag_output)

# write.csv(bag_output, file = "201210_no0_cor_bag_imp25.csv", row.names = F)
