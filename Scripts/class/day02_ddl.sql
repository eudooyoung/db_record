use scott;

drop table dept;
drop table emp;
drop table salgrade;


CREATE TABLE DEPT
(
	DEPTNO INT,
	DNAME VARCHAR(14),
	LOC VARCHAR(13)
);



CREATE TABLE EMP
(
	EMPNO INT,
	ENAME VARCHAR(10),
	JOB VARCHAR(9),
	MGR INT,
	HIREDATE DATE,
	SAL INT,
	COMM DECIMAL(7,2),
	DEPTNO INT
);

CREATE TABLE SALGRADE
(
	GRADE INT,
	LOSAL  INT,
	HISAL  INT
);


ALTER TABLE DEPT ADD (
  CONSTRAINT PK_DEPT -- 뭘까
 PRIMARY KEY
 (DEPTNO));

ALTER TABLE EMP ADD (
  CONSTRAINT PK_EMP
 PRIMARY KEY
 (EMPNO));

ALTER TABLE EMP ADD (
  CONSTRAINT FK_DEPTNO 
 FOREIGN KEY (DEPTNO) 
 REFERENCES DEPT (DEPTNO));

--  
-- 
-- DDL (CREATE TABLE) 및 제약조건
-- **DDL(DATA DEFINITION LANGUAGE)**는 데이터 정의 언어로, 객체를 만들고(CREATE), 수정(ALTER)하고, 삭제(DROP)하는 구문
-- MySQL에서 객체는 주로 테이블(TABLE), 뷰(VIEW), 인덱스(INDEX) 등이 있다.
-- 제약조건 
-- 테이블작성시 각 컬럼에 대해 값 기록에 대한 제약조건을 설정할수 있다. 
-- 데이터 무결성 보장을 목적으로함 
-- 입력 / 수정 하는 데이터에 문제가 없는지 자동으로 검사하는 목적
-- PRIMARY KEY, NOT NULL, UNIQUE, CHECK, FOREIGN KEY


-- 저장할 대상: 엔티티(회원정보, 게시판, 상품), 엔티티간의 관계: 회원이 상품을 주문하다(주문정보)
--           엔티티 + 관계 ==> 테이블로 만들자.!!!!

CREATE TABLE member(
	no INT AUTO_INCREMENT PRIMARY KEY,
	id varchar(10),
	pw varchar(10)not null,
	name varchar(10),
	tel varchar(10),
	create_date timestamp

);

desc member; -- 테이블 구조 확인

-- show columns from member;

INSERT INTO MEMBER
VALUES(NULL,'m01', '1', '리사', '010',NOW());
INSERT INTO MEMBER
VALUES(NULL,'2', '2', '주혁', '010',NOW());
INSERT INTO MEMBER
VALUES(NULL,'3', '3', '3', '010',NOW());
INSERT INTO MEMBER
VALUES(NULL,'4', '4', '4', '010',NOW());
INSERT INTO MEMBER
VALUES(NULL,'5', '5', '5', '010',NOW());

commit;

select *
from member;

-- 1. 서브쿼리를 이용한 테이블 생성
--  NOT NULL 제약조건을 포함한 컬럼 구조는 복사되지만, PRIMARY KEY, AUTO_INCREMENT, INDEX가 복사되지 않음.

-- 1 구조복사 방법 
-- MEMBER2 테이블을 MEMBER의 구조를 복사해서 생성 (데이터는 복사하지 않음)
create table member2 -- 구조 카피 방법
as select * from member where 1 = 0; -- '1=0'은 줄정리용?

select * from member2;

desc member2;

create table member3
as select * from member;

select * from member3;

drop table if exists member2;

-- 2 구조복사 방법
-- 테이블 구조만 복사하여 생성
-- CREATE TABLE ... LIKE ...
-- NOT NULL 제약조건을 포함한 데이터 구조 + PRIMARY KEY, AUTO_INCREMENT, INDEX 복사됨 (하지만 FOREIGN KEY는 제외됨).

