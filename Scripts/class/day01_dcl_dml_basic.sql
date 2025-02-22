-- DB(DataBase)란?
-- -> 한 조직에 필요한 정보를 여러 응용 시스템에서 공용할 수 있도록 논리적으로
-- 연관된 데이터를 모으고, 중복되는 데이터를 최소화하여 구조적으로 통합/저장해 놓은 것

-- Data란?
-- -> 어떠한 자료 혹은 실제 값을 의미함-흩어져있는 어떤자료
--	- 에베레스트의 높이 : 8848m (8848 미터 라는 데이터)

-- 정보란?
-- -> 데이터를 기반으로 하여 의미를 부여한 것-우리가 찾고자하는것 
--	 - 에베레스트는 세계에서 가장 높은 산 (가장 높은 산이라는 정보)

-- DBMS?
-- 데이터베이스에서 데이터를 추출, 조작, 정의, 제어 등을 할 수 있게 해주는 데이터베이스 전용 관리 프로그램
-- 데이터 독립화(데이터저장소를 변경하거나 데이터베이스 크기를 변경하더라도 기존 프로그램에 영향이 없어야한다)
-- 데이터 중복 최소화(데이터가 여러개 중복되어 저장되는것 방지 - 하나의 테이블에 저장하고 공유하여 중복을 최소화 )
-- 데이터 무결성 보장(데이터가 어떤경로로 들어오든 데이터에 오류가 있으면 안됨 - 제약조건을 두어 반드시 들어가야 하는 데이터 , 중복되면 안되는 데이터등을 관리 )

-- 스키마(schema)는 데이터베이스에서 데이터의 구조, 조직, 그리고 관계를 정의하는 틀 또는 청사진을 의미 
-- 데이터베이스 스키마는 데이터가 어떻게 저장될지, 데이터 간에 어떤 관계가 있는지, 데이터에 어떤 제약 조건이 적용되는지 등을 명시
-- 스키마는 데이터베이스를 설계할 때 논리적 구조를 제공

-- 오라클에서의 스키마
-- 오라클에서 "스키마"는 데이터베이스 사용자에게 소속된 객체(테이블, 뷰, 인덱스, 스토어드 프로시저 등)의 집합을 의미
-- 오라클에서 스키마를 생성한다는 것은 사실상 사용자를 생성하는 것이며 해당 사용자에게 소속된 데이터베이스 객체를 관리하는 것
-- 오라클 데이터베이스는 여러 스키마를 포함할 수 있으며, 각 스키마는 고유한 사용자에 의해 소유되고 관리됨



-- MySQL에서의 데이터베이스
-- MySQL에서 "데이터베이스"는 스키마와 거의 동일한 개념으로 사용됨 .
-- MySQL에서 데이터베이스를 생성하면, 그 데이터베이스 내에 테이블, 뷰, 인덱스 등을 생성할 수 있는 논리적 컨테이너로 취급하며, 각 데이터베이스는 서로 독립적인 객체 집합을 가짐.
-- MySQL에서는 사용자와 데이터베이스가 명시적으로 연결되지 않습니다. 대신, 사용자에게 특정 데이터베이스에 대한 접근 권한을 부여할 수 있습니다.

-- 차이점
-- 오라클에서는 "스키마"가 사용자와 직접 연결되어 사용자별로 데이터베이스 객체를 관리하는 개념. 
-- 반면, MySQL에서는 "데이터베이스"가 이러한 역할을 하며, 사용자는 별도로 권한을 부여받아 여러 데이터베이스에 접근할 수 있다. 

-- 구조적 차이: 오라클에서는 데이터베이스 내부에 여러 스키마(사용자)가 존재할 수 있으며, 각 스키마는 자신의 객체를 가짐
--          MySQL에서는 각 데이터베이스가 독립적인 객체 집합을 가지며, 사용자는 권한에 따라 하나 이상의 데이터베이스에 접근가능함
-- 관리 방식: 오라클에서는 스키마(사용자) 생성 시 데이터베이스 객체에 대한 권리가 함께 부여되고 
--          MySQL에서는 데이터베이스를 생성한 후, 별도로 사용자에게 해당 데이터베이스에 대한 접근 권한을 설정해야함

show databases;

-- 컨트롤 엔터, %: 공유 호스트, 알트 + x: 전체 실행

-- 'localhost' 대신 '%' 을 사용할 경우 외부에서도 접속 가능
-- CREATE USER '사용자아이디'@'접속허용IP' IDENTIFIED BY '비밀번호';
-- GRANT ALL PRIVILEGES ON 권한허용DB명.* TO '사용자아이디' @ '접속허용IP';
create user sccott@'%' identified by 'tiger';

