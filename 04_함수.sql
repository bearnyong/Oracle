/* 그룹 함수와 단일행 함수*/
-- 단일행 함수(single row function) : n개의 값을 넣어서 n개의 결과를 리턴
-- 그룹 함수(group function) : n개의 값을 넣어 1개의 결과를 리턴
-- 그룹 함수 : sum, abg, max, min, count


-- [ SUM(숫자) ]
-- : 합계를 구하여 리턴
SELECT
       SUM(SALARY)
  FROM EMPLOYEE;


-- [ AVG(숫자) ]
-- : 평균 구하기
SELECT
       SUM(SALARY)
  FROM EMPLOYEE;


-- [ MIN(숫자 | 문자 | 날짜) ]
-- : 가장 작은 값 리턴
SELECT
       MIN(EMAIL),
       MIN(HIRE_DATE),
       MIN(SALARY)
  FROM EMPLOYEE;


-- [ CONUT(* | 칼럼명) ]
-- [ CONUT(*) ] : 모든 행의 수 리턴
-- [ CONUT(컬럼명) ] : NULL을 제외한 실제 값이 기록된 행의 수 리턴
SELECT
       COUNT(*),
       COUNT(DEPT_CODE),
       COUNT(DISTINCT DEPT_CODE) /*DEPT_CODE의 중복된 값을 제외*/
  FROM EMPLOYEE;
  
SELECT
       *
  FROM EMPLOYEE;


-- [ 단일행 함수 ]
-- 문자 관련 함수 : LENGTH LENGTHB, SUBSTR, UPPERM LOWER, INSTR

SELECT
       LENGTH('오라클'),
       LENGTHB('오라클') -- 한글byte
       -- 한글 byte랑 영어 byte 값 차이보기
  FROM DUAL; -- DUMMY TABLE(임의로 테스트할 때 사용하는 테이블)

SELECT
       LENGTH(EMAIL),
       LENGTHB(EMAIL) -- 영어 byte
       -- 한글 byte랑 영어 byte 값 차이보기
  FROM EMPLOYEE;


-- INSTR : 문자의 위치가 어디있는지 반환해줌
-- INSTR('문자열' | 컬럼명, '문자열', 찾을 위치의 시작값, [빈도])
SELECT INSTR('AAABBACAABBAA', 'B') FROM DUAL;
SELECT INSTR('AAABBACAABBAA', 'B', 1) FROM DUAL;
SELECT INSTR('AAABBACAABBAA', 'B', -1) FROM DUAL;
SELECT INSTR('AAABBACAABBAA', 'B', 1, 4) FROM DUAL;

SELECT
       EMAIL,
       INSTR(EMAIL, '@', -1) 위치
  FROM EMPLOYEE;

SELECT
       EMP_NAME
  FROM EMPLOYEE
 WHERE INSTR(EMP_NAME, '하') > 1;
 -- '하'의 위치가 첫번쨰보다 뒤에 있을 때 출력

SELECT
       EMP_NAME,
       EMAIL,
       SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1)
       -- SUBSTR : 잘라줄 범위 설정 ('@' 이전의 값을 출력하기 위해 -1을 작성한다.)
  FROM EMPLOYEE;

SELECT
       LPAD(EMAIL, 20, '#')
       -- LPAD : 우측에서 20번째 이후의 문자들을 #으로 채운다.
  FROM EMPLOYEE;

SELECT
       RPAD(SUBSTR(EMAIL, 1, 10), 20, '#')
       -- RPAD : 좌측에서 10번째까지의 문자를 자르고, 나머지 20까지의 문자들을 #으로 채운다.
  FROM EMPLOYEE;


-- [LTRIM / RTRIM]
-- : 주어진 컬럼이나 문자열 왼쪽 / 오른쪽에서 지정한 문자를 제거한 나머지를 반환
SELECT '      GREEDY' FROM DUAL;
SELECT LTRIM('      GREEDY') FROM DUAL;
SELECT LTRIM('000000GREEDY', '0') FROM DUAL;
SELECT LTRIM('1232324213GREEDY', '123') FROM DUAL;
SELECT LTRIM('ABCBAabcGREEDY', 'ABCa') FROM DUAL;
SELECT LTRIM('32451652GREEDY', '0123456789') FROM DUAL;

SELECT 'GREEDY0000' FROM DUAL;
SELECT RTRIM('GREEDY0000', '0') FROM DUAL;

SELECT
       EMP_ID,
       EMP_NAME
  FROM EMPLOYEE
 WHERE EMP_NAME = RTRIM('선동일 ');