create table emp2
like emp;

select * from emp2;

insert into emp2
   (empno, ename, job, mgr, hiredate, sal, deptno)
values
   (7369, 'smith', 'clerk', 7902, 
    '1980-12-17', 800, 20);

commit;

-- 제약조건 
-- 테이블작성시 각 컬럼에 대해 값 기록에 대한 제약조건을 설정할수 있다. 
-- 데이터 무결성 보장을 목적으로함 
-- 입력 / 수정 하는 데이터에 문제가 없는지 자동으로 검사하는 목적
-- PRIMARY KEY, NOT NULL, UNIQUE, CHECK, FOREIGN KEY
-- 기본키(Primary Key)
-- **기본키(Primary Key)**는 테이블에서 각 행을 고유하게 식별하는 컬럼을 의미
-- NOT NULL과 UNIQUE 제약 조건이 결합된 형태로, 중복 값이 없고 NULL 값을 가질 수 없다.
-- 한 테이블에 하나만 설정할 수 있으며, 컬럼 레벨과 테이블 레벨 모두에서 설정 가능
-- 하나의 컬럼을 기본키로 설정하거나, 여러 컬럼을 묶어 복합키로 설정할 수 있다.
-- 
-- 
-- 외래키(Foreign Key)
-- **외래키(Foreign Key)**는 다른 테이블의 PRIMARY KEY 또는 UNIQUE 제약 조건이 설정된 컬럼을 참조하는 제약 조건이다.
-- 테이블 간의 관계를 설정하며, 참조 무결성을 유지하기 위해 사용된다.
--  외래키를 설정하면 참조된 테이블의 값만 사용할 수 있으며, 참조 무결성을 위반할 수 없게 된다.
--  테이블 레벨 에서 설정 가능

drop table member;

CREATE TABLE MEMBER (
  ID INT AUTO_INCREMENT PRIMARY KEY,  -- 컬럼 레벨에서 기본키 지정 , 속성을 통해 상품이 추가될 때마다 고유한 값이 자동으로 생성
  NAME VARCHAR(100),
  AGE INT
);

CREATE TABLE MEMBER (
  ID INT AUTO_INCREMENT, -- 속성을 통해 상품이 추가될 때마다 고유한 값이 자동으로 생성
  NAME VARCHAR(100),
  AGE INT
  PRIMARY key (id) -- 테이블 레벨에서 지정
);

create table orders(
	order_id int AUTO_INCREMENT,
	customer_id int,
-- 	primary key (order_id)
	constraint 
		primary key pk_orders_order_id (order_id), -- 기본키 제약조건명 지정 
	constraint fk_orders_cusomer_id
		foreign key (customer_id) references member(id) -- 테이블에서 외래키, 제약조건명 지정
);

desc orders;
show index from orders;

CREATE TABLE PRODUCTS (
  PRODUCT_ID INT AUTO_INCREMENT,  -- 상품 ID, 자동 증가
  NAME VARCHAR(100),              -- 상품명
  PRICE DECIMAL(10, 2),           -- 상품 가격
  STOCK INT,                      -- 재고 수량
  PRIMARY KEY (PRODUCT_ID)        -- PRODUCT_ID를 기본키로 설정
);

CREATE TABLE ORDER_ITEMS ( -- 주문 상세 테이블 
  ORDER_ID INT,              -- 주문 ID
  PRODUCT_ID INT,            -- 상품 ID
  QUANTITY INT,              -- 상품 수량
  PRICE DECIMAL(10, 2),      -- 상품 가격
  PRIMARY KEY (ORDER_ID, PRODUCT_ID), -- 복합키로 프라이머리 키 지정, 주문과 상품 id 조합이 고유해야함
  CONSTRAINT FK_ORDER 
  	FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID), 
  CONSTRAINT FK_PRODUCT
  	FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCTS(PRODUCT_ID)
);

