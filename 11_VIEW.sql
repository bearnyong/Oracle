/* 
VIEW(뷰)
SELECT 쿼리문을 저장한 객체이다.
실질적인 데이터를 저장하고 있지는 않음
테이블을 사용하는 것과 동일하게 사용할 수 있다.
CREATE [OR REPLACE] VIEW 뷰이름 AS 서브쿼리
*/

CREATE TABLE 테이블명
AS
SELECT * FROM EMPLOYEE;

-- 사번, 이름, 직급명, 부서명, 근무지역을 조회하고
-- 그 결과를 V_RESULT_EMP 라는 뷰를 생성해서 저장하세요
CREATE OR REPLACE VIEW V_RESULT_EMP -- 가상의 테이블을 만들어서 저장
AS
SELECT E.EMP_ID,
       E.EMP_NAME,
       J.JOB_NAME,
       D.DEPT_TITLE,
       L.LOCAL_NAME
  FROM EMPLOYEE E
 LEFT JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
 LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
 LEFT JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);

SELECT * FROM V_RESULT_EMP; -- 위에서 가상의 테이블을 만들어 저장했기에 조회를 위한 가상테이블이 됨 (INSERT,...불가능)

UPDATE V_RESULT_EMP
  SET EMP_ID = '100'
 WHERE EMP_ID = '205';
 -- 이렇게 업데이트를 할 경우 원본 테이블인 EMPLOYEE 의 컬럼 값도 변경된다.

SELECT * FROM V_RESULT_EMP WHERE EMP_ID = '100';


-- 데이터 딕셔너리(DATE DICTIONARY)
-- 자원을 효율적으로 관리하기 위해 다양한 정보를 저장하는 시스템 테이블
-- 사용자가 테이블을 생성하거나, 사용자를 변경하는 등의 작업을 할 때
-- 데이터 베이스는 서버에 의해 자동으로 갱신되는 테이블
-- 사용자는 데이터 딕셔너리 내용을 직접 수정하거나 삭제할 수 없다.

-- 원본 테이블을 커스터마이징 해서 보여주는 원본 테이블의 가상 테이블 객체 (VIEW)

-- 3개의 딕셔너리 뷰로 나뉜다.
-- 1. DEBA_XXX : 데이터 베이스 관리자만 접근이 가능한 객체등의 정보조회
-- 2. ALL_XXX : 자신의 계정 _ 권한을 부여받은 ㅈ객체의 정보 조회
-- 3. USER_XXXX : 자신 계정이 소유한 객체등에 관한 정보 조회

-- 뷰에 대한 정보를 확인하는 데이터 딕셔너리
SELECT
*
FROM USER_VIEWS UV;


-- 뷰를 지울 떄
DROP VIEW V_EMP;

-- 베이스 테이블의 정보가 변경되면 VIEW도 같이 변경된다.
COMMIT;

SELECT * FROM V_RESULT_EMP;

UPDATE
       EMPLOYEE E
SET E.EMP_NAME = '차태연'
WHERE E.EMP_ID = '217';

COMMIT;

SELECT * FROM V_RESULT_EMP;

ROLLBACK;

DROP VIEW V_RESULT_EMP;


-- 뷰에 별칭 부여
CREATE OR REPLACE VIEW V_EMP(
사번, 
이름, 
부서
) AS
SELECT E.EMP_ID,
       E.EMP_NAME,
       E.DEPT_CODE
FROM EMPLOYEE E;

SELECT * FROM V_EMP;


-- 뷰의 컬럼에 별칭을 부여할 수 있다.
CREATE OR REPLACE VIEW V_EMPLOYEE(
사번,
이름,
직금,
성별,
근무년수
) AS
SELECT
       E.EMP_ID,
       E.EMP_NAME,
       J.JOB_NAME,
       DECODE(SUBSTR(E.EMP_NO, 8, 1), 1, '남', '여'),
       EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM E.HIRE_DATE)
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);

SELECT * FROM V_EMPLOYEE;


-- DML 명령어로 조작이 불가능한 경우
-- 1. 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
-- 2. 뷰에 포함되지 않은 컬럼 중에서 베이스가 되는 테이블 컬러밍 NOT NULL 제약조건이 지정된 경우
-- 3. 산술표현식으로 정의된 경우
-- 4. JOIN을 이용해 여러 테이블을 연결한 경우
-- 5. DISTINCT 포함한 경우
-- 6. 그룹함수나 GROUP BY 절을 포함한 경우

