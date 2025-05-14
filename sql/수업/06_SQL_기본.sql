/*
 *** 인텔리제이를 이용하여 MySQL 연결하여 사용하기 ***

 1. 데이터 소스 생성
    방법 1) 메인 메뉴에서 `File` | `New` | `Data Source`를 선택하고 `MySQL`을 선택
    방법 2) Database 도구 창에서  `New` 버튼을 클릭하고 `Data Source` 선택 후 `MySQL`을 선택

 2. 드라이버 설정
    - 연결 설정 영역 하단에 `Download missing driver files` 링크가 있는지 확인
    - 있으면 클릭하여 다운로드 수행

 3. 연결 세부 정보 지정
    - `General(일반)` 탭에서 알맞은 정보 입력
        - `Host`: 서버 주소 (예: localhost 또는 127.0.0.1)
        - : MySQL 포트 (기본값: 3306) `Port`
        - `Authentication`: 인증 방식 선택 (일반적으로 `User & Password`)
        - 및 : 사용자 자격 증명 입력
            `User` : root
            `Password` : root 비밀번호
        - `Database`: 연결할 데이터베이스 이름

 4. URL 확인 후 연결 테스트
    - URL : jdbc:mysql://localhost:3306   형태
    - 연결 테스트 클릭 -> 체크 표시 확인

 5. 'Schemas(스키마)' 탭에서 사용하려는 스키마 모두 체크

 6. 확인 클릭

 *** SQL 실행은 CTRL + Enter ***

 - 커서가 올라간 SQL만 실행하고 싶은 경우
    인텔리제이 설정 > 데이터베이스 > 쿼리 실행 > 실행
    > 구문 내 캐럿이 실행될 때 > "최소 하위 쿼리 또는 구문" 선택
*/

-- employee 데이터베이스 사용
USE employees;

-- 전체 테이블 경로를 사용한 titles 테이블 조회
SELECT * FROM employees.titles;

-- 현재 데이터베이스의 titles 테이블 조회
SELECT * FROM titles;

-- 직원의 이름만 조회
SELECT first_name FROM employees;

-- 직원의 이름, 성, 성별 조회
SELECT first_name, last_name, gender FROM employees;


-- 사용 가능한 모든 데이터베이스 목록 조회
SHOW DATABASES;

-- 현재 데이터베이스의 모든 테이블 목록 조회
SHOW TABLES;

-- employees 테이블의 구조 확인 (컬럼 정보)
DESCRIBE employees; 
-- 또는 
DESC employees;


-- 별칭(Alias)을 사용한 컬럼명 변경 조회
SELECT first_name AS 이름, gender AS 성별, hire_date '회사 입사일'
FROM employees;


-- sqlDB 데이터베이스로 전환
use sqldb;

-- 이름이 '김경호'인 사용자 정보 조회
SELECT * FROM usertbl
WHERE name = '김경호';


-- AND 연산자를 사용한 다중 조건 검색 (1970년 이후 출생자 중 키가 182 이상)
SELECT userid, name FROM usertbl
WHERE birthyear >= 1970 AND height >= 182;


-- BETWEEN 연산자를 사용한 범위 검색 (키가 180~183인 사용자)
SELECT name, height FROM usertbl
WHERE height BETWEEN 180 AND 183;


-- IN 연산자를 사용한 다중값 검색 (경남, 전남, 경북 거주자)
SELECT name, addr FROM usertbl
WHERE addr IN ('경남', '전남', '경북');


-- 패턴 매칭을 위한 LIKE 연산자 사용 (김씨 성을 가진 사용자)
SELECT name, height FROM usertbl
WHERE name LIKE '김%';


-- 키가 177보다 큰 사용자 조회
SELECT name, height FROM usertbl WHERE height > 177;

-- 서브쿼리를 사용하여 김경호보다 키가 큰 사용자 조회
SELECT name, height FROM usertbl 
WHERE height > (SELECT height FROM usertbl WHERE name = '김경호');

