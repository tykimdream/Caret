setRepositories(ind = 1:8)

library(tidyverse)
library(datarium)
library(caret)###important package
library(dplyr)
library(rpart)
library(rpart.plot)
library(kknn)
library(ROCR)
library(kernlab)
library(MASS)
library(ggplot2)
library(randomForest)
library(VGAM)
library(adabag)

setwd("C:\\Users\\tykim\\OneDrive\\바탕 화면\\2021-1학기\\데이터마이닝R\\Code")
getwd()

data(cars)
str(cars)

#### 차 모델 예측하기

data <- cars

data$Buick <- data$Buick*1
data$Cadillac <-  data$Cadillac*2
data$Chevy <-data$Chevy * 3
data$Pontiac <- data$Pontiac*4
data$Saab <-data$Saab*5
data$Saturn <- data$Saturn*6

data <- data %>% mutate(
  Type = data$Buick+data$Cadillac+data$Chevy+data$Pontiac+data$Saab+data$Saturn
)

data <- data %>% 
  dplyr::select(-c("Buick", "Cadillac", "Chevy", "Pontiac", "Saab", "Saturn")) %>% 
  na.omit()

str(data)
data$Type <- as.factor(data$Type)

data <- data %>% mutate(
  Type = factor(Type, levels = c(1,2,3,4,5,6),
                labels = c("Buick", "Cadillac", "Chevy", "Pontiac", "Saab", "Saturn")))

model_brand <- glm(Type ~., data, family = "binomial")
summary(model_brand)
step(model_brand, direction = "both")


control <- trainControl(method = "CV", number = 10)

LDA <- train(Type ~ Price + Cylinder + Cruise + Leather + sedan,
             data,  method = "lda", trControl = control)

# QDA <- train(Type ~ Price + Cylinder + Cruise + Leather + sedan,
#              data,  method = "qda", trControl = control)

CART <- train(Type ~ Price + Cylinder + Cruise + Leather + sedan,
              data, method = "rpart", trControl = control)

SVM <- train(Type ~ Price + Cylinder + Cruise + Leather + sedan,
             data, method = "svmRadial", trControl = control)

RF <- train(Type ~ Price + Cylinder + Cruise + Leather + sedan,
            data, method = "rf", trControl = control)

KNN <- train(Type ~ Price + Cylinder + Cruise + Leather + sedan,
             data, method = "knn", trControl = control)

ACW<- train(Type ~ Price + Cylinder + Cruise + Leather + sedan,
            data, method = "vglmAdjCat", trControl = control)

GLM <- train(Type ~ Price + Cylinder + Cruise + Leather + sedan,
             data, method = "glm", trControl = control)

predicted_brand_LDA <- predict(LDA, data)
# predicted_brand_QDA <- predict(QDA, data)
predicted_brand_CART <- predict(CART, data)
predicted_brand_SVM <- predict(SVM, data)
predicted_brand_RF <- predict(RF, data)
predicted_brand_KNN <- predict(KNN, data)
# predicted_brand_ACW <- predict(ACW, data)
# predicted_brand_GLM <- predict(GLM, data)

confusion_brand_LDA <- table(predicted = predicted_brand_LDA, Observed = data$Type)
confusion_brand_CART <- table(predicted = predicted_brand_CART, Observed = data$Type)
confusion_brand_SVM <- table(predicted = predicted_brand_SVM, Observed = data$Type)
confusion_brand_RF <- table(predicted = predicted_brand_RF, Observed = data$Type)
confusion_brand_KNN <- table(predicted = predicted_brand_KNN, Observed = data$Type)

Mat_LDA <- confusionMatrix(predicted_brand_LDA, data$Type)
Mat_CART <- confusionMatrix(predicted_brand_CART, data$Type)
Mat_SVM <- confusionMatrix(predicted_brand_SVM, data$Type)
Mat_RF <- confusionMatrix(predicted_brand_RF, data$Type)
Mat_KNN <- confusionMatrix(predicted_brand_KNN, data$Type)

RESULT <- list(LDA = Mat_LDA$overall, CART = Mat_CART$overall, SVM = Mat_SVM$overall,
               RF = Mat_RF$overall, KNN = Mat_KNN$overall)
