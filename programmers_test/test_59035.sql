-- https://school.programmers.co.kr/learn/courses/30/lessons/59035

/*
ANIMAL_INS 테이블
ANIMAL_ID 동물 아이디
ANIMAL_TYPE 생물 종
DATETIME 보호 시작일
INTAKE_CONDITION 보호 시작 시 상태
NAME 이름
SEX_UPON_INTAKE 성별 및 중성화 여부

모든 동물의 이름(*)과 보호 시작일을 조회
결과는 ANIMAL_ID 역순
*/

SELECT
       NAME,
       DATETIME
FROM ANIMAL_INS
ORDER BY ANIMAL_ID DESC;