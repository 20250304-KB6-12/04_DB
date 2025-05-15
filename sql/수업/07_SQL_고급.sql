/* sqldb 데이터베이스 추가 테이블 생성 */
USE sqldb;

/* emptbl 테이블 생성 */
CREATE TABLE emptbl(
                       emp CHAR(3),
                       manager CHAR(3),
                       empTel VARCHAR(8)
);


INSERT INTO empTbl VALUES('나사장', NULL, '0000');
INSERT INTO empTbl VALUES('김재무', '나사장', '2222');
INSERT INTO empTbl VALUES('김부장', '김재무', '2222-1');
INSERT INTO empTbl VALUES('이부장', '김재무', '2222-2');
INSERT INTO empTbl VALUES('우대리', '이부장', '2222-2-1');
INSERT INTO empTbl VALUES('지사원', '이부장', '2222-2-2');
INSERT INTO empTbl VALUES('이영업', '나사장', '1111');
INSERT INTO empTbl VALUES('한과장', '이영업', '1111-1');
INSERT INTO empTbl VALUES('최정보', '나사장', '3333');
INSERT INTO empTbl VALUES('윤차장', '최정보', '3333-1');
INSERT INTO empTbl VALUES('이주임', '윤차장', '3333-1-1');

COMMIT;


/* stdtbl, clubtbl, stdclubtbl 테이블 생성 */
USE sqldb;

CREATE TABLE stdtbl (
                        stdName  VARCHAR(10) NOT NULL PRIMARY KEY,
                        addr  CHAR(4) NOT NULL
);

CREATE TABLE clubtbl (
                         clubName  VARCHAR(10) NOT NULL PRIMARY KEY,
                         roomNo  CHAR(4) NOT NULL
);

CREATE TABLE stdclubtbl(
                           num int AUTO_INCREMENT NOT NULL PRIMARY KEY,
                           stdName  VARCHAR(10) NOT NULL,
                           clubName  VARCHAR(10) NOT NULL,
                           FOREIGN KEY(stdName) REFERENCES stdtbl(stdName),
                           FOREIGN KEY(clubName) REFERENCES clubtbl(clubName)
);

INSERT INTO stdtbl VALUES ('김범수','경남'), ('성시경','서울'), ('조용필','경기'), ('은지원','경북'),('바비킴','서울');
INSERT INTO clubtbl VALUES ('수영','101호'), ('바둑','102호'), ('축구','103호'), ('봉사','104호');
INSERT INTO stdclubtbl VALUES (NULL, '김범수','바둑'), (NULL,'김범수','축구'), (NULL,'조용필','축구'), (NULL,'은지원','축구'), (NULL,'은지원','봉사'), (NULL,'바비킴','봉사');

COMMIT;


-- 구매 이력이 없는 사용자만 출력하세요
USE sqldb;

SELECT *
FROM
    buytbl b
RIGHT OUTER JOIN
    usertbl u on b.userID = u.userID
WHERE
    -- b.userID = u.userID
    IFNULL(b.userID, TRUE)
ORDER BY
    b.userID;




SELECT 1 > '2mega' FROM dual;


### 2.1.1. `IF(수식, 참, 거짓)`
-- 수식이 참 또는 거짓인지 결과에 따라서 2중 분기
SELECT IF (100>200, '참이다', '거짓이다'); -- 거짓이다
SELECT IF (300>200, '참이다', '거짓이다'); -- 참이다

### `IFNULL(수식1, 수식2)`

-- 수식1 NULL X → 수식1 반환
-- 수식1 NULL O → 수식2 반환

-- DB에서 NULL : 빈칸
USE sqldb;
SELECT *
FROM usertbl
WHERE
    -- mobile1 = NULL; -- 조회 X
    IFNULL(mobile1, FALSE);  -- IS NOT NULL과 같음
    -- mobile1 컬럼의 값이 존재 -> TRUE -> 결과에 포함되어 출력
    -- mobile1 컬럼의 값이 없다면 (NULL) ->  FALSE -> 결과 포함 X

