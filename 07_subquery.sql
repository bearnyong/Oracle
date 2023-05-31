/* SUBQUERY (서브쿼리)*/

-- 사원명이 노옹철인 사람의 부서 조회
SELECT 
       E.DEPT_CODE
  FROM EMPLOYEE E
 WHERE E.EMP_NAME = '노옹철';


-- 부서코드가 노옹철 사원과 같은 소속의 직원 명단 조회
-- JOIN응 이용해서 문제를 접근하려고 했으나 문제가 발생됨...
SELECT --DISTINCT
       E.DEPT_CODE,
       E2.EMP_NAME
  FROM EMPLOYEE E
  JOIN EMPLOYEE E2 ON (E.DEPT_CODE = E2.DEPT_CODE)
 WHERE E.DEPT_CODE = 'D9';

-- 이를 해결하고자 서브 쿼리를 이용함
SELECT
       E.EMP_NAME
  FROM EMPLOYEE E
 WHERE E.DEPT_CODE = (SELECT E2.DEPT_CODE
                      FROM EMPLOYEE E2
                      WHERE E2.EMP_NAME = '노옹철');


-- 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의
-- 사번, 이름, 직급코드, 급여를 조회하세요.
-- 1. 전 직원의 급여를 조회한다. EMPLOYEE (SUBQUERY)
-- 2. 급여 평균을 구한다. AVG(SALARY) (SUBQUERY)
-- 3. 평균보다 많은 급여를 받는 직원을 조회한다.  WHERER.E.SALARY > (1~2 조건)
-- 4. 사번, 이름, 직급코드, 급여를 조회한다.
SELECT
       E.EMP_ID,
       E.EMP_NAME,
       E.JOB_CODE,
       E.SALARY
  FROM EMPLOYEE E
 WHERE E.SALARY > (SELECT
                   FLOOR(AVG(E2.SALARY))
                   FROM EMPLOYEE E2);


-- 서브쿼리의 유형
-- 단일행 서브쿼리 : 쿼리 결과가 단일행만을 리턴하는 서브쿼리
-- 다중행 서브쿼리 : 쿼리 결과가 다중행을 리턴하는 서브쿼리
-- 다중열 서브쿼리 : 쿼리 결과가 다중 컬럼을 리턴하는 서브쿼리
-- 다중행 다중열 서브쿼리
-- 인라인 뷰 : 뷰 형태로 테이블을 리턴하는 서브쿼리 (FROM절)

-- 서브쿼리 유형에 다라 서브쿼리 앞에 붙는 연산자가 다르다.
-- 단일행 서브쿼리 앞에는 일반 비교 연산자 사용 가능
-- > , < , >= , <= , = , !=/<>/^=

-- 노옹철 사원의 급여보다 많은 급여를 받는 직원의
-- 사번, 이름, 부서, 직급, 급여를 조회하세요
-- 1. 노옹철 사원의 급여를 조회해본다...
-- 2. 
SELECT
       E.EMP_ID,
       E.EMP_NAME,
       E.DEPT_CODE,
       E.JOB_CODE,
       E.SALARY
FROM EMPLOYEE E
WHERE E.SALARY > (SELECT E1.SALARY
                  FROM EMPLOYEE E1
                  WHERE E1.EMP_NAME = '노옹철');


-- 서브쿼리는 SELECT, FROM, WHERE, ORDER BY 절에서 사용이 가능하다
-- 부서별 급여의 합계 중 가장 큰 부서의 부서명 급여 합계를 구한다.
SELECT
       D.DEPT_TITLE,
       SUM(E.SALARY)
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
GROUP BY D.DEPT_TITLE
HAVING SUM(E.SALARY) = (SELECT MAX(SUM(E2.SALARY))
                          FROM EMPLOYEE E2
                          GROUP BY DEPT_CODE);
                          
                          
