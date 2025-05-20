-- tabledb 데이터베이스 생성

DROP DATABASE tabledb;
CREATE DATABASE tabledb;

use tabledb;

DROP TABLE IF EXISTS usertbl;

CREATE TABLE usertbl
(
    userID    CHAR(8)     NOT NULL PRIMARY KEY,
    name      VARCHAR(10) NOT NULL,
    birthYear INT         NOT NULL,
    addr      CHAR(2)     NOT NULL,
    mobile1   CHAR(3)     NULL,
    mobile2   CHAR(8)     NULL,
    height    SMALLINT    NULL,
    mDate     DATE        NULL
);

DROP TABLE IF EXISTS buytbl;
CREATE TABLE buytbl(
   num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
   userid CHAR(8) NOT NULL,
   prodName CHAR(6) NOT NULL,
   groupName CHAR(4) NULL,
   price INT NOT NULL,
   amount SMALLINT NOT NULL,
   FOREIGN KEY(userid) REFERENCES usertbl(userID)
);


-- 회원 테이블에 다음 데이터를 입력하세요
INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');

SELECT * FROM usertbl;

INSERT INTO buytbl VALUES(NULL, 'KBS', '운동화', NULL, 30, 2);
INSERT INTO buytbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);

-- userid는 외래키이므로 usertbl에 'JYP'가 있어야 함.
-- 현재 해당 userid가 없기 때문에 에러임
INSERT INTO buytbl VALUES(NULL, 'JYP', '모니터', '전자', 200, 1);


SELECT * FROM buytbl;


-- 다음 컬럼을 가지는 usertbl을 정의하세요.
-- 기존 usertbl이 존재하는 경우 삭제함
-- 기본키는 테이블 레벨에서 정의하고 제약 조건명을 함께 지정

DROP TABLE IF EXISTS buytbl, usertbl;
CREATE TABLE usertbl (
     userID CHAR(8) NOT NULL,
     name VARCHAR(10) NOT NULL,
     birthYear INT NOT NULL,
     CONSTRAINT PRIMARY KEY PK_userTBL_userID(userID)
);


-- 다음 컬럼을 가지는 prodTbl 정의하세요.
-- 기존 prodTbl 존재하는 경우 삭제함
DROP TABLE IF EXISTS prodTbl;
CREATE TABLE prodTbl (
     prodCode CHAR(3) NOT NULL,
     prodID CHAR(4) NOT NULL,
     prodDate DATETIME NOT NULL,
     prodCur CHAR(10) NULL,
     CONSTRAINT PK_prodTbl_proCode_prodID
         PRIMARY KEY (prodCode, prodID)
);



--

use tabledb;
CREATE VIEW v_userbuytbl
AS
SELECT U.userid, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
FROM usertbl U
         INNER JOIN buytbl B
                    ON U.userid = B.userid;

SELECT * FROM v_userbuytbl WHERE name = '김범수';
