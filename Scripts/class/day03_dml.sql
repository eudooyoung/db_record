
use scott;

-- 그룹함수와 단일행함수
-- 단일행함수는 각 행에 대해 하나의 값을 반환하며,
-- 그룹함수는 여러 행에 대해 하나의 결과를 반환한다.

-- 단일행 함수
-- 문자 관련 함수: LENGTH, CONCAT, SUBSTR, UPPER, LOWER, INSTR 등

-- CONCAT: 문자열을 하나로 합친다.
USE scott;

select * from emp;

-- day01 에 emp insert 까지하고 시작 
SELECT CONCAT(CONCAT(EMPNO, ':'), ENAME) AS CONCAT_RESULT FROM EMP;

-- LENGTH: 문자열의 길이를 구한다.
SELECT LENGTH(ENAME) FROM EMP;

-- TRIM: 주어진 문자열의 앞/뒤에서 지정한 문자를 제거한다.
SELECT ENAME, TRIM(BOTH 'A' FROM ENAME) FROM EMP;  -- 양쪽 끝에서 'A' 제거
SELECT ENAME, TRIM(LEADING 'A' FROM ENAME) FROM EMP;  -- 왼쪽에서 'A' 제거
SELECT ENAME, TRIM(TRAILING 'A' FROM ENAME) FROM EMP;  -- 오른쪽에서 'A' 제거

select * from emp;

-- REPLACE: 문자열을 대체한다.
SELECT ENAME,REPLACE(ENAME, ' ', '') FROM EMP;
SELECT REPLACE('서울시 강남구 역삼동', '역삼동', '삼성동') AS VAL;

-- SUBSTR: 문자열의 일부를 잘라낸다.
SELECT ENAME, 
       SUBSTR(HIREDATE, 3, 2) AS 입사년도, 
       SUBSTR(HIREDATE, 6, 2) AS 입사월, 
       SUBSTR(HIREDATE, 9, 2) AS 입사일
FROM EMP;

-- NULL 처리 함수: NVL 대신 IFNULL 사용
-- IFNULL(컬럼명, NULL일 때 대체할 값)

select ename, comm, ifnull(comm, 0) comm1 from emp;

-- 숫자 관련 함수: ABS, MOD, ROUND, FLOOR, TRUNC, CEIL

-- ABS: 절대값을 구하는 함수
SELECT ABS(-10) AS COL1, ABS(10) AS COL2;

-- MOD: 나머지를 구하는 함수
SELECT MOD(10, 5) AS COL1, MOD(10, 3) AS COL2;

-- ROUND: 반올림 함수
SELECT ROUND(123.456) AS ROUND_NO_DECIMAL;  -- 반올림
SELECT ROUND(123.456, 1) AS ROUND_ONE_DECIMAL;  -- 소수점 첫째 자리까지출력, 둘째자리 반올림

-- FLOOR: 내림 함수
SELECT FLOOR(123.456) AS FLOOR_RESULT;

-- TRUNC (MySQL에서는 TRUNC 대신 ROUND를 사용)
SELECT ROUND(123.456, 0) AS TRUNC_RESULT;  -- 소수점 이하 자르기

-- CEIL: 올림 함수
SELECT CEIL(123.456) AS CEIL_RESULT;

-- 날짜 함수: CURDATE(), MONTHS_BETWEEN() 대신 TIMESTAMPDIFF 사용
-- SYSDATE 대신 NOW() 또는 CURRENT_TIMESTAMP 사용

-- SYSDATE: 현재 날짜와 시간을 반환 (NOW() 또는 CURRENT_TIMESTAMP로 대체)
SELECT NOW() AS SYSDATE;  -- 또는
SELECT CURRENT_TIMESTAMP AS SYSDATE;

-- TIMESTAMPDIFF: 두 날짜 사이의 개월 수 계산
SELECT ENAME, HIREDATE, TIMESTAMPDIFF(MONTH, HIREDATE, NOW()) AS MONTHS_BETWEEN FROM EMP;

-- ADD_MONTHS: 날짜에 개월 수 더하기
SELECT DATE_ADD(NOW(), INTERVAL 5 MONTH) AS ADD_5_MONTHS;
SELECT DATE_ADD(NOW(), INTERVAL -1 MONTH) AS SUBTRACT_1_MONTH;