drop table if exists order_items;

CREATE TABLE ORDER_ITEMS ( -- 주문 상세 테이블 
  ORDER_ITEM_ID INT auto_increment,              
  ORDER_ID INT,
  PRODUCT_ID INT,            -- 상품 ID
  QUANTITY INT,              -- 상품 수량
  PRICE DECIMAL(10, 2),      -- 상품 가격
  PRIMARY KEY (ORDER_ITEM_ID), -- 복합키로 프라이머리 키 지정, 주문과 상품 id 조합이 고유해야함
  CONSTRAINT FK_ORDER 
  	FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID), 
  CONSTRAINT FK_PRODUCT
  	FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCTS(PRODUCT_ID)
);

insert into order_items (order_id, product_id, quantity, price)
values(null, null, null, 100.10);


-- NOT NULL : 해당 컬럼에 반드시 값을 기록해야하는경우 사용
--           삽입/ 수정시 NULL 값을 허용하지 않도록 '컬럼레벨에서 제한 '

/*--------------------------------------------------------------------    
-- 아무런 제약 조건이 설정되지않은경우 NULL 값이 문제없이 삽입 됨,
-- ex) 제약조건 없으면 회원가입시 정보를 입력 하지않아도 가입이 처리 됨..
--------------------------------------------------------------------  */

drop table if exists order_items;

CREATE TABLE ORDER_ITEMS ( -- 주문 상세 테이블 
  ORDER_ITEM_ID INT auto_increment,              
  ORDER_ID INT not null,
  PRODUCT_ID INT not null,            -- 상품 ID
  QUANTITY INT not null,              -- 상품 수량
  PRICE DECIMAL(10, 2) not null,      -- 상품 가격
  PRIMARY KEY (ORDER_ITEM_ID), -- 복합키로 프라이머리 키 지정, 주문과 상품 id 조합이 고유해야함
  CONSTRAINT FK_ORDER 
  	FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID), 
  CONSTRAINT FK_PRODUCT
  	FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCTS(PRODUCT_ID)
);

select *
from order_items;

commit;
-- UNIQUE  제약조건 : 컬럼에 입력값에대한 중복을 제한하는 제약조건  
--                   컬럼레벨, 테이블레벨에서 설정가능

/*-----------------------------------------------------------------------
--	※ 실제 데이터 확인히 중복된 값이 들어가도 처리가 됨
--	ex) 회원 가입시 중복된 아이디가 가입되면 회원들을 구분할수 없게 됨

	UNIQUE 제약조건이 설정된 컬럼에는 중복 값은 넣을 수 없게 됨

	※ UNIQUE 제약 조건이 설정되었다 하더라도 NULL값으로 넣게 되면
	중복 처리가 되어 버림 
	이때 해결 방법은 UNIQUE 제약조건과 NOT NULL 제약 조건을 같이 주면 됨
------------------------------------------------------------------------*/


-- CHECK제약조건  : 컬럼에 기록되는 값에 조건을 설정할수있음 - 8버전부터가능
-- CHECK(컬럼명 비교연산자 비교값 )
-- 주의 : 비교값은 리터럴만 사용 할수있음 , 변하는 값이나 함수는 사용 못함. (자동 NOT NULL  규칙이 적용됨)
--  GENDER VARCHAR(10) CHECK(GENDER IN ('남','여')),


-- DEFAULT: 컬럼에 값이 입력되지 않았을 경우, 기본값을 자동으로 할당한다.


-- NOT NULL: 해당 컬럼이 NULL 값을 허용하지 않음을 보장.
-- UNIQUE: 중복된 값이 입력되지 않도록 고유한 값을 보장.
-- CHECK: 특정 조건을 만족하는 값만 허용하여 데이터 유효성을 보장.
-- DEFAULT: 값이 입력되지 않았을 경우, 기본값을 자동으로 할당하여 입력 데이터의 일관성을 유지.

