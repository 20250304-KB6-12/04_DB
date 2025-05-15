USE sqldb;

-- 학생 테이블, 동아리 테이블, 학생 동아리 테이블을 이용해서
-- 학생을 기준으로 학생이름/지역/가입한 동아리/동아리방을 출력하세요
SELECT s.stdName,
       s.addr,
       sc.clubName,
       c.roomNo
FROM stdtbl s
         JOIN
     stdclubtbl sc on s.stdName = sc.stdName
         JOIN
     clubtbl c on sc.clubName = c.clubName
ORDER BY s.stdName;


-- 동아리를 기준으로 가입한 학생의 목록을 출력하세요
-- 출력 정보 : clubName, roomNo, stdName, addr
SELECT *
FROM clubtbl c
         JOIN
     stdclubtbl sc on c.clubName = sc.clubName
         JOIN
     stdtbl s on sc.stdName = s.stdName
ORDER BY c.clubName;

-- 앞에서 추가한 테이블에서 '우대리'의 상관 연락처 정보를 확인하세요.
-- 출력할 정보: 부하직원, 직속상관, 직속상관연락처
SELECT
    A.emp AS '부하직원',
    B.emp AS '직속상관',
    B.empTel AS '직속상관연락처'
FROM
    empTbl A
JOIN
    empTbl B ON A.manager = B.emp
WHERE
    A.emp = '우대리';



USE employees;

-- 현재 재직 중인 직원의 정보를 출력하세요
-- 출력 항목: emp_no, first_name, last_name, title
SELECT
    e.emp_no,
    first_name,
    last_name,
    title
FROM
    employees e
JOIN
    titles t  on e.emp_no = t.emp_no
WHERE
    t.to_date = '9999-01-01';


-- 현재 재직 중인 직원 정보를 출력하세요
-- 출력항목: 직원의 기본 정보 모두, title, salary
SELECT
    e.*,
    t.title,
    s.salary
FROM
    employees e
JOIN
    titles t  on e.emp_no = t.emp_no
JOIN
    salaries s on t.emp_no = s.emp_no
WHERE
    t.to_date = '9999-01-01'
    AND s.to_date = '9999-01-01';


-- 현재 재직중인 직원의 정보를 출력하세요.
-- 출력항목: emp_no, first_name, last_name, dept_name
-- 정렬: emp_no 오름 차순
SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    d.dept_name
FROM
    employees e
JOIN
    dept_emp de on e.emp_no = de.emp_no
JOIN
    departments d on d.dept_no = de.dept_no
WHERE
    de.to_date = '9999-01-01'
ORDER BY
    e.emp_no;

-- 부서별 재직중인 직원의 수를 출력하세요
-- 출력 항목: 부서 번호, 부서명, 인원수 ○ 정렬: 부서 번호 오름차순
SELECT
    d.dept_no,
    d.dept_name,
    COUNT(*)
FROM
    departments d
JOIN
    dept_emp de on d.dept_no = de.dept_no
WHERE
    de.to_date = '9999-01-01'
GROUP BY
    d.dept_no,
    d.dept_name
ORDER BY
    d.dept_no;


-- 직원 번호가 10209인 직원의 부서 이동 히스토리를 출력하세요.
-- 출력항목: emp_no, first_name, last_name, dept_name, from_date, to_date
SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    d.dept_name,
    de.from_date,
    de.to_date
FROM
    employees e
JOIN
    dept_emp de on e.emp_no = de.emp_no
JOIN
    departments d on d.dept_no = de.dept_no
WHERE
    e.emp_no = 10209
ORDER BY
    from_date;