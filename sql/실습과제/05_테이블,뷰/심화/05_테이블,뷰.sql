-- userTBL 이 존재하면 drop
drop table if exists userTBL;

-- userTBL 생성
create table userTBL
(
    userID    char(8)     not null primary key,
    name      varchar(10) not null,
    birthYear int         not null
);

drop table if exists buyTBL;

-- buyTBL
CREATE TABLE buyTBL
(
    num      INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    userID   CHAR(8)            NOT NULL,
    prodName CHAR(6)            NOT NULL
);

ALTER TABLE buyTBL
    ADD CONSTRAINT FK_userTBL_buyTBL
        FOREIGN KEY (userID)
            REFERENCES userTBL (userID);





create database tableDB;
USE tableDB;
DROP TABLE IF EXISTS buyTBL, userTBL;
CREATE TABLE userTBL
(
    userID    CHAR(8)     NOT NULL PRIMARY KEY,
    name      VARCHAR(10) NOT NULL,
    birthYear INT         NOT NULL,
    email     CHAR(30)    NULL UNIQUE
);

drop table if exists userTBL;
create table userTBL
(
    userID char(8) primary key,
    name varchar(10),
    birthYear int check (birthYear >= 1900 and birthYear <= 2023),
    mobile1 char(3) null,
    CONSTRAINT ck_name check ( name is not null )
);



drop table if exists usertbl;
create table userTBL
(
    userID char(8) not null primary key ,
    name varchar(10) not null ,
    birthYear int not null default -1,
    addr char(2) not null default '서울',
    mobile1 char(3) null,
    mobile2 char(8) null,
    height smallint null default 170,
    mDate date null
);


-- default 문은 deafult 로 설정된 값을 자동 입력
insert into usertbl values (
                               'LHL', '이혜리', default, default, '011', '1234567', default, '2023.12.12');

-- 열이름이 명시되지 않으면 default로 설정된 값을 자동으로 입력
insert into usertbl (userID, name)
values ('KAY', '김아영');

-- 값이 직접 명시되면 default로 설정된 값은 무시
insert into usertbl values (
                               'WB', '원빈', 1982, '대전', '019', '9876543', default, '2020.5.5');

select *
from usertbl;






CREATE OR REPLACE VIEW EMPLOYEES_INFO
AS
SELECT e.*,
       t.title,
       t.from_date t_from,
       t.to_date   t_to,
       s.salary,
       s.from_date s_from,
       s.to_date   s_to
FROM employees e
         INNER JOIN titles t
                    ON e.emp_no = t.emp_no
         INNER JOIN salaries s
                    ON e.emp_no = s.emp_no;

SELECT *
FROM EMPLOYEES_INFO;

EXPLAIN
SELECT *
FROM EMPLOYEES_INFO
WHERE s_to = '9999-01-01';

SELECT *
FROM EMPLOYEES_INFO
WHERE t_to = '9999-01-01';

EXPLAIN
SELECT emp_no,
       birth_date,
       first_name,
       last_name,
       gender,
       hire_date,
       title,
       t_to,
       salary
FROM employees_info main
WHERE t_to = '9999-01-01' -- 현재 직급 재직 중
  AND s_to = '9999-01-01' -- 현재 유효한 급여 정보
GROUP BY emp_no, birth_date, first_name, last_name, gender, hire_date, title, t_from, salary
ORDER BY emp_no;


explain
SELECT e.*,
       t.title,
       t.from_date t_from,
       t.to_date   t_to,
       s.salary,
       s.from_date s_from,
       s.to_date   s_to
FROM (select * from employees where emp_no > 0) e
         INNER JOIN titles t
                    ON e.emp_no = t.emp_no
         INNER JOIN salaries s
                    ON e.emp_no = s.emp_no;



CREATE OR REPLACE VIEW EMP_DEPT_INFO
AS
SELECT e.emp_no, d.dept_no, d.dept_name, de.from_date, de.to_date
FROM departments d
         INNER JOIN dept_emp de
                    ON d.dept_no = de.dept_no
         INNER JOIN employees e
                    ON de.emp_no = e.emp_no;

SELECT *
FROM EMP_DEPT_INFO
WHERE to_date = '9999-01-01'