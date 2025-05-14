-- 한 줄 주석
/* 범위 주석 */

-- 테이블 삭제
-- drop table memberTBL;
-- drop table productTBL;

/* 데이터베이스 선택 방법
 방법 1) 왼쪽 Navigator >> Schemas 탭 >> SQL 수행할 데이터베이스 더블 클릭
 방법 2) use 데이터베이스명;  실행
*/
use shopdb;

/* memberTBL 테이블 생성 */
CREATE TABLE memberTBL (
    memberID CHAR(8) NOT NULL,
    memberName CHAR(5) NOT NULL,
    memberAddress CHAR(20) NULL,
    PRIMARY KEY (memberID)
); 

/* memberTBL 테이블에 샘플 데이터 4행 삽입 */
INSERT INTO memberTBL VALUES
('Dang', '당탕이', '경기 부천시 중동'),
('Jee', '지운이', '서울 은평구 중산동'),
('Han', '한주연', '인천 남구 주안동'),
('Sang', '상길이', '경기 성남시 분당구');

/* 샘플 데이터 삽입 확인 */
SELECT * FROM memberTBL;



/* productTBL 테이블 생성 */
CREATE TABLE productTBL (
    productName CHAR(4) NOT NULL,
    cost INT NOT NULL,
    makeDate DATE,
    company CHAR(5),
    amount INT NOT NULL,
    PRIMARY KEY (productName)
);
 
/* productTBL 샘플데이터 3행 삽입 */
INSERT INTO productTBL VALUES
('컴퓨터', 10, '2021-01-01', '삼성', 17),
('세탁기', 20, '2022-09-01', 'LG', 3),
('냉장고', 5, '2023-02-01', '대우', 22);

/* 샘플 데이터 삽입 확인 */
SELECT * FROM productTBL;



-- 특정 열 조회
SELECT memberName, memberAddress FROM memberTBL;

-- 조건부 조회
SELECT * FROM memberTBL WHERE memberName = '지운이';

