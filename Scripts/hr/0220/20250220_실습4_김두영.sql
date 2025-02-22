use hr;
drop table if exists board, member;

, , , ;
-- 함수
-- 1. 직원의 이름과 이메일, 이메일 길이를 출력하시오
--		  직원명	    이메일		이메일길이
--	ex) 	홍길동 , hong  	  13

select * from employees;

-- SELECT CONCAT(CONCAT(EMPNO, ':'), ENAME) AS CONCAT_RESULT FROM EMP;
select
	concat(concat(first_name, ' '), last_name) as '직원명',
	email '이메일',
	length(email) '이메일 길이'
from employees;

-- 2. 2001 AND 2005년에 고용된  직원명과 입사년도, 보너스(COMMISSION_PCT) 값을 출력하시오
--	그때 보너스 값이 null인 경우에는 0 이라고 출력 되게 만드시오
select
	concat(concat(first_name, ' '), last_name) '직원명',
	year(hire_date) '입사년도',
	ifnull(commission_pct, 0) '보너스'
from employees
where hire_date
between '2001-01-01' and '2005-12-31';

-- 3. '515' 핸드폰 번호를 사용하지 않는 사람의 수를 출력하시오(뒤에 단위는 명을 붙이시오)

-- select first_name, last_name, phone_number
-- from employees
-- where phone_number
-- not like '515%';

select concat(count(phone_number), '명') '핸드폰 번호를 사용하지 않는 사람의 수'
from employees
where phone_number
not like '515%';

-- 4. 직원명과 입사년월을 2003년 6월 형태로 출력하시오
--	단, 아래와 같이 출력되도록 만들어 보시오
--	    EMP_NAME		HIRE_YY
--	ex) 리사		       1997년 3월

-- SELECT DATE_FORMAT(CURRENT_TIMESTAMP, '%Y년 %m월 %d일') AS 포맷_날짜;

select
	concat(concat(first_name, ' '), last_name) 'EMP_NAME',
	date_format(hire_date, '%Y년 %m월') 'HIRE_YY'
from employees;

-- 5 . 부서코드가 50,90인 직원들 중에서 2004년도에 입사한 직원 조회
-- 120(EMPNO)	Matthew Weiss(ENAME)	50(DEPTID)	2004-07-18(HIRE_DATE)  형식으로 출력

-- select *
-- from employees
-- where hire_date between '2004-01-01' and '2004-12-31';

select 
	employee_id 'EMPNO',
	concat(concat(first_name, ' '), last_name) 'ENAME',
	department_id 'DEPTID',
	date_format(hire_date, '%Y-%m-%d') 'HIRE_DATE'
from employees
where (department_id = 50 or department_id = 90)
and hire_date between '2004-01-01' and '2004-12-31';
	

-- 6 . 직원명, 입사일, 오늘까지의 근무일수 조회 * 주말도 포함 , 소수점 아래는 버림

-- SELECT ENAME, HIREDATE, TIMESTAMPDIFF(MONTH, HIREDATE, NOW()) AS MONTHS_BETWEEN FROM EMP;
select now();

select
	concat(concat(first_name, ' '), last_name) '직원명',
	date_format(hire_date, '%Y-%m-%d') '입사일',
	datediff(now(), hire_date) '오늘까지의 근무일수'
from employees;
	

-- 7. 직원들의 입사일로부터 년도만 가지고 각 년도별 입사 인원수를 구하시오
--  아래의 년도에 입사한 인원수를 조회하시오. 마지막으로 전체직원수도 구하시오
--
--	-------------------------------------------------------------------------
--	 2001년   2002년   2003년   2004년   2005년   2006년   2007년 2008년 전체직원수

select year(hire_date) 연도, count(hire_date) 입사직원수, grouping(year(hire_date))
from employees
group by year(hire_date) with rollup
order by year(hire_date);

