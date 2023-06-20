-- https://school.programmers.co.kr/learn/courses/30/lessons/131120

/*
MEMBER_PROFILE 테이블
MEMBER_ID 회원ID
MEMBER_NAME 회원이름
TLNO 회원 연락처
GENDER 성별
DATE_OF_BIRTH 생년월일

<문제>
생일이 3월인 여성 회원의 - WHERE
ID(MEMBER_ID),
이름(MEMBER_NAME),
성별(GENDER),
생년월일 조회(DATE_OF_BIRTH)

회원ID 기준 오름차순
*/

SELECT
       MEMBER_ID,
       MEMBER_NAME,
       GENDER,
       TO_CHAR(DATE_OF_BIRTH, 'YYYY-MM-DD')
FROM MEMBER_PROFILE
WHERE TO_CHAR(DATE_OF_BIRTH, 'MM') = 03
AND GENDER = 'W'
AND TLNO IS NOT NULL
ORDER BY MEMBER_ID ASC;