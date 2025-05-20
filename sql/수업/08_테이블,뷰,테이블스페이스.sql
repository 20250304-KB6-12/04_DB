-- DB 제거
DROP DATABASE tabledb;

-- DB 생성
CREATE DATABASE tabledb;

USE tabledb;

-- 테이블이 존재하면 삭제
DROP TABLE IF EXISTS usertbl;

CREATE TABLE usertbl(
    userID      CHAR(8) NOT NULL PRIMARY KEY,
    name        VARCHAR(10) NOT NULL,
    birthYear   INT NOT NULL,
    addr        CHAR(2) NOT NULL,
    mobile1     CHAR(3) NULL,
    mobile2     CHAR(8) NULL,
    height      SMALLINT NULL,
    mDate       DATE NULL
);


-- 회원 테이블 샘플 데이터
INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');

SELECT * FROM usertbl;


USE tabledb;

-- 테이블이 존재하면 삭제
DROP TABLE IF EXISTS buytbl;

CREATE TABLE buytbl(
   num         INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
   userid      CHAR(8) NOT NULL,
   prodName    CHAR(6) NOT NULL,
   groupName   CHAR(4) NULL,
   price       INT NOT NULL,
   amount      SMALLINT NOT NULL,
   FOREIGN KEY(userid) REFERENCES usertbl(userID)
);

-- 구매 테이블 샘플 데이터
INSERT INTO buytbl VALUES(NULL, 'KBS', '운동화', NULL, 30, 2);
INSERT INTO buytbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);

-- 오류 발생 : userid 컬럼이 참조하는 usertbl테이블의 userID 컬럼에 'JYP'가 없음
INSERT INTO buytbl VALUES(NULL, 'JYP', '모니터', '전자', 200, 1);

/* PK 제약조건*/
USE tabledb;

DROP TABLE IF EXISTS buytbl;
DROP TABLE IF EXISTS usertbl;

-- usertbl 테이블 생성 + userID 컬럼 PK 지정
CREATE TABLE usertbl (
     userID CHAR(8) NOT NULL,
     name VARCHAR(10) NOT NULL,
     birthYear INT NOT NULL,
     CONSTRAINT PRIMARY KEY PK_userTBL_userID(userID) -- 테이블 레벨 PK 설정
);


DROP TABLE IF EXISTS prodTbl;

-- prodTbl 테이블 생성 + prodCode, prodID 복합PK 설정
-- 복합키로 설정된 컬럼의 값이 모두 같다면 중복!
CREATE TABLE prodTbl (
     prodCode  CHAR(3) NOT NULL,
     prodID    CHAR(4) NOT NULL,
     prodDate  DATETIME NOT NULL,
     prodCur   CHAR(10) NULL,
     CONSTRAINT PK_prodTbl_proCode_prodID
         PRIMARY KEY (prodCode, prodID)
);

/* FK 제약조건 */

USE tabledb;

DROP TABLE IF EXISTS buyTBL, userTBL;

CREATE TABLE userTBL(
    userID    CHAR(8) NOT NULL PRIMARY KEY,
    name      VARCHAR(10) NOT NULL,
    birthYear  INT NOT NULL
);


-- buyTbl의 userID 컬럼에 FK 제약 조건 설정(userTBL의 userID 컬럼 값 참조)
CREATE TABLE buyTBL(
   num INT AUTO_INCREMENT NOT NULL PRIMARY KEY ,
   userID  CHAR(8) NOT NULL,
   prodName CHAR(6) NOT NULL,
   FOREIGN KEY(userID) REFERENCES userTBL(userID)
);



USE tabledb;

DROP TABLE IF EXISTS buyTBL;

-- buyTbl의 userID 컬럼에 FK 제약 조건 + 옵션 설정
CREATE TABLE buyTBL(
       num INT AUTO_INCREMENT NOT NULL PRIMARY KEY ,
       userID  CHAR(8) NOT NULL,
       prodName CHAR(6) NOT NULL,
       FOREIGN KEY(userID) REFERENCES userTBL(userID)
           ON DELETE CASCADE
           ON UPDATE CASCADE
);



USE sqldb;
SELECT * FROM stdtbl;
SELECT * FROM clubtbl;
SELECT * FROM stdclubtbl;

-- 외래키 체크 활성화(1, 기본값)
-- stdtbl에 '아이유'가 없어서 참조 오류 발생
INSERT INTO stdclubtbl
VALUES(NULL, '아이유', '수영');


-- 외래키 체크 비활성화 (대량 데이터 로드 시)
SET foreign_key_checks = 0;

-- 비활성화 후 다시 INSERT -> 성공
INSERT INTO stdclubtbl
VALUES(NULL, '아이유', '수영');

SELECT * FROM stdclubtbl;

-- 외래키 체크 활성화
SET foreign_key_checks = 1;