-- [TRIM]
-- 주어진 컬럼이나 문자열 앞 / 뒤에 지정한 문자를 제거
SELECT TRIM(    'GREEDY    ') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZZGREEDYZZZ') FROM DUAL;
SELECT TRIM(LEADING 'Z' FROM 'ZZZZGREEDYZZZ') FROM DUAL;
SELECT TRIM(TRAILING 'Z' FROM 'ZZZZGREEDYZZZ') FROM DUAL;
SELECT TRIM(BOTH 'Z' FROM 'ZZZZGREEDYZZZ') FROM DUAL;


-- [SUBSTR]
-- 컬럼이나 문자열에서 지정한 위치로부터 지정한 갯수의 문자열을 잘라서 리턴
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;
SELECT SUBSTR('쇼우 미 더 머니', 2, 5) FROM DUAL;

-- 여직원의 이름, 주민번호 조회
SELECT
       EMP_NAME,
       EMP_NO
  FROM EMPLOYEE
 WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

-- EMPLOYEE 테이블에서 직원의 주민번호를 조회하여
-- 사원명(EMP_NAME), 생년(EMP_NO), 생월(EMP_NO), 생일(EMP_NO)을 각각 분리하여 조회
-- 단 컬럼명의 별칭은 사원명, 생년, 생월, 생일로 구분한다.
-- 완료시 남사원의 정보만 표현하도록 수정한다.
/*
1. EMPLOYEE 테이블에서 조회하기 - FROM EMPLOYEE
2. 사원명, 생년, 생월, 생일 각각 분리하여 조회 - SELECT
3. 컬럼의 별칭은 사원명, 생년, 생월, 생일 구분 - SELECT AS ""
4. 남사원의 정보만 표현한다 - WHERER
*/
SELECT
       EMP_NAME,
       SUBSTR(EMP_NO, 1, 2) AS "생년",
       SUBSTR(EMP_NO, 3, 2) AS "생월",
       SUBSTR(EMP_NO, 5, 2) AS "생일"
  FROM EMPLOYEE
 WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3');

SELECT
       *
  FROM EMPLOYEE;


-- 서브쿼리(스칼라 쿼리)
SELECT
       EMP_ID,
       EMP_NAME,
       SALARY
  FROM EMPLOYEE
 WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEE);
 -- EMPLOYEE의 SALARY 전체 평균을 가져와서 평균 값보다 높은 SALARY를 가지고 있는 정보를 가져온다.
 

-- EMPLOYEE 테이블에서 사원명, 주민번호 조회
-- 단, 주민번호는 생년월일만 보이게 하고 - 다음 값은 *로 변경하여 출력한다.
-- 컬럼명은 사원명, 주민번호로 변경한다.
/*
1. EMPLOYEE 테이블에서 조회하기 - FROM
2. 사원명 주민번호를 조회한다. - SELECT 컬럼
3. 주민번호는 8번째까지 자르고 이 자리부터 값을 '*'로 변경하여 출력한다. - SELECT
4. 컬럼명은 사원명, 주민번호로 변경한다. - SELECT 별칭
*/
SELECT
       EMP_NAME AS 사원명,
       RPAD(SUBSTR(EMP_NO, 1, 7),14, '*') AS 주민번호
 FROM EMPLOYEE;
 
 
-- [LOWER / UPPER]
-- 대/소문자 변경해주는 함수
SELECT LOWER('Welcom to My World') from dual; --소문자
SELECT UPPER('Welcom to My World') from dual; --대문자


-- [CONCAT]
-- 문자열 두 개를 하나의 문자열로 합친 후 리턴
SELECT COMCAT('가나다라', 'ABCD') FROM DUAL;
SELECT '가나다라' || 'ABCD' FROM DUAL;


-- [REPLACE]
-- 컬럼 혹은 문자열을 입력받아 변경하고자 하는 문자열을 변경하려고 하는 문자열로 바꾼 후 리턴
SELECT REPLACE('서울시 강남구 역삼동', '역삼동', '삼성동') FROM DUAL;


/*
숫자 처리 함수
ABS, MOD, ROUND FLOOR, TRUNC, CEIL
*/


-- [ ABS(숫자 | 컬럼) ]
-- 절대값 구하는 함수
SELECT
       ABS(-10),
       ABS(10)
  FROM DUAL;


-- [ MOD(숫자, 숫자) ]
-- 두 수를 나누어서 나머리즐 구하는 함수(자바%)
-- 첫 번째 인자는 나누어지는 수, 두 번쨰 인자는 나눌 수
SELECT
       MOD(10,5),
       MOD(10,3)
  FROM DUAL;


