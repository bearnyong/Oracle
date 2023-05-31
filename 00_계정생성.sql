-- 한 줄 주석
/* 여러 줄 주석 */

/* 계정 생성과 같은 명령어는 권한을 가져야 한다.*/

-- [계정 생성]
-- CREATE USER C##EMPLOYEE IDENTIFIED BY EMPLOYEE;
-- C##EMPLOYEE라는 유저를 추가하고 비밀번호는 EMPLOYEE로 하겠다.
-- C##이 붙어있는 이유? CDB를 식별해주기 위해서? (오라클 특성)

-- [권한 승인]
-- GRANT RESOURCE, CONNECT TO C##EMPLOYEE;
-- 해당 사용자가 데이터베이스에 접근할 수 있는 권한을 주기 위해 CONNECT를 작성한다.
-- 인덱스, 뷰, 트리거 같은 데이터베이스 엔진에서 만들 수 있는 권한을 담아놓는.. RESOURCE?

/* F9를 누르면 한 번에 실행되기에 중복 실행이 되지 않도록 한 줄씩 실행시켜야 한다.? */

-- [엑세스를 했을 때 발생하는 용량 제어]
-- ALTER USER C##EMPLOYEE QUOTA UNLIMITED ON SYSTEM;
-- ALTER USER C##EMPLOYEE QUOTA UNLIMITED ON USERS;
-- SYSTEM과 USERS의 용량 제한을 없앤다.

/* 이 페이지는 DBA 영역이기 때문에 몰라도 됨... */