grant all privileges on *.* to 'scott'@'%';

select * from mysql.user;

show grants;

-- 데이터 베이스 생성 
-- CREATE DATABASE DB명 ;
create database scott;


-- 실행 db를 설정
use scott;

-- ----------------
-- hr / hr

create user hr1@'%' identified by 'hr1';

grant all privileges on *.* to hr@'%';

show grants for 'hr'@'%';

-- 권한삭제
-- 사용자는 필요한데 권한을 삭제하고 싶은 경우
-- 기본형식 (사용자 삭제아닙니다) --
-- REVOKE ALL ON DB명.테이블명 FROM 사용자아이디;

-- 사용자의 모든권한 삭제 --
-- REVOKE ALL ON *.* FROM 사용자아이디;

revoke all on *.* from 'hr'@'%';

-- 유저 삭제
-- 사용자 아이디 삭제 --
-- DROP USER '사용자아이디';
drop user 'hr1'@'%';
-- create user 'hr'@'%' identified by 'hr';


create table bonus

(
	
	ename varchar(10),
	
	job varchar(9),
	
	sal int,
	
	comm int

);
-- mysql 8.0.17 버전부터 int 타입에 길이 설정하는 건 더 이상 지원하지 않기로 하고 향후 버전부터는 제거될 기능 중 하나라서 경고
-- integer display width is deprecated and will be removed in a future release.

create table dept
(
	deptno int,
	dname varchar(14),
	loc varchar(13)
);



create table emp
(
	empno int,
	ename varchar(10),
	job varchar(9),
	mgr int,
	hiredate date,
	sal int,
	comm decimal(7,2),
	deptno int
);




create table salgrade
(
	grade int,
	losal  int,
	hisal  int
);

-- 전체 데이터 중에 emp 선택
select * from emp;



insert into dept
   (deptno, dname, loc)
 values
   (10, 'accounting', 'new york');
insert into dept
   (deptno, dname, loc)
 values
   (20, 'research', 'dallas');
insert into dept
   (deptno, dname, loc)
 values
   (30, 'sales', 'chicago');
insert into dept
   (deptno, dname, loc)
 values
   (40, 'operations', 'boston');
commit;




insert into salgrade
   (grade, losal, hisal)
 values
   (1, 700, 1200);
insert into salgrade
   (grade, losal, hisal)
 values
   (2, 1201, 1400);
insert into salgrade
   (grade, losal, hisal)
 values
   (3, 1401, 2000);
insert into salgrade
   (grade, losal, hisal)
 values
   (4, 2001, 3000);
insert into salgrade
   (grade, losal, hisal)
 values
   (5, 3001, 9999);
commit;


use scott;

insert into emp
   (empno, ename, job, mgr, hiredate, sal, deptno)
values
   (7369, 'smith', 'clerk', 7902, 
    '1980-12-17', 800, 20);
insert into emp
   (empno, ename, job, mgr, hiredate, sal, comm, deptno)
values
   (7499, 'allen', 'salesman', 7698, 
    '1981-02-20', 1600, 300, 30);
insert into emp
   (empno, ename, job, mgr, hiredate, sal, comm, deptno)
values
   (7521, 'ward', 'salesman', 7698, 
    '1981-02-22', 1250, 500, 30);
insert into emp
   (empno, ename, job, mgr, hiredate, sal, deptno)
values
   (7566, 'jones', 'manager', 7839, 
    '1981-04-02', 2975, 20);
insert into emp
   (empno, ename, job, mgr, hiredate, sal, comm, deptno)
values
   (7654, 'martin', 'salesman', 7698, 
    '1981-09-28', 1250, 1400, 30);
insert into emp
   (empno, ename, job, mgr, hiredate, sal, deptno)
values
   (7698, 'blake', 'manager', 7839, 
    '1981-05-01', 2850, 30);
insert into emp
   (empno, ename, job, mgr, hiredate, sal, deptno)
values
   (7782, 'clark', 'manager', 7839, 
    '1981-06-09', 2450, 10);
insert into emp
   (empno, ename, job, mgr, hiredate, sal, deptno)
values
   (7788, 'scott', 'analyst', 7566, 
    '1987-04-19', 3000, 20);
insert into emp
   (empno, ename, job, hiredate, sal, deptno)
values
   (7839, 'king', 'president', 
    '1981-11-17', 5000, 10);
insert into emp
   (empno, ename, job, mgr, hiredate, sal, comm, deptno)