-- 대리 직급의 직원들 중 과장 직급의 최소 급여보다 많이 받는 직원의
-- 사번, 이름, 직급명, 급여를 조회하세요.
-- 1. 대리 직급의 직원들
-- 2. 과장 직급의 최소급여 (가장 적은 급여??) --셀렉트문이 2번 들어가네? (=서브쿼리)
-- 3. 대리 직급의 직원 급여 > 과장 직급의 최소급여 (가장 적은 급여??)
-- 4. 사번(EMP_ID), 이름(EMP_NAME), 직급명(JOB - JOB_NAME), 급여(SALARY)
SELECT
       E.EMP_ID,
       E.EMP_NAME,
       J.JOB_NAME,
       E.SALARY
  FROM EMPLOYEE E
  JOIN JOB J ON(J.JOB_CODE = E.JOB_CODE)
 WHERE J.JOB_NAME = '대리'
 AND E.SALARY > (SELECT
                 MIN(E1.SALARY)
                 FROM EMPLOYEE E1
                 JOIN JOB J1 ON(J1.JOB_CODE = E1.JOB_CODE)
                 WHERE J1.JOB_NAME = '과장');


-- 차장 직급의 급여의 가장 큰 값보다 많이 받는 과장 직급의
-- 사번, 이름, 직급, 급여를 조회한다.
-- 단, > ALL 혹은 < ALL 연산자를 이용한다.
SELECT
       E.EMP_ID,
       E.EMP_NAME,
       J.JOB_NAME,
       E.SALARY
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE J.JOB_NAME = '과장'
AND E.SALARY > ALL (SELECT E2.SALARY
                    FROM EMPLOYEE E2
                    JOIN JOB J2 ON (E2.JOB_CODE = J2.JOB_CODE)
                    WHERE J2.JOB_NAME = '차장' );
                    

SELECT
       E.*
  FROM EMPLOYEE E
 WHERE EXISTS (SELECT
                      E2.*
                 FROM EMPLOYEE E2
                  WHERE E2.EMP_ID = '200'); -- 이값이 존재하면 전체 데이터 다 가져와라 (연산결과는 TRUE, FALSE로 나온다)


-- 자기 직급의 평균급여를 받고 있는 직원의
-- 사번, 이름, 직급코드, 급여를 조회한다.
-- 단, 급여와 평균은 만원단위로 계한한다. (TRUNC(컬럼명, -5)
-- 1. 각 직급의 평균 급여를 구한다. AVG(SALARY)
-- 2. 평균 급여를 받는 직원을 조회한다.
-- 3. 급여와 평균은 만원단위로 계산하낟.
-- 4. 사번(EMP_ID), 이름(EMP_NAME), 직급명(JOB_CODE), 급여(SALARY)
SELECT
       E.EMP_ID,
       E.EMP_NAME,
       E.JOB_CODE,
       E.SALARY
FROM EMPLOYEE E
WHERE E.SALARY IN(SELECT TRUNC(AVG(E2.SALARY),-5)  --직급에 대한 평균을 구하는 코드 (IN : E.SALARY안에 저 IN()에 대한 정보가 들어있어?)
                    FROM EMPLOYEE E2
                   GROUP BY E2.JOB_CODE);


-- 퇴사한 여직원과 같은 부서, 같은 직급에 해당하는 사원의
-- 이름, 직급, 부서코드, 입사일
-- 1. 퇴사한 여직원 (재직여부, 성별)
-- 2. 퇴사한 여직원의 부서, 직급
-- 3. 사원에 대한 정보

SELECT
       E.EMP_NAME,
       E.JOB_CODE,
       E.DEPT_CODE,
       E.HIRE_DATE
  FROM EMPLOYEE E
 WHERE (E.DEPT_CODE, E.JOB_CODE) IN (SELECT E2.DEPT_CODE, E2.JOB_CODE
                                       FROM EMPLOYEE E2
                                      WHERE SUBSTR(E2.EMP_NO, 8, 1) = '2'
                                      AND E2.ENT_YN = 'Y')
 AND E.ENT_YN = 'N';


-- FROM 절에 서브쿼리를 사용할 수 있다 (인라인 뷰)
-- 인라인 뷰(INLINE VIEW)
SELECT
       E.EMP_NAME,
       J.JOB_NAME,
       E.SALARY
  FROM (SELECT E2.JOB_CODE,
               TRUNC(AVG(E2.SALARY),-5) AS JOBAVG
          FROM EMPLOYEE E2
         GROUP BY E2.JOB_CODE) V
  JOIN EMPLOYEE E ON(V.JOBAVG = E.SALARY AND E.JOB_CODE = V.JOB_CODE)
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
 ORDER BY J.JOB_NAME;


SELECT
       V.JOBAVG
  FROM (SELECT E2.JOB_CODE,
               TRUNC(AVG(E2.SALARY), -5) AS JOBAVG
                 FROM EMPLOYEE E2
                GROUP BY E2.JOB_CODE) V;


SELECT
       V.직원명,
       V.부서명,
       V.직급이름
FROM (SELECT
             E.EMP_NAME AS "직원명",
             D.DEPT_TITLE AS "부서명",
             J.JOB_NAME AS "직급이름"
        FROM EMPLOYEE E
        LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
        JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)) V
       WHERE V.부서명 = '인사관리부';


