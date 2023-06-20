-- https://school.programmers.co.kr/learn/courses/30/lessons/59034

/*
ANIMAL_INS 테이블  
ANIMAL_ID 아이디
ANIMAL_TYPE 생물 종
DATETIME 보호 시작일
INTAKE_CONDITION 보호 시작 시 상태
NAME 이름
SEX_UPON_INTAKE 성별 및 중성화 여부

ANIMAL_ID 순으로 조회
*/

SELECT
       *
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;