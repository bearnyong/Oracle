-- https://school.programmers.co.kr/learn/courses/30/lessons/164671

/*
<USED_GOODS_BOARD> 테이블
BOARD_ID 게시글ID
WRITER_ID 작성자ID
TITLE 게시글제목
CONTENTS 게시글 내용
PRICE 가격
CREATED_DATE 작성일
STATUS 거래 상태
VIEWS 조회수

<USED_GOODS_FILE> 테이블
FILE_ID 파일ID
FILE_EXT 파일 확장자
FILE_NAME 파일 이름
BOARD_ID 게시글 ID

문제
조회수(VIEWS)가 가장 높은(MAX) 중고거래 게시물에 대한 첨부파일 경로를 조회한다.

첨부 파일 경로 - FILE ID 기준 내림차순 (ORDER BY F.FILE_ID DESC)
기본 파일 경로 - /home/grep/src/
- 게시글 ID를 기준으로 디렉토리 구분(BOARD_ID)
- 파일이름(파일ID(FILE_ID), 파일 이름(FILE_NAME), 파일 확장자(FILE_EXT))

1. USED_GOODS_BOARD 테이블에서 views가 가장 높은 (MAX(VIEWS)) 값 찾기 - WHERE
2. 첨부파일 경로 조회하기(파일 ID 기준 내림차순) - ORDER BY FILE_ID DESC
2-1. 기본 파일 경로 /home/grep/src/ || 디렉토리 구분(BOARD_ID) || 파일ID(FILE_ID), 파일 이름(FILE_NAME), 파일 확장자(FILE_EXT)
*/

SELECT
       '/home/grep/src/' || B.BOARD_ID || '/' || F.FILE_ID || F.FILE_NAME || F.FILE_EXT AS fILE_PATH
FROM USED_GOODS_FILE F
JOIN USED_GOODS_BOARD B ON (B.BOARD_ID = F.BOARD_ID)
WHERE B.VIEWS = (SELECT
                        MAX(B1.VIEWS)
                   FROM USED_GOODS_BOARD B1)
ORDER BY F.FILE_ID DESC;

