library(tidyverse)

## File import
customer <- read_csv("data/Customer.csv") ### Customer 데이터 읽기
transactions <- read_csv("data/transactions.csv") ### Transactions 데이터 읽기
prod_cat_info <- read_csv("data/prod_cat_info.csv") ### prod_cat_info 데이터 읽기

## information
head(customer)
glimpse(customer)

## NULL값 확인
sapply(customer, function(col) sum(is.na(col)))

## 결측치 데이터 확인

### Gender 결측치
customer[is.na(customer$Gender),] # Method1

customer %>%
    filter(is.na(Gender)) # Method2

#### 결측치를 알 수 없음의 의미로 'unknown'으로 변경하기
customer$Gender <- ifelse(is.na(customer$Gender), "unknown", customer$Gender)
#### 검증
customer %>%
    group_by(Gender) %>%
    summarise(n = n())

### city_code 결측치
customer[is.na(customer$city_code),] # Method1

customer %>%
    filter(is.na(city_code)) # Method2

#### city_code 데이터 집계 (내림차순 정렬))

customer %>%
    group_by(city_code) %>%
    summarise(n = n_distinct(customer_Id)) %>%
    arrange(desc(n))

## 결측치를 city_code 최대값 지역인 3으로 임의로 부여하기
customer$city_code <- ifelse(is.na(customer$city_code), 3, customer$city_code)

customer %>%
    filter(is.na(city_code)) # Method2

customer %>%
    group_by(city_code) %>%
    summarise(n = n_distinct(customer_Id)) %>%
    arrange(desc(n))

## 최종적으로 각 컬럼의 결측치 수 확인하기
sapply(customer, function(col) sum(is.na(col)))