-- 외래키 검사를 활성화해도
-- 이미 테이블에 잘못 삽입된 데이터는 검사하지 않는다!
SELECT * FROM stdclubtbl;



/* UNIQUE 제약 조건*/
USE tabledb;

DROP TABLE IF EXISTS buytbl, usertbl;

CREATE TABLE usertbl (
     userID CHAR(8) NOT NULL PRIMARY KEY,
     name VARCHAR(10) NOT NULL,
     email CHAR(30) NULL UNIQUE
);

-- 1. 정상 데이터 삽입 (기본 데이터)
INSERT INTO usertbl (userID, name, email) VALUES ('user001', '김철수', 'kim@example.com');
INSERT INTO usertbl (userID, name, email) VALUES ('user002', '이영희', 'lee@example.com');
INSERT INTO usertbl (userID, name, email) VALUES ('user003', '박지성', 'park@example.com');
INSERT INTO usertbl (userID, name, email) VALUES ('user004', '최민수', 'choi@example.com');
INSERT INTO usertbl (userID, name, email) VALUES ('user005', '정소미', 'jung@example.com');

-- 2. UNIQUE 제약조건 위반 테스트 (이메일 중복)
-- 이미 존재하는 이메일로 새 사용자 추가 시도 (오류 발생)
INSERT INTO usertbl (userID, name, email) VALUES ('user006', '홍길동', 'kim@example.com');

-- 3. NULL 값 테스트 (email은 NULL 허용)
INSERT INTO usertbl (userID, name, email) VALUES ('user007', '강민준', NULL);
INSERT INTO usertbl (userID, name, email) VALUES ('user008', '손흥민', NULL);

-- 4. 대소문자 테스트 (MySQL 기본 설정에서는 대소문자 구분 없음)
INSERT INTO usertbl (userID, name, email) VALUES ('user010', '이지원', 'LEE@EXAMPLE.COM');

-- 5. 업데이트 테스트 (이메일 중복으로 변경)
-- 기존 사용자의 이메일을 이미 존재하는 값으로 변경 (오류 발생)
UPDATE usertbl SET email = 'park@example.com' WHERE userID = 'user002';

-- 6. 업데이트 테스트 (중복 없는 이메일로 변경)
UPDATE usertbl SET email = 'lee_new@example.com' WHERE userID = 'user002';

-- 7. 일괄 삽입 테스트 (부분 실패할 경우 SQL 전체 실패)
INSERT INTO usertbl (userID, name, email) VALUES
  ('user011', '조아라', 'jo@example.com'),
  ('user012', '한지민', 'han@example.com'),
  ('user013', '류현진', 'kim@example.com'); -- 중복 이메일로 실패

SELECT * FROM usertbl;


/*  CHECK 제약 조건 */
USE tabledb;

-- 출생년도가 1900년 이후 그리고 2023년 이전, 이름은 반드시 넣어야 함.
DROP TABLE IF EXISTS userTBL;

CREATE TABLE userTBL(
    userID    CHAR(8) PRIMARY KEY,
    name      VARCHAR(10) ,
    birthYear  INT CHECK  (birthYear >= 1900 AND birthYear <= 2023),
    mobile1    char(3) NULL,
    CONSTRAINT CK_name CHECK ( name IS NOT NULL)
);

-- 1. 정상 데이터 삽입 (모든 제약조건 충족)
INSERT INTO userTBL (userID, name, birthYear, mobile1) VALUES ('user001', '김철수', 1990, '010');
INSERT INTO userTBL (userID, name, birthYear, mobile1) VALUES ('user002', '이영희', 1985, '011');
INSERT INTO userTBL (userID, name, birthYear, mobile1) VALUES ('user003', '박지성', 2000, '010');
INSERT INTO userTBL (userID, name, birthYear, mobile1) VALUES ('user004', '최민수', 1970, '019');
INSERT INTO userTBL (userID, name, birthYear, mobile1) VALUES ('user005', '정소미', 2023, NULL);

-- 2. CHECK 제약조건 위반 테스트 (birthYear < 1900)
-- birthYear가 1900보다 작은 경우 (오류 발생)
INSERT INTO userTBL (userID, name, birthYear, mobile1) VALUES ('user006', '홍길동', 1899, '010');

-- 3. CHECK 제약조건 위반 테스트 (birthYear > 2023)
-- birthYear가 2023보다 큰 경우 (오류 발생)
INSERT INTO userTBL (userID, name, birthYear, mobile1) VALUES ('user007', '강민준', 2024, '010');

-- 4. birthYear NULL 테스트 (CHECK 제약조건은 NULL 값에 적용되지 않음, 삽입 성공!)
INSERT INTO userTBL (userID, name, birthYear, mobile1) VALUES ('user009', '손흥민', NULL, '010');

-- 5. 업데이트 테스트 (CHECK 제약조건 위반으로 업데이트)
-- 정상 데이터를 제약조건 위반 값으로 업데이트 (오류 발생)
UPDATE userTBL SET birthYear = 2025 WHERE userID = 'user001';