-- 사용자 이름은 반드시 입력되며, 중복되지 않아야 함
-- 비밀번호는 반드시 입력되어야 함
-- 이메일은 중복될 수 없음 (중복 시 오류 발생)
-- 나이는 18세 이상 65세 이하로 제한

create table member4 (
	id int auto_increment primary key,
	username varchar(100) not null unique, -- not null: 반드시 입력
	password varchar(100) not null,
	email varchar(100) unique, -- unique: 중복 불가	
	age int check(age >= 18 and age <= 64), -- between 되는지 확인
	created_at timestamp default current_timestamp, -- default: 값이 입력되지 않았을 경우, 기본값을 자동으로 할당
	updated_at timestamp default current_timestamp on update current_timestamp 
);


-- 1. 모든 조건을 만족하는 정상적인 데이터 삽입
insert into member4 
	values(null, '김두영', 12234, '1223@123.com', 23, default, default);	 

-- 2. NOT NULL 위반: USERNAME이 NULL
insert into member4 
	values(null, null, 12234, '1223@123.com', 23, default, default);	

-- 3. UNIQUE 위반: USERNAME이 중복
insert into member4 
	values(null, '김두영', 12234, '1223@123.com', 23, default, default);	

-- 4. UNIQUE 위반: EMAIL이 중복
insert into member4 
	values(null, '김두영1', 12234, '1223@123.com', 23, default, default);	 

-- 5. CHECK 위반: AGE가 17 (범위 미만)
insert into member4 
	values(null, '김두영', 12234, '1223@123.com', 17, default, default);	 

-- 6. CHECK 위반: AGE가 66 (범위 초과)
insert into member4 
	values(null, '김두영', 12234, '1223@123.com', 66, default, default);	

-- 7. NULL 값 허용 필드 테스트: EMAIL이 NULL -- 정상적으로 삽입 unique 는 null 은허용된다
insert into member4 
	values(null, '김두영2', 12234, null, 23, default, default);


drop table if exists order_items, orders, products, member;
rollback;

use scott;

create table orders(
	order_id int AUTO_INCREMENT,
	customer_id int,
	constraint 
		primary key pk_orders_order_id (order_id) -- 기본키 제약조건명 지정 
-- 	primary key (order_id)
-- 	constraint fk_orders_cusomer_id
-- 		foreign key (customer_id) references member(id) -- 테이블에서 외래키, 제약조건명 지정
);

describe orders;

use hr;

create table member (
	ID int auto_increment primary key,
	PW varchar(100),
	NAME varchar(100),
	TEL varchar(100)
);

alter table member
add unique (NAME);

desc member;

create table board (
	NO int auto_increment,
	TITLE varchar(100),
	CONTENT varchar(100),
	WRITER varchar(100),
	constraint
		primary key pk_board_NO (NO),
	constraint fk_board_WRITER
		foreign key (WRITER) references member (NAME)
);

create table reply (
	ID int auto_increment,
	ORIID int,
	CONTENT varchar(100),
	WRITER varchar(100),
	constraint
		primary key pk_reply_ID (ID),
	constraint fk_reply_WRITER
		foreign key (WRITER) references member (NAME),
	constraint fk_reply_ORIID
		foreign key (ORIID) references board (NO)
);

-- 널빼고 컬럼지정해서 넣는 방식 확인
insert into member
values(null, '1234', '김두영', '12341234'),
	  (null, '5678', '김진영', '56785678'),
	  (null, '4321', '김세영', '43214321');

insert into board
values(null, '첫번째 제목', '안녕', '김두영'),
	     (null, '두번째', '안녕2', '김진영'),
	     (null, '세번째', '안녕3', '김세영');

insert into reply
values(null, 1, 're: 안녕', '김두영'),
	     (null, 2, 're: 안녕2', '김진영'),
	     (null, 3, 're: 안녕3', '김세영');

select *
from reply;

delete
from reply;