-- 다중 행 서브쿼리 사용 시 에러 발생 (단일 값 비교 연산자와 함께 사용할 수 없음)
SELECT name, height FROM usertbl
WHERE height >= (SELECT height FROM usertbl WHERE addr = '경남');

-- ANY 연산자를 사용하여 경남 거주자 중 가장 작은 키보다 크거나 같은 사용자 조회
SELECT name, height FROM usertbl
WHERE height >= ANY (SELECT height FROM usertbl WHERE addr = '경남');

-- 경남 거주자 키와 동일한 키를 가진 사용자 조회
SELECT name, height FROM usertbl
WHERE height = ANY (SELECT height FROM usertbl WHERE addr = '경남');

-- IN 연산자를 사용한 동일한 결과 (경남 거주자와 키가 같은 사용자)
SELECT name, height FROM usertbl
WHERE height IN (SELECT height FROM usertbl WHERE addr = '경남');


-- ALL 연산자를 사용하여 경남 거주자 모두보다 키가 큰 사용자 조회
SELECT name, height FROM usertbl
WHERE height > ALL (SELECT height FROM usertbl WHERE addr = '경남');

-- 가입일(mDate) 기준 오름차순 정렬
SELECT name, mDate FROM usertbl ORDER BY mDate ASC;


-- ASC 키워드 생략 시 기본값은 오름차순
SELECT name, mDate FROM usertbl ORDER BY mDate;

-- 가입일 기준 내림차순 정렬
SELECT name, mDate FROM usertbl ORDER BY mDate DESC;

-- 다중 정렬: 키 기준 내림차순, 같은 키는 이름 기준 오름차순
SELECT name, height FROM usertbl ORDER BY height DESC, name ASC;

-- ASC는 기본값이므로 생략 가능
SELECT name, height FROM usertbl ORDER BY height DESC, name;


-- 모든 주소 조회 (중복 포함)
SELECT addr FROM usertbl;

-- 주소 기준 정렬
SELECT addr FROM usertbl ORDER BY addr;

-- 중복 제거된 고유 주소 목록 조회
SELECT DISTINCT addr FROM usertbl;



USE employees;

-- 입사일 기준 오름차순 정렬된 직원 목록
SELECT emp_no, hire_date FROM employees
ORDER BY hire_date ASC;


-- LIMIT 절을 사용하여 결과 개수 제한 (상위 5개만)
SELECT emp_no, hire_date FROM employees
ORDER BY hire_date ASC
LIMIT 5;


-- LIMIT와 OFFSET 함께 사용 (0번 인덱스부터 5개 레코드)
SELECT emp_no, hire_date FROM employees
ORDER BY hire_date ASC
LIMIT 0, 5; -- LIMIT 5 OFFSET 0과 동일


USE sqldb;

-- SELECT INTO 구문으로 테이블 복사 생성
CREATE TABLE buytbl2 (SELECT * FROM buytbl);

-- 복사된 테이블 확인
SELECT * FROM buytbl2;

-- 일부 컬럼만 선택하여 새 테이블 생성
CREATE TABLE buytbl3 (SELECT userID, prodName FROM buytbl);

-- 생성된 테이블 확인
SELECT * FROM buytbl3;


-- 사용자별 구매 수량 합계 계산 (GROUP BY 사용)
SELECT userID, SUM(amount) FROM buytbl GROUP BY userID;


-- 별칭을 사용하여 그룹화된 결과 출력
SELECT userID AS '사용자 아이디', SUM(amount) AS '총 구매 개수'
FROM buytbl
GROUP BY userID;

-- 사용자별 총 구매 금액 계산
SELECT userID AS '사용자 아이디', SUM(amount*price) AS '총 구매액'
FROM buytbl
GROUP BY userID;


-- 전체 평균 구매 개수 계산
SELECT AVG(amount) AS '평균 구매 개수'
FROM buytbl;


-- 사용자별 평균 구매 개수 계산
SELECT userID, AVG(amount) AS '평균 구매 개수'
FROM buytbl
GROUP BY userID;


-- GROUP BY 없이 집계함수와 일반 컬럼 함께 사용 시 에러 발생
SELECT name, MAX(height), MIN(height)
FROM usertbl;

