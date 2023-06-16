-- https://school.programmers.co.kr/learn/courses/30/lessons/151137

-- 코드를 입력하세요
/*
CAR_RENTAL_COMPANY_CAR 테이블
CAR_ID 자동차ID
CAR_TYPE 자동차 종류
DAILY_FEE 일일 대여 요금(원)
OPTIONS  자동차 옵션 리스트

통풍시트 OR 열선시트 OR 가죽시트 중 하나 이상의 옵션이 포합된 자동차,
종류별로 몇 대인지 구하시오.

1. 조건문을 이용하여 통풍시트 OR 열선시트 OR 가죽시트 중 하나 이상의 옵션이 포함된 자동차를 찾아준다.
2. 그룹으로 묶어준다 (자동차종류)
3. 자동차의 종류와 카운트를 조회한다.
*/

SELECT
       CAR_TYPE,
       COUNT(*) AS CARS
FROM CAR_RENTAL_COMPANY_CAR 
WHERE OPTIONS LIKE '%통풍시트%'
OR OPTIONS LIKE '%열선시트%'
OR OPTIONS LIKE '%가죽시트%'
GROUP BY CAR_TYPE
ORDER BY CAR_TYPE ASC;