-- 사번이 짝수인 직원의 사번, 이름, 급여, 부서코드 조회
SELECT
       EMP_ID,
       EMP_NAME,
       SALARY,
       DEPT_CODE
  FROM EMPLOYEE
 WHERE MOD(EMP_ID, 2)=0;


-- [ FLOOR(숫자) ]
-- 내림처리를 한 정수를 반환하는 함수
SELECT FLOOR(123,785) FROM DUAL;


-- [ TRUNC(숫자,[위치]) ]
-- 내림처리(절삭) 함수
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.456, 1) FROM DUAL;
SELECT TRUNC(123.456, -1) FROM DUAL;


-- [ CEIL(숫자) ]
-- 올림처리 함수
SELECT CEIL(123.456) FROM DUAL;


/*숫자 처리 함수 전체보기*/
SELECT
       ROUND(1234.2324),
       FLOOR(1234.2324),
       TRUNC(1234.2324),
       CEIL(1234.2324)
  FROM DUAL;


--
--
--
--
-- 05.12.

/*날짜 처리 함수*/
-- SYSDATE, MONTHS_BETWEEN, ADD_MONTHS, NEXT_DAY, LAST_DAY, EXTRACT,....

-- [ SYSDATE ]
-- 현재 날짜와 시간을 반환해주는 함수
SELECT SYSDATE FROM DUAL;


-- [ MONTHS_BETWEEN (날짜, 날짜) ]
-- 두 날짜의 개월 수 차이를 숫자로 리턴하는 함수
SELECT
       EMP_NAME,
       HIRE_DATE,
       CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS 개월수
  FROM EMPLOYEE;

SELECT
       SYSDATE + 1,
       SYSDATE - 1,
       SYSDATE - HIRE_DATE
  FROM EMPLOYEE;


-- [ ADD_MONTHS(날짜, 숫자) ]
-- 날짜에 숫자만큼 개월수를 더해서 리턴
SELECT
       ADD_MONTHS(SYSDATE, 5)
  FROM DUAL;


-- [ NEXT_DATE(기준날짜, 요일)
-- 기준 날짜에서 구하려는 요일에 가장 가까운 날짜 리턴
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 6) FROM DUAL; /*일(1) 월(2) 화(3) 수(4) 목(5) 금(6) 토(6)*/
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL; /*인코딩 설정이 이미 한글로 되어있는 경우 오류가 발생한다.*/

/*기본 설정 언어인 영어를 한국을 기준으로 변경한다는 .. 그런 늒임스...*/
ALTER SESSION SET NLS_LANGUAGE = KOREAN;


-- LAST_DAY(날짜)
-- 해당 월의 마지막 날짜를 리턴
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;


-- [ EXTRACT ] : 년, 월, 일 정보를 추출하여 리턴(자주사용)
-- [ EXTRACT(YEAR FROM 날짜) ] : 년도만 추출
-- [ EXTRACT(MONTH FROM 날짜) ] : 월만 추출
-- [ EXTRACT(DAY FROM 날짜) ] : 날짜만 추출
SELECT
       EXTRACT(YEAR FROM SYSDATE) AS 년도,
       EXTRACT(MONTH FROM SYSDATE) AS 월,
       EXTRACT(DAY FROM SYSDATE) AS 일
  FROM DUAL;


-- 날짜 인코딩 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';


-- 형변환 함수
-- TO_CHAR(날짜, [포맷]) : 날짜형 데이터를 문자형 데이터로 변경
-- TO_CHAR(숫자, [포맷]) : 숫자형 데이터를 문자형 데이터로 변경
SELECT TO_CHAR(1234) FROM DUAL;
SELECT TO_CHAR(1234, '9999') FROM DUAL;
SELECT TO_CHAR(1234, '0000') FROM DUAL;
SELECT TO_CHAR(1234, 'L99,999') FROM DUAL;
SELECT TO_CHAR(1234, '$99,999') FROM DUAL;
SELECT TO_CHAR(1234, '00,000') FROM DUAL;


-- 직원의 테이블에서 사원명, 급여 조회
-- 급여는 '\9,000,0000' 형식으로 표시
SELECT
       EMP_NAME,
       TO_CHAR(SALARY, 'L99,999,999') AS 급여
  FROM EMPLOYEE;


-- 날짜 데이터에 포맷 적용(자주 사용)
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-fmMM-DD DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YEAR,Q') || '분기' FROM DUAL;


-- 날짜 포맷 예제
SELECT
       EMP_NAME,
       TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') 입사일,
       TO_CHAR(HIRE_DATE, 'YYYY-MM-DD HH24:MI:SS') 상세입사일,
       TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"') 입사일한글
  FROM EMPLOYEE;


