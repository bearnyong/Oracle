/*
조인 (JOIN)
 : 두 개의 테이블을 하나로 합쳐서 결과를 조회한다.
 
오라클 전용 구문
FROM 절에 ' , '로 구분하여 사용할 테이블을 다 기술한다.
WHERE 절에 합치기에 사용할 컬럼을 이용하여 조건을 기술한다.
 
연결에 사용할 두 컬럼명이 다른 경우

--PK : 식별값, FK 포렌키 : 참조하는 키, 프라이머리키(인덱스) : 식별키
*/
 
SELECT
       EMP_ID,
       EMP_NAME,
       DEPT_CODE,
       DEPT_TITLE
 FROM EMPLOYEE, 
      DEPARTMENT    -- EMPLOYEE 테이블과 DEPARTMENT 테이블을 참고하여
 WHERE DEPT_CODE = DEPT_ID;     -- (조건)DEPT_CODE와 DEPT_ID가 같은 정보들


-- 연결에 사용할 두 컬럼명이 같은 경우
SELECT  
       EMPLOYEE.EMP_ID,
       EMPLOYEE.EMP_NAME,
       EMPLOYEE.JOB_CODE,
       JOB.JOB_CODE,
       JOB.JOB_NAME
  FROM EMPLOYEE,
       JOB
 WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;


-- 테이블에 별칭 사용
SELECT
       E.EMP_ID,
       E.EMP_NAME,
       E.JOB_CODE,
       J.JOB_NAME
  FROM EMPLOYEE "E",
       JOB "J"
 WHERE E.JOB_CODE = J.JOB_CODE;


-- ANSI 표준 구문
-- 연결에 사용할 컬럼명이 같은 경우 USING(컬럼명)
SELECT
       EMP_ID,
       EMP_NAME,
       JOB_CODE,
       JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);  --PK : 식별값, FK 포렌키 : 참조하는 키, 프라이머리키(인덱스) : 식별키
-- FK끼리 값이 같으면 묶어줄 수 있다.


-- ★★★ 연결에 사용할 컬럼명이 다른 경우 ON()을 사용
SELECT
       EMP_ID,
       EMP_NAME,
       DEPT_CODE,
       DEPT_TITLE
  FROM EMPLOYEE
 JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
 
 
-- 컬럼명이 같은 경우에도 ON()을 사용할 수 있다.
SELECT
       E.EMP_ID,
       E.EMP_NAME,
       E.JOB_CODE,
       J.JOB_NAME
  FROM EMPLOYEE E
 JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);


-- 부서 테이블과 지역 테이블을 조인하여 테이블의 모든 데이터를 조회한다.
-- ANSI 표준(SQL)
SELECT
       D.*,
       L.*
  FROM DEPARTMENT D
 JOIN LOCATION L ON(L.LOCAL_CODE = D.LOCATION_ID);


-- 
SELECT
       D.*,
       L.*
  FROM DEPARTMENT D,
 LOCATION L
 WHERE D.LOCATION_ID = L.LOCAL_CODE;


/* 조인의 기본이 EQUAL JOIN 이다.(EQU JOIN 이라고도 한다). 등가조인
일치하는 값이 없는 행은 조인에 제외하는 것을 INNER JOIN 이라고 한다 (NULL값은 조인에서 제외)

JOIN의 기본은 INNER JOIN & EQUAL JOIN 이다.
INNER JOIN : 공통된 정보만 가져온다.
OUTER JOIN : 두 테이블의 지정하는 컬럼 값이 일치하지 않는 행도(NULL 값을 가진 행)
조인 결과에 포함시킴 OUTER JOIN을 명시해야 한다.

1. LEFT OUTER JOIN
 : 합치기에 사용한 두 테이블 중 왼편에 기술된 테이블의 행의 수를 기준으로 JOIN
 
2. RIGHT OUTER JOIN
: 합치기에 사용한 두 테이블 중 오른편에 기술된 테이블의 행의 수를 기준으로 JOIN

3. FULL OUTER JOIN
: 합치기에 사용한 두 테이블이 가진 모든 행을 결과에 포함시켜 JOIN

*/

SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM EMPLOYEE
 JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
       
       
-- LEFT PITER JOIN      
-- ANSI 표준
SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM EMPLOYEE
 LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
       
-- 오라클 전용
SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM EMPLOYEE,
       DEPARTMENT
 WHERE DEPT_CODE = DEPT_ID(+);
     
     
-- RIGHT OUTER JOIN
-- ANSI
SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM EMPLOYEE
 RIGHT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 오라클 전용
SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM EMPLOYEE,
       DEPARTMENT
 WHERE DEPT_CODE(+) = DEPT_ID;


-- FULL OUTER JOIN (다 호출됨)
SELECT
       EMP_NAME,
       DEPT_TITLE
FROM EMPLOYEE
FULL OUTER JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-- 오라클
-- 오라클 전용 구문으로는 FULL OUTER JOIN을 할 수 없음
SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM EMPLOYEE
 WHERE DEPT_CODE(+) = DEPT_ID(+);