-- 이름별로 그룹화하여 최대/최소 키 계산 (의미 없는 쿼리)
SELECT name, MAX(height), MIN(height)
FROM usertbl
GROUP BY name;



-- 서브쿼리를 사용하여 최대/최소 키를 가진 사용자 조회
SELECT name, height
FROM usertbl
WHERE height = (SELECT MAX(height) FROM usertbl)
   OR height = (SELECT MIN(height) FROM usertbl);


-- COUNT 함수로 전체 행 개수 계산
SELECT COUNT(*) FROM usertbl;

-- NULL이 아닌 휴대폰 번호를 가진 사용자 수 계산
SELECT COUNT(mobile1) AS '휴대폰이 있는 사용자'
FROM usertbl;


-- HAVING 절 사용 예시

-- 사용자별 총 구매액 계산
SELECT userID AS '사용자', SUM(price*amount) AS '총구매액'
FROM buytbl
GROUP BY userID;

-- HAVING 절로 그룹화된 결과 필터링 (총구매액 1000 초과)
SELECT userID AS '사용자', SUM(price*amount) AS '종구매액'
FROM buytbl
GROUP BY userID
HAVING SUM(price * amount) > 1000;


-- ROLLUP을 사용한 소계/합계 표시
SELECT num, groupName, SUM(price * amount) AS '비용'
FROM buytbl
GROUP BY groupName, num
WITH ROLLUP;

-- 그룹별 소계와 전체 합계 표시
SELECT groupName, SUM(price * amount) AS '비용'
FROM buytbl
GROUP BY groupName
WITH ROLLUP;


-- 2. 데이터의 변경을 위한 SQL문
-- INSERT 구문 예시

USE sqldb;
-- 테스트 테이블 생성
CREATE TABLE testTbl1(id INT, username CHAR(3), age INT);

-- 모든 컬럼에 값 입력
INSERT INTO testTbl1 VALUES(1, '홍길동', 25);

-- 특정 컬럼만 지정하여 값 입력 (지정되지 않은 컬럼은 NULL)
INSERT INTO testTbl1(id, userName) VALUES(2, '설현');

-- 컬럼 순서를 바꿔서 값 입력
INSERT INTO testTbl1(username, age, id) VALUES('하나', 26, 3);


USE sqldb;
-- 자동 증가(AUTO_INCREMENT) 컬럼이 있는 테이블 생성
CREATE TABLE testTbl2(
  id INT AUTO_INCREMENT PRIMARY KEY,
  userName CHAR(3),
  age INT
);

-- AUTO_INCREMENT 컬럼에는 NULL 입력 (자동으로 값 증가)
INSERT INTO testTbl2 VALUES (NULL, '지인', 25);
INSERT INTO testTbl2 VALUES (NULL, '유나', 22);
INSERT INTO testTbl2 VALUES (NULL, '유경' , 21);
SELECT * FROM testTbl2;


USE sqldb;
-- 데이터 복사를 위한 테이블 생성
CREATE TABLE testTbl4(id INT, Fname VARCHAR(50), Lname VARCHAR(50));
-- INSERT SELECT 구문으로 다른 테이블에서 데이터 복사
INSERT INTO testTbl4
SELECT emp_no, first_name, last_name
FROM employees.employees;

-- 복사된 데이터 확인
SELECT * FROM testTbl4;

-- UPDATE문 예시

-- 특정 조건에 맞는 레코드 업데이트
UPDATE testTbl4
SET Lname = '없음'
WHERE Fname = 'Kyoichi';

-- 모든 레코드의 가격을 1.5배로 업데이트
UPDATE buytbl
SET price = price * 1.5;


-- DELETE 문 예시
-- 특정 조건에 맞는 레코드 삭제
DELETE FROM testTbl4
WHERE Fname = 'Aamer';

-- LIMIT을 사용하여 삭제할 레코드 수 제한
DELETE FROM testTbl4
WHERE Fname = 'Aamer' LIMIT 5;

USE sqldb;
SELECT name, height
FROM usertbl
ORDER BY height DESC;

