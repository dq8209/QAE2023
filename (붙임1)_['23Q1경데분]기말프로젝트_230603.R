
# ## set=================================
# ## 폴더 지정-----------------
# setwd("C:/Data") 
# getwd()

# ## 설치확인-----------------
# install.packages("rvest")
# install.packages("dplyr")
# install.packages("stringr")
# install.packages("httr")
# install.packages("XML")
# install.packages("jsonlite")
# install.packages("writexl")
# install.packages("readr")
# install.packages("rmarkdown")
# install.packages("htmlTable")

# ## 사용-----------------
# library(rvest)
# library(dplyr)
# library(stringr)
# library(httr)
# library(XML)
# library(xml2)
# library(jsonlite)
# library(writexl)
# library(readr)
# library(rmarkdown)
# library(htmlTable)


## 작업=================================
## 수집대상 페이지(정책이름,지역,정책구분)-----------------------
URL <- "https://www.youthcenter.go.kr/youngPlcyUnif/youngPlcyUnifList.do"
res <- read_html(URL)


## (1) 지원제도명-----------------------
pattern <- ".result-list-box strong"
지원제도명 <- res %>% 
  html_nodes(pattern) %>% 
  html_text()


## (2) 지역-----------------------
pattern <- "div.badge"
지역 <- res %>% 
  html_nodes(pattern) %>% 
  html_text()


## (3) 구분-----------------------
pattern <- ".srh-cate-data"
구분 <- res %>% 
  html_nodes(pattern) %>% 
  html_text()


## (4)사이트-----------------------
pattern <- ".result-list-box a"
사이트 <- res %>%
  html_nodes(pattern) %>% 
  html_text()
#? 개발자도구 다시 확인


# ## (5) 페이지 이동-----------------------
# rid <- "#srchFrm > div.paging.green > a:nth-child()"
# reference(rid)
# Sys.sleep(3)
# n.item <- check()[1]
# 
# for (i in 1:) {
#   print(i)
#   more.items()
#   Sys.sleep(3)
#   n.item <- check()[1]
#   print(n.item)
#   if (n.item.previous==n.item) break()
#   n.item.previous <- n.item
#}
# Temp <- Temp %>%
#   mutate(str = str_extract(.,"[A-Z]\\d{13}"))
# Temp <-Temp[-1]


## 추출=================================
## 데이터 프레임-----------------------
df <- cbind(지원제도명, 지역, 구분, 사이트)
df <- data.frame(df)
html <- htmlTable(df)

## 파일 저장-----------------------
# write_csv(df, "청년_지원_정책.csv")
# write_xlsx(df, "청년_지원_정책.xlsx")
write(html, file = "청년_지원_정책.html")