-- CROSS JOIN : 카테이션 급 조인되는 테이블의 각 해들이 모두 매핑된 데이터가 검색되는 방식
-- 값이 없는 부분을 다 매핑시켜줌..? 잘 사용하지 X 관련 없는 데이터들을 출력할 일이 없음
SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM EMPLOYEE
 CROSS JOIN DEPARTMENT;

-- 오라클 전용구문
SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM EMPLOYEE,
       DEPARTMENT;
       

-- NON FQUAL JOIN(NON EQU JOIN - 비등가 조인)
-- : 지정한 컬럼의 값이 일치하는 경우가 아닌 값의 범위에 포함되는 행들을 연결하는 방식
-- ANSI////////////////////////////////////////////////////
SELECT
       EMP_NAME,
       SALARY,
       E.SAL_LEVEL,
       S.SAL_LEVEL
  FROM EMPLOYEE E
 JOIN SAL_GRADE S ON (SALARY BETWEEN MIM_SAL AND MAX_SAL);

-- 오라클 전용/////////////////////////////////////
SELECT
       EMP_NAME,
       SALARY,
       E.SAL_LEVEL,
       S.SAL_LEVEL
  FROM EMPLOYEE E,
       SAL_GRADE S
 WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;


-- SELF JOIN : 동일한 테이블을 조인하는 것 (자가조인)
-- ANSI
SELECT
       E1.EMP_ID,
       E1.EMP_NAME AS "사원이름",
       E1.DEPT_CODE,
       E1.MANAGER_ID,
       E2.EMP_NAME AS "관리자 이름"
  FROM EMPLOYEE E1
 JOIN EMPLOYEE E2 ON (E1.MANAGER_ID = E2.EMP_ID);

-- 오라클 전용
SELECT
       E1.EMP_ID,
       E1.EMP_NAME AS "사원이름",
       E1.DEPT_CODE,
       E1.MANAGER_ID,
       E2.EMP_NAME AS "관리자 이름"
  FROM EMPLOYEE E1,
       EMPLOYEE E2
 WHERE E1.MANAGER_ID = E2.EMP_ID;


-- 다중 조인 : 여러 개 테이블 조인
-- ANSI
SELECT
       EMP_ID,
       EMP_NAME,
       DEPT_CODE,
       DEPT_TITLE,
       LOCAL_NAME
  FROM EMPLOYEE
 JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
 JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

-- 오라클
SELECT
       EMP_ID,
       EMP_NAME,
       DEPT_CODE,
       DEPT_TITLE,
       LOCAL_NAME
  FROM EMPLOYEE,
       DEPARTMENT,
       LOCATION
 WHERE DEPT_CODE = DEPT_ID
 AND LOCATION_ID = LOCAL_CODE;


-- 연습문제
-- 직급이 대리이면서 아시아 지역에 근무하는 직원조회
-- 사번, 이름, 직급명, 부서명, 근무지역명, 급여를 조회
-- 조회시에는 모든 컬럼에 테이블 별칭을 붙여서 조회한다.

--1. 직급이 대리(JOB - JOB_NAME)이면서 아시아 지역(LOCATION - LOCAL_NAME)에 근무하는 직원조회 (WHERE, AND)
--2. 사번(EMP_ID), 이름(EMP_NAME), 직급명(JOB - JOB_NAME), 부서명(DEPARTMENT - DEPT_TITLE), 근무지역명(LOCATION - LOCAL_NAME), 급여(SALARY) 조회
--3. 컬럼에 데이블 별칭을 붙여서 조회한다. (테이블 별칭 붙이기)

-- ANSI
SELECT
       E.EMP_ID AS 사번,
       E.EMP_NAME AS 이름,
       J.JOB_NAME AS 직급명,
       D.DEPT_TITLE AS 부서명,
       L.LOCAL_NAME AS 근무지역명,
       E.SALARY AS 급여
  FROM EMPLOYEE E
 JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
 JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
 JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
 WHERE J.JOB_NAME = '대리'
 AND (L.LOCAL_NAME = 'ASIA1' OR L.LOCAL_NAME = 'ASIA2' OR L.LOCAL_NAME = 'ASIA3');

-- 오라클
SELECT
       E.EMP_ID AS 사번,
       E.EMP_NAME AS 이름,
       J.JOB_NAME AS 직급명,
       D.DEPT_TITLE AS 부서명,
       L.LOCAL_NAME AS 근무지역명,
       E.SALARY AS 급여
  FROM EMPLOYEE E,
       JOB J,
       DEPARTMENT D,
       LOCATION L
 WHERE E.JOB_CODE = J.JOB_CODE
 AND E.DEPT_CODE = D.DEPT_ID
 AND D.LOCATION_ID = L.LOCAL_CODE
 AND JOB_NAME = '대리'
 AND (L.LOCAL_NAME = 'ASIA1' OR L.LOCAL_NAME = 'ASIA2' OR L.LOCAL_NAME = 'ASIA3');

