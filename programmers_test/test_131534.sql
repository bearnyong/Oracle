-- https://school.programmers.co.kr/learn/courses/30/lessons/131534

/*
USER_INFO 테이블
USER_ID 회원 ID
GENDER 성별
AGE 나이
JOINED 가입일

ONLINE_SALE 테이블
ONLINE_SALE_ID 온라인 상품 판매 ID
USER_ID 회원 ID 
PRODUCT_ID 상품 ID
SALES_AMOUNT 판매량
SALES_DATE 판매일

(WHERE)
조건1. 2021년에 가입한 전체 회원들 중 O

(SELECT)
조건2. 상품을 구매한 회원수, O
조건3. 상품을 구매한 회원의 비율(=2021년에 가입한 회원 중 상품을 구매한 회원수 / 2021년에 가입한 전체 회원 수)
 - 소수점 두번쨰자리에서 반올림
조건4. 년, 월 출력

(ORDER BY)
조건5. 전체 결과 - 년 ,월 순으로 오름차순 정렬

*/



SELECT
       TO_CHAR(O.SALES_DATE, 'YYYY') AS "YEAR",
       TO_NUMBER(TO_CHAR(O.SALES_DATE, 'FMMM')) AS "MONTH",
       COUNT(DISTINCT O.USER_ID) AS "PUCHASED_USERS",
       ROUND(COUNT(DISTINCT O.USER_ID)/(SELECT COUNT(UU.USER_ID)
                                          FROM USER_INFO UU
                                         WHERE TO_CHAR(UU.JOINED, 'YYYY') = '2021') , 1) AS "PUCHASED_RATIO"
FROM ONLINE_SALE O
JOIN USER_INFO U ON (O.USER_ID  = U.USER_ID)
WHERE TO_CHAR(U.JOINED, 'YYYY') = '2021'
GROUP BY TO_CHAR(O.SALES_DATE, 'YYYY'), TO_NUMBER(TO_CHAR(O.SALES_DATE, 'FMMM'))
ORDER BY "YEAR" ASC, "MONTH" ASC;