-- 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우 (오류 케이스 등)
CREATE OR REPLACE VIEW V_JOB2
AS
SELECT J.JOB_CODE
FROM JOB J;

SELECT * FROM V_JOB2;

INSERT
INTO V_JOB2
(
JOB_CODE,
JOB_NAME --위에서 JOB_CODE만 가져왔는데 NAME을 참조하려고 해서 오류
)VALUES(
'J8',
'인턴'
);

UPDATE
V_JOB2 V
SET V.JOB_NAME = '인턴'
WHERE V.JOB_CODE = 'J7';

SELECT * FROM V_JOB2;

DELETE
FROM V_JOB2 V
WHERE V.JOB_CODE = 'J7';  --JOB_CODE를 다른 곳에서 참조하고 있기 때문에 무결성 제약조건 위배..


-- 산술 표현식으로 정의된 경우
CREATE OR REPLACE VIEW EMP_SAL
AS
SELECT 
       E.EMP_ID,
       E.EMP_NAME,
       E.SALARY,
       (E.SALARY + (E.SALARY + NVL(E.BONUS,0))) * 12 연봉
       FROM EMPLOYEE E;

SELECT * FROM EMP_SAL;

INSERT
INTO EMP_SAL(
EMP_ID,
EMP_NAME,
SALARY,
연봉
)VALUES(
'800',
'정지훈',
3000000,
40000000
);

SELECT * FROM EMP_SAL;

DELETE FROM EMP_SAL WHERE 연봉 = 192000003.6;


-- JOIN을 이용해 여러 테이블을 연결한 경우
CREATE OR REPLACE VIEW V_JOINEMP
AS
SELECT
       E.EMP_ID,
       E.EMP_NAME,
       D.DEPT_TITLE  -- 무결성 제약조건 때문에 값을 넣지 못함
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID);

SELECT * FROM V_JOINEMP;

INSERT
INTO V_JOINEMP
(
EMP_ID,
EMP_NAME,
DEPT_TITLE
)
VALUES
(
888,
'조세오',
'인사관리부'
);

UPDATE
       V.JOINEMP V
    SET V.DEPT_TITLE = '인사관리부';


DELETE
FROM V_JOINEMP
WHERE EMP_ID = '201';  --이렇게 삭제하면 원본에 영향을 주게 됨 -EMPLOYEE 테이블에 EMP_ID 201번 행이 삭제된다.


SELECT * FROM EMPLOYEE;

ROLLBACK;


-- ★★ VIEW 옵션
-- OR REPLACE : 기존에 동일한 뷰 이름이 존재하는 경우 덮어쓰고 존재하지 않으면 새로 생성하는 옵션 (좋은 방법 아님 : 모든 뷰의 이름을 알고있어야함)
-- FORCE 옵션 : 서브쿼리에 사용된 테이블이 존재하지 않아도 뷰 생성

-- 서브쿼리에 사용된 테이블이 존재하지 않아도 뷰가 생성됨(컴파일오류와 함께 테이블 생성)
CREATE OR REPLACE FORCE VIEW V_EMP
AS
SELECT TCODE,
       TNAME,
       TCONTENTS
FROM TEST;

SELECT * FROM V_EMP;  --오류가 있다고 출력

-- NOFORCE 옵션 : 서브쿼리에 테이블이 존재해야만 뷰 생성함(기본값)
CREATE OR REPLACE /*NOFORCE*/ VIEW V_EMP2
AS
SELECT TCODE,
       TNAME,
       TCONTENTS
FROM TEST;


-- WITH CHECK 옵션 : 컬럼의 값을 수정하지 못하게 한다.
-- WITH CECK OPTION : 조건절에 사용된 컬럼의 값을 수정하지 못하게 한다.
CREATE OR REPLACE VIEW V_EMP3
AS
SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID = '200'
WITH CHECK OPTION;

UPDATE
       V_EMP3
    SET MANAGER_ID = '900'
WHERE MANAGER_ID = '200';


-- WITH READ ONLY : DML 수행 불가능!!!!!!!
CREATE OR REPLACE VIEW V_DEPT
AS
SELECT *
FROM  DEPARTMENT D
WITH READ ONLY;

DELETE FROM V_DEPT;  --읽기 전용 뷰이기 떄문에 조작 불가능
SELECT * FROM V_DEPT;  --읽기만 가능