-- 년도 포맷
SELECT
      TO_CHAR(SYSDATE, 'YYYY'),
      TO_CHAR(SYSDATE, 'RRRR'),
      TO_CHAR(SYSDATE, 'YY'),
      TO_CHAR(SYSDATE, 'YEAR')
  FROM DUAL;


-- YY와 RR의 차이
/*
RR은 두 자리 년도를 네자리로 변경 할 때 변경하는 년도가 50년 미만인 경우 2000년대를 적용
50년 이상인 경우 1900년대를 적용한다.
*/
SELECT
       TO_CHAR(TO_DATE('980630', 'YYMMDD'), 'YYYY-MM-DD'),
       TO_CHAR(TO_DATE('980630', 'RRMMDD'), 'YYYY-MM-DD')
  FROM DUAL;


-- 월 포맷---------------------------------------------------------
SELECT
       TO_CHAR(SYSKDATE, 'MM'),
       TO_CHAR(SYSKDATE, 'MONTH'),
       TO_CHAR(SYSKDATE, 'MON'),
       TO_CHAR(SYSKDATE, 'RM')
  FROM DUAL;


-- 일 포맷
SELECT
       TO_CHAR(SYSDATE, '"1년 기준" DDD"일째"'),
       TO_CHAR(SYSDATE, '"달 기준" DD"일째"'),
       TO_CHAR(SYSDATE, '"주 기준" D"일째"')
  FROM DUAL;


-- 분기와 요일
SELECT
       TO_CHAR(SYSDATE, 'Q"분기"'),
       TO_CHAR(SYSDATE, 'DAY"'),
       TO_CHAR(SYSDATE, 'DY')
  FROM DUAL;


-- 응용하기
SELECT
       TO_DATE('20101010', 'RRRRMMDD')
  FROM DUAL;

SELECT
       TO_CHAR(TO_DATE('20101010', 'RRRRMMDD'), 'RRRR, MON')
  FROM DUAL;

SELECT
       TO_CHAR(TO_DATE('041030 143000', 'RRMMDD HH24MISS'), 'DD-MON-RR HH:MI:SS PM')
  FROM DUAL;

-- 문제1. EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사 후 6개월이 되는 날짜 조회
-- 문제2. EMPLOYEE 테이블에서 근무 년수가 20년 이상인 직원 조회
-- 문제3. EMPLOYEE 테이블에서 사원명, 입사일, 입사한 월의 근무일수를 조회한다.
-- 단, 주말은 고려하지 않는다.
-- 문제4. 직원 테이블에서 이름, 입사일 조회 입사일에 포맷을 적용하여 조회
-- 포맷 형식은 다음과 같다. 2018년 6월 15일 (수) 형식으로 출력되도록 한다.


-- 문제1. EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사 후 6개월이 되는 날짜 조회
-- 1. EMPLOYEE 테이블에서 가져온다
-- 2. 사원의 이름(EMP_NAME), 입사일(HIRE_DATE), 입사 후 6개월이 되는 날짜를 조회한다.
SELECT
       EMP_NAME,
       HIRE_DATE,
       ADD_MONTHS(HIRE_DATE, 6)
  FROM EMPLOYEE;


-- 문제2. EMPLOYEE 테이블에서 근무 년수가 20년 이상인 직원 조회
-- 1. EMPLOYEE 테이블에서 가져온다
-- 2. 직원을 조회한다.
-- 3. 근무년수가 20년 이상인 직원을 조회한다.
SELECT
       EMP_NAME
  FROM EMPLOYEE
 WHERE (EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE)) >= 20;
-- MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240;


-- 문제3. EMPLOYEE 테이블에서 사원명, 입사일, 입사한 월의 근무일수를 조회한다.
-- 단, 주말은 고려하지 않는다.
-- 1. EMPLOYEE 테이블에서 가져온다
-- 2. 사원명, 입사일, 입사한 월의 근무일수를 조회한다.
-- 3. 주말은 고려하지 않는다.
SELECT
       EMP_NAME AS 사원명,
       HIRE_DATE AS 입사일,
       LAST_DAY(HIRE_DATE)-HIRE_DATE + 1 AS "입사한 월의 근무일수"
  FROM EMPLOYEE;
       

-- 문제4. 직원 테이블에서 이름, 입사일 조회 입사일에 포맷을 적용하여 조회
-- 포맷 형식은 다음과 같다. 2018년 6월 15일(수) 형식으로 출력되도록 한다.
SELECT
       TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일("DY")"') AS 입사일
  FROM EMPLOYEE;



-- TO_NUMBER(문자,[포맷]) : 문자데이터를 숫자로 리턴
SELECT
       TO_NUMBER('123456789')