-- WEEKDAY(): 주어진 날짜의 요일을 반환 월요일(0)부터 일요일(6)까지
select WEEKDAY(NOW());
-- 7 -weekday(now() 로 다음주 월요일까지 기간을 구하고 + 3일
SELECT NOW() AS TODAY, DATE_ADD(NOW(), INTERVAL (7 - WEEKDAY(NOW())) + 3 DAY) AS NEXT_THURSDAY;

-- LAST_DAY: 해당 월의 마지막 날을 반환
SELECT LAST_DAY(NOW()) AS LAST_DAY_OF_MONTH;

-- EXTRACT: 특정 날짜에서 연도, 월, 일을 추출
SELECT EXTRACT(YEAR FROM CURRENT_TIMESTAMP) AS 년도, 
       EXTRACT(MONTH FROM CURRENT_TIMESTAMP) AS 월, 
       EXTRACT(DAY FROM CURRENT_TIMESTAMP) AS 일;

-- DATE_FORMAT: 날짜 데이터를 특정 형식으로 변환
SELECT DATE_FORMAT(CURRENT_TIMESTAMP, '%Y년 %m월 %d일') AS 포맷_날짜; -- 대문자로

-- CAST
-- 데이터를 특정 데이터 타입으로 변환하는 함수

-- 비표준
SELECT CAST('2020$12$12' AS DATE);
SELECT CAST('2020/12/12' AS DATE);
SELECT CAST('2020%12%12' AS DATE);
SELECT CAST('2020@12@12' AS DATE);

SELECT CAST('2020-12-12' AS DATE); -- 표준 형식SELECT CAST('2020-12-12' AS DATE); -- 표준 형식
select cast(replace('2020$12$12', '$', '-') as date);


SELECT CONVERT(AVG(PRICE) , SIGNED INTEGER) AS '평균 구매 가격'  FROM PRODUCTS ;

-- %Y → 4자리 연도 (예: 2024)
-- %y → 2자리 연도 (예: 24 → 2024)
-- %m → 2자리 월 (예: 01 ~ 12)
-- %d → 2자리 일 (예: 01 ~ 31)
-- %H → 24시간 형식 시 (예: 00 ~ 23)
-- %i → 분 (예: 00 ~ 59)
-- %s → 초 (예: 00 ~ 59)

SELECT STR_TO_DATE('2020$12$12', '%Y$%m$%d');

SELECT STR_TO_DATE('2024-02-12 14:30:45', '%Y-%m-%d %H:%i:%s');

CREATE TABLE PRODUCTS (
  PRODUCT_ID INT AUTO_INCREMENT,  -- 상품 ID, 자동 증가
  NAME VARCHAR(100),              -- 상품명
  PRICE DECIMAL(10, 2),           -- 상품 가격
  STOCK INT,                      -- 재고 수량
  PRIMARY KEY (PRODUCT_ID)        -- PRODUCT_ID를 기본키로 설정
);
INSERT INTO PRODUCTS (NAME, PRICE, STOCK)
VALUES 
  ('노트북', 1200000.10, 50),    -- 노트북
  ('스마트폰', 950000.20, 100), -- 스마트폰
  ('태블릿', 500000.00, 70),    -- 태블릿
  ('이어폰', 50000.00, 200),    -- 이어폰
  ('모니터', 300000.00, 80);    -- 모니터
COMMIT;

SELECT AVG(PRICE) AS '평균 구매 가격' FROM PRODUCTS ;
SELECT CAST(AVG(PRICE) AS SIGNED INTEGER) AS '평균 구매 가격'  FROM PRODUCTS ;

SELECT CAST(AVG(PRICE) AS SIGNED ) AS '평균 구매 가격'  FROM PRODUCTS ; -- SIGNED 디폴트가 INTEGER

-- IF(조건, true_value, false_value):
select if(100 > 200, '참이다', '거짓이다');

-- IFNULL(검사할 값, NULL일 경우 반환할 대체 값.):
-- 값이 NULL인 경우 대체 값을 반환
select ifnull(null, '널이다.') val1,
	   ifnull(100, '널이다') val2;

-- NULLIF는 두 값이 같으면 NULL을 반환하고, 그렇지 않으면 첫 번째 값을 반환하는 함수
select nullif(2, 2) val1,
	   nullif(2, 4) val2;

-- CASE문
/* CASE
        WHEN 조건식 THEN 결과값
        WHEN 조건식 THEN 결과값
    ELSE 결과값
    END*/
-- 단일 값 비교(CASE value WHEN ...)
SELECT 	CASE 10   -- 비교 대상 값: 10
		WHEN 1  THEN  '일'
		WHEN 5  THEN  '오'
		WHEN 10 THEN  '십' 
		ELSE '모름'
	END as 'CASE연습';
-- 조건식 비교 방식의 CASE 구문

-- 직원의 급여를 인상하고자 한다
-- 직급코드가 SALESMAN인 직원은 급여의 10%를 인상하고
-- 직급코드가 MANAGER인 직원은 급여의 15%를 인상하고
-- 직급코드가 clerk 직원은 급여의 20%를 인상한다.
-- 그 외 직급의 직원은 5%만 인상한다.
-- 직원 테이블에서 직원명, 직급코드, 급여, 인상급여(위 조건)을
-- 조회하세요

select *
from emp;

select ename, deptno, sal,
	case
		when job = 'salseman' then sal * 1.1
		when job = 'manager' then sal * 1.15
		when job = 'clerk' then sal * 1.2
		else sal * 1.05
	end as changesal
from emp;

-- 사원의 급여에 따라 등급을 구분하는 CASE 구문
  -- 사번, 사원명, 급여를 EMP 테이블에서 조회하고 
-- 급여가 2500만원 초과이면 '고급'
-- 급여가 1500~2500만원이면 '중급'
-- 그이하는 초급으로 출력하고 별칭은 'GRADE' 이라고한다.

select empno, ename, sal, 
	case
		when sal > 2500 then '고급'
		when sal between 1500 and 2500 then '중급'
		else '초급'
	end as grade
from emp
order by sal desc;

commit;

-- COUNT, SUM, AVG, MIN, MAX 그룹 함수\


select count(sal), sum(sal), avg(sal), min(sal), max(sal)
from emp
where job = 'clerk';

select *
from emp;

select job, deptno, count(*)
from emp
group by job, deptno;
-- where job = 'salesman';

select sal
from emp
where job = 'salesman';

-- 직급별 집계
select job, count(sal), sum(sal), avg(sal), min(sal), max(sal)
from emp
group by job;

select job, count(sal), sum(sal) salary, avg(sal), min(sal), max(sal)
from emp
group by job
having salary > 5000 -- 그룹화된 컬럼에 주는 조건
order by salary desc; -- 부여한 별칭으로 사용 가능

-- COUNT(*)은 사용 가능하지만, 다른 그룹 함수(SUM, AVG, MAX, MIN 등)에서는 (*)를 사용할 수 없다.
-- COUNT(*) → 테이블의 모든 행 개수 반환 (NULL 포함)
-- COUNT(컬럼명) → 특정 컬럼의 NULL이 아닌 값만 카운트
-- COUNT(DISTINCT 컬럼명) → 특정 컬럼에서 중복 제거 후 유니크한 값 개수만 카운트

select * from emp;

select count(mgr), count(*), count(distinct mgr) -- 컬럼명을 지정: null 생략, distinct: 중복 제거
from emp;

-- 집계함수 

-- ROLLUP 함수 : 그룹별로 중간 집계 처리를 하는 함수 
-- GROUP BY 절에서만 사용 
-- 그룹별로 묶여진 값에 중간집계와 총집계를 구할때 사용
-- 그룹별로 계산된 값에대한 총집계가 자동으로 추가된다. 
-- 인자로 전달한 그룹중에서 가장 먼저 지정한 그룹(컬럼)별 합계와 총합계

select deptno, job, sum(sal) /*, grouping(deptno), grouping(job) <- 됨!!*/
from emp
group by deptno, job with rollup
order by deptno;

select
	deptno,
	job,
	sum(sal)
from emp
group by deptno, job
order by 1; -- deptno를 의미하는듯

select
	deptno,
	job,
	sum(sal)
from emp
group by deptno, job with rollup -- group by로 지정된 컬럼만 select에 올 수 있음
order by 1;

-- GROUPING - 오라클에서 그룹상태확인 -mysql doesn't support this keyword

SELECT 
    DEPTNO,
    JOB,
    SUM(SAL),
    CASE
        WHEN DEPTNO IS NULL AND JOB IS NOT NULL THEN '직급별 합계'
        WHEN DEPTNO IS NOT NULL AND JOB IS NULL THEN '부서별 합계'
        WHEN DEPTNO IS NULL AND JOB IS NULL THEN '총합계'
        ELSE '그룹별 합계'
    END AS 구분
FROM EMP
GROUP BY DEPTNO, JOB WITH ROLLUP
ORDER BY 1;


-- @SET SPERATION(집합연산)
-- 두개 이상의 테이블에서 조인을 사용하지 않고 연관된 데이터를 조회하는 방법
-- 여러 개의 질의 결과를 연결하여 하나로 결합하는 방식 
-- 각 테이블의 조회 결과를 하나의 테이블에 합쳐서 반환함 

-- 조건 : SELECT 절의 "컬럼 수가 동일"해야 함
--       SELECT 절의 동일 위치에 존재하는 "컬럼의 데이터 타입이 상호호환"가능해야 함.

-- UNION, UNION ALL, INTERSECT, MINUS

-- UNION : 여러 개의 쿼리 결과를 하나로 합치는 연산자. 중복된 행을 제외하고 하나로 합친다.

select
	empno,
	ename,
	deptno,
	sal
from emp
where deptno = 10
union -- select 합칠때?, union: 중복 제거
select
	empno, -- 첫 문장 기준으로 쿼리 수 맞추기
	ename,
	deptno,
	sal
from emp
where sal > 1500;

select
	empno,
	ename,
	deptno,
	sal
from emp
where deptno = 10
union all -- 중복 포함
select
	empno, 
	ename,
	deptno,
	sal
from emp
where sal > 1500;

-- INTERSECT : 여러 개의 SELECT 한 결과에서 공통된 부분만 결과로 추출 (MySQL에서는 JOIN으로 대체 가능)

select -- mysql에서는 쿼리로 해결
	empno, 
	ename,
	deptno,
	sal
from emp
where sal > 1500
and deptno = 10;

-- MINUS : 선행 SELECT 결과에서 다음 SELECT 결과와 겹치는 부분을 제외한 나머지 부분만 추출
select
	empno, 
	ename,
	deptno,
	sal
from emp
where deptno = 10
and sal not in (select
/*여기 붙는 컬럼과*/	sal /*여기 들어가는 컬럼이 같기만 하면 되는 듯?*/
					from emp
					where sal > 1500); -- show every employee whose deptno is 10, and sal is not over 1500.

select * from emp;

select
	deptno,
	job,
	mgr,
	floor(avg(sal)) avg_sal
from emp
group by deptno, job, mgr
union all
select
	deptno,
	null, -- 일반적으로 데이터 형식에 맞춰서, varchar: '' job
	mgr,
	floor(avg(sal)) avg_sal
from emp
group by deptno, mgr
union all
select
	null, -- int: 0 deptno
	job,
	mgr,
	floor(avg(sal)) avg_sal
from emp
group by job, mgr;

describe emp;

/*@ 조인문(JOIN)
-> 여러테이블의 레코드를 조합하여 하나의 열로 표현한 것, 하나로 합쳐서 결과를 조회한다. 
-> 두 개 이상의 테이블에서 연관성을 가지고 있는 데이터들을 따로 분류하여 새로운 가상의 테이블을 이용하여 출력
   서로 다른 테이블에서 각각 공통값을 이용함으로써 필드를 조합함
   즉, 관계형 데이터베이스에서 SQL 문을 이용한 테이블간 "관계"를 맺는 방법
   
* 
- ANSI 표준구문
(ANSI(미국 국립 표준 협회 => 산업표준을 재정하는 단체)에서 지정한 DBMS에 상관없이 공통으로 사용하는 표준 SQL)
*/

/* INNER JOIN(JOIN): 테이블 간 공통된 값만 추출 (등가 join, equal join)
   EMP 테이블과 DEPT 테이블을 조인한다.
   EMPNO, ENAME, JOB, DEPTNO, LOC 컬럼을 검색하며, 조인 조건은 DEPTNO
*/

-- 컬럼명이 동일한 경우
select * from emp;
select * from dept;

select job, count(job)
from emp
group by job;

select ifnull(mgr, 'CEO') 매니저_사원번호, count(ifnull(mgr, 0)) 담당_직원수 -- 각 매니저의 번호와, 담당직원 수, 
from emp
group by mgr;

select hiredate 1980년_1981년_입사자
from emp
group by hiredate
having year(hiredate) between 1980 and 1981
order by hiredate;

SELECT 
    DEPTNO,
    JOB,
    SUM(SAL),
    CASE
        WHEN DEPTNO IS NULL AND JOB IS NOT NULL THEN '직급별 합계'
        WHEN DEPTNO IS NOT NULL AND JOB IS NULL THEN '부서별 합계'
        WHEN DEPTNO IS NULL AND JOB IS NULL THEN '총합계'
        ELSE '그룹별 합계'
    END AS 구분
FROM EMP
GROUP BY DEPTNO, JOB WITH ROLLUP
ORDER BY 1;

select 
	year(hiredate) 입사연도,
	count(year(hiredate)) 입사직원수,
	grouping(year(hiredate)) 비고
	-- 	case
	-- 		when (year(hiredate)) is null then '총 직원수'
	-- 		else '연도별'
	-- 	end 연도별 //이건 안되는 듯
from emp
group by 입사연도 with rollup;



select emp.*, dept.* -- EMPNO, ENAME, JOB, DEPTNO, DNAME, LOC
from emp
join dept using (deptno); -- 키 값이 같으면 using 사용

-- 컬럼명이 다른 경우
select * -- EMPNO, ENAME, JOB, a.DEPTNO, LOC
from emp a
join dept b on a.DEPTNO = b.DEPTNO;  -- 다를경우 on 사용

/* OUTER JOIN: 두 테이블의 지정된 컬럼 값이 일치하지 않는 행도 포함 */

/* 1. LEFT OUTER JOIN: EMP 테이블의 모든 정보를 보여주고, DEPT 테이블은 매칭되는 정보만 표시 */
select EMPNO, ENAME, JOB, a.DEPTNO, LOC
from emp a
left join dept b on a.DEPTNO = b.DEPTNO;

commit;

/* 2. RIGHT OUTER JOIN: DEPT 테이블의 모든 정보를 보여주고, EMP 테이블은 매칭되는 정보만 표시 */
select *
from emp a
right join dept b on a.DEPTNO = b.DEPTNO;

drop table if exists order_items, orders, member, reply, category, board, member2;


CREATE TABLE member(
	no INT AUTO_INCREMENT PRIMARY KEY,
	id varchar(10),
	pw varchar(10),
	name varchar(10),
	tel varchar(10),
	create_date timestamp
);

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

CREATE TABLE CATEGORY(
  C_CODE INT PRIMARY KEY,
  C_NAME VARCHAR(30) CHECK(C_NAME IN('공통', '운동', '등산', '게임', '낚시', '요리', '기타'))  
);

select *
from category;

INSERT INTO CATEGORY (C_CODE, C_NAME) VALUES(10, '공통');
INSERT INTO CATEGORY (C_CODE, C_NAME) VALUES(20, '운동');
INSERT INTO CATEGORY (C_CODE, C_NAME) VALUES(30, '요리');
INSERT INTO CATEGORY (C_CODE, C_NAME) VALUES(70, '기타');

COMMIT;
SELECT * FROM CATEGORY;
CREATE TABLE BOARD (
  NO INT PRIMARY KEY AUTO_INCREMENT,
  CATEGORY_CODE INT,
  TITLE VARCHAR(100),
  CONTENT TEXT NOT NULL,
  WRITER INT NOT NULL,
  COUNT INT DEFAULT 0 NOT NULL,
  CREATED_DATE DATETIME DEFAULT CURRENT_TIMESTAMP,
  MODIFIED_DATE DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  STATUS CHAR(1) DEFAULT 'Y',
  FOREIGN KEY (CATEGORY_CODE) REFERENCES CATEGORY(C_CODE),
  FOREIGN KEY (WRITER) REFERENCES MEMBER(NO)
);

INSERT INTO BOARD 
( CATEGORY_CODE, TITLE, CONTENT, WRITER) 
VALUES( 10, '게시글 1 ', '게시글1 CONTENT 입니다 ', 1);
INSERT INTO BOARD 
( CATEGORY_CODE, TITLE, CONTENT, WRITER) 
VALUES( 10, '게시글 2 ', '게시글2 CONTENT 입니다 ', 3);
INSERT INTO BOARD 
( CATEGORY_CODE, TITLE, CONTENT, WRITER) 
VALUES( 10, '게시글 3 ', '게시글3 CONTENT 입니다 ', 1);
INSERT INTO BOARD 
( CATEGORY_CODE, TITLE, CONTENT, WRITER) 
VALUES( 10, '게시글 4 ', '게시글4 CONTENT 입니다 ', 1);
INSERT INTO BOARD 
( CATEGORY_CODE, TITLE, CONTENT, WRITER) 
VALUES( 10, '게시글 5 ', '게시글5 CONTENT 입니다 ', 3);

COMMIT;
SELECT * FROM BOARD;
COMMIT;

SELECT * FROM MEMBER;

/* INNER JOIN: 게시글을 쓴 사람의 정보 조회 */
select * -- b.title '게시글 제목', b.writer '작성자 아이디', a.name '작성자 이름' -- a.*, b.*
from board as b
join member as a on b.writer = a.no;

select *
from member a
join board b on a.no = b.writer;

/* OUTER JOIN: 모든 회원이 작성한 글의 정보 */
select a.id '작성자 아이디', b.*
from member a
left join board b on a.no = b.writer
order by a.id;

/* 글을 기준으로 글을 쓴 사람의 정보 조회 */
select b.title '게시글 제목', a.*
from board as b
left join member as a on b.writer = a.no;

select a.id '작성자 아이디', b.*
from member a
right join board b on a.no = b.writer
order by b.title;

/* FULL OUTER JOIN: MySQL에서는 FULL OUTER JOIN을 지원하지 않으므로 UNION을 사용하여 구현 */

select a.no, a.id, a.name, b.title
from member a
left join board b on a.no = b.writer
union
select a.no, a.id, a.name, b.title
from member a
right join board b on a.no = b.writer;

/* CROSS JOIN: 모든 행이 조인된 곱집합을 반환 */
select * from member; -- 5
select * from board; -- 5

select *
from member
cross join board; -- 25

/* NON EQUAL JOIN: 범위에 해당하는 값들 조인 */
select * from emp;
select * from salgrade;

select 
	a.empno, a.ename, b.grade
from emp a
join salgrade b on a.sal between b.losal and b.hisal -- on 뒤에 조건 기입
order by a.sal desc;

/* SELF JOIN: 같은 테이블을 조인 */
select * from salgrade;

select *
from emp a
join emp b on a.mgr = b.empno; -- emp 테이블의 mgr을 empno로 갖는 사원 정보를 출력

-- 사원과 매니저의정보 , 사번, 이름, DNAME,  GRADE 각각(매니저가 있는 사원만)
select * from dept;


select 
	a.empno 사원번호, a.ename 사원이름,
	c.DNAME , d.GRADE,
	b.ename 담당매니저, b.empno 매니저사원번호,
	e.DNAME 매니저DNAME, f.grade 매니저급여등급
from emp a
	left join dept c on a.deptno = c.deptno
	join salgrade d on a.sal between d.losal and d.hisal
join emp b on a.mgr = b.empno
	left join dept e on b.deptno = e.deptno
	join salgrade f on b.sal between f.losal and f.hisal
order by a.empno;

select a.empno, a.ename, e.dname emp_dname, c.grade emp_grade, b.empno mgr_empno, b.ename mgr_name, f.dname mgr_dname, d.grade mgr_grade
from emp a
join emp b on a.mgr = b.empno
left join salgrade c on a.sal between c.losal and c.hisal
left join salgrade d on b.sal between d.losal and d.hisal
left join dept e on a.deptno = e.deptno
left join dept f on b.deptno = f.deptno;

-- 연습
-- select *
-- from emp a
-- 	join dept c on a.deptno = c.deptno
-- 	join salgrade d on a.sal between d.losal and d.hisal;

commit;

-- 서브쿼리의 유형
-- 단일행 서브쿼리 : 서브쿼리의 조회 결과값이 1개 행일 때
-- 다중행 서브쿼리 : 서브쿼리의 조회 결과값이 여러 개일 때
-- 다중열 서브쿼리 : 서브쿼리의 조회 결과값의 컬럼이 여러 개일 때
-- 다중행 다중열 서브쿼리 : 조회 결과가 행 수와 열 수가 여러 개인 경우
-- 상관 서브쿼리 : 서브쿼리가 메인 쿼리의 값을 참조하여 연산하는 경우
-- 스칼라 서브쿼리 : 상관 서브쿼리이면서 결과값이 하나인 서브쿼리

-- 1. 단일행 서브쿼리
-- 단일행 서브쿼리 앞에는 일반 비교 연산자 사용
-- 예시: >, <, >=, <=, =, !=, <>, ^=

-- SMITH 사원의 급여보다 많이 받는 직원의
-- 사번, 이름, 부서명, 급여를 조회
select * from emp;

select sal from emp where ename = 'smith';

select a.empno, a.ename, b.dname, a.sal
from emp a
left join dept b on a.deptno = b.deptno
where a.sal > (select sal from emp where ename = 'smith') -- 단일행 서브커리
order by sal;

-- 가장 적은 급여를 받는 직원의 사번, 이름, 부서명, 급여 조회
select a.empno, a.ename, b.dname, a.sal
from emp a
left join dept b on a.deptno = b.deptno
where a.sal = (select min(sal) from emp); -- 괄호안에 조건 기입

-- 부서별 급여 합계가 가장 큰 부서의 부서명, 급여 합계를 조회
select * from emp;
select * from dept;

select max(saltot)
from (
select deptno, sum(sal) saltot
from emp
group by deptno
) a;


select b.dname, sum(sal) -- 부서별 급여 합계 조회
from emp a
left join dept b on a.deptno = b.deptno
group by a.deptno;

select b.dname, sum(sal) 
from emp a
left join dept b on a.deptno = b.deptno
group by a.deptno
having sum(sal) = (  -- group by 조건 넣을 때는 having절 사용
					select max(saltot) -- max(sum(sal)) 이거 안됨
					from (  -- from절에 서브쿼리 삽입
						  select deptno, sum(sal) saltot
						  from emp
						  group by deptno
						)
a);


-- sasdlkfjasrgasrgaslkrgalkghalalskrhlaskghlakshglaksrhgasrgalgkasjrhgaslghjaksrlsagjhasrhugaslkurgh 
select max(saltot)
from (
	select deptno, sum(sal) saltot
	from emp
	group by deptno
)a ; -- from절 안에 셀렉트문 쓰고 별칭을 부여해야 함

select b.dname, sum(a.sal) -- emp를 a로 지정한 것을 의미함
from emp a
left join dept b on a.deptno = b.deptno
group by a.deptno, dname
having sum(a.sal) = (                        -- HAVING SUM(A.SAL) = (SELECT MAX(SUM(SAL)) FROM EMP GROUP BY DEPTNO);
						select max(a.saltot) -- from절 뒤의 a를 의미함
						from (
							select deptno, sum(sal) saltot
							from emp
							group by deptno
					)a 
);

use hr;

-- sasdlkfjasrgasrgaslkrgalkghalalskrhlaskghlakshglaksrhgasrgalgkasjrhgaslghjaksrlsagjhasrhugaslkurgh 

-- 2. 다중행 서브쿼리 
-- 다중행 서브쿼리 앞에서는 일반 비교 연산자를 사용 할수 없다
-- IN / NOT IN : 여러개의 결과값 중에서 한개라도 일치하는 값이 있다면 , 혹은 없다면 이라는 의미
-- > ANY, < ANY : 여러개의 결과값중에서 한개라도 큰 / 작은 경우 - 가장 작은 값보다 크냐? /가장 큰 값보다 작냐?
-- > ALL, < ALL : 모든값 보다 큰 / 작은 경우 - 가장 큰 값보다 크냐?/가장 작은 값보다 작냐?
-- EXIST / NOT EXIST : 서브쿼리에만 사용하는 연산자로 서브쿼리의 결과중에서 만족하는 값이 하나라도 존재하면 참
--                     값이 존재하는가? / 존재하지않는가?

-- (부서별 최고 급여)를 받는 직원의 이름, 부서, 급여 조회
select deptno, max(sal)
from emp
group by deptno;

select a.ename, b.dname, a.sal
from emp a
left join dept b on a.deptno = b.deptno
where a.sal in(
				select max(sal)
				from emp
				group by deptno
);

select b.dname
from emp a
left join dept b on a.deptno = b.deptno
group by b.dname;


select deptno, max(sal)
from emp
group by deptno;

select a.ename, b.dname, a.sal
from emp a
left join dept b on a.deptno = b.deptno
where a.sal in (
				select max(sal)
			    from emp
			    group by deptno
);

select deptno, max(sal)
from emp
group by deptno;

select ename, deptno, sal
from emp
where sal in(
			select max(sal)
			from emp
			group by deptno
			)
order by sal desc;

select deptno
from emp
group by deptno;

select * from emp;

-- 관리자에 해당하는 직원에 대한 정보와 관리자가 아닌 직원의 정보를 추출하여 조회 
-- 사번, 이름 , 부서명 , 직급명, '관리자' AS 구분 / '직원' AS 구분

-- 집합 연산자 방식
select a.empno, a.ename, b.dname, a.job, '관리자' 구분
from emp a
left join dept b on a.deptno = b.deptno
where a.empno in (select mgr from emp where mgr is not null)
union
select a.empno, a.ename, b.dname, a.job, '직원' 구분
from emp a
left join dept b on a.deptno = b.deptno
where a.empno not in (select mgr from emp where mgr is not null);

-- case를 이용한 방식
select a.empno, a.ename, b.dname, a.job,
		case
			when a.empno in(select mgr from emp where mgr is not null) then '관리자'
			else '직원'
		end 구분
from emp a
left join dept b on a.deptno = b.deptno
order by 구분;




select a.empno, a.ename, b.dname, '관리자' 구분
from emp a
left join dept b on a.deptno = b.deptno
where a.empno in (select distinct mgr from emp where mgr is not null)
union
select a.empno, a.ename, b.dname, '직원' 구분
from emp a
left join dept b on a.deptno = b.deptno
where a.empno not in (select distinct mgr from emp where mgr is not null);

-- 서브쿼리, case
select a.empno, a.ename, b.dname,
	case 
		when a.empno in (select distinct mgr from emp where mgr is not null) then '관리자'
		else '직원'
	end 구분
from emp a
left join dept b on a.deptno = b.deptno;

-- 전체 직원 중(CLERK클럭 점원 직급의 최소 급여)보다 많은 사람 조회
select * from emp;


select *
from emp
where sal > any (
				select min(sal)
				from emp
				group by job
				having job = 'clerk'
				);



select ename, sal
from emp
where sal > any (
				select min(a.sal)
				from emp a
				group by job);


-- > ANY, < ANY : 여러개의 결과값중에서 한개라도 큰 / 작은 경우 - 가장 작은 값보다 크냐? /가장 큰 값보다 작냐?
select *
from emp
where sal > any(select sal from emp where job = 'clerk');

select sal from emp where job = 'clerk';

-- CLERK클럭 점원 직급의 최대 급여보다 많이 받는 사람 조회

select *
from emp
where sal > all(select sal from emp where job = 'clerk');



select *
from emp
where sal > all(select sal from emp where job = 'clerk');

-- EXISTS : 서브쿼리의 결과 중에서 만족하는 값이 하나라도 존재하면 참
-- 참, 거짓 서브쿼리안에 값이 있는지 없는지 
-- 서브쿼리 결과가 참이면 메인쿼리를 실행, 서브쿼리 결과가 거짓이면 메인쿼리를 실행하지않는다.

SELECT A.ENAME, A.MGR, A.SAL 
FROM EMP A
WHERE EXISTS (SELECT 1 FROM EMP B WHERE B.SAL >= 5000);



-- 다중열 서브쿼리
-- 전체 직원들 중, 각 부서의 최고 급여를 받는 직원들을 찾아 그들의 이름, 부서번호, 직책, 급여 정보를 조회

select empno, ename, deptno, job, sal
from emp
where (deptno, sal) in (
					     select deptno, max(sal)
					     from emp
					     group by deptno
					    );

select deptno, max(sal) -- 그룹별로 가장큰 급여를 받는 직원의 급여
from emp
group by deptno;

select empno, ename, deptno, job, sal
from emp
where (deptno, sal) in (
						 select deptno, max(sal) -- 그룹별로 가장큰 급여를 받는 직원의 급여
						 from emp
						 group by deptno
						);

select * from emp;
-- 각 부서에서 가장 오래 근무한 직원 조회

select *
from emp
where (deptno, hiredate)
in(
	select deptno, min(hiredate)
	from emp
	group by deptno
	);

select deptno, min(hiredate)
from emp
group by deptno;

select ename, hiredate, deptno
from emp
where (deptno, hiredate) in (
							select deptno, min(hiredate)
							from emp
							group by deptno
						    );


-- 상관 서브쿼리 : 서브쿼리가 메인 쿼리의 값을 참조하여 연산하는 경우
-- 스칼라 서브쿼리 : 상관 서브쿼리이면서 결과값이 하나인 서브쿼리


-- 스칼라 서브쿼리
-- 단일행 서브쿼리 + 상관쿼리(-> 상관쿼리 이면서 결과값이 1개인 서브쿼리)
-- SELECT절, WHERE절, ORDER BY절 사용 가능

-- WHERE절에서 스칼라 서브쿼리 이용
-- (동일 직급의 급여 평균 (AVG(SAL))보다) 급여를 많이 받고 있는 직원의
-- 사번, 직급코드, 급여를 조회하세요

select empno, deptno, sal
from emp
where sal > all (
				select floor(avg(sal))
				from emp
				group by deptno
			)
group by deptno;

select job, floor(avg(sal))
from emp
group by job;

select empno, job, sal
from emp
where job


select avg(sal) from emp where job = 'clerk';

select *
from emp a
where sal < (select avg(sal) from emp where job = a.job);

select *
from emp a
where sal < (select avg(sal) from emp where job = a.job);

select *
from emp
where (job, sal) in (
					 select job, min(sal)
					 from emp
					 group by job
					);
-- SELECT 절에서 스칼라 서브쿼리 이용 
-- 모든 사원의 사번, 이름, 관리자 사번, 관리자명 조회
-- COALESCE 는 NULL 값을 대체하는 함수이다. 여러 개의 인자를 받으며, 첫 번째로 NULL이 아닌 값을 반환한다.
select
	empno,
	ename,
	mgr,
	coalesce((select ename from emp where empno = a.mgr), '없음') mgrname
from emp a;

-- ORDER BY 절에서 스칼라 서브쿼리 이용 

-- 모든 직원의 사번, 이름 , 소속 부서코드 조회
-- 단 부서명 내림차순 정렬
select * from emp;

select empno, ename, deptno
from emp a
order by (select dname from dept b where b.deptno = a.deptno) desc;

-- 서브쿼리의 사용 위치 : 
-- SELECT절, FROM절, WHERE절, HAVING절, GROUP BY절, ORDER BY절
-- DML 구문 : INSERT문, UPDATE문
-- DDL 구문 : CREATE TABLE문, CREATE VIEW문

-- FROM 절에서 서브쿼리를 사용할 수 있다 : 테이블 대신에 사용
-- 인라인 뷰(INLINE VIEW)라고 함
-- : 서브쿼리가 만든 결과집합(RESULT SET)에 대한 출력 화면
commit;

-- JOB 별 월급 평균(ROUND(AVG(SAL), 0) )을 구하고 급여가 이와 일치하는 사원정보 이름, 직급명,sal 구하기

select
	job, round(avg(sal), 0) jobavg
from emp
group by job;

select ename, a.job, sal
from emp a
join(
	select
		job, round(avg(sal), 0) jobavg
	from emp
	group by job
	)b on a.job = b.job and a.sal = b.jobavg
order by a.job;

-- 부서명이 SALES인 사원명,  부서명, 직급이름을 구하시오 (인라인뷰사용)
select a.ename, b.dname, a.job
from emp a
left join dept b on a.deptno = b.deptno;

select ename, dname
from (
	select a.*, dname
	from emp a
	left join dept b on a.deptno = b.deptno
	)a
where dname = 'sales';

/*# TOP-N 분석이란?
	TOP-N 질의는 columns에서 가장 큰 n개의 값 또는 가장 작은 n개의 값을 요청할 때
	사용됨
	예) 가장 적게 팔린 제품 10가지는? 또는 회사에서 가장 소득이 많은 사람 3명은?
*/
-- 인라인 뷰를 활용한 TOP-N 분석
-- ORDER BY 한 결과에 ROWNUM을 붙임
-- ROWNUM은 행 번호를 의미함

SELECT 
    ROW_NUMBER() OVER () AS ROWNUM,
    ENAME, 
    SAL
FROM EMP;

SELECT 
    ROW_NUMBER() OVER () AS ROWNUM,
    ENAME, 
    SAL
FROM EMP
order by sal desc;

select *
from (
	SELECT 
	    ROW_NUMBER() OVER (order by sal desc) AS ROWNUM, -- over() 안에 order by 삽입 가능 , 정렬조건 
	    ENAME, 
	    SAL
	FROM EMP
	 ) a
where rownum <=5;

SELECT 
    ROW_NUMBER() OVER () AS ROWNUM,
    ENAME, 
    SAL
FROM EMP
order by sal desc
limit 5;

-- 급여 평균 2위 안에 드는 부서의 부서코드와 부서명, 평균급여를 조회

select *
from emp

select a.deptno, b.dname, avgsal
from (
		select row_number() over(order by avg(sal) desc) rownum, deptno, avg(sal) avgsal
		from emp
		group by deptno
		having deptno is not null
		)a
left join dept b on a.deptno = b.deptno  -- join절 안에 from절 안에 넣어보기
where rownum <=2;

select a.deptno, b.dname, avg(a.sal) sal_avg, row_number() over(order by avg(a.sal) desc) rownum
from emp a
join dept b on a.deptno = b.deptno
group by a.deptno, b.dname
limit 2;

select deptno, dname, sal_avg
from (
		select a.deptno, b.dname, avg(a.sal) sal_avg, row_number() over(order by avg(a.sal) desc) rownum
		from emp a
		join dept b on a.deptno = b.deptno
		group by a.deptno, b.dname
		limit 2
)a ;

select *
from dept;

-- RANK() OVER(정렬기준) / DENSE_RANK() OVER(정렬기준)
-- 순위를 매기는 함수
-- RANK() OVER : 동일한 순위 이후에 다음 순위로 점프
-- DENSE_RANK() OVER : 동일한 순위 이후에도 다음 순위는 1씩 증가

-- 직원 정보에서 급여를 가장 많이 받는 순으로 이름, 급여, 순위 조회

select ename, sal, dense_rank() over(order by sal desc) 순위
from emp; -- 1, 2, 2, 3, 4...

select ename, sal, rank() over(order by sal desc) 순위
from emp; -- 1, 2, 2, 4...

SELECT 
    이름,
    급여,
    순위,
    순위2
FROM (
    SELECT
        ENAME AS "이름",
        SAL AS "급여",
        RANK() OVER (ORDER BY SAL DESC) AS "순위",
        DENSE_RANK() OVER (ORDER BY SAL DESC) AS "순위2"
    FROM EMP
) A
WHERE 순위 <= 5; -- from절에 서브쿼리 넣어서 사용한 방법

-- WITH 구문 사용
-- 서브쿼리에 이름을 붙여 사용하며, 중복 작성을 줄일 수 있음

with topn_sal as (
	select
		empno,
		ename,
		sal
	from emp
	order by sal desc
)
select
	row_number () over() as "순위",
	ename,
	sal
from topn_sal;

-- 여러개의 with절

with tot_sal as (
	select sum(sal) sal1
	from emp
),
avg_sal as (
	select avg(sal) sal2
	from emp
)
select
	'합계' col1, sal1 col2
from tot_sal
union
select
	'평균' col1, sal2 col2
from avg_sal
union all
select '직원', sum(sal) col2
from emp
where empno in ('7369', '7499');

-- 부서별 급여 합계가 전체 급여 총 합의 20%보다 많은 부서 조회
-- 첫 번째 방법: HAVING 절 사용
select sum(sum_sal)
from (
	select a.deptno, b.dname 부서명, sum(sal) sum_sal
	from emp a
	join dept b on a.deptno = b.deptno
	group by deptno, dname
) a;

select a.deptno, b.dname 부서명, sum(sal) sum_sal
from emp a
join dept b on a.deptno = b.deptno
group by deptno, dname
having sum(a.sal) > (select sum(sal) * 0.2 from emp); -- having절 안에 서브쿼리

select sum(sal) * 0.5
from emp;

-- 두 번째 방법: 인라인뷰 사용 :from절에 넣는것
select deptno, dname, tot_sal
from (
		select 
			a.deptno deptno,
			b.dname dname,
			sum(a.sal) tot_sal
		from emp a
		join dept b on a.deptno = b.deptno
		group by deptno, dname
) a
where tot_sal > (select sum(sal) * 0.2 from emp);

-- 세 번째 방법: WITH 구문 사용
with tot_sal as(
	select 
			a.deptno deptno,
			b.dname dname,
			sum(a.sal) total_sal
		from emp a
		join dept b on a.deptno = b.deptno
		group by deptno, dname 
)
select *
from tot_sal
where total_sal > (select sum(sal) * 0.2 from emp);

--  클러스터형 인덱스 (Clustered Index)
-- 데이터는 클러스터형 인덱스에 따라 정렬된 상태로 저장
-- PRIMARY KEY가 클러스터형 인덱스로 자동 생성
-- 한 테이블에 하나만 존재


-- 보조인덱스
-- 클러스터형 인덱스와 독립적으로 생성 가능하며, 한 테이블에 여러 개의 생성가능
-- 
-- 보조 인덱스는 데이터를 직접 저장하지 않고 클러스터형 인덱스의 키를 가리키는 포인터를 저장 하여
-- 검색 시 클러스터형 인덱스를 참조
-- 데이터 정렬에 영향을 미치지 않는다.

-- 클러스터형 인덱스는 데이터와 인덱스가 결합되어 저장되며, 
-- PRIMARY KEY 또는 UNIQUE NOT NULL 제약 조건이 있는 컬럼으로 자동 생성
-- 보조 인덱스는 클러스터형 인덱스를 참조하는 추가적인 인덱스로, 한 테이블에 여러 개 생성
-- 검색 속도와 효율성에서 클러스터형 인덱스가 더 빠르지만, 보조 인덱스는 특정 컬럼에 대한 추가적인 검색 최적화를 제공

-- 클러스터형 인덱스:
-- 데이터의 기본 검색 기준이 되는 경우.
-- 예: id 같은 기본 키, 고유한 값(UNIQUE).
-- 보조 인덱스:
-- 검색 최적화가 필요한 다른 컬럼에 추가.
-- 예: email 같은 자주 조회되는 값.

CREATE TABLE  tbl1
	(	a INT PRIMARY KEY, 
		b INT,
		c INT
	);

show index from tbl1;

CREATE TABLE  tbl2
	(	a INT PRIMARY KEY,
		b INT UNIQUE,
		c INT UNIQUE,
		d INT
	);

show index from tbl2;

CREATE TABLE  tbl5
	(	a INT UNIQUE NOT NULL,  
		b INT UNIQUE ,
		c INT UNIQUE,
		d INT PRIMARY KEY 
	);

show index from tbl5;
DROP TABLE IF EXISTS usertbl;

CREATE TABLE usertbl 
( userID  char(8) NOT NULL PRIMARY KEY,  
  name    varchar(10) NOT NULL,
  birthYear   int NOT NULL,
  addr	  nchar(2) NOT NULL 
 );

INSERT INTO usertbl VALUES('JNK', '제니', 1996, '서울'); 
INSERT INTO usertbl VALUES('LRS', '리사', 1997, '태국');  
INSERT INTO usertbl VALUES('KJS', '카리나', 2000, '서울'); 
INSERT INTO usertbl VALUES('WNS', '윈터', 2000, '부산');  
INSERT INTO usertbl VALUES('MHJ', '민지', 2004, '서울');
commit;
show index from usertbl;

select * from usertbl;

ALTER TABLE usertbl DROP PRIMARY KEY ;

ALTER TABLE usertbl 
	ADD CONSTRAINT pk_name PRIMARY KEY(name);

show index from usertbl;

CREATE INDEX idx_usertbl_addr 
   ON usertbl (addr); -- 보조 인덱스 지정. 속도 향상

select * from usertbl;

-- CREATE UNIQUE INDEX idx_usertbl_birtyYear 
-- 	ON usertbl (birthYear);
-- 기존 데이터에 중복값이 있어서 오류.

CREATE INDEX idx_usertbl_addr_birthYear 
	ON usertbl (addr,birthYear);

show index from usertbl;

drop index idx_usertbl_addr_birthYear on usertbl;

show index from usertbl;


-- type = ALL → FULL SCAN 발생! (테이블 전체를 검색함)
-- possible_keys = NULL → 사용할 수 있는 인덱스 없음

-- type = ref → 인덱스를 활용한 INDEX SCAN 수행
-- key = idx_usertbl_name_birthYear → 인덱스가 적용됨
-- Extra = Using index → 실제 테이블을 검색하지 않고 인덱스에서 직접 값을 가져옴 (효율적)


-- MySQL은 보조 인덱스보다 PRIMARY KEY를 우선적으로 사용
-- type 정리
-- const - PRIMARY KEY 또는 UNIQUE 인덱스를 사용한 단일 행 검색 (가장 빠름)
-- eq_ref - JOIN에서 PRIMARY KEY 또는 UNIQUE 인덱스를 사용한 1:1 검색
-- ref - 보조 인덱스(INDEX)를 사용한 검색 (일부 값 일치)
-- range - BETWEEN, <, >, IN 등의 범위 검색
-- index - 인덱스를 전체 스캔 (ORDER BY, GROUP BY에서 발생)
-- ALL - 테이블 전체를 검색 (인덱스 없음, 가장 느림)

EXPLAIN SELECT * FROM usertbl WHERE userid = 'JNK'; 
explain SELECT * FROM usertbl WHERE name = '제니';
explain SELECT * FROM usertbl WHERE addr = '서울';

SELECT * FROM usertbl WHERE userid = 'JNK'; 
SELECT * FROM usertbl WHERE name = '제니';

-- VIEW (뷰)
-- SELECT 쿼리문을 저장한 객체이다
-- 실질적인 데이터를 저장하고 있지 않음
-- 테이블을 사용하는 것과 동일하게 사용할 수 있다.
-- 매번 자주 사용하는 쿼리문을 정의해 두고 싶을 때 뷰를 생성
-- VIEW를 한번 만들어두고 마치 테이블처럼 사용한다고 생각!
-- CREATE [OR REPLACE] VIEW 뷰이름 AS 서브쿼리

CREATE OR REPLACE VIEW V_EMP AS
SELECT 
    EMPNO AS 사번,      
    ENAME AS 이름,     
    DEPTNO AS 부서     
FROM EMP;

select *
from v_emp;

drop view v_emp;

SHOW FULL TABLES WHERE Table_Type = 'VIEW';

create or replace view v_dept as
select
	*
from dept;

select * from dept;

-- 생성된 뷰를 이용해서 DML(INSERT, UPDATE, DELETE) 사용 가능

-- 뷰에 INSERT
INSERT INTO V_DEPT
    (DEPTNO, DNAME, LOC)
VALUES
    (50,'MULTI', 'MULTI');
SELECT * FROM V_DEPT;
SELECT * FROM DEPT;

-- 뷰에 UPDATE
UPDATE V_DEPT
SET DNAME = 'YouTuber'
WHERE DEPTNO = '50';

-- 뷰에 DELETE
DELETE FROM V_DEPT WHERE DEPTNO = '50';

-- DML 명령어로 조작이 불가능한 경우
-- 1. 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
-- 2. 뷰에 포함되지 않은 컬럼 중에,
--    베이스가 되는 테이블 컬럼이 NOT NULL 제약 조건이 지정된 경우
-- 3. 산술 표현식으로 정의된 경우
-- 4. JOIN을 이용해 여러 테이블을 연결한 경우 (지원 가능하지만 조작 불가)
-- 5. DISTINCT 포함한 경우
-- 6. 그룹 함수나 GROUP BY 절을 포함한 경우
select * from v_dept;

CREATE OR REPLACE VIEW V_GROUPDEPT
AS
SELECT 
    DEPTNO,
    SUM(SAL) AS 합계, 
    AVG(SAL) AS 평균 
FROM EMP
GROUP BY DEPTNO;

select *
from v_groupdept;

 -- WITH CHECK OPTION을 사용하면, 특정 조건을 만족하는 행만 추가/수정 가능하도록 제한
CREATE or replace VIEW view_seoul_users AS 
SELECT * FROM usertbl WHERE addr = '서울'
WITH CHECK OPTION;

select * from usertbl;
select * from view_seoul_users;

-- INSERT INTO view_seoul_users VALUES ('JSM', '지수', 1995, '부산');: check option failed

-- 트리거(TRIGGER)
-- > 데이터베이스가 미리 정해놓은 조건을 만족하거나 어떠한 동작이 수행되면
-- 자동적으로 수행되는 객체를 의미
-- - 트리거의 사전적 의미 : 연쇄 반응
-- 트리거는 테이블이나 뷰가 INSERT, UPDATE, DELETE등의 DML문에 의해 데이터가 입력,수정,삭제
-- 될 경우 자동으로 실행 됨 
-- 제품 입출고에 따른 재고 변화 자동 업데이트
-- DELIMITER $$를 사용하여 MySQL이 블록 종료를 $$로 인식하게함
-- 기본적으로 MySQL은 ;를 명령문 종료로 인식 ,;(종료) 를 내부에 많이 사용하기떄문,
-- 제품 테이블

CREATE TABLE PRODUCT (
    PCODE INT PRIMARY KEY AUTO_INCREMENT,
    PNAME VARCHAR(30),
    BRAND VARCHAR(30),
    PRICE DECIMAL(10, 2),
    STOCK INT DEFAULT 0
);

-- 제품 입출고 테이블 생성
CREATE TABLE PRO_DETAIL (
    DCODE INT PRIMARY KEY AUTO_INCREMENT,
    PCODE INT,
    PDATE DATE,
    AMOUNT INT,
    STATUS ENUM('입고', '출고'),
    FOREIGN KEY (PCODE) REFERENCES PRODUCT(PCODE)
);

-- 제품 및 입출고 데이터 조회
SELECT * FROM PRODUCT;
SELECT * FROM PRO_DETAIL;

-- 제품 테이블에 데이터 삽입
INSERT INTO PRODUCT (PNAME, BRAND, PRICE) VALUES ('울트라', 'SS', 900000);
INSERT INTO PRODUCT (PNAME, BRAND, PRICE) VALUES ('아이폰', 'AP', 900000);
INSERT INTO PRODUCT (PNAME, BRAND, PRICE) VALUES ('샤오미', 'SOM', 900000);

commit;

delimiter $$  

create trigger trg_pro_detail_insert
after insert on pro_detail
for each row
begin
    if new.status = '입고' then
        update product
        set stock = stock + new.amount
        where pcode = new.pcode;
    elseif new.status = '출고' then
        update product
        set stock = stock - new.amount
        where pcode = new.pcode;
    end if;
end $$-- 트리거 종료

delimiter ;

delimiter //
create trigger trg_deletedmembertbl  
	after delete 
	on membertbl 
	for each row 
begin 
	-- old 테이블의 내용을 백업테이블에 삽입
	insert into deletedmembertbl 
		values (old.memberid, old.membername, old.memberaddress, curdate() ); 
end //
delimiter ;



commit;

insert into pro_detail (pcode, pdate, amount, status) values (1, curdate(), 5, '입고');
insert into pro_detail (pcode, pdate, amount, status) values (2, curdate(), 10, '입고');
insert into pro_detail (pcode, pdate, amount, status) values (3, curdate(), 20, '입고');

insert into pro_detail (pcode, pdate, amount, status) values (1, curdate(), 1, '출고');
insert into pro_detail (pcode, pdate, amount, status) values (2, curdate(), 5, '출고');
insert into pro_detail (pcode, pdate, amount, status) values (3, curdate(), 13, '출고');

select * from product;
select * from pro_detail;

set autocommit = 0;

create table testtbl2 
  (id  int auto_increment primary key, 
   username varchar(100),                   
   age int );
insert into testtbl2 values (null, '이유', 25);
insert into testtbl2 values (null, '공유', 22);
insert into testtbl2 values (null, '주혁', 21);

alter table testtbl2
modify column username varchar(200);

commit;

select * from testtbl2;

show index from testtbl2;

start transaction; -- 트랜젝션 시작
select * from testtbl2 where id = 1 for update;

update testtbl2 
set username = '제니2'
where id = 1;

commit;  -- 여기서 커밋해야 다른 스크립트에서 적용