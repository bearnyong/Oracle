/*
DDL(CRATE TABLE) 및 제약 조건
DDL (DATA DEFINITION LANGUAGE) : 데이터 정의 언어
객체 (OBJECT)를 만들고 (CREATE), 수정하고(ALTER), 삭제하는(DROP) 구문

테이블 만들기
-- [표현식] : CREATE TABLE 테이블명(컬럼 명 자료형(크기), 컬럼명 자료형(크기),.....)*/

-- 테이블 생성구문
CREATE TABLE MEMBER(
       MEMBER_ID VARCHAR2(20),
       MEMBER_PWD VARCHAR2(20),
       MEMBER_NAME VARCHAR2(20)
);
       
       
-- 컬럼에 주석 달기
-- [표현식] : COMMENT ON COLUMN 테이블명 IS '주석내용';
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원이름';

SELECT
       M.*
FROM MEMBER M;

-- 해당 계정에 생성된 테이블 목록을 보여주는 구문으로 USER_TABLES에 정보가 담겨있음
SELECT
       UT.*
FROM USER_TABLES UT;

SELECT
       UTC.*
FROM USER_TAB_COLUMNS UTC
WHERE UTC.TABLE_NAME = 'MEMBER';

DESC MEMBER;



-- 제약 조건
-- 테이블 정의 시 각 컬럼에 대한 값을 넣을 숙 있는 조건을 설정할 수 있다.
-- 데이터 무결성 보장을 목적으로 한다.
-- PRIMARY KEY(기본키), NOT NULL, UNIQUEM, CHECK(지정값만), FOREIGN KEY(외래키)
-- NOT NULL : 해당 컬럼에 NULL 값을 허용하지 않는 제약조건 컬럼레벨에서 제한

CREATE TABLE USER_NOCNS(
       USER_NO NUMBER,
       USER_ID VARCHAR2(20),
       USER_PWD VARCHAR2(30),
       USER_NAME VARCHAR2(30),
       GENDER VARCHAR2(10),
       PHONE VARCHAR2(30),
       EMAIL VARCHAR2(50)
);


-- 데이터 추가
INSERT
  INTO USER_NOCNS(
  USER_NO, USER_ID, USER_PWD,
  USER_NAME, GENDER, PHONE, EMAIL
)
VALUES(
  1, 'USER01', 'PASS01',
  '홍길동', '남', '010-1234-5344',
  'GONG123@GMAIL.COM'
);

CREATE TABLE USER_NOTNULL(
       USER_NO NUMBER NOT NULL,
       USER_ID VARCHAR2(20) NOT NULL,  --NOT NULL 조건을 가지고 있기 떄문에 NULL 값을 가질 수 없다.
       USER_PWD VARCHAR2(30) NOT NULL,
       USER_NAME VARCHAR2(30) NOT NULL,
       GENDER VARCHAR2(10),
       PHONE VARCHAR2(30),
       EMAIL VARCHAR2(50)
);

INSERT
  INTO USER_NOTNULL(
  USER_NO, USER_ID, USER_PWD,
  USER_NAME, GENDER, PHONE, EMAIL
)
VALUES(
  1, 'USER01', 'PASS01',
  NULL, NULL, '010-1234-5344',
  'GONG123@GMAIL.COM'
);


SELECT
       UN.*
  FROM USER_NOTNULL UN;

SELECT
       UC.*
  FROM USER_CONSTRAINTS UC;

SELECT --컬럼에 대한 제약 조건들
       UCC.*
  FROM USER_CONS_COLUMNS UCC;



/* 
데이터 딕셔너리 조회
데이터 딕셔너리란?
데이터 사전이라고 불린다. (데이터에 의한 데이터 -> 메타데이터)
KKL 구문을 이용해서 데이터의 구조를 정의, 수정, 삭제할 시 자동으로 반영되는 뷰(가상 테이블)
딕셔너리 뷰는 조회만 가능하다.
1. USER_XXX
2. DBA_XXX
3. ALL_XXX
*/

SELECT
       UC.*,
       UCC.*
