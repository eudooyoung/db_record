use scott;
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

use hr;

-- 기본 
-- 1. JOBS 테이블에서 JOB_TITLE의 정보만 출력되도록 하시오
select job_title
from jobs;

-- 2. DEPARTMENTS 테이블의 내용 전체를 출력하는 SELECT문을 작성하시오
select *
from departments;

-- 3. EMPLOYEES 테이블에서 이름(FIRST_NAME, LAST_NAME), 이메일(EMAIL), 전화번호(PHONE_NUMBER), 고용일(HIRE_DATE)만 출력하시오
select first_name, last_name, email, phone_number, hire_date
from employees;

-- 4. EMPLOYEES 테이블에서 고용일(HIRE_DATE), 이름(FIRST_NAME, LAST_NAME), 월급(SALARY)를 출력하시오
select hire_date, first_name, last_name, salary
from employees;

-- 5. EMPLOYEES 테이블에서 월급(SALARY)이 9000 이상인 사람의 이름(FIRST_NAME, LAST_NAME)과 월급을 출력하시오
select first_name, last_name, salary
from employees
where salary >=9000;

-- 6. EMPLOYEES 테이블에서 월급(SALARY)이 7000 이상이면서 JOB_ID가 'FI_ACCOUNT'인 사람의 이름(FIRST_NAME, LAST_NAME)과 전화번호(PHONE_NUMBER)를 출력하시오
select first_name, last_name, phone_number
from employees
where salary >= 7000
and job_id = 'fi_account';

-- 7. EMPLOYEES 테이블에서 고용일이 2005-01-01 ~ 2010-01-01 사이인 사원의 전체 내용을 출력하시오
select *
from employees
where hire_date
between '2004-01-01' and '2010-01-01';

-- 8. EMPLOYEES 테이블에서 FIRST_NAME 끝이 sa로 끝나는 사원의 전체 이름을 출력하시오
select first_name, last_name
from employees
where first_name
like '%sa';

-- 9. EMPLOYEES 테이블에서 전화번호 처음 3자리가 515가 아닌 사원의 이름, 전화번호를 출력하시오
select first_name, last_name, phone_number
from employees
where phone_number
not like '515%';

-- 10. EMPLOYEES 테이블에서 DEPARTMENT_ID가 90 또는 60이고 고용일이 2005-01-01 ~ 2010-12-01이면서, 월급이 9000 이상인 사원의 전체 정보를 출력하시오
select *
from employees
where ((department_id = 90 or department_id = 60)
and (hire_date between '2005-01-01' and '2010-12-01'))
and salary >= 9000;

-- 3.------------------------------------

CREATE TABLE employees1 (
	id INT AUTO_INCREMENT PRIMARY key,
	name VARCHAR(100),
	department VARCHAR(100),
	salary INT
);

insert into employees1
	(name, department, salary)
	values 	('제니', 'Engineering', 63000),
			('리사', 'Sales', 55000),
			('사나', 'Engineering', 60000),
			('주혁', 'Sales', 55000);
-- 1)
select *
from employees1;

-- 2)
select name, salary
from employees1
where department = 'Engineering';

-- 3)
update employees1
set salary = 65000
where id = 3;

-- 4)
delete
from employees1
where id = 3;

-- 5)
select *
from employees1
order by salary desc;

-- 6)
select *
from employees1
order by salary desc
limit 2;

commit;