select ifnull(연도, '전체직원수') 연도, 입사직원수
from (
	  select year(hire_date) 연도, count(hire_date) 입사직원수
	  from employees
	  group by year(hire_date) with rollup
	  order by year(hire_date)
) a;
--	-------------------------------------------------------------------------
-- select count(hire_date) '2001년'
-- from employees
-- where extract(year from hire_date) = 2001;
-- 
-- select count(hire_date) '2002년'
-- from employees
-- where extract(year from hire_date) = 2002;
-- 
-- select count(hire_date) '2003년'
-- from employees
-- where extract(year from hire_date) = 2003;
-- 
-- select count(hire_date) '2004년'
-- from employees
-- where extract(year from hire_date) = 2004;
-- 
-- select count(hire_date) '2005년'
-- from employees
-- where extract(year from hire_date) = 2005;
-- 
-- select count(hire_date) '2006년'
-- from employees
-- where extract(year from hire_date) = 2006;
-- 
-- select count(hire_date) '2007년'
-- from employees
-- where extract(year from hire_date) = 2007;
-- 
-- select count(hire_date) '2008년'
-- from employees
-- where extract(year from hire_date) = 2008;
-- 
-- select 1 + 7 + 6 + 10 + 29 + 24 + 19 + 11;
-- 
-- create table hire_by_year (
-- 	2001년 int,
-- 	2002년 int,
-- 	2003년 int,
-- 	2004년 int,
-- 	2005년 int,
-- 	2006년 int,
-- 	2007년 int,
-- 	2008년 int
-- );
-- 
-- alter table hire_by_year add 전체직원수 int;
-- 
-- insert into hire_by_year
-- values(1, 7, 6, 10, 29, 24, 19, 11, 107);
-- 
-- select * from hire_by_year;

-- 다른사람 코드 참고
SELECT 
    SUM(CASE WHEN YEAR(hire_date) = 2001 THEN 1 ELSE 0 END) AS '2001년', -- 참이면 1, 거짓이면 0 반환, sum()이 1만 더함
    SUM(CASE WHEN YEAR(hire_date) = 2002 THEN 1 ELSE 0 END) AS '2002년',
    SUM(CASE WHEN YEAR(hire_date) = 2003 THEN 1 ELSE 0 END) AS '2003년',
    SUM(CASE WHEN YEAR(hire_date) = 2004 THEN 1 ELSE 0 END) AS '2004년',
    SUM(CASE WHEN YEAR(hire_date) = 2005 THEN 1 ELSE 0 END) AS '2005년',
    SUM(CASE WHEN YEAR(hire_date) = 2006 THEN 1 ELSE 0 END) AS '2006년',
    SUM(CASE WHEN YEAR(hire_date) = 2007 THEN 1 ELSE 0 END) AS '2007년',
    SUM(CASE WHEN YEAR(hire_date) = 2008 THEN 1 ELSE 0 END) AS '2008년',
    COUNT(*) AS 전체직원수
FROM employees;


-- 8. 부서코드가 50이면 총무부, 60이면 기획부, 90이면 영업부로 처리하시오
--   단, 부서코드가 50, 60, 90 인 직원의 정보만 조회함
--   부서코드 기준 오름차순 정렬함.

select *,
	case department_id
		when 50 then '총무부'
		when 60 then '기획부'
		else '영업부'
	end as result
from employees
where department_id in(50, 60, 90)
order by department_id;

-- 9. EMPLOYEES 테이블에서 이름, 연봉, 총수령액(보너스 포함), 실수령액(총 수령액에서 월급의 세금 3% 차감)을 출력하시오
select
	concat(concat(first_name, ' '), last_name) '이름',
	salary * 12 '연봉',
	(salary * 12) * (1 + ifnull(commission_pct, 0)) '총수령액',
	(salary * 12) * (1 + ifnull(commission_pct, 0)) * 0.97 '실수령액'
from employees;

-- 10. EMPLOYEES 테이블에서 20년 이상 근속한 직원의 이름, 월급, 보너스를 출력하시오 (편집됨) 

select
	concat(concat(first_name, ' '), last_name) '이름',
	salary '월급',
	(salary * 12) * (1 + ifnull(commission_pct, 0)) '보너스'
from employees
where timestampdiff(year, hire_date, now()) >= 20;

commit;