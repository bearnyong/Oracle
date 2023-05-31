-- GROUP BY(조회 결과를 그룹으로 묶을 때)와 HAVING 그리고 ORDER BY(정렬할 때 쓰는 함수)
/*
5 : SELECT 컬럼명 AS 별칭, 계산식, 함수식
1 : FROM 참조할 테이블명
2 : WHERE 행을 식별하기 위한 조건식
3 : GROUP BY 그룹을 묶을 컬럼명
4 : HAVING 그룹을 식별하기 위한 조건식
6 : ORDER BY 컬럼명|별칭|컬럼순번 정렬방식([ASC--오름차순]|DESC--내림차순) [NULLS FIRST | LAST]
*/

SELECT                      --3
       DEPT_CODE,
       COUNT(*) AS "사원수"
  FROM EMPLOYEE             --1
 GROUP BY DEPT_CODE         --2 
 ORDER BY DEPT_CODE ASC;    --4 부서 코드의 오름차순(ASC)으로 정렬한다.

SELECT COUNT(8) FROM EMPLOYEE;

SELECT
       DEPT_CODE
  FROM EMPLOYEE
 ORDER BY DEPT_CODE ASC;
-- D1 : 3, D2 : 3, D5 : 6, D6 : 3, D8 : 3, D9 : 3, NULL :2


SELECT
       DEPT_CODE,
       JOB_CODE,
       SUM(SALARY),
       COUNT(*)
  FROM EMPLOYEE
 GROUP BY DEPT_CODE,
          JOB_CODE
 ORDER BY 1;        -- 내림차순으로 정렬(기준이 없으니 첫번째 조회값 DEPT_CODE을 기준으로 내림차순 정렬한다)
 

-- 직원 테이블에서 보너스를 받는 직원들의 직급코드, 사원 수를 조회하여
-- 직급코드 순으로 오름차순 정렬하세요
SELECT
       JOB_CODE,
       COUNT(*)
  FROM EMPLOYEE
 WHERE BONUS IS NOT NULL
 GROUP BY JOB_CODE
 ORDER BY JOB_CODE;


-- 직원 테이블에서 주민번호의 8번쨰 자리를 조회하여
-- 1이면 남, 2이면 여 로 결과를 조회하고
-- 성별, 성별 급여 평균(정수처리) , 급여 합계, 인원수를 조회한뒤
-- 인원수로 내림차순 정렬한다.
SELECT
       DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') AS "성별",
       FLOOR(AVG(SALARY)) AS "평균",
       SUM(SALARY) AS "합계",
       COUNT(8) AS "인원수"
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1),'1', '남', '2', '여')
ORDER BY 인원수 DESC;      -- 별칭 기준으로 정렬이 가능하다.



-- HAVING : 그룹에 대한 조건을 설정할 때 사용한다.
-- 평균 급여를 300만원을 초과해서 받는 부서의 부서코드와 급여 평균을 조회
SELECT
       DEPT_CODE,
       FLOOR(AVG(SALARY)) AS "급여"
  FROM EMPLOYEE
 WHERE SALARY > 3000000
 GROUP BY DEPT_CODE
 ORDER BY 1;
-- 단일 오류


-- 부서별 그룹의 급여 합계가 9백만원을 초과하는 부서의 부서코드와 급여 합계 조회
SELECT
       DEPT_CODE,
       SUM(SALARY) AS "합계"
  FROM EMPLOYEE
 GROUP BY DEPT_CODE
 HAVING SUM(SALARY) > 9000000;


SELECT
       DEPT_CODE,
       SUM(SALARY)
  FROM EMPLOYEE
 GROUP BY DEPT_CODE
 HAVING SUM(SALARY) = 17700000;


SELECT
       DEPT_CODE,
       SUM(SALARY)
  FROM EMPLOYEE
 GROUP BY DEPT_CODE
 HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                        GROUP BY DEPT_CODE);
       

-- 집계 함수
-- ROLLUP 함수 : 그룹별로 중간 집계 처리를 하는 함수로 GROUP BY절에서만 사용한다.
SELECT
       JOB_CODE,
       SUM(SALARY)
  FROM EMPLOYEE
 GROUP BY ROLLUP(JOB_CODE)
 ORDER BY 1;



-- CUBE 함수 : 그룹별 산출한 결과를 집계하는 함수이다. ROLLUP과 비슷하게 사용한다.
SELECT
      JOB_CODE,
      SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE)
ORDER BY 1;


SELECT
       DEPT_CODE,
       JOB_CODE,
       SUM(SALARY)
  FROM EMPLOYEE
 GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
 ORDER BY 1;
 
 SELECT
       DEPT_CODE,
       JOB_CODE,
       SUM(SALARY)
  FROM EMPLOYEE
 GROUP BY CUBE(DEPT_CODE, JOB_CODE)
 ORDER BY 1;


-- GROUPING 함수 : ROLLUP 이나 CUBE에 의한 산출물이 
-- 인자로 전달받은 컬럼 집합의 산출물이면 0을 반환하고, 아니면 1을 반환하는 함수
SELECT
       DEPT_CODE,
       JOB_CODE,
       SUM(SALARY),
       GROUPING(DEPT_CODE) "부서별 그룹 묶인 상태",
       GROUPING(JOB_CODE) "부서별 그룹 묶인 상태"
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;


SELECT
       DEPT_CODE,
       JOB_CODE,
       SUM(SALARY),
       CASE
         WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) =1 THEN '부서별 합계'
         WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE) =0 THEN '직급별 합계'
         WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) =0 THEN '부서,직급별 합계'
         ELSE '총합계'
        END AS "구분"
  FROM EMPLOYEE
 GROUP BY CUBE(DEPT_CODE, JOB_CODE)
 ORDER BY 1;



-- SET OPERATION(집합연산)
-- UNION : 여거 개의 쿼리 결과를 하나로 합치는 연산자이다. 중복된 영역을 제외하여 하나로 합친다.
SELECT
       EMP_ID,
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D5'
 UNION
SELECT
       EMP_ID,
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM EMPLOYEE
 WHERE SALARY > 3000000;


-- DUNION ALL : 여러 개의 쿼리 결과를 하나로 합치는 연산자 UNION과의 차이점은 중복 영역을 모두 포함시킨다는 점이다.
SELECT
       EMP_ID,
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM EMPLOYEE
 WHERE DEPT_cODE = 'D5'
 UNION
  ALL
SELECT
       EMP_ID,
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM EMPLOYEE
 WHERE SALARY > 3000000;      


-- INTERRECT : 여러 개의 SELECT 한 결과에서 공통 부분만 결과로 추출 수학에서의 교집합과 비슷하다.
SELECT
       EMP_ID,
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM EMPLOYEE
  WHERE DEPT_CODE = 'D5'
  INTERSECT
  SELECT
       EMP_ID,
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM EMPLOYEE
  WHERE SALARY > 3000000;
  
  
  -- MINUS : 선형 SELECT 결과에서 후행 SELECT 결과와 겹치는 부분을 제외한 나머지만 추출 수학의 차집합
  SELECT
       EMP_ID,
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM EMPLOYEE
  WHERE DEPT_CODE = 'D5'
  MINUS
  SELECT
       EMP_ID,
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM EMPLOYEE
  WHERE SALARY > 3000000;
  