FROM USER_CONSTRAINST UC
JOIN USER_CONS_COLUMNS UCC ON(UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
WHERE UC.TABLE_NAME = 'USER_NOTNULL';


-- UNIQUE 제약조건
-- 컬럼 입력값에 대해 기존에 존재하는 값과 중복된 값이 들어갈 수 없도록 제한을 거는 제약조건
-- 컬럼레벨에서 설정 가능, 테이블 레벨에서 설정 가능
-- NULL값은 
SELECT
       UN.*
FROM USER_NOCNS UN;

-- 기존 존재하는 값
INSERT
    INTO USER_NOCNS(
      USER_NO, USER_ID, USER_PWD,
      USER_NAME, GENDER, PHONE, EMAIL
    ) VALUES(
      1, 'USER01', 'PASS01',
      '홍길동', '남', '010-2323-2323',
      'GONG123@GMAIL.COM'
);

CREATE TABLE USER_UNIQUE(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) UNIQUE NOT NULL,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

INSERT
    INTO USER_UNIQUE(
      USER_NO, USER_ID, USER_PWD,
      USER_NAME, GENDER, PHONE, EMAIL
    ) VALUES(
      1, 'USER01', 'PASS01',
      '홍길동', '남', '010-2323-2323',
      'GONG123@GMAIL.COM'
);

INSERT
    INTO USER_UNIQUE(
      USER_NO, USER_ID, USER_PWD,
      USER_NAME, GENDER, PHONE, EMAIL
    ) VALUES(
      2, 'USER01', 'PASS01',
      '김길동', '남', '010-2323-2323',
      'GONG123@GMAIL.COM'
);

SELECT
       *
FROM USER_UNIQUE;


SELECT
       UCC.TABLE_NAME,
       UCC.COLUMN_NAME,
       UC.CONSTRAINT_TYPE
  FROM USER_CONSTRAINTS UC,
       USER_CONS_COLUMNS UCC
 WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
 AND UCC.CONSTRAINT_NAME = 'SYS_C008368';


CREATE TABLE USER_UNIQUE2(
  USER_NO NUMBER,
  USER_ID VARCHAR2(20) NOT NULL,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  UNIQUE(USER_ID)
);

CREATE TABLE USER_UNIQUE3(
  USER_NO NUMBER,
  USER_ID VARCHAR2(20) NOT NULL,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  UNIQUE(USER_ID, USER_NO)
);


-- 제약 조건에 이름 설정
CREATE TABLE CONS_NAME(
  TEST_DATA1 VARCHAR2(20) CONSTRAINT NN_TEST_DATA1 NOT NULL,
  TEST_DATA2 VARCHAR2(20) CONSTRAINT UN_TEST_DATA2 UNIQUE,
  TEST_DATA3 VARCHAR2(20),
  CONSTRAINT UN_TEST_DATA3 UNIQUE(TEST_DATA3)
);

-- CHECK 제약 조건
-- 컬럼에 들어가는 값에 비교연산을 이용해 조건을 만족하는 경우에만 값이 들어갈 수 있도록 제한하는 제약 조건
CREATE TABLE USER_CHACK(
  USER_NO NUMBER,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10) CHECK(GENDER IN('남', '여')),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50)
);

INSERT
INTO USER_CHACK(
      USER_NO, USER_ID, USER_PWD,
      USER_NAME, GENDER, PHONE, EMAIL
    ) VALUES(
      1, 'USER01', 'PASS01',
      '홍길동', '남', '010-2323-3434',
      'HONG123@GMAIL.COM'
    );
    
INSERT
INTO USER_CHACK(
      USER_NO, USER_ID, USER_PWD,
      USER_NAME, GENDER, PHONE, EMAIL
    ) VALUES(
      1, 'USER01', 'PASS01',
      '홍길동', '남자', '010-2323-3434',
      'HONG123@GMAIL.COM'
    );



-- 05.17
SELECT 
       UC.TABLE_NAME,
       UCC.COLUMN_NAME,
       UC.CONSTRAINT_NAME,
       UC.CONSTRAINT_TYPE
FROM USER_CONSTRAINTS UC
JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
WHERE UC.CONSTRAINT_NAME = 'PK_USER_NO';


CREATE TABLE USER_PRIMARYKEY2(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    CONSTRAINT PK_USER_NO2 PRIMARY KEY(USER_NO, USER_ID)   --제약조건을 PK_USER_NO2라는 이름으로 생성하여 USER_NO과 USER_ID에 PRIMARY KEY(기본키)
 );
 
 SELECT 
       UC.TABLE_NAME,
       UCC.COLUMN_NAME,
       UC.CONSTRAINT_NAME,
       UC.CONSTRAINT_TYPE
FROM USER_CONSTRAINTS UC
JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
WHERE UC.CONSTRAINT_NAME = 'PK_USER_NO2';