-- 인라인뷰를 활용한 TOP-N 분석
-- 가상의 컬럼을 이용하여 식별하기 위한 값을 넣어준다.
SELECT
       ROWNUM, -- 가상의 컬럼
       E.EMP_NAME,
       E.SALARY
FROM EMPLOYEE E
ORDER BY ROWNUM ASC;

SELECT
       ROWNUM,
       V.EMP_NAME,
       V.SALARY
  FROM (SELECT E.*
          FROM EMPLOYEE E
         ORDER BY E.SALARY DESC) V
 WHERE ROWNUM <= 5;


SELECT
       V2.RNUM,
       V2.EMP_NAME,
       V2.SALARY
  FROM (SELECT ROWNUM RNUM,
               V.EMP_NAME,
               V.SALARY
          FROM (SELECT E.EMP_NAME,
                       E.SALARY
                  FROM EMPLOYEE E
                 ORDER BY E.SALARY DESC ) V
        ) V2
 WHERE RNUM BETWEEN 6 AND 10;
 
-- 급여 평균 3위 안에 드는 부서의
-- 부서코드(DEPT_CODE), 부서명(DEPT_TITLE), 평균급여(AVG(SALARY))를 조회하세요.
-- 1. 부서 (DEPT_TITLE) 조회
-- 2. 급여 평균 3위 안에 드는 부서 조회
SELECT
       V.DEPT_CODE,
       V.DEPT_TITLE,
       V.평균급여
  FROM (SELECT
             E.DEPT_CODE,
             D.DEPT_TITLE,
             AVG(SALARY) 평균급여
         FROM EMPLOYEE E
        JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
        GROUP BY E.DEPT_CODE, D.DEPT_TITLE
        ORDER BY AVG(E.SALARY) DESC) V
WHERE ROWNUM <= 3;

-- 1. 평균 급여 구하기
SELECT
       DEPT_CODE,
       AVG(SALARY) 평균급여
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY AVG(SALARY) DESC;

-- 2. 평균 3위 안에 있는 부서 구하기
SELECT
       V.DEPT_CODE,
       D.DEPT_TITLE,
       V.평균급여
FROM ( --1.평균 급여 구하기
SELECT
       DEPT_CODE,
       AVG(SALARY) 평균급여
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY AVG(SALARY) DESC
) V
JOIN DEPARTMENT D ON (V.DEPT_CODE = D.DEPT_ID)
WHERE ROWNUM <= 3;


-- RANK() : 동일한 순위 이후의 등수를 동일한 인원수 만큼 건너뛰고 순위를 계산하는 방식
-- DENSE_RANK() : 중복되는 순위 이후의 등수를 이후 등수로 처리하는 방식
SELECT
       E.EMP_NAME,
       E.SALARY,
       RANK() OVER(ORDER BY SALARY DESC) 순위
FROM EMPLOYEE E;

SELECT
       E.EMP_NAME,
       E.SALARY,
       DENSE_RANK() OVER(ORDER BY E.SALARY DESC) 순위
FROM EMPLOYEE E;

SELECT
       V.*
FROM (SELECT
              E.EMP_NAME,
              E.SALARY,
              RANK() OVER(ORDER BY E.SALARY DESC) 순위
        FROM EMPLOYEE E) V