FROM DUAL;

SELECT '123' + '456' FROM DUAL;
SELECT '123' + '456A' FROM DUAL;        -- 에러발생
SELECT TO_NUMBER('123') + TO_NUMBER('456A') FROM DUAL;  -- 문자는 변형이 안됨
SELECT TO_NUMBER('A') + TO_NUMBER('B') FROM DUAL;  -- 문자는 변형이 안됨

SELECT '1,000,000' + '500,000' FORM DUAL;   -- 에러발생
SELECT
       TO_NUMBER('1,000,000', '99,999,999') + TO_NUMBER('500,000', '999,999')
FROM DUAL;


-- NULL 처리 함수
-- NVL(컬럼명, 컬럼이 NULL인 경우 바꿀 값)
SELECT
       EMP_NAME,
       BONUS,
       NVL(BONUS, 0)
  FROM EMPLOYEE;
-- 자바에서는 INT 자료형에 NULL을 가질 수 없다.


-- NUL2(컬럼명, 바꿀값1, 바꿀값2)
-- 해당 컬럼에 값이 있으면 바꿀값1로 변경, NULL이면 바꿀값 2로 변경
SELECT
       EMP_NAME,
       BONUS,
       NVL2(BONUS, 0.7, 0.5)
  FROM EMPLOYEE;
-- 자바의 3항 연산자와 비슷하다 (조건식) ? 참 : 거짓


-- 선택함수
-- 여러 가지 경우에 선택할 수 있는 기능을 제공한다
-- DECODE(계산식 | 컬럼명, 조건값1, 선택값1, 조건값2, 선택값2, ----)
SELECT
        EMP_ID,
        EMP_NAME,
        EMP_NO,
        DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '여')
   FROM EMPLOYEE;


-- CASE
-- WHEN 조건식 THEN 결과값
-- WHEN 조건식 THEN 결과값
-- ELSE 결과값
-- END
SELECT
       EMP_NAME,
       JOB_CODE,
       SALARY,
       CASE
           WHEN JOB_CODE = 'J7' THEN SALARY * 1.1
           WHEN JOB_CODE = 'J6' THEN SALARY * 1.15
           WHEN JOB_CODE = 'J5' THEN SALARY * 1.2
           ELSE SALARY * 1.05
        END AS 인상급여
  FROM EMPLOYEE;


/*
1번 문제
사번(EMP_ID), 사원명(EMP_NAME), 급여(SALARY)를 EMPLOYEE 테이블에서 조회하고
급여가 500만원 초과이면 '고급'
급여가 300~500만원이면 '중급'
그 이하는 '초급'으로 출력되도록 하고 별칭은 '구분'으로 한다.
*/
SELECT
       EMP_ID,
       EMP_NAME,
       SALARY,
       CASE
           WHEN SALARY>5000000 THEN '고급'
           WHEN (SALARY>=3000000) AND (SALARY<=5000000) THEN '중급'
           ELSE '초급'
        END AS 구분
  FROM EMPLOYEE;


/*
2번 문제
EMPLOYEE 테이블에서 사원명(EMP_NAME), 성별을 구한다.
성별의 조건은 1,3, 남자, 2,4, 여자, 그 외는 외계인으로 처리한다.
*/
SELECT
        EMP_NAME,
        CASE
            WHEN SUBSTR(EMP_NO, 8,1)=1 THEN '남'
            WHEN SUBSTR(EMP_NO, 8,1)=3 THEN '남'
            WHEN SUBSTR(EMP_NO, 8,1)=2 THEN '여'
            WHEN SUBSTR(EMP_NO, 8,1)=4 THEN '여'
            ELSE '외계인'
            END
   FROM EMPLOYEE;


/*
3번 문제
EMPLOYEE 테이블에서 보너스 포인트를 인상한다.
단, 기존에 보너스(BONUS)를 받는 직원은 1.7, 보너스가 없는 직원은 0.5
급여(SALARY), 이름(EMP_NAME)
*/
SELECT
       EMP_NAME,
       BONUS,
       NVL2(BONUS, 1.7, 0.5) AS "보너스 포인트 인상"
  FROM EMPLOYEE;


/*
4번 문제
EMPLOYEE 테이블에서 2000년도 이후에 입사한 사원의
    사번(EMP_ID), 이름(EMP_NAME), 입사일(HIRE_DATE)을 조회한다.
*/
SELECT
       EMP_ID,
       EMP_NAME,
       HIRE_DATE
  FROM EMPLOYEE
 WHERE EXTRACT(YEAR FROM HIRE_DATE) >= 2000;
 