values
   (7844, 'turner', 'salesman', 7698, 
    '1981-09-08', 1500, 0, 30);
insert into emp
   (empno, ename, job, mgr, hiredate, sal, deptno)
values
   (7876, 'adams', 'clerk', 7788, 
    '1987-05-23', 1100, 20);
insert into emp
   (empno, ename, job, mgr, hiredate, sal, deptno)
values
   (7900, 'james min', 'clerk', 7698, 
    '1981-12-03', 950, 30);
insert into emp
   (empno, ename, job, mgr, hiredate, sal, deptno)
values
   (7902, 'ford ford', 'analyst', 7566, 
    '1981-12-03', 3000, 20);
insert into emp
   (empno, ename, job, mgr, hiredate, sal, deptno)
values
   (7934, 'millera', 'clerk', 10000, 
    '1982-01-23', 1300, 10);
commit;

select * from emp;

select ename, sal from emp;

-- 별칭 부여(result set)
select ename as name, sal as salary from emp;

-- as 생략
select ename name, sal salary from emp;

-- 수정
update emp
set sal = 1500, job = 'manager'
where empno = 7934;

select * 
from emp
where empno = 7934;

-- 삭제
delete 
from emp
where empno = 7934;

-- 모두 삭제
delete
from emp;

-- 마지막 커밋 시점으로 복귀
rollback;

-- https://www.w3schools.com/mysql/mysql_operators.asp

-- --------------------------------문제 

-- 1.emp 테이블에서 모든 직원의 이름과 직업을 조회
select ename, job
from emp;
-- 2.dept 테이블에서 모든 컬럼을 조회
select *
from dept;
-- 3.emp 테이블에서 sal(급여)이 3000 이상(>=)인 직원의 정보를 조회
select *
from emp
where sal >= 3000;
-- 4.salgrade 테이블에서 급여 등급(grade)이 3인 데이터를 조회
select *
from salgrade
where grade = 3;
-- 5.emp 테이블에서 hiredate가 '1981-12-03' 이후인 직원의 이름과 입사일을 조회
select ename, hiredate
from emp
where hiredate >= '1981-12-03';
-- 6.job이 'manager'인 직원들의 empno, ename, job을 조회
select empno, ename, job
from emp
where job = 'manager';


-- 1.dept 테이블에  데이터를 추가
-- deptno: 50
-- dname: 'it'
-- loc: 'seattle' 
-- 방법1 - 컬럼명지정
insert into dept
	(deptno, dname, loc)
	values(50, 'it', 'seattle');

-- 방법 2- 테이블에 바로 추가

insert into dept
	values(50, 'it', 'seattle');

delete
from dept
where deptno = 50;

-- 2.emp 테이블에  데이터를 추가
-- empno: 8000
-- ename: 'lee'
-- job: 'developer'
-- mgr: 7782
-- hiredate: '2023-01-10'
-- sal: 4500
-- deptno: 50

select *
from emp;

-- 한번에 여러 행 추가
insert into emp 
	values(8000, 'lee', 'developer', 7782, '2023-01-10', 4500, null, 50),
		  (8000, 'lee', 'developer', 7782, '2023-01-10', 4500, null, 50);

insert into emp 
	values(8000, 'lee', 'developer', 7782, '2023-01-10', 4500, null, 50);

delete
from emp
where empno = 8000;

-- 1.emp 테이블에서 직원 smith의 급여를 1000으로 변경
-- 2.dept 테이블에서 deptno가 20인 부서의 loc을 'san francisco'로 변경
-- 3.emp 테이블에서 empno가 7839인 직원의 직업을 'president -> ceo'로 변경

update emp
set sal = 1000
where ename = 'smith';

update dept
set loc = 'san fancisco'
where deptno = 20;

update emp
set job = 'ceo'
where empno = 7839;

-- 1.emp 테이블에서 ename이 'lee'인 데이터를 삭제
delete
from emp
where ename = 'lee';
-- 2.dept 테이블에서 deptno가 50인 부서를 삭제
delete
from dept
where deptno = 50;
-- 3.salgrade 테이블에서 grade가 5인 데이터를 삭제
delete
from salgrade 
where grade = 5;

select *
from emp;

commit;

-- 중복제거: distinct
select distinct job
from emp;

select distinct deptno, job
from emp;

-- 정렬하여 출력
select distinct deptno, job
from emp
order by deptno;