-- 컬럼명 IS NULL : 해당 컬럼의 값이 NULL인 경우 TRUE
SELECT *
FROM
    usertbl
WHERE
   mobile1 IS NULL;


-- IFNULL() - SELECT절에 사용
SELECT
    name, IFNULL(mobile1, '없음') AS "전화번호 앞자리"
FROM
    usertbl;

### 2.1.3 `NULLIF(수식1, 수식2)`
-- 수식1 = 수식2 → NULL 반환
-- 수식1 ≠ 수식2 → 수식1 반환
SELECT NULLIF(100,100), IFNULL(200,100); -- NULL, 200

### 2.1.4 `CASE ~ WHEN ~ ELSE ~ END`

-- CASE는 내장 함수는 아니며 연산자(Operator)로 분류
-- 다중 분기에 사용되므로 내장함수와 함께 알아두면 좋음

SELECT
    CASE 10
        WHEN 1 THEN '일'
        WHEN 5 THEN '오'
        WHEN 10 THEN '십'
        END AS 'CASE연습'; -- 십

SELECT
    name,
    birthYear,
    CASE
        WHEN birthYear >= 1980 THEN '80년대생'
        WHEN birthYear >= 1970 THEN '70년대생'
        WHEN birthYear >= 1960 THEN '60년대생'
        ELSE '50년대생'
    END '몇년도생'
FROM
    usertbl;


/*GROUP_CONCAT(문자열 SEPARATOR ',')*/
-- GROUPBY 항목의 개별 내용을 하나의 문자열로 연결
-- 연결 시 지정한 구분자로 연결


SELECT
	u.userID,
	u.name,
	GROUP_CONCAT(b.prodName SEPARATOR ',') AS '상품목록'
FROM
	usertbl u
LEFT OUTER JOIN
	buytbl b ON u.userID = b.userID
GROUP BY
	u.userID, u.name
ORDER BY
	u.userID;


/* INNER JOIN */
USE sqldb;

SELECT *
FROM
    buytbl
        INNER JOIN
    usertbl ON buytbl.userID = usertbl.userID
WHERE
    buytbl.userID = 'JYP';



USE sqldb;

SELECT *
FROM
    usertbl LEFT JOIN buytbl
        ON buytbl.userID = usertbl.userID;


/* 여러 테이블 JOIN */
USE sqldb;

SELECT
    *
FROM
    stdtbl S
INNER JOIN
    stdclubtbl SC ON S.stdName = SC.stdName
INNER JOIN
    clubtbl C ON SC.clubName = C.clubName
ORDER BY
    S.stdName;












USE sqldb;

SELECT
    A.emp AS '부하직원',
    B.emp AS '직속상관',
    B.empTel AS '직속상관연락처'
FROM
    empTbl A
        INNER JOIN
    empTbl B ON A.manager = B.emp
WHERE
    b.emp = '나사장';



USE sqldb;

SELECT
    name,
    addr,
    mobile1
FROM
    usertbl
WHERE
    addr = '서울'

UNION ALL

SELECT
    name,
    addr,
    mobile1
FROM
    usertbl
WHERE
    mobile1 = '011'
ORDER BY
    name;


-- 중복되는 이승기가 1행만 조회됨





USE sqldb;


SELECT
    name,
    addr,
    mobile1
FROM
    usertbl
WHERE
    addr = '서울'
  AND name IN (
    SELECT
        name
    FROM
        usertbl
    WHERE
        mobile1 = '011'
    ORDER BY
        name
);

-- 중복되는 이승기만 1행 조회됨



USE sqldb;

SELECT
    name,
    addr,
    mobile1
FROM
    usertbl
WHERE
    addr = '서울'
  AND name NOT IN (
    SELECT
        name
    FROM
        usertbl
    WHERE
        mobile1 = '011'
    ORDER BY
        name
);

-- 이승기를 제외한 바비킴, 임재범, 성시경 조회