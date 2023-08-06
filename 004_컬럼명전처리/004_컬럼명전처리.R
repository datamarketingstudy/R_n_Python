library(tidyverse)

## File import
transactions <- read_csv("data/transactions_v2.csv")
glimpse(transactions)

## to lower column name
# install.packages("janitor") ### 미설치 시 최초 1회 설치
library(janitor) ### library janitor

colnames(transactions)
clean_names(transactions) %>% colnames()

transactions <- clean_names(transactions)
glimpse(transactions)


## 모두 대문자 또는 소문자로 치환할 경우 [base 이용]
toupper(colnames(transactions)) # 대문자
tolower(colnames(transactions)) # 소문자