WHERE V.순위 BETWEEN 10 AND 19;


-- 상[호연]관 서브쿼리
-- 메인쿼리의 값이 변경되는거에 따라 서브쿼리에 영향을 미치고
-- 서브쿼리가 만들어진 값을 메인쿼리가 사용하는 상호 연관되어 있는 서브쿼리
SELECT
       E.EMP_ID,
       E.EMP_NAME,
       E.DEPT_CODE,
       E.MANAGER_ID
  FROM EMPLOYEE E
 WHERE EXISTS(SELECT E2.EMP_ID
                FROM EMPLOYEE E2
               WHERE E.MANAGER_ID = E2.EMP_ID);


-- 스칼라 서브쿼리
-- 단일행 서브쿼리 + 상관쿼리

-- 동일한 직급의 평균 급여보다 급여를 많이 받고 있는 직원의 정보 조회
SELECT
       E.EMP_NAME,
       E.JOB_CODE,
       E.SALARY
  FROM EMPLOYEE E
 WHERE E.SALARY > (SELECT TRUNC(AVG(E2.SALARY), -5)
                     FROM EMPLOYEE E2
                    WHERE E.JOB_CODE = E2.JOB_CODE);


-- SELECT 절에서 스칼라 서브쿼리 이용
-- 모든 사원의 사번, 이름, 관리자사번, 관리자명 조회
SELECT
       E.EMP_ID,
       E.EMP_NAME,
       E.MANAGER_ID,
       NVL((SELECT E2.EMP_NAME
              FROM EMPLOYEE E2
             WHERE E.MANAGER_ID = E2.EMP_ID), '없음')
  FROM EMPLOYEE E
 ORDER BY 1;


-- ORDER BY 절에서 스칼라 서브쿼리 이용
-- 모든 직원의 사번(EMP_ID), 이름(EMP_NAME), 소속부서(DEPARTMENT - DEPT_TITLE) 조회
-- 단, 부서명(DEPT_TITLE) 내림차순정렬
SELECT
       E.EMP_ID,
       E.EMP_NAME,
       E.DEPT_CODE
FROM EMPLOYEE E
ORDER BY (SELECT D.DEPT_TITLE
          FROM DEPARTMENT D
          WHERE D.DEPT_ID = E.DEPT_CODE) DESC;
          
          
-- ORDER BY 절에서 스칼라 서브쿼리 이용
-- 모든 직원의 사번(EMP_ID), 이름(EMP_NAME), 소속부서(DEPT_CODE) 조회
-- 단, 부서지역명(LOCATION - LOCAL_NAME) 내림차순정렬
SELECT
       E.EMP_ID,
       E.EMP_NAME,
       E.DEPT_CODE
FROM EMPLOYEE E
ORDER BY (SELECT L.LOCAL_NAME
          FROM LOCATION L
          JOIN DEPARTMENT D ON(D.LOCATION_ID = L.LOCAL_CODE)
          WHERE D.DEPT_ID = E.DEPT_CODE) DESC;


/* ★★★★ 회사에서 매니저 활동 중인 직원들에게 추가 보너스  0.5%를 지급하고자 한다.
조회는 다음과 같다.
1. 사원 아이디
2. 사원 이름
3. 관리 직원수
4. 인상된 보너스
단, 관리직원이 없는 직원은 제외된다.
정렬은 관리직원이 많은 순서로 정렬한다.
*/
-- 매니저 활동 중인 직원들을 조회한다. MANAGER_ID가 있으면 활동중인거겠지?...
SELECT
       COUNT(*)
  FROM EMPLOYEE E
 WHERE (SELECT E.MANAGER_ID
          FROM EMPLOYEE E
         WHERE EXISTS(SELECT COUNT(*)
                        FROM EMPLOYEE E2
                       WHERE E.MANAGER_ID = E2.EMP_ID))
GROUP BY MANAGER_ID;


-- 추가 보너스 0.5%를 준다..?
-- 해당 사원의 아이디(EMP_ID), 이름(EMP_NAME), 관리 직원수(COUNT?), 인상된 보너스(SALARY*0.5)
       
-- 매니저 활동 중인 직원들만 출력한다.