-- drop table if exists reply, board;
-- 
-- select *
-- from member4;
-- 
-- delete
-- from member4;

drop table if exists member4;

create table member4(
	ID INT AUTO_INCREMENT PRIMARY KEY COMMENT '아이디',
	USERNAME VARCHAR(100) not null unique COMMENT '이름',
	PASSWORD VARCHAR(100) not NULL COMMENT '비밀번호',
	EMAIL VARCHAR(100) UNIQUE COMMENT '이메일',
	AGE INT CHECK(AGE >= 18 and AGE <= 65) COMMENT '나이',
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '생성일', -- 생성일
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP  COMMENT '수정일',-- 수정일
	CONSTRAINT UC_member4_EMAIL UNIQUE (EMAIL),      
	CONSTRAINT CK_member4_AGE CHECK (AGE >= 18 and AGE <= 65)  -- 성별 값 체크
);

-- -----------------------------

-- 컬럼 추가/삭제/변경, 제약조건 추가/삭제/변경
-- 테이블명 변경, 제약조건 이름 변경
-- ALTER 구문 사용 예시

-- 컬럼 추가

-- 제약조건 추가
-- MySQL에서는 PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK 제약조건을 아래와 같이 추가 가능
-- ALTER TABLE 테이블명 ADD PRIMARY KEY(컬럼명)
-- ALTER TABLE 테이블명 ADD FOREIGN KEY(컬럼명) REFERENCES 테이블명(컬럼명)
-- ALTER TABLE 테이블명 ADD UNIQUE(컬럼명)
-- ALTER TABLE 테이블명 ADD CHECK(컬럼명 비교연산자 비교값)
-- ALTER TABLE 테이블명 MODIFY 컬럼명 데이터타입 NOT NULL

-- EX>
-- ALTER TABLE MEMBER2 ADD PRIMARY KEY (ID);
-- ALTER TABLE MEMBER2 MODIFY NAME VARCHAR(100) NULL; -- 이미 NOT NULL인 경우 NULL로 변경 가능

-- ---------

-- TEST11 테이블 생성
CREATE TABLE TEST11 (
  ID VARCHAR(100) PRIMARY KEY,  -- 기본키
  NAME VARCHAR(100) UNIQUE      -- 유니크 제약조건
);

-- 데이터 삽입
INSERT INTO TEST11 VALUES ('123', '123');
INSERT INTO TEST11 VALUES ('111', '111');

-- TEST22 테이블 생성
CREATE TABLE TEST22 (
  ID VARCHAR(100),
  NAME VARCHAR(100),
  TEST_ID VARCHAR(100),
  CONSTRAINT FK_TEST22_TEST11
  	FOREIGN KEY (TEST_ID) REFERENCES TEST11(ID)  
);

INSERT INTO TEST22 VALUES ('123', '123', '111');
INSERT INTO TEST22 VALUES ('123', '123', '114'); -- 참조테이블에 없는 값을 넣으려고하면 오류

delete
from test22
where id = 123;

commit;

alter table test22 add ADDR varchar(100);

desc test22;

-- 컬럼 자료형 수정
-- MySQL에서 컬럼 크기 변경 가능
-- 기존 데이터를 유지할 수 있는 경우에만 크기 줄이기가 가능
alter table test22 modify ADDR varchar(20);

desc test22;

-- 컬럼 이름 변경
-- MySQL에서는 RENAME COLUMN 사용
alter table test22 rename column ADDR to ADDR2;

desc test22;

-- 컬럼 생성 시 DEFAULT 값 지정
alter table test22 add LOC varchar(20) default '한국';

-- 컬럼에 제약조건 추가
-- PRIMARY KEY, UNIQUE 제약조건 추가
ALTER TABLE TEST22
ADD CONSTRAINT PK_TEST22_ID PRIMARY KEY (ID);
ALTER TABLE TEST22
ADD CONSTRAINT UN_TEST22_NAME UNIQUE (NAME);