-- 6. 정상 업데이트 테스트(성공)
UPDATE userTBL SET birthYear = 1995 WHERE userID = 'user003';

-- 7. 일괄 삽입 테스트 (부분 실패할 경우 SQL 전체 실패)
INSERT INTO userTBL (userID, name, birthYear, mobile1) VALUES
   ('user012', '한지민', 2010, '010'),
   ('user013', '류현진', 1850, '010'), -- birthYear 제약조건 위반
   ('user014', '송중기', 1980, '010');

SELECT * FROM usertbl;

-- 8. birthYear에 숫자가 아닌 값 입력 시도 (타입 에러 발생)
INSERT INTO userTBL (userID, name, birthYear, mobile1) VALUES ('user015', '장원영', 'ABCD', '010');


/* DEFAULT */

USE tabledb;

DROP TABLE IF EXISTS userTBL;

CREATE TABLE userTBL (
     userID      CHAR(8) NOT NULL PRIMARY KEY,
     name        VARCHAR(10) NOT NULL,
     birthYear   INT NOT NULL DEFAULT -1,
     addr        CHAR(2) NOT NULL DEFAULT '서울',
     mobile1     CHAR(3) NULL,
     mobile2     CHAR(8) NULL,
     height      SMALLINT NULL DEFAULT 170,
     mDate       DATE NULL
);

-- default작성 시 DEFAULT로 설정된 값을 자동 입력
INSERT INTO usertbl VALUES
    ('LHL', '이혜리', default, default, '011', '1234567',
        default, '2023.12.12');

-- 열 이름이 명시되지 않으면 DEFAULT로 설정된 값을 자동 입력
INSERT INTO usertbl(userID, name) VALUES('KAY', '김아영');

-- 값이 직접 작성되면 DEFAULT로 설정된 값은 무시
INSERT INTO usertbl VALUES ('WB', '원빈', 1982, '대전', '019', '9876543', 176,
                            '2020.5.5');

SELECT  * FROM usertbl;



/* VIEW */
USE tabledb;

-- v_usertbl 뷰가 있다면 삭제
DROP VIEW IF EXISTS v_usertbl;

-- v_usertbl 뷰 생성
CREATE VIEW v_usertbl
AS
SELECT
    userid,
    name,
    addr
FROM
    usertbl;

SELECT * FROM v_usertbl;-- 뷰를 테이블이라고 생각해도 무방


-- v_userbuytbl 뷰가 있다면 삭제
DROP VIEW IF EXISTS v_userbuytbl;

CREATE TABLE buyTBL(
   num INT AUTO_INCREMENT NOT NULL PRIMARY KEY ,
   userID  CHAR(8) NOT NULL,
   prodName CHAR(6) NOT NULL,
   FOREIGN KEY(userID) REFERENCES userTBL(userID)
       ON DELETE CASCADE
       ON UPDATE CASCADE
);


INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');

-- buytbl 생성
INSERT INTO buytbl VALUES(NULL, 'KBS', '운동화');
INSERT INTO buytbl VALUES(NULL, 'KBS', '노트북');

-- v_userbuytbl 뷰 생성
CREATE VIEW v_userbuytbl
AS
SELECT
    U.userid,
    U.name,
    B.prodName,
    U.addr,
    CONCAT(U.mobile1, U.mobile2) AS '연락처'
FROM
    usertbl U
        INNER JOIN
    buytbl B ON U.userid = B.userid;

SELECT *
FROM
    v_userbuytbl
WHERE
    name = '김범수';


/* TABLESPACE */

USE tabledb;

-- 현재 시스템 변수 'innodb_file_per_table' 설정 확인
SHOW VARIABLES LIKE 'innodb_file_per_table';

-- 'innodb_file_per_table' ON으로 변경
-- ON : 각 innodb 테이블이 자체 테이블스페이스에 저장됨
-- OFF : 모든 innodb 테이블 데이터가 시스템 테이블스페이스에 저장됨
SET GLOBAL innodb_file_per_table = ON;

-- 테이블스페이스 생성
CREATE TABLESPACE ts_a ADD DATAFILE 'ts_a.ibd';
CREATE TABLESPACE ts_b ADD DATAFILE 'ts_b.ibd';
CREATE TABLESPACE ts_c ADD DATAFILE 'ts_c.ibd';

-- 테이블 생성 시 테이블스페이스 지정
CREATE TABLE table_a (id INT) TABLESPACE ts_a;

-- 기존 테이블의 테이블스페이스 변경
CREATE TABLE table_b (id INT);
ALTER TABLE table_b TABLESPACE ts_b;


CREATE TABLE table_c (SELECT * FROM employees.salaries);

SELECT COUNT(*) FROM table_c;

ALTER TABLE table_c TABLESPACE ts_c;