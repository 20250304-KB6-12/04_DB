-- book_management 스키마에 SQL 적용
-- use book_management;

DROP TABLE IF EXISTS `loan_records`;
DROP TABLE IF EXISTS `books`;
DROP TABLE IF EXISTS `categories`;
DROP TABLE IF EXISTS `students`;
DROP TABLE IF EXISTS `departments`;
DROP TABLE IF EXISTS `undergraduates`;



CREATE TABLE `departments` (
	`dept_id`	INT	NOT NULL,
	`dept_name`	VARCHAR(100)	NOT NULL,
	`undergraduate_id`	INT	NOT NULL
);


CREATE TABLE `students` (
	`student_id`	INT	NOT NULL,
	`student_name`	VARCHAR(30)	NOT NULL,
	`address`	VARCHAR(200)	NULL,
	`phone`	VARCHAR(20)	NULL,
	`dept_id`	INT	NOT NULL
);



CREATE TABLE `categories` (
	`category_id`	INT	NOT NULL,
	`category_name`	VARCHAR(100)	NOT NULL,
	`position`	VARCHAR(100)	NOT NULL
);



CREATE TABLE `undergraduates` (
	`undergraduate_id`	INT	NOT NULL,
	`undergraduate_name`	VARCHAR(100)	NOT NULL,
	`establish_date`	DATE	NULL
);



CREATE TABLE `loan_records` (
	`loan_id`	INT	NOT NULL,
	`loan_date`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`due_date`	DATETIME	NULL,
	`student_id`	INT	NOT NULL,
	`book_id`	INT	NOT NULL
);



CREATE TABLE `books` (
	`book_id`	INT	NOT NULL,
	`title`	VARCHAR(200)	NOT NULL,
	`author`	VARCHAR(50)	NOT NULL,
	`publisher`	VARCHAR(100)	NOT NULL,
	`price`	INT	NOT NULL,
	`category_id`	INT	NOT NULL
);



ALTER TABLE `departments` ADD CONSTRAINT `PK_DEPARTMENTS` PRIMARY KEY (
	`dept_id`
);

ALTER TABLE `students` ADD CONSTRAINT `PK_STUDENTS` PRIMARY KEY (
	`student_id`
);

ALTER TABLE `categories` ADD CONSTRAINT `PK_CATEGORIES` PRIMARY KEY (
	`category_id`
);

ALTER TABLE `undergraduates` ADD CONSTRAINT `PK_UNDERGRADUATES` PRIMARY KEY (
	`undergraduate_id`
);

ALTER TABLE `loan_records` ADD CONSTRAINT `PK_LOAN_RECORDS` PRIMARY KEY (
	`loan_id`
);

ALTER TABLE `books` ADD CONSTRAINT `PK_BOOKS` PRIMARY KEY (
	`book_id`
);

-- PK 끝

-- PK 컬럼 값 자동 증가
ALTER TABLE `undergraduates` MODIFY `undergraduate_id` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `departments` MODIFY `dept_id` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `students` MODIFY `student_id` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `categories` MODIFY `category_id` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `books` MODIFY `book_id` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `loan_records` MODIFY `loan_id` INT NOT NULL AUTO_INCREMENT;


-- FK 시작

ALTER TABLE `departments` ADD CONSTRAINT `FK_undergraduates_TO_departments_1` FOREIGN KEY (
	`undergraduate_id`
)
REFERENCES `undergraduates` (
	`undergraduate_id`
);

ALTER TABLE `students` ADD CONSTRAINT `FK_departments_TO_students_1` FOREIGN KEY (
	`dept_id`
)
REFERENCES `departments` (
	`dept_id`
);

ALTER TABLE `loan_records` ADD CONSTRAINT `FK_students_TO_loan_records_1` FOREIGN KEY (
	`student_id`
)
REFERENCES `students` (
	`student_id`
);

ALTER TABLE `loan_records` ADD CONSTRAINT `FK_books_TO_loan_records_1` FOREIGN KEY (
	`book_id`
)
REFERENCES `books` (
	`book_id`
);

ALTER TABLE `books` ADD CONSTRAINT `FK_categories_TO_books_1` FOREIGN KEY (
	`category_id`
)
REFERENCES `categories` (
	`category_id`
);