-- 비교연산
/*
=	같다	WHERE job = 'manager'
!= 또는 <>	같지 않다	WHERE deptno <> 10
>	초과	WHERE sal > 2000
<	미만	WHERE sal < 2000
>=	이상	WHERE sal >= 2000
<=	이하	WHERE sal <= 2000

**/

select *
from emp
where sal > 3000;

 -- 논리 연산자 (AND, OR, NOT)

-- 직급이 'manager'이고 급여가 2500 초과인 직원 조회
select *
  from emp
 where job = 'manager'
   and sal > 2500; 

-- 직급이 'salesman'이거나 급여가 3000 초과인 직원 조회
select
	*
from
	emp
where
	job = 'salesman'
	or sal > 3000;

-- 직급이 'clerk'가 아닌 직원 조회
select
	*
from
	emp
where
	not job = 'clerk';

-- NOT을 AND, OR과 함께 사용
-- 직급이 'clerk' 또는 'manager'가 아닌 직원 조회
select *
from emp
where not job = 'clerk' and not job = 'manager';
where not (job = 'clerk' or job = 'manager');

-- 급여가 1000 보다 크거나 직업이 clerk 이고 / 직업이 manager  인 직원 조회
/*
() (괄호)	최우선
NOT	1
AND	2
OR	3
*/
select *
from emp
where (sal > 1000 or job = 'clerk') and (job = 'manager');

-- OR를 먼저 평가하고 싶다면? (() 사용)
-- SELECT * FROM emp where (SAL > 1000 or job = 'clerk') and  job = 'manager';

-- 
-- BETWEEN (범위 조건)
-- 시작 값과 끝 값 모두 포함 ( 이상 이하 )

-- 급여가 1000 이상 3000 이하인 직원 조회
select *
from emp
where sal
between 1000 and 3000;

-- 1981년에 입사한

select *
from emp
where hiredate
between '1981-01-01' and '1981-12-31'
order by hiredate;

-- 급여가 1000 ~ 3000 범위가 아닌 직원 조회
select *
from emp
where not sal
between 1000 and 3000;

-- in(여러 값 중 하나와 일치)
-- or 여러 개를 쓰는 것보다 간단하게 표현 가능

select distinct job
from emp;

select *
from emp
where job
in ('manager', 'ceo', 'salesman');

-- not은 어디 붙여도 상관 없나?
select *
from emp
where job
not in ('manager', 'ceo', 'salesman');

-- LIKE (패턴 검색)
-- 문자열 검색 시 LIKE을 사용하며, '%문자%' 와일드카드를 활용
-- %	여러 개의 문자를 대체
-- _	한 개의 문자를 대체

SELECT ename FROM emp WHERE ename LIKE 'A%'; -- A로 시작하는 직원 조회 (Allen, Adams 등)
SELECT ename FROM emp WHERE ename LIKE '%n'; -- n으로 끝나는 직원 조회 (Martin 등)
SELECT ename FROM emp WHERE ename LIKE '%o%'; -- o를 포함하는 직원 조회 (Ford, Scott 등)
SELECT ename FROM emp WHERE ename LIKE '_o%'; -- 두 번째 글자가 'o'인 직원 조회

-- IS NULL / IS NOT NULL (NULL 값 조회)
-- NULL 값이 있는지 확인할 때 사용
-- = 연산자로 NULL 비교 불가능 (WHERE col = NULL X)

select *
from emp
where comm is null;

select *
from emp
where comm is not null;

/*
 * 정렬 (ORDER BY)
ORDER BY 기본 정렬은 ASC(오름차순)
오름차순(ASC), 내림차순(DESC) 정렬 가능
*/

select *
from emp
order by sal asc;

select *
from emp
order by sal desc;

-- sal 기준으로 우선 내림차순, 동일한 값에 대해서는 name 을 오름차순 정렬
select ename, sal
from emp
order by sal desc, ename;

-- LIMIT offset, limit;
-- LIMIT과 OFFSET을 사용하면 조회 결과의 일부만 가져올 수 있도록 제어
-- offset → 건너뛸 행(row) 개수
-- limit → 그 후 가져올 행(row) 개수
-- 페이지 구현 할때 사용

select ename, sal
from emp
order by sal desc, ename
limit 1;

select ename, sal
from emp
order by sal desc, ename
limit 2, 3;


-- 문제 
-- 1.emp 테이블에서 sal(급여)이 2000 이상인 직원의 empno, ename과 job을 sal 오름차순으로 정렬하여 조회
select empno, ename, job
from emp
where sal >= 2000
order by sal;

-- 2. deptno가 20인 직원들의 empno, ename, sal을 급여 기준 내림차순 정렬
select empno, ename, sal
from emp
where deptno = 20
order by sal desc;

