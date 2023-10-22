library(tidyverse)

## File import
transactions <- read_csv("data/transactions_v3.csv")
glimpse(transactions)

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
    
## confirmed rows (solution 1)
order_minus_cancel = 20876 - 2177
order_minus_cancel

## solution 2. confirmed_yn column
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

## NA값 대체
transactions$confirmed_yn <- ifelse(is.na(transactions$confirmed_yn), 1, transactions$confirmed_yn)

## 집계
transactions %>%
    group_by(confirmed_yn) %>%
    summarise(n = n())    

## 검증
order_minus_cancel == transactions %>%
    group_by(confirmed_yn) %>%
    summarise(n = n()) %>%
    filter(confirmed_yn == 1) %>%
    select(n)

## transaction_id가 2개 초과인 데이터 샘플링
transactions %>%
    group_by(transaction_id) %>%
    summarise(n = n()) %>%
    filter(n > 2) %>%
    head()

sample_df <- transactions %>%
    filter(transaction_id == 426787191) %>%
    arrange(tran_date)
sample_df

# 동일 주문번호 내 각 주문상태 값 단위로 가장 마지막 거래일자 row만 남겨두고 제외시키기
result <- sample_df %>%
    arrange(transaction_id, desc(tran_date)) %>%
    group_by(transaction_id, order_status) %>%
    mutate(row_num = row_number())
result

result %>%
    filter(row_num == 1) %>%
    arrange(tran_date)

## 전체 데이터에 적용

transactions <- transactions %>%
    arrange(transaction_id, desc(tran_date)) %>%
    group_by(transaction_id, order_status) %>%
    mutate(row_num = row_number())

transactions <- transactions %>%
    filter(row_num == 1)
head(transactions)

## 검증
# sol.1
transactions %>%
    group_by(order_status) %>%
    summarise(n = n())
order_minus_cancel2 <- 20876-2059
order_minus_cancel2

#sol.2
transactions %>%
    group_by(confirmed_yn) %>%
    summarise(n = n()) %>%
    filter(confirmed_yn == 1) %>%
    select(n)

order_minus_cancel2 == transactions %>%
    group_by(confirmed_yn) %>%
    summarise(n = n()) %>%
    filter(confirmed_yn == 1) %>%
    select(n)

## 주문은 없고, 취소가 발생한 건이 있는지 확인
transactions %>%
    group_by(transaction_id) %>%
    summarise(od_n = sum(ifelse(order_status == 'Ordered', 1, 0)),
              ca_n = sum(ifelse(order_status == 'Canceled', 1, 0))) %>%
    filter(od_n == 0)

transactions %>%
    filter(transaction_id == 8868056339)

## 해당 건 제거
omit_df <- transactions %>%
    group_by(transaction_id) %>%
    summarise(od_n = sum(ifelse(order_status == 'Ordered', 1, 0)),
              ca_n = sum(ifelse(order_status == 'Canceled', 1, 0))) %>%
    filter(od_n == 0)
omit_df

transactions <- transactions %>%
    anti_join(omit_df, by = "transaction_id")
glimpse(transactions)

## 최종 검증
transactions %>%
    group_by(order_status) %>%
    summarise(n = n())
order_minus_cancel3 <- 20876-2057
order_minus_cancel3

transactions %>%
    group_by(confirmed_yn) %>%
    summarise(n = n())

order_minus_cancel3 == transactions %>%
    group_by(confirmed_yn) %>%
    summarise(n = n()) %>%
    filter(confirmed_yn == 1) %>%
    select(n)