RESULT




#### 도전과제 차 가격 예측하기 ####

data1 <- cars

model <- glm(Price ~ .,data1, family = "gaussian")
summary(model)
step(model, direction = "both")


control <- trainControl(method = "CV", number = 10)

# LDA_P <- train( Price ~ Mileage + Cylinder + Doors + Cruise + Leather + 
#                 Buick + Cadillac + Chevy + Pontiac + Saab + convertible + 
#                 hatchback + sedan, data1, trControl = control, method = "lda")
# QDA_P <- train( Price ~ Mileage + Cylinder + Doors + Cruise + Leather + 
#                 Buick + Cadillac + Chevy + Pontiac + Saab + convertible + 
#                 hatchback + sedan, data1, trControl = control, method = "qda")
CART_P <- train( Price ~ Mileage + Cylinder + Doors + Cruise + Leather + 
                Buick + Cadillac + Chevy + Pontiac + Saab + convertible + 
                hatchback + sedan, data1, trControl = control, method = "rpart")
SVM_P <- train( Price ~ Mileage + Cylinder + Doors + Cruise + Leather + 
                Buick + Cadillac + Chevy + Pontiac + Saab + convertible + 
                hatchback + sedan, data1, trControl = control, method = "svmRadial")
RF_P <- train( Price ~ Mileage + Cylinder + Doors + Cruise + Leather + 
                Buick + Cadillac + Chevy + Pontiac + Saab + convertible + 
                hatchback + sedan, data1, trControl = control, method = "rf")
KNN_P <- train( Price ~ Mileage + Cylinder + Doors + Cruise + Leather + 
                Buick + Cadillac + Chevy + Pontiac + Saab + convertible + 
                hatchback + sedan, data1, trControl = control, method = "knn")
# ACW_P <- train( Price ~ Mileage + Cylinder + Doors + Cruise + Leather + 
#                 Buick + Cadillac + Chevy + Pontiac + Saab + convertible + 
#                 hatchback + sedan, data1, trControl = control, method = "vglmAdjCat")
GLM_P <- train( Price ~ Mileage + Cylinder + Doors + Cruise + Leather + 
                Buick + Cadillac + Chevy + Pontiac + Saab + convertible + 
                hatchback + sedan, data1, trControl = control, method = "glm")

predicted_brand_CART_P <- predict(CART_P, data1)
predicted_brand_SVM_P <- predict(SVM_P, data1)
predicted_brand_RF_P <- predict(RF_P, data1)
predicted_brand_KNN_P <- predict(KNN_P, data1)
predicted_brand_GLM_P <- predict(GLM_P, data1)

confusion_brand_CART_P <- table(predicted = predicted_brand_CART_P, Observed = data1$Price)
confusion_brand_SVM_P <- table(predicted = predicted_brand_SVM_P, Observed = data1$Price)
confusion_brand_RF_P <- table(predicted = predicted_brand_RF_P, Observed = data1$Price)
confusion_brand_KNN_P <- table(predicted = predicted_brand_KNN_P, Observed = data1$Price)
confusion_brand_GLM_P <- table(predicted = predicted_brand_GLM_P, Observed = data1$Price)

Mat_CART_P <- confusionMatrix(predicted_brand_CART_P, data1$Price)
Mat_SVM_P <- confusionMatrix(predicted_brand_SVM_P, data1$Price)
Mat_RF_P <- confusionMatrix(predicted_brand_RF_P, data1$Price)
Mat_KNN_P <- confusionMatrix(predicted_brand_KNN_P, data1$Price)
Mat_GLM_P <- confusionMatrix(predicted_brand_GLM_P, data1$Price)

RESULT <- list(LDA = Mat_LDA$overall, CART = Mat_CART$overall, SVM = Mat_SVM$overall,
               RF = Mat_RF$overall, KNN = Mat_KNN$overall)
RESULT

results <- resamples(list(SVM = SVM, SVM2 = SVM2))

ggplot(results) + labs(y = "Accuarcy")



###############################
table(real, predict) ##[2,2] / [ ,2] 이게 민감도
table(predict, real) ##[2,2] / [2, ] 이게 민감도