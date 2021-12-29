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

data(dhfr)
data1 <- dhfr
glimpse(data1)

## Shuffle
randomIdx <- sample(1:nrow(data1)) 
data1 <- data1[randomIdx,]

model1 <- glm(Y~.,data1, family="binomial")
summary(model1)
#model_step <- step(model1, direction = "both")

## parameter setting
preproc <- c("center", "scale")
control <- trainControl(method = "CV", number = 10)
performance_metric <- "Accuracy"

LDA <- train(Y ~ moe2D_KierA1 + moe2D_KierA2 + moe2D_KierFlex + moe2D_PEOE_VSA.1 + 
               moe2D_PEOE_VSA.5 + moe2D_PEOE_VSA.2.1 + moe2D_Q_VSA_NEG + 
               moe2D_Q_VSA_POL + moe2D_SMR_VSA3 + moe2D_a_don + moe2D_a_nC + 
               moe2D_b_count + moe2D_b_heavy + moeGao_chi2v_C + moeGao_chi3c + 
               moeGao_chi3c_C + moeGao_chi3cv + moeGao_chi3cv_C + moeGao_chi4ca_C + 
               moeGao_chi4cav_C + moe2D_kS_aaNH + moe2D_kS_sBr + moe2D_opr_brigid + 
               moe2D_vsa_acc, 
               data = data1,  method = "lda", metric = performance_metric,
               trControl = control, preProcess = preproc)


QDA <- train(Y ~ moe2D_KierA1 + moe2D_KierA2 + moe2D_KierFlex + moe2D_PEOE_VSA.1 + 
               moe2D_PEOE_VSA.5 + moe2D_PEOE_VSA.2.1 + moe2D_Q_VSA_NEG + 
               moe2D_Q_VSA_POL + moe2D_SMR_VSA3 + moe2D_a_don + moe2D_a_nC + 
               moe2D_b_count + moe2D_b_heavy + moeGao_chi2v_C + moeGao_chi3c + 
               moeGao_chi3c_C + moeGao_chi3cv + moeGao_chi3cv_C + moeGao_chi4ca_C + 
               moeGao_chi4cav_C + moe2D_kS_aaNH + moe2D_kS_sBr + moe2D_opr_brigid + 
               moe2D_vsa_acc, 
               data = data1,  method = "qda", metric = performance_metric,
               trControl = control, preProcess = preproc)

CART <- train(Y ~ moe2D_KierA1 + moe2D_KierA2 + moe2D_KierFlex + moe2D_PEOE_VSA.1 + 
                moe2D_PEOE_VSA.5 + moe2D_PEOE_VSA.2.1 + moe2D_Q_VSA_NEG + 
                moe2D_Q_VSA_POL + moe2D_SMR_VSA3 + moe2D_a_don + moe2D_a_nC + 
                moe2D_b_count + moe2D_b_heavy + moeGao_chi2v_C + moeGao_chi3c + 
                moeGao_chi3c_C + moeGao_chi3cv + moeGao_chi3cv_C + moeGao_chi4ca_C + 
                moeGao_chi4cav_C + moe2D_kS_aaNH + moe2D_kS_sBr + moe2D_opr_brigid + 
                moe2D_vsa_acc, 
                data = data1, method = "rpart", metric = performance_metric,
                trControl = control, preProcess = preproc)

SVM <- train(Y ~ moe2D_KierA1 + moe2D_KierA2 + moe2D_KierFlex + moe2D_PEOE_VSA.1 + 
               moe2D_PEOE_VSA.5 + moe2D_PEOE_VSA.2.1 + moe2D_Q_VSA_NEG + 
               moe2D_Q_VSA_POL + moe2D_SMR_VSA3 + moe2D_a_don + moe2D_a_nC + 
               moe2D_b_count + moe2D_b_heavy + moeGao_chi2v_C + moeGao_chi3c + 
               moeGao_chi3c_C + moeGao_chi3cv + moeGao_chi3cv_C + moeGao_chi4ca_C + 
               moeGao_chi4cav_C + moe2D_kS_aaNH + moe2D_kS_sBr + moe2D_opr_brigid + 
               moe2D_vsa_acc,
               data = data1, method = "svmRadial", metric = performance_metric,
               trControl = control, preProcess = preproc)

RF <- train(Y ~ moe2D_KierA1 + moe2D_KierA2 + moe2D_KierFlex + moe2D_PEOE_VSA.1 + 
              moe2D_PEOE_VSA.5 + moe2D_PEOE_VSA.2.1 + moe2D_Q_VSA_NEG + 
              moe2D_Q_VSA_POL + moe2D_SMR_VSA3 + moe2D_a_don + moe2D_a_nC + 
              moe2D_b_count + moe2D_b_heavy + moeGao_chi2v_C + moeGao_chi3c + 
              moeGao_chi3c_C + moeGao_chi3cv + moeGao_chi3cv_C + moeGao_chi4ca_C + 
              moeGao_chi4cav_C + moe2D_kS_aaNH + moe2D_kS_sBr + moe2D_opr_brigid + 
              moe2D_vsa_acc,
              data = data1, method = "rf", metric = performance_metric, 
              trControl = control, preProcess = preproc)

