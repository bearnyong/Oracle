-- DDL
-- ALTER : 객체를 수정하는 구문
-- 테이블 객체 수정 : ALTER TABLE 테이블명 수정할 내용;
-- 컬럼 추가 / 변경 / 삭제, 제약조건 추가 / 변경/ 삭제
-- 테이블명 변경, 제약조건 이름 변경

-- 컬럼 추가
SELECT
       DC.*
FROM DEPT_COPY DC;

ALTER TABLE DEPT_COPY
ADD(LNAME VARCHAR2(20));

SELECT * FROM DEPT_COPY;

-- 컬럼 삭제
ALTER TABLE DEPT_COPY
DROP COLUMN LNAME;

SELECT * FROM DEPT_COPY;

-- 컬럼 생성 시 DEFAULT 값 설정
ALTER TABLE DEPT_COPY
ADD (CNAME VARCHAR2(20) DEFAULT '한국');

SELECT * FROM DEPT_COPY;

-- 컬럼에 제약조건 추가
CREATE TABLE DEPT_COPY2
AS
SELECT *
FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2
ADD CONSTRAINT PK_DEPT_ID2 PRIMARY KEY(DEPT_ID);

ALTER TABLE DEPT_COPY2
ADD CONSTRAINT UN_DEPT_TITLE2 UNIQUE(DEPT_TITLE);

ALTER TABLE DEPT_COPY2
MODIFY LOCATION_ID CONSTRAINT NN_LID NOT NULL; 

ALTER TABLE DEPT_COPY2
MODIFY LOCATIO_ID NULL;

-- 컬럼 자료형 수정
ALTER TABLE DEPT_COPY2
MODIFY DEPT_ID CHAR(3)
MODIFY DEPT_TITLE VARCHAR(30)
MODIFY LOCATION_ID VARCHAR(2);

-- DEFUALT 값 변경
ALTER TABLE DEPT_COPY
MODIFY CNAME DEFAULT '미국';

SELECT * FROM DEPT_COPY;

-- 새로 추가할 경우 기본값 '미국'
INSERT
INTO DEPT_COPY
VALUES
(
'DB',
'생산부',
'L2',
DEFAULT
);

SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_TITLE;

SELECT * FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2
DROP COLUMN LOCATION_ID;

SELECT * FROM DEPT_COPY2;


-- 지우려는 테이블에 최소 한 개 이상의 컬럼이 남아 있어야 한다.
ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_ID;

CREATE TABLE TB1
(
PK NUMBER PRIMARY KEY,
FK NUMBER REFERENCES TB1,
COL1 NUMBER,
CHECK(PK>0 AND COL1>0)
);

ALTER TABLE TB1
DROP COLUMN PK;  -- 테이블 삭제가 안되는 이유 : PK랑 FK랑 관계를 맺고 있어서(기본키 참조)

ALTER TABLE TB1
DROP COLUMN PK CASCADE CONSTRAINT;  -- 제약조건 삭제해줘야함 (무결성어쩌고 때문에),,!! CONSTRAINT뒤에 제약조건 이름을 명시해줘야함.. 안그러면 전부 삭제됨!!

SELECT * FROM TB1;


-- 컬럼 삭제
-- 테이블에는 최소 한 개 이상의 컬럼이 존재해야 한다. : 모든 컬럼 삭제는 불가능하다.
-- 데이터가 기록되어 있는 컬럼도 삭제 가능함
-- 삭제된 컬럼은 복구가 안된다.
ALTER TABLE DEPT_COPY
DROP (CNAME, DEPT_TITLE, LOCATION_ID);

SELECT * FROM DEPT_COPY;  -- 두 번 연속 실행 결과 (0.007초 -> 0.001초로) 단축 이유 : 메모리 안의 저장공간에 저장이 되기 때문에 속도가 빨라진다.

ROLLBACK;


CREATE TABLE CONST_EMP(
    ENAME VARCHAR2(20) NOT NULL,
    ENO VARCHAR2(15) NOT NULL,
    MARRIAGE CHAR(1) DEFAULT 'N',
    EID CHAR(2),
    EMAIL VARCHAR2(30),
    JID CHAR(2),
    MID CHAR(3),
    DID CHAR(2),
    CONSTRAINT CK_MARRIAGE CHECK(MARRIAGE IN ('Y', 'N')),
    CONSTRAINT PK_EID PRIMARY KEY(EID),
    CONSTRAINT UN_END UNIQUE (ENO),
    CONSTRAINT UN_EMAIL UNIQUE(EMAIL),
    CONSTRAINT FK_JID FOREIGN KEY (JID) REFERENCES JOB(JOB_CODE) ON DELETE SET NULL,
    CONSTRAINT FK_NID FOREIGN KEY(MID) REFERENCES CONST_EMP ON DELETE SET NULL,
    CONSTRAINT FK_DID FOREIGN KEY(DID) REFERENCES DEPARTMENT ON DELETE CASCADE
);

ALTER TABLE CONST_EMP
DROP CONSTRAINT CK_MARRIAGE;

ALTER TABLE CONST_EMP
DROP CONSTRAINT FK_DID
DROP CONSTRAINT FK_JID
DROP CONSTRAINT FK_MID;

ALTER TABLE CONST_EMP
MODIFY (ENAME NULL, ENO NULL);  --둘 다 NULL 값이 들어갈 수 있게 수정


-- 컬럼 이름 변경
CREATE TABLE DEPT_COPY3
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY3;

ALTER TABLE DEPT_COPY3 RENAME COLUMN DEPT_ID TO DEPT_CODE;

SELECT * FROM DEPT_COPY3;

ALTER TABLE DEPT_COPY3
ADD CONSTRAINT PK_DEPT_CODE3 PRIMARY KEY(DEPT_CODE);

ALTER TABLE DEPT_COPY3
RENAME CONSTRAINT PK_DEPT_CODE3 TO PK_DCODE;

ALTER TABLE DEPT_COPY3
RENAME TO DEPT_TEST;

SELECT * FROM DEPT_TEST;

-- 테이블 삭제
DROP TABLE DEPT_TEST CASCADE CONSTRAINT;