-- https://school.programmers.co.kr/learn/courses/30/lessons/157341

/*
CAR_RENTAL_COMPANY_CAR 테이블
CAR_ID 자동차ID
CAR_TYPE 자동차 종류
DAILY_FEE 일일대여요금(원)
OPTIONS  자동차 옵션 리스트

CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블
HISTORY_ID 자동차 대여기록 ID
CAR_ID 자동차 ID
START_DATE 대여 시작일
END_DATE 대여 종료일

<문제>
자동차 종류가 '세단'인 자동차들 중
10월에 대여를 시작한 기록이 있는 자동차ID 리스트 출력
자동차ID 리스트 -> 중복X,
자동차ID 기준 내림차순(DESC)

1. 자동차 종류가 '세단'인 자동차를 찾는다 - WHERE
2. AND 대여시작일(START_DATE)이 10월
3. 자동차ID 중복X - DISTINCT : 중복 값 제거
4. 자동차ID 내림차순(DESC)
*/

SELECT DISTINCT C.CAR_ID
FROM CAR_RENTAL_COMPANY_CAR C
JOIN CAR_RENTAL_COMPANY_RENTAL_HISTORY H ON (H.CAR_ID = C.CAR_ID)
WHERE C.CAR_TYPE = '세단'
AND TO_CHAR(START_DATE, 'YYYY-MM') = '2022-10'
ORDER BY C.CAR_ID DESC