-- 제약조건 삭제
-- PRIMARY KEY, UNIQUE 제약조건 삭제
ALTER TABLE TEST22 DROP PRIMARY KEY;
ALTER TABLE TEST22 DROP INDEX UN_TEST22_NAME; -- UNIQUE 제약조건은 인덱스와 동일하게 처리됨

-- NOT NULL 제약조건 삭제
ALTER TABLE TEST22 MODIFY LOC VARCHAR(20) NULL;

desc test22;

-- 컬럼 삭제
-- MySQL에서는 DROP COLUMN 구문 사용
ALTER TABLE TEST22 DROP COLUMN ADDR2;
desc test22;

alter table test22 drop column test_id;

alter table test22 drop foreign key fk_test22_test11; -- 외래키 지정시 형식아이디? 확인

desc test22;

drop table test11;

drop table test22;

CREATE TABLE TEST11 (
  ID VARCHAR(100) PRIMARY KEY,  -- 기본키
  NAME VARCHAR(100) UNIQUE      -- 유니크 제약조건
);

-- 데이터 삽입
INSERT INTO TEST11 VALUES ('123', '123');
INSERT INTO TEST11 VALUES ('111', '111');

-- TEST22 테이블 생성
CREATE TABLE TEST22 (
  ID VARCHAR(100),
  NAME VARCHAR(100),
  TEST_ID VARCHAR(100),
  CONSTRAINT FK_TEST22_TEST11
  	FOREIGN KEY (TEST_ID) REFERENCES TEST11(ID)  
);

INSERT INTO TEST22 VALUES ('123', '123', '111');
INSERT INTO TEST22 VALUES ('123', '123', '114');

-- 부모테이블 삭제시 처리조건 
-- ON DELETE CASCADE: 부모 테이블의 데이터를 삭제할 때, 자식 테이블에서 해당 외래키를 참조하는 데이터도 자동으로 삭제
-- ON UPDATE CASCADE: 부모 테이블의 기본키 값이 변경되면 자식 테이블의 외래키 값도 자동으로 업데이트

use scott;

DROP TABLE IF EXISTS REPLY, BOARD, MEMBER ;

CREATE TABLE MEMBER (
  MEMBER_ID INT AUTO_INCREMENT PRIMARY KEY,  -- 회원 ID, 자동 증가 및 기본키
  NAME VARCHAR(100) NOT NULL                 -- 회원 이름
);

CREATE TABLE BOARD (
  BOARD_ID INT AUTO_INCREMENT PRIMARY KEY,   -- 게시글 ID, 자동 증가 및 기본키
  TITLE VARCHAR(100) NOT NULL,               -- 게시글 제목
  WRITER_ID INT,                             -- 작성자 ID (외래키)
  CONSTRAINT FK_WRITER 
	FOREIGN KEY (WRITER_ID) REFERENCES MEMBER(MEMBER_ID)
  	on delete cascade
  	on update cascade
);

INSERT INTO MEMBER (NAME) VALUES ('유재석');
INSERT INTO MEMBER (NAME) VALUES ('제니');
INSERT INTO MEMBER (NAME) VALUES ('이광수');

INSERT INTO BOARD (TITLE, WRITER_ID) VALUES ('첫 번째 게시글', 1); 
INSERT INTO BOARD (TITLE, WRITER_ID) VALUES ('두 번째 게시글', 2); 
INSERT INTO BOARD (TITLE, WRITER_ID) VALUES ('세 번째 게시글', 3);

commit;

select *
from member;

select *
from board;

delete from member where member_id = 1;
update member set member_id = 10 where member_id = 2;

commit;

create database SQLDB;

use SQLDB;

-- 다른 데이터베이스에 있는 테이블 복사
create table board_copy
as select * from scott.board;

select * from board_copy;

-- 구조만복사
create table board_copy2 like scott.board;
select * from board_copy2;

-- 다른 테이블 데이터 추가
insert into board_copy2
select * from scott.board;

