Caret 메뉴얼에서 데이터셋을 가져왔다
(Classification And REgression Training)

https://topepo.github.io/caret/data-sets.html

첫번째 데이터는 DHFR Inhibition 데이터셋을 사용하였다.
Sutherland and Weaver (2004) discuss QSAR models for dihydrofolate reductase (DHFR) inhibition. This data set contains values for 325 compounds. For each compound, 228 molecular descriptors have been calculated. Additionally, each sample is designated as “active” or “inactive”. 

glm을 이용하여 모델을 만들고 summary를 해봤다. 
AIC가 442인 것을 확인하였고, step 함수를 사용하여 AIC를 줄여보았다.
<img src = "" width = "400">

굉장히 오랜 시간이 걸려 돌려보니 실행함에 따라 AIC가 점진적으로 줄어드는 것을 확인할 수 있었다.
<img src = "" width = "400">
<img src = "" width = "400">
위의 방식으로 LDA, QDA, CART, SVM, RF, KNN, ACW, GLM 모두 적용해 주었다. 이번 프로젝트에서 활용할 8가지 방식이다. 


<img src = "" width = "400">
PLOT을 활용하여 정확도를 비교해보았다. KNN과 DECISION TREE의 경우 LOWER와 UPPER 사이의 간격이 굉장히 큰 것을 볼 수 있다. 또한 정확도도 낮아 활용하기 어려울 것으로 사료된다. 이외에도 ACW가 가장 좁은 간격으로 가장 높은 평균 정확성을 보여주고 있다. 따라서 ACW가 이번 모델에 가장 적합한 것으로 사료된다. 이외에도 LIST를 활용하여 각각의 Accuracy, Kappa, AccuracyLower, AccuracyUpper, AccuracyNull, AccuracyPValue, McnemarPValue 값을 출력했다.


두번째 데이터는 CARS 데이터셋을 사용하였다. 
Resale data for 2005 model year GM cars Kuiper (2008) collected data on Kelly Blue Book resale data for 804 GM cars (2005 model year).
cars is data frame of the suggested retail price (column Price) and various characteristics of each car (columns Mileage, Cylinder, Doors, Cruise, Sound, Leather, Buick, Cadillac, Chevy, Pontiac, Saab, Saturn, convertible, coupe, hatchback, sedan and wagon)

<img src = "" width = "400">
우선 데이터를 살펴보니 브랜드가 1과 0으로 표현되어 있고, 가격과 운행거리, 실린더의 개수, 문의 수 등 차의 상태와 관련된 피쳐 그리고 마지막으로 차의 종류가 있었다. 단순하게 진행하면 정해진 데이터를 변형하지 않고 가격을 예측하면 되겠지만 조금 바꿔보아 데이터를 통하여 차 브랜드 예측을 진행해 볼 예정이다.

각 브랜드의 값이 0과 1의 반복이고 중복이 없다. 즉 하나의 자동차는 하나의 브랜드를 갖고 있을 수 있다는 것이다. 따라서 각 브랜드 별로 N계수를 곱해 브랜드 별 고유 코드를 부여하고 합쳐서 Type이라는 하나의 피쳐를 만들었다. 

EX) BUICK: 1, CADILIAC: 2, CHEVY:3…..
<img src = "" width = "400">

이후 피쳐 셀렉션을 한 뒤 각각의 다른 방법으로 train해 줬다.
<img src = "" width = "400">
AIC: 367.6

<img src = "" width = "400">
이번 프로젝트에서 사용할 동일한 방식을 모두 적용했다. 이 중 안되는 것들은 주석으로 탈락시키며 진행하겠다.

<img src = "" width = "400">
각 방식으로 TRAIN을 시킨 뒤 OVERALL을 RESULT에 LIST로 담아 각각의 방식을 결과 값에 라벨링하여 결과 값을 도출하였다.

<img src = "" width = "400">
Random Forest 방식이 UPPER, LOWER의 큰 차이 없이 가장 높은 정확성을 보이는 것을 확인할 수 있다. CART 방식이 가장 낮은 정확도를 보이는 것을 알 수 있고 LOWER 역시 가장 낮았다.

이번 프로젝트를 수행하면서 정말 많은 길을 돌아왔다. 이전 프로젝트를 참고하기도 하고 교수님께서 강의에서 진행했던 코드를 따라가 보기도 했다. 지금 제출하는 코드에 몇 가지 에러가 있는 것을 알지만 지금으로서는 이것이 최대한인 것 같다. 