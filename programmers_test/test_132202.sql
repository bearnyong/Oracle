-- https://school.programmers.co.kr/learn/courses/30/lessons/132202

/*
APPOINTMENT 테이블
APNT_YMD 진료예약일시
APNT_NO 진료예약번호
PT_NO 환자번호 
MCDP_CD 진료과코드
MDDR_ID 의사ID
APNT_CNCL_YN 예약취소여부
APNT_CNCL_YMD 예약취소날짜

2022-05에 예약한 환자 수를
진료과코드(MCDP_CD)별로 GROUP BY MCDP_CD 조회 SELECT MCDP_CD, COUNT(*)

조건 컬럼명은 '진료과 코드', '5월예약건수'
ORDER BY 예약한 환자 수 기준으로 오름차순(ASC), 진료과코드(ASC)

1. 2022-05에 예약한 환자 수 - WHERE APNT_YMD LIKE '2022-05%'
2. 진료과코드별로 조회한다. - GROUP BY MCDP_CD
3. 조건 컬럼명은 '진료과 코드', '5월예약건수'
4. ORDER BY 예약한 환자 수 기준으로 오름차순(ASC), 진료과코드(ASC)
*/
SELECT
       MCDP_CD AS "진료과코드",
       COUNT(*) AS "5월예약건수"
FROM APPOINTMENT 
WHERE TO_CHAR(APNT_YMD, 'YYYY-MM') = '2022-05'
GROUP BY MCDP_CD
ORDER BY "5월예약건수" ASC, "진료과코드" ASC;