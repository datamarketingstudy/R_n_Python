#install.pakages("tidyverse") # 최초 설치 1회
library(tidyverse)

## File import

### Customer 데이터 읽기
customer <- read_csv("data/Customer.csv")
head(customer) # 첫 6행 확인
nrow(customer) # 데이터 총 행 수 확인
str(customer) # 전체적인 데이터 구조 확인

### Transactions 데이터 읽기
transactions <- read_csv("data/transactions.csv")
head(transactions) # 첫 6행 확인
nrow(transactions) # 데이터 총 행 수 확인
str(transactions) # 전체적인 데이터 구조 확인


### prod_cat_info 데이터 읽기
prod_cat_info <- read_csv("data/prod_cat_info.csv")
head(prod_cat_info) # 첫 6행 확인
nrow(prod_cat_info) # 데이터 총 행 수 확인
str(prod_cat_info) # 전체적인 데이터 구조 확인

### str 함수 대신 glimpse 함수를 이용할 수 있음
glimpse(transactions)

