-- 현재 서버에 존재 하는 데이터베이스 확인
SHOW databases;

-- 현재 데이터베이스를 employees로 설정하기
USE employees;

-- employees 데이터베이스의 테이블 목록보기
SHOW TABLES;

-- employees 테이블의열 목록 출력하기
DESCRIBE employees;

-- titles 테이블의 데이터 출력하기
SELECT *
FROM employees.titles;
SELECT *
FROM titles;

-- employees 테이블에서 first_name 컬럼만 출력하기
SELECT first_name
FROM employees;

-- employees 테이블에서 first_name 컬럼, last_name 컬럼, gender 컬럼 출력하기
SELECT first_name, last_name, gender
FROM employees;

-- employees 테이블 출력시 다음과 같이 나오도록 쿼리를 작성하세요
SELECT first_name AS 이름, gender AS 성별, hire_date '회사 입사일'
FROM employees;

USE sqldb;

-- usertbl 테이블에서 이름이 '김경호'인 행을 출력하세요.
SELECT *
FROM usertbl
WHERE name = '김경호';

-- usertbl 테이블에서 생년이 1970 이상이고 키가 182이상인 데이터를 출력하세요.
SELECT userid, name
FROM usertbl
WHERE birthyear >= 1970
  AND height >= 182;

-- usertbl 테이블에서 키가 180~183 범위인 데이터를 출력하세요.
SELECT name, height
FROM usertbl
WHERE height BETWEEN 180 AND 183;

-- usertbl 테이블에서 주소가 '경남' 또는 '전남' 또는 '경북'인 데이터를 출력하세요.
SELECT name, addr
FROM usertbl
WHERE addr IN ('경남', '전남', '경북');

-- usertbl 테이블에서 이름이 '김'으로 시작하는 데이터를 출력하세요.
SELECT name, height
FROM usertbl
WHERE name LIKE '김%';

-- usertbl에서 김경호 보다 큰 사람들의 이름과 키를 출력하세요.
-- 서브쿼리를 이용하여 쿼리를 작성하세요.
SELECT name, height
FROM usertbl
WHERE height > (SELECT height FROM usertbl WHERE name = '김경호');

-- usertbl을 mdata의 오름 차순으로 정렬하여 출력하세요.
SELECT name, mDate
FROM usertbl
ORDER BY mDate ASC;

-- usertbl을 mdata의 내림 차순으로 정렬하여 출력하세요.
SELECT name, mDate
FROM usertbl
ORDER BY mDate DESC;

-- usertbl을 height의 내림차순으로 정렬하고,
-- 동률인 경우 name의 내림차순으로 정렬하여 출력하세요.
SELECT name, height
FROM usertbl
ORDER BY height DESC, name;

-- usertbl의 주소지를 중복없이 오름 차순으로 출력하세요.
SELECT DISTINCT addr
FROM usertbl
ORDER BY addr;



USE world;

-- 국가 코드가 'KOR'인 도시를 찾아 인구수를 역순으로 표시하세요.
select name
from city
where countrycode = 'kor'
order by population desc;

-- city 테이블에서 국가 코드와 인구수를 출력하라.
-- 정렬은 국가 코드별로 오름차순으로,
-- 동일한 코드(국가) 안에서는 인구 수의 역군으로 표시하세요.
select countrycode, population
from city
order by countrycode asc, population desc;

-- city 테이블에서 국가 코드가 'KOR'인 도시의 수를 표시하세요
select count(countrycode)
from city
where countrycode = 'KOR';

-- city 테이블에서 KOR', JPN', 'CHN'인 도시의 수를 표시하세요
select name
from country
where Code in ('KOR', 'JPN', 'CHN');

-- 국가 코드가 'KOR' 이면서 인구가 100만 이상인 도시를 찾으세요
select name
from city
where countrycode = 'kor'
  and population >= 1000000;

-- 국가 코드가 'KOR'인 도시 중 인구수가 많은 순서로 상위 10개만 표시하세요
select name
from city
where countrycode = 'kor'
order by population desc
limit 10;

-- city 테이블에서 국가 코드가 'KOR'이고,
-- 인구가 100만 이상 500만 이하인 도시를 찾으세요
select name
from city
where countrycode = 'kor'
  and population between 1000000 and 5000000;