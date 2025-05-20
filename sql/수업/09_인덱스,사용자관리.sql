/* 클러스터형 인덱스(Clustered Index) */
USE tabledb;

-- Primary Key 설정 시 자동으로 클러스터형 인덱스 생성
CREATE TABLE tbl1 (
  a INT PRIMARY KEY,-- 이 열에 클러스터형 인덱스 자동 생성
  b INT,
  c INT
);

-- 인덱스 확인
SHOW INDEX FROM tbl1;

/* 보조 인덱스 */
-- UNIQUE 제약조건은 보조 인덱스 자동 생성
CREATE TABLE tbl2 (
    a INT PRIMARY KEY,-- 클러스터형 인덱스
    b INT UNIQUE,-- 보조 인덱스
    c INT UNIQUE,-- 보조 인덱스
    d INT
);

SHOW INDEX FROM tbl2;

-- UNIQUE 제약조건은 보조 인덱스 자동 생성
CREATE TABLE tbl3 (
    a INT UNIQUE,-- 보조 인덱스
    b INT UNIQUE,-- 보조 인덱스
    c INT UNIQUE,-- 보조 인덱스
    d INT
);

SHOW INDEX FROM tbl3;


-- Primary Key가 없고 Unique, Not Null 제약조건이 있는 경우
CREATE TABLE tbl4 (
    a INT UNIQUE NOT NULL,-- 클러스터형 인덱스로 생성
    b INT UNIQUE,
    c INT UNIQUE,
    d INT
);

SHOW INDEX FROM tbl4;


-- 실행 계획 확인
USE employees;
EXPLAIN SELECT * FROM employees
WHERE emp_no = 222222;

SHOW INDEX FROM employees;

USE employees;

-- 테이블 분석ANALYZE TABLE usertbl;

-- 인덱스 크기 확인
SHOW TABLE STATUS LIKE 'employees';

set profiling = 1;
-- index 사용 X
select * from employees;

-- index 사용 O
select * from employees order by emp_no;
show profiles ;


/* INDEX 생성/제거 */
-- addr 컬럼에 인덱스 만들기
CREATE INDEX idx_usertbl_addr
    ON usertbl(addr);


-- 인덱스 삭제 예제
DROP INDEX idx_usertbl_addr ON usertbl;
-- 또는
ALTER TABLE usertbl DROP INDEX idx_usertbl_addr;


/* 복합 인덱스 */
-- name, birthYear 조합으로 인덱스 생성
CREATE UNIQUE INDEX idx_usertbl_name_birthYear
    ON usertbl(name, birthYear);

-- 테이블 분석
ANALYZE TABLE usertbl;

-- 인덱스 크기 확인
SHOW TABLE STATUS LIKE 'usertbl';







/* 사용자 계정 생성 + 권한 부여하기 */

-- scoula_db 데이터베이스(스키마) 생성
CREATE DATABASE scoula_db;


DROP USER IF EXISTS 'scoula'@'%';

-- 모든 호스트에서 접속 가능한 사용자 scoula 생성
CREATE USER 'scoula'@'%' IDENTIFIED BY '1234';

-- scoula계정에 scoula_db 모든 권한 부여
GRANT ALL PRIVILEGES ON scoula_db.* TO 'scoula'@'%';

-- scoula 계정에 sqldb 모든 권한 부여
GRANT ALL PRIVILEGES ON sqldb.* TO 'scoula'@'%';

-- 권한 적용
FLUSH PRIVILEGES;


/* TRANSACTION CONTROL LANGUAGE (TCL) */



/* AUTO COMMIT 상태 확인*/
SELECT @@autocommit;

set autocommit = true; -- Auto commit 켜기


SELECT @@autocommit;

set autocommit = false;

SELECT @@autocommit; -- 0 auto commmit off

USE sqldb;

SELECT * FROM BUYTBL;

START TRANSACTION;

DELETE FROM buytbl WHERE num = 1;
DELETE FROM buytbl WHERE num = 2;

SELECT * FROM BUYTBL;

ROLLBACK;

SELECT * FROM BUYTBL;

SELECT * FROM usertbl;