/*
FOREIGN KEY(외래키/ 외부키/ 참조무결성 제약조건) :
참조(REFERENCES)된 다른 테이블에서 제공하는 값만 사용할 수 있음
참조 무결성을 위배하지 않게 하기 위해 사용한다.
FOREIGN KEY 제약조건에 의해서 테이블간의 곤례(RELATIONSHIP)이 형성된다.
제공되는 값 외에는 NULL을 사용할 수 있다.

선행해서 데이더가 들어가야 하는 테이블을 부모테이블
나중에 참조하여 데이터를 넣는 테이블을 자식테이블이라고 한다.

컬럼 레벨인 경우
컬럼명 자료형(크기) [CONSTRAINT 제약 조건 이름] REFERENCES 참조할테이블명[(참조할 컬럼)] [삭제룰]

테이블 레벨인 경우
[CONSTRAINT 이름] FOREIGN KEY (적용할 컬럼명) REFERENCES 참조할테이블명[(참조할 컬럼)] [삭제룰]

참조할 테이블의 참조할 컬러명이 생략되면 PRINAPY KEY로 설정된 컬러미 자동으로 참조할 컬러밍 된다.
참조될 수 있는 커럼은 PRIMARY KEY 컬럼과 UNIQUE 컬럼만 외래키로 참조할 수 있다.
*/

CREATE TABLE USER_GREADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GREADE (GRADE_CODE, GRADE_NAME) VALUES (10, '일반회원');
INSERT INTO USER_GREADE (GRADE_CODE, GRADE_NAME) VALUES (20, '우수회원');
INSERT INTO USER_GREADE (GRADE_CODE, GRADE_NAME) VALUES (30, '특별회원');


SELECT * FROM USER_GREADE;

 COMMIT;  --반영하다
  -- 트랜젝션: 데이터베이스의 상태를 변환 시키는 모든것 
  -- 롤백은 과거로 되돌린다.
  -- 하나의 묶음
  

CREATE TABLE USER_FOREIGNKEY(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER,
    CONSTRAINT FK_GRADE_CODE FOREIGN KEY (GRADE_CODE) REFERENCES USER_GREADE (GRADE_CODE)
    -- 외래키의 제약 조건이름 FK_GRADE_CODE, USER_GREADE (GRADE_CODE)관계를 맺은 다음 REFERENCES(참조)
);
    
INSERT INTO USER_FOREIGNKEY VALUES(1, 'USER01', 'PASS01', '이순신', '남', '010-2323-2323', 'ASDF@GMAIL.COM', 10);
INSERT INTO USER_FOREIGNKEY VALUES(2, 'USER02', 'PASS02', '홍길동', '남', '010-2323-2323', 'ASDF@GMAIL.COM', 20);
INSERT INTO USER_FOREIGNKEY VALUES(3, 'USER03', 'PASS03', '유관순', '여', '010-2323-2323', 'ASDF@GMAIL.COM', 30);
INSERT INTO USER_FOREIGNKEY VALUES(4, 'USER04', 'PASS01', '안중근', '남', '010-2323-2323', 'ASDF@GMAIL.COM', 10);
INSERT INTO USER_FOREIGNKEY VALUES(5, 'USER05', 'PASS01', '임꺽정', '남', '010-2323-2323', 'ASDF@GMAIL.COM', 20);
INSERT INTO USER_FOREIGNKEY VALUES(6, 'USER06', 'PASS01', '강감찬', '남', '010-2323-2323', 'ASDF@GMAIL.COM', NULL);
INSERT INTO USER_FOREIGNKEY VALUES(7, 'USER07', 'PASS01', '강감찬', '남', '010-2323-2323', 'ASDF@GMAIL.COM', 40); --부모키가 없어서 제약조건 오류

COMMIT;

SELECT * FROM USER_FOREIGNKEY;

/*
CONSTRAINT_TYPE
P : PRIMARY KEY
R : FOREIGN KEY
U : UNIQUE
C : CHECK, NOT NULL
무결성 제약 조건은 5개이지만 유형이 4가지로 분류되는 이유는 NOT NULL과 CHECK 제약 조건을 모두 C로 표현하기 떄문이다.
NULL 제약 조건은 칼럼에 NOT NULL 조건을 체크할지 말지를 결정하기 떄문에 CHECK를 나타내는 C로 표현한 것으로 이해하면 된다.

또, 각각의 제약 조건 유형은 제약 조건의 이니셜로 표현되지만 FOREIGN KEY만은 R로 표현되는데
이는 FOREIGN KEY는 참조 무결성을 지켜야하기 떄문에 참조(REFERENCE) 무결성(INTEGRITY)의 이니셜인 R을 FOREIGN KEY의 제약조건유형으로 지정함

무결성 : 데이터의 정확성 일관성을 나타낸다. 즉, 데이터의 결함이 없는 상태, 데이터를 정확하고 일관되게 듀지하는 것을 의미함
무결성 제약 조건 : 데이터베이스의 정확성, 일관성을 보장하기 위해 저장, 삭제, 수정 등을 제약하기 위한 조건을 뜻한다.
주요 목적으로 데이터베이스에 저장된 데이터의 무결성을 보장하고 데이터베이스의 상태를 일관되게 유지하는 것이다.

개체 무결성 : 각 릴레이션의 기본키를 구성하는 속성은 널(NULL) 값이나 중복된 값을 가질 수 없다.
참조 무결성 : 외래키 값은 NULL이거나 참조하는 릴레이션의 기본키 값과 동일해야 한다.
             즉, 각 릴레이션은 참조할 수 없는 외래키 값을 가질 수 없다.

*/

