-- https://school.programmers.co.kr/learn/courses/30/lessons/132204

/*
PATIENT 테이블 (환자 정보)
PT_NO 환자번호
PT_NAME 환자이름
GEND_CD 성별코드
AGE 나이
TLNO 전화번호

DOCTOR 테이블 (의사 정보)
DR_NAME 의사이름
DR_ID 의사ID,
LCNS_NO 면허번호
HIRE_YMD 고용일자
MCDP_CD 진료과코드
TLNO 전화번호

APPOINTMENT 테이블 (진료 예약 목록)
APNT_YMD 진료예약일시
APNT_NO 진료예약번호
PT_NO 환자번호
MCDP_CD 진료과코드
MDDR_ID 의사ID
APNT_CNCL_YN 예약취소여부
APNT_CNCL_YMD 예약취소날짜

2022년 4월 13일 취소되지 않은 흉부외과(CS) 진료 예약 내역 조회
진료예약번호(A.APNT_NO),
환자이름(P.PT_NAME), 
환자번호(P.PT_NO), 
진료과코드(D.MCDP_CD), 
의사이름(D.DR_NAME), 
진료예약일시(A.APNT_YMD)
ORDER BY 진료예약일시 오름차순ASC
*/

SELECT
       A.APNT_NO,
       P.PT_NAME,
       P.PT_NO,
       D.MCDP_CD,
       D.DR_NAME,
       A.APNT_YMD
FROM APPOINTMENT A
JOIN DOCTOR D ON (D.DR_ID = A.MDDR_ID)
JOIN PATIENT P ON (P.PT_NO  = A.PT_NO)
WHERE TO_CHAR(A.APNT_YMD, 'YYYY-MM-DD') = '2022-04-13'
AND A.APNT_CNCL_YN = 'N'
ORDER BY A.APNT_YMD ASC;