KNN <- train(Y ~ moe2D_KierA1 + moe2D_KierA2 + moe2D_KierFlex + moe2D_PEOE_VSA.1 + 
              moe2D_PEOE_VSA.5 + moe2D_PEOE_VSA.2.1 + moe2D_Q_VSA_NEG + 
              moe2D_Q_VSA_POL + moe2D_SMR_VSA3 + moe2D_a_don + moe2D_a_nC + 
              moe2D_b_count + moe2D_b_heavy + moeGao_chi2v_C + moeGao_chi3c + 
              moeGao_chi3c_C + moeGao_chi3cv + moeGao_chi3cv_C + moeGao_chi4ca_C + 
              moeGao_chi4cav_C + moe2D_kS_aaNH + moe2D_kS_sBr + moe2D_opr_brigid + 
              moe2D_vsa_acc,
              data = data1, method = "knn", metric = performance_metric, 
              trControl = control, preProcess = preproc)

ACW<- train(Y ~ moe2D_KierA1 + moe2D_KierA2 + moe2D_KierFlex + moe2D_PEOE_VSA.1 + 
                moe2D_PEOE_VSA.5 + moe2D_PEOE_VSA.2.1 + moe2D_Q_VSA_NEG + 
                moe2D_Q_VSA_POL + moe2D_SMR_VSA3 + moe2D_a_don + moe2D_a_nC + 
                moe2D_b_count + moe2D_b_heavy + moeGao_chi2v_C + moeGao_chi3c + 
                moeGao_chi3c_C + moeGao_chi3cv + moeGao_chi3cv_C + moeGao_chi4ca_C + 
                moeGao_chi4cav_C + moe2D_kS_aaNH + moe2D_kS_sBr + moe2D_opr_brigid + 
                moe2D_vsa_acc,
                data = data1, method = "vglmAdjCat", metric = performance_metric, 
                trControl = control, preProcess = preproc)

GLM <- train(Y ~ moe2D_KierA1 + moe2D_KierA2 + moe2D_KierFlex + moe2D_PEOE_VSA.1 + 
               moe2D_PEOE_VSA.5 + moe2D_PEOE_VSA.2.1 + moe2D_Q_VSA_NEG + 
               moe2D_Q_VSA_POL + moe2D_SMR_VSA3 + moe2D_a_don + moe2D_a_nC + 
               moe2D_b_count + moe2D_b_heavy + moeGao_chi2v_C + moeGao_chi3c + 
               moeGao_chi3c_C + moeGao_chi3cv + moeGao_chi3cv_C + moeGao_chi4ca_C + 
               moeGao_chi4cav_C + moe2D_kS_aaNH + moe2D_kS_sBr + moe2D_opr_brigid + 
               moe2D_vsa_acc,
               data = data1, method = "glm", metric = performance_metric, 
               trControl = control, preProcess = preproc)

results <- resamples(list(LDA = LDA, QDA = QDA, DecisonTree = CART,
                          SVM = SVM, KNN = KNN, RandomForest =RF, AcceptsCaseWeights = ACW, GLM = GLM))

ggplot(results) + labs(y = "Accuarcy")


LDA_prediction <- predict(LDA, data1)
QDA_prediction <- predict(LDA, data1)
CART_prediction <- predict(LDA, data1)
SVM_prediction <- predict(LDA, data1)
KNN_prediction <- predict(LDA, data1)
RF_prediction <- predict(LDA, data1)
ACW_prediction <- predict(LDA, data1)
GLM_prediction <- predict(LDA, data1)

confusion_LDA <- table(predicted = LDA_prediction, Observed = data1$Y)
confusion_QDA <- table(predicted = QDA_prediction, Observed = data1$Y)
confusion_CART <- table(predicted = CART_prediction, Observed = data1$Y)
confusion_SVM <- table(predicted = SVM_prediction, Observed = data1$Y)
confusion_KNN <- table(predicted = KNN_prediction, Observed = data1$Y)
confusion_RF <- table(predicted = RF_prediction, Observed = data1$Y)
confusion_ACW <- table(predicted = ACW_prediction, Observed = data1$Y)
confusion_GLM <- table(predicted = GLM_prediction, Observed = data1$Y)

Mat_LDA <- confusionMatrix(LDA_prediction, data1$Y)
Mat_QDA <- confusionMatrix(QDA_prediction, data1$Y)
Mat_CART <- confusionMatrix(CART_prediction, data1$Y)
Mat_SVM <- confusionMatrix(SVM_prediction, data1$Y)
Mat_KNN <- confusionMatrix(KNN_prediction, data1$Y)
Mat_RF <- confusionMatrix(RF_prediction, data1$Y)
Mat_ACW <- confusionMatrix(ACW_prediction, data1$Y)
Mat_GLM <- confusionMatrix(GLM_prediction, data1$Y)


RESULT <- list(LDA = Mat_LDA$overall, QDA = Mat_QDA$overall, CART = Mat_CART$overall, SVM = Mat_SVM$overall,
               KNN = Mat_KNN$overall, RF = Mat_RF$overall, ACW = Mat_ACW$overall, GLM = Mat_GLM$overall)
RESULT

