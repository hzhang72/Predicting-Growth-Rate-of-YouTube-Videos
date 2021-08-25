# Predicting-Growth-Rate-of-YouTube-Videos

Situation: 
YouTube is a large global video-sharing platform where users can interact with videos in various ways. Views are one of the most important metrics of a video, as they measure the amount of user engagement and help determine how much revenue the video will bring to the content creator. Knowing how fast a video’s number of views grows in the first few hours after it has been uploaded is a useful indicator for content creators. 

Task:
In this project, I aim to predict the percentage change in views on a video between the second and sixth hour since its publishing. This will help the content creator determine the eventual performance of their video and the overall success of their channel. 

Result:
The model was constructed using a bagged regression tree with the top 25 most important predictors. This model has an R squared of 0.86, which indicates that the model explains 86% variability of the response data around its mean. Using this model, I can predict how fast a video will grow within the first few hours of its lifetime, which is a broader indicator of the eventual success of the video as well as the overall health of the channel. 