/*제약 조건 찾기*/
SELECT
       UC.TABLE_NAME ,
       UCC.COLUMN_NAME ,
       UC.CONSTRAINT_NAME ,
       UC.CONSTRAINT_TYPE 
  FROM USER_CONSTRAINTS UC
     , USER_CONS_COLUMNS UCC
 WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
   AND UC.CONSTRAINT_NAME = 'FK_GRADE_CODE';

SELECT 
       UF.USER_ID ,
       UF.USER_NAME ,
       UF.GENDER ,
       UF.PHONE ,
       UG.GRADE_NAME
  FROM USER_FOREIGNKEY UF
 NATURAL LEFT JOIN USER_GREADE UG;
 
-- 삭제 옵션
-- : 부모 테이블의 데이터 삭제 시 자식 테이블의 데이터를 어떤 식으로 처리할 지에 대한 내용을 설정하는 옵션
-- ON DELETE RESTRICT : 참조되고 있는 값 삭제 불가(기본값)
-- ON DELETE SET NULL  : 참조하고 있는 행 상세 시 참조하는 컬럼을 NULL로 변경
-- ON DELETE CASCADE : 참고하고 있는 행 삭제 시 참조하는 컬럼을 가진 행 삭제

COMMIT;

DELETE 
  FROM USER_GREADE 
 WHERE GRADE_CODE = 10;  -- 자식이 있어서 삭제할 수 없다.

DELETE 
  FROM USER_GREADE 
 WHERE GRADE_CODE = 20;  -- 자식이 있어서 삭제할 수 없다.


SELECT 
       UG.*
  FROM USER_GREADE UG;  -- 그래서 값이 그래도임
  
  
ROLLBACK;