-- 3.sal이 2000 이상이면서 comm(커미션)이 NULL이 아닌 직원들의 empno, ename, sal, comm을 조회
select empno, ename, sal, comm
from emp
where (sal >= 2000) and (comm is not null);

-- 4.job이 'manager'이거나 sal이 2500 이상 4000 이하인 직원들의 empno, ename, job, sal을 조회
-- sal기준 내림차순, 중복되는경우 이름기준 오름차순으로 출력
select empno, ename, job, sal
from emp
where (job = 'manager')
or (sal >= 2500 and sal <=4000)
order by sal desc, ename;

-- 5.deptno가 20이 아닌 직원 중에서 sal이 1500 이상인 직원들의 empno, ename, deptno, sal을 조회
select empno, ename, deptno, sal
from emp
where deptno != 20 and sal >=1500;

-- 6.1981년에 입사한 직원 중에서 급여가 높은 상위 3명 조회
select *
from emp
order by sal desc
limit 3;

-- 7.ename이 'A'로 시작하지 않는 직원들의 empno, ename을 조회
select empno, ename
from emp
where not ename
like 'A%';

-- 8.ename이 5글자인 직원들의 empno, ename을 조회
select empno, ename
from emp
where ename
like '_____';

-- 9.deptno가 10, 20, 30인 직원들의 empno, ename, deptno를 조회
-- 부서번호 기준 오름차순, 같은 부서 내에서는 이름 기준 내림차순
select empno, ename, deptno
from emp
where deptno
or 10 or 20 or 30
order by deptno, ename desc;

-- 10.급여 순위가 3번째인 직원의 empno, ename, sal을 조회 (LIMIT 사용)
select empno, ename, sal
from emp
order by sal desc, ename
limit 2, 1;


-- mysql에서는 oracle의 dual 테이블과 같은 특별한 테이블이 없고,
-- select 구문에서 간단한 산술 연산을 수행할 때는 테이블이 필요하지 않다



-- 상수 연산 및 함수 호출 예시
select 1*2 as val;  -- 테이블 없이 상수 출력

 -- 현재 날짜 및 시간 출력
select now();
--  별칭 이름 변경

select now() as currentdate;
--  _ 와 같은 문자열이 들어가는경우 백틱 사용
select now() as `current_date`;
select now()  `current_date`; -- as 없이도 별칭을 사용

-- Oracle에서 사용하는 시퀀스 기능은 MySQL의 AUTO_INCREMENT와 동일한 역할

-- 시퀀스 대체: AUTO_INCREMENT 사용
-- 각 행을 고유하게 식별할 수 있는 식별자를 자동으로 생성하여 테이블에 추가된 레코드를 관리
-- 주로 기본 키(Primary Key) 열에 적용하여 행이 삽입될 때마다 번호가 자동으로 증가
-- AUTO_INCREMENT 속성을 설정한 열에는 반드시 INDEX(인덱스)가 필요하며,
-- 일반적으로 PRIMARY KEY 또는 UNIQUE KEY로 설정

CREATE TABLE EMPLOYEES (
  EMP_ID INT AUTO_INCREMENT,  -- 자동 증가하는 기본키
  EMP_NAME VARCHAR(100),
  PRIMARY KEY (EMP_ID) -- 주석처리하면 에러발행 --SQL Error [1075] [42000]: Incorrect table definition; there can be only one auto column and it must be defined as a key
);

INSERT INTO EMPLOYEES (EMP_NAME) VALUES ('유재석');
INSERT INTO EMPLOYEES (EMP_NAME) VALUES ('제니');
commit;
select* from employees e;

SELECT LAST_INSERT_ID();
-- 데이터 삽입 (AUTO_INCREMENT를 위해 id에 NULL 값을 입력)
INSERT INTO EMPLOYEES VALUES (null, '제니');

ALTER TABLE EMPLOYEES AUTO_INCREMENT=100;
INSERT INTO EMPLOYEES VALUES (null, '제니');

-- AUTO_INCREMENT 증가 간격을 3으로 설정 (3씩 증가)
SET @@auto_increment_increment=3;
-- 103으로 추가됭ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅁ
INSERT INTO EMPLOYEES VALUES (null, '제니');
select* from employees e;

SET @@auto_increment_increment=1;

-- 테이블 삭제
drop table employees;
drop table if exists employees;

create user hr@'%' identified by 'hr';
grant all privileges on *.* to 'hr'@'%';

create database hr;
use hr; -- 쓸때 사용

commit;
