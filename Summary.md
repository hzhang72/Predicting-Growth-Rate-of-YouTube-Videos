# Predicting-Growth-Rate-of-YouTube-Videos

Situation: 
YouTube is a large global video-sharing platform where users can interact with videos in various ways. Views are one of the most important metrics of a video, as they measure the amount of user engagement and help determine how much revenue the video will bring to the content creator. Knowing how fast a video’s number of views grows in the first few hours after it has been uploaded is a useful indicator for content creators. 

Task:
In this project, I aim to predict the percentage change in views on a video between the second and sixth hour since its publishing. This will help the content creator determine the eventual performance of their video and the overall success of their channel. 

Action:
1. Data Preprocessing 
There are 260 variables and 7242 observations in the data set, including 1 response variable “Growth”. 
1)	I believe that the date and time a video is published influences the number of early views. Therefore, I split the “Published Date” variable into the separate month, day, hour, and minute variables and deleted the “Published Date” variable. 
2)	I excluded quantitative variables that have an absolute correlation of 0.9 or above. Because multicollinearity can affect the variable importance.

2. Statistical Model 
1)	I elected to use tree-based methods. I compared bagged models against random forest models and consistently found that bagged models performed better. 
2)	To improve its performance, I used the rfcv() function in the R randomForest library to perform 5-fold cross-validation for feature selection. The results indicate that a model between 22 and 45 predictors would have the lowest error rate. 
3)	To find the top 25 most important predictors, I built a bagged regression model using all the predictors in our cleaned dataset. Then, we chose the top 25 most important variables based upon the mean decrease of accuracy in predictions.

Result:
The model was constructed using a bagged regression tree with the top 25 most important predictors. This model has an R squared of 0.86, which indicates that the model explains 86% variability of the response data around its mean. Using this model, I can predict how fast a video will grow within the first few hours of its lifetime, which is a broader indicator of the eventual success of the video as well as the overall health of the channel. 