CREATE TABLE USER_GRADE2(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE2 VALUES(10, '일반회원');
INSERT INTO USER_GRADE2 VALUES(20, '우수회원');
INSERT INTO USER_GRADE2 VALUES(30, '특별회원');

SELECT  * FROM USER_GRADE2;

CREATE TABLE USER_FOREIGNKEY2(
 USER_NO NUMBER PRIMARY KEY,
 USER_ID VARCHAR2(20) UNIQUE,
 USER_PWD VARCHAR2(30) NOT NULL,
 USER_NAME VARCHAR2(30),
 GENDER VARCHAR2(10),
 PHONE VARCHAR2(30),
 EMAIL VARCHAR2(50),
 GRADE_CODE NUMBER,
 CONSTRAINT FK_GRADE_CODE2 FOREIGN KEY (GRADE_CODE)
 REFERENCES USER_GRADE2 (GRADE_CODE) ON DELETE SET NULL
);

INSERT INTO USER_FOREIGNKEY2 VALUES(1,'USER01', 'PASS01', '홍길동', '남', '010-3223-2323', 'HONE@GMAIL.COM', 10);
INSERT INTO USER_FOREIGNKEY2 VALUES(2,'USER02', 'PASS01', '길동', '남', '010-3223-2323', 'NE@GMAIL.COM', 10);
INSERT INTO USER_FOREIGNKEY2 VALUES(3,'USER03', 'PASS01', '동', '남', '010-3223-2323', 'ONE@GMAIL.COM', 10);

SELECT * FROM USER_FOREIGNKEY2;

DELETE FROM USER_GRADE2 WHERE GRADE_CODE = 10;  -- 부모테이블에 있는 GRADE_CODE 10을 삭제함

SELECT * FROM USER_FOREIGNKEY2; -- GRADE_CODE코드 확인하면 NULL값 확인

-- ON DELETE CASCADE
CREATE TABLE USER_GRADE3(
  GRADE_CODE NUMBER PRIMARY KEY,
  GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE3 VALUES(10, '일반회원');
INSERT INTO USER_GRADE3 VALUES(20, '우수회원');
INSERT INTO USER_GRADE3 VALUES(30, '특별회원');

SELECT * FROM USER_GRADE3;

CREATE TABLE USER_FOREIGNKEY3(
 USER_NO NUMBER PRIMARY KEY,
 USER_ID VARCHAR2(20) UNIQUE,
 USER_PWD VARCHAR2(30) NOT NULL,
 USER_NAME VARCHAR2(30),
 GENDER VARCHAR2(10),
 PHONE VARCHAR2(30),
 EMAIL VARCHAR2(50),
 GRADE_CODE NUMBER,
 CONSTRAINT FK_GRADE_CODE3 FOREIGN KEY (GRADE_CODE)
 REFERENCES USER_GRADE3 (GRADE_CODE) ON DELETE CASCADE
);

INSERT INTO USER_FOREIGNKEY3 VALUES(1,'USER01', 'PASS01', '홍길동', '남', '010-3223-2323', 'HONE@GMAIL.COM', 10);
INSERT INTO USER_FOREIGNKEY3 VALUES(2,'USER02', 'PASS01', '길동', '남', '010-3223-2323', 'NE@GMAIL.COM', 20);
INSERT INTO USER_FOREIGNKEY3 VALUES(3,'USER03', 'PASS01', '동', '남', '010-3223-2323', 'ONE@GMAIL.COM', 30);

SELECT * FROM USER_FOREIGNKEY3;

DELETE FROM USER_GRADE3 WHERE GRADE_CODE =10;  -- 부모테이블에 있는 GRADE_CODE 10을 삭제함

SELECT * FROM USER_FOREIGNKEY3; -- (1,'USER01', 'PASS01', '홍길동', '남', '010-3223-2323', 'HONE@GMAIL.COM', 10); 이 삭제됨... 



CREATE TABLE EMPLOYEE_COPY
AS
SELECT E.*
  FROM EMPLOYEE E;

SELECT * FROM EMPLOYEE_COPY;

--제약조건 추가
/*
ALTER TABLE 테이블명 ADD PRIMARY KEY (컬럼명);
ALTER TABLE 테이블명 ADD FOREIGN KEY (컬럼명) REFERENCES 테이블 (컬럼명);
ALTER TABLE 테이블명 ADD UNIQUE (컬럼명);
ALTER TABLE 테이블명 ADD MODIFY 컬럼명 [NOT] NULL;
*/

ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY(EMP_ID);
ALTER TABLE EMPLOYEE_COPY MODIFY EMP_NAME NULL; --NOT NULL에서 NULL로 제약조건 변경

ALTER TABLE DEPARTMENT ADD PRIMARY KEY(DEPT_ID);


-- 실습
-- EMPLOYEE 테이블의 DEPT_CODE에 외래키 제약조건 추가
-- 참조 테이블은 DEPARTMENT, 참조할 컬럼은 DEPARTMENT의 기본키
ALTER TABLE EMPLOYEE ADD FOREIGN KEY (DEPT_CODE) REFERENCES DEPARTMENT (DEPT_ID);

-- DEPARTMENT 테이블의 LOCATION_ID에 외래키 제약조건 추가
-- 참조 테이블은 LOCATION, 참조 컬럼은 LOCATION의 기본키
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION (LOCAL_CODE);

-- EMPLOYEE 테이블의 JOB_CODE에 외래키 제약조건 추가
-- 참조 테이블은 JOB 테이블, 참조 컬럼은 JOB 테이블의 기본키
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB (JOB_CODE);

-- EMPLOYEE 테이블의 SAL_LEVEL에 외래키 제약조건 추가
-- 참조 테이블은 SAL_GRADE 테이블, 참조 컬럼은 SAL_GRADE 테이블의 기본키
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(SAL_LEVEL) REFERENCES SAL_GRADE (SAL_LEVEL);

-- EMPLOYEE 테이블의 ENT_YN 컬럼에 CHECK제약조건 추가 ('Y', 'N')
-- 단, 대소문자를 구분하기 때문에 대문자로 설정할 것
ALTER TABLE EMPLOYEE ADD CHECK(ENT_YN IN('Y','N'));

-- EMPLOYEE 테이블의 SALARY 컬럼에 CHECK제약조건 추가(양수)
ALTER TABLE EMPLOYEE ADD CHECK (SALARY>0);

-- EMPLOYEE 테이블의 EMP_NO 컬럼에 UNIQUE 제약조건 추가
ALTER TABLE EMPLOYEE ADD UNIQUE (EMP_NO);