commit;

CREATE TABLE old_table1 (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE old_table2 (
    id INT PRIMARY KEY,
    description TEXT
);

-- 여러 테이블의 이름을 동시에 변경
-- RENAME TABLE old_table1 TO new_table1, old_table2 TO new_table2;

rename table old_table1 to new_table1, old_table2 to new_table2;
select * from new_table1;

CREATE TABLE A (
    id INT PRIMARY KEY,
    name VARCHAR(20)
);
INSERT INTO A (id, name) VALUES (1, 'Alice');
INSERT INTO A (id, name) VALUES (2, 'Bob');
commit;
select * from A;

TRUNCATE TABLE A;
rollback;
desc A;
select * from A;

drop table A;
delete from A;
rollback; -- rollback 확인
select * from A;
desc A;

CREATE TABLE TB_EMP (
    employee_id INT , 
    name VARCHAR(100) NOT NULL,                 
    department VARCHAR(50),                     
    salary DECIMAL(10, 2)                       
);
SELECT * FROM tb_emp;
-- 새로운 열을 추가
alter table TB_EMP
add column age INT;

-- 기존 열을 삭제
ALTER TABLE TB_EMP
DROP COLUMN age;

-- 컬럼 데이터 타입이나 속성 수정
ALTER TABLE TB_EMP
MODIFY COLUMN salary INT;

desc tb_emp;

-- 컬럼 이름과 속성을 모두 변경할 때 사용
ALTER TABLE TB_EMP
CHANGE COLUMN name full_name VARCHAR(150);

-- 테이블의 이름을 변경
ALTER TABLE TB_EMP
RENAME TO staff;

desc staff;
-- PRIMARY KEY를 추가하여 열에 기본 키 제약 조건을 설정
ALTER TABLE staff
ADD PRIMARY KEY (employee_id);

desc staff;

-- FOREIGN KEY 제약 조건을 추가하여 열을 다른 테이블의 열과 연결
-- ALTER TABLE 수정할테이블명
-- ADD FOREIGN KEY (수정할컬럼명) REFERENCES 참조테이블명(참조컬럼명);

SELECT * FROM staff;

-- UNIQUE 제약 조건을 추가
ALTER TABLE staff
ADD UNIQUE (full_name);
desc staff;

-- 테이블의 모든 제약 조건 조회
SELECT CONSTRAINT_NAME, TABLE_NAME, CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'staff';


-- staff 테이블의 인덱스 정보를 확인 해서도 삭제가능 
SHOW INDEX FROM staff;

-- UNIQUE 제약 조건을 삭제
ALTER TABLE staff
DROP INDEX full_name;

desc staff;
select * from staff;

DROP TABLE IF EXISTS TB_EMP;


CREATE TABLE IF NOT EXISTS TB_EMP (
    id INT,     
    name VARCHAR(50) UNIQUE,                
    position VARCHAR(50)
);

INSERT IGNORE INTO TB_EMP (name, position) VALUES ('제니', 'Manager'); -- insert ignore는 에러나면 건너뜀?
INSERT IGNORE INTO TB_EMP (name, position) VALUES ('제니', 'Manager');
INSERT IGNORE INTO TB_EMP (name, position) VALUES ('리사', 'Manager');

select * from tb_emp;
delete from tb_emp;

-- 열이 존재하지 않는 경우 추가 후 AUTO_INCREMENT 설정
ALTER TABLE TB_EMP 
ADD COLUMN emp_id INT PRIMARY KEY AUTO_INCREMENT;

-- AUTO_INCREMENT 속성 제거
ALTER TABLE TB_EMP 
MODIFY COLUMN emp_id INT;

-- 이미 존재하는 열에 AUTO_INCREMENT 속성을 추가
ALTER TABLE TB_EMP 
MODIFY COLUMN emp_id INT AUTO_INCREMENT;

DESCRIBE TB_EMP;

commit;

