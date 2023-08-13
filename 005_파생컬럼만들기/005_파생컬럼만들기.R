library(tidyverse)

## File import
transactions <- read_csv("data/transactions_v3.csv")
head(transactions)

## sampling data
transactions %>%
    filter(transaction_id == 80712190438) %>%
    arrange(tran_date)

## mutating columns
transactions <- transactions %>%
    mutate(order_status = ifelse(total_amt < 0, 'Canceled', 'Ordered'))

## Sample filtering
transactions %>%
    filter(transaction_id == 80712190438) %>%
    arrange(tran_date)

## order_status rows
transactions %>%
    group_by(order_status) %>%
    summarise(n = n())

20876-2177 ## confirmed 

## confirmed_yn column
canceled_df <- transactions %>%
    filter(order_status == 'Canceled') %>% 
    select(transaction_id) %>% 
    mutate(confirmed_yn = 0) %>% 
    distinct()

head(canceled_df)

## canceled 정보 join
transactions <- transactions %>%
    left_join(canceled_df, by = 'transaction_id')
glimpse(transactions)

## 집계
transactions %>%
    group_by(confirmed_yn) %>%
    summarise(n = n())    

## NA값 대체
transactions$confirmed_yn <- ifelse(is.na(transactions$confirmed_yn), 1, transactions$confirmed_yn)

## 집계
transactions %>%
    group_by(confirmed_yn) %>%
    summarise(n = n())    
