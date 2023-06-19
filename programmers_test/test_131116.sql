-- https://school.programmers.co.kr/learn/courses/30/lessons/131116

/*
FOOD_PRODUCT 테이블

PRODUCT_ID 식품 ID
PRODUCT_NAME 식품 이름
PRODUCT_CD 식품코드
CATEGORY 식품분류
PRICE 식품가격

식품분류별로 가장 비싼 식품의
select 분류, 가격, 이름을 조회
where 식품분류- 과자 or 국 or 김치 or 식용유
*/


SELECT
       CATEGORY,
       PRICE,
       PRODUCT_NAME
FROM FOOD_PRODUCT
WHERE (CATEGORY, PRICE) IN (SELECT
                                   CATEGORY,
                                   MAX(PRICE)
                              FROM FOOD_PRODUCT
                             WHERE CATEGORY IN ('과자', '국', '김치', '식용유')
                          GROUP BY CATEGORY)
ORDER BY PRICE DESC;



