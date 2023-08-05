library(tidyverse)

## File import
customer <- read_csv("data/Customer.csv") ### Customer 데이터 읽기
glimpse(customer) ### 데이터 구조 및 컬럼 타입 확인 
     
## lubridate package
install.packages("lubridate") ### 패키지가 없을 경우 최초 1회만 
library(lubridate) ### 패키지 불러오기

## 'yyyy-mm-dd' 형태의 데이터로 변환
customer$DOB <- dmy(customer$DOB)
glimpse(customer)

# ========== Case 2. 동일하지 않은 형식의 데이터를 날짜형 데이터로 변환하기 ==========

## File import
transactions <- read_csv("data/transactions.csv") ### Transactions 데이터 읽기
glimpse(transactions)

## 데이터 전체 보기
View(transactions)
unique(transactions$tran_date)

## STEP 1. '/' 패턴을 '-' 패턴으로 변경하기
transactions$tran_date <- gsub('/', '-', transactions$tran_date)
unique(transactions$tran_date)

## STEP 2. lubridate 패키지의 dmy 함수를 이용하여 날짜형 데이터 타입으로 변환
transactions$tran_date <- dmy(transactions$tran_date)
glimpse(transactions)

