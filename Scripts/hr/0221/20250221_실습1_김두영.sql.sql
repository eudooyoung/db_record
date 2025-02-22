use hr;

-- 1. 2020년 12월 25일이 무슨 요일인지 조회하시오.
select 
	case weekday('2020-12-25')
		when 0 then '월요일'
		when 1 then '화요일'
		when 2 then '수요일'
		when 3 then '목요일'
		when 4 then '금요일'
		when 5 then '토요일'
		when 6 then '일요일'
	end as '2020년 크리스마스 요일';
	
-- 2. 
--    성이 Cambrault씨인 직원들의 사원명, 사원번호 , 부서명, 직급명을 조회하시오.
select *
from employees;

select concat(a.first_name, ' ', a.last_name) 사원명, a.employee_id 사원번호, b.department_name 부서명, a.job_id 직급명
from employees a
join departments b on a.department_id = b.department_id
where a.last_name = 'Cambrault';

-- ANSI 표준
-- 3. 가장 급여가 적은 직원의 사번, 사원명,
--    SAL, 부서명, 직급명을 조회하시오.

select a.employee_id 사원번호, concat(a.first_name, ' ', a.last_name) 사원명, a.salary SAL, b.department_name 부서명, a.job_id 직급명
from employees a
join departments b on a.department_id = b.department_id
where a.salary = (select min(salary) from employees);

-- ANSI 표준
-- 4. 이름에 'sa'자가 들어가는 직원들의
-- 사번, 사원명, 부서명을 조회하시오.
select a.employee_id, concat(a.first_name, ' ', a.last_name) 사원명, b.department_name 부서명
from employees a
join departments b on a.department_id = b.department_id
where (a.first_name, a.last_name) in (
										select first_name, last_name
										from employees
										where first_name like '%sa%' or last_name like '%sa%' 
										);

select first_name, last_name
from employees
where first_name like '%sa%' or last_name like '%sa%';

-- ANSI 표준
-- 5. IT팀에 근무하는 사원명,
--    직급명, 부서코드, 부서명을 조회하시오.
select concat(a.first_name, ' ', a.last_name) 사원명, a.job_id 직급명, a.department_id 부서코드, b.department_name 부서명
from employees a
join departments b on a.department_id = b.department_id
where b.department_name = (select department_name from departments where department_name = 'IT');

select department_name
from departments
where department_name = 'IT';

select * from employees;
-- ANSI표준
-- 6. COMMISSION_PCT 를 받는 직원들의 사원명,
--    COMMISSION_PCT , 부서명, 근무지역명을 조회하시오.

select concat(a.first_name, ' ', a.last_name) 사원명, a.commission_pct, a.job_id 직급명, a.department_id 부서코드, b.department_name 부서명
from employees a
join departments b on a.department_id = b.department_id
where a.commission_pct in (select commission_pct from employees where commission_pct is not null);

select commission_pct
from employees
where commission_pct is not null;
-- ANSI표준
-- ANSI 표준

-- 7. 부서코드가 10인 직원들의 사원명,
--    직급명, 부서명, 근무지역명을 조회하시오.
select concat(a.first_name, ' ', a.last_name) 사원명, a.job_id 직급명, b.department_name 부서명, c.city 근무지역명
from employees a
join departments b on a.department_id = b.department_id
join locations c on b.location_id = c.location_id
where b.department_id in (select department_id from departments where department_id = 10);

-- ANSI 표준
-- 8.United States of America(US) Canada(CA)에 근무하는 직원들의
--    사원명, 부서명, 지역명, 국가명을 조회하시오.
-- ANSI 표준
select concat(a.first_name, ' ', a.last_name) 사원명, b.department_name 부서명, c.city 지역명, d.country_name 국가명
from employees a
join departments b on a.department_id = b.department_id
join locations c on b.location_id = c.location_id
join countries d on c.country_id = d.country_id
where c.country_id in (select country_id from countries where country_id like 'US' or 'CA');

-- 9. (COMMISSION_PCT가 없는 직원들 중)에서 직급코드가
--     FI_ACCOUNT와 IT_PROG인 직원들의 사원명, 직급명, 급여를 조회하시오.
--     단, join과 IN 사용할 것

select commission_pct
from employees
where commission_pct is null;

select concat(a.first_name, ' ', a.last_name) 사원명, b.job_title 직급명, a.salary 급여
from employees a
join jobs b on a.job_id = b.job_id
where b.job_id in (select job_id from jobs where job_id = 'FI_ACCOUNT' or job_id ='IT_PROG')
and a.commission_pct is null;

commit;

-- ANSI 표준
-- 10, 사번, 이름, 직급명, 부서명, 근무지역(시티명)을 조회하고,
-- 그 결과를 V_RESULT_EMP라는 뷰로 생성하여 저장하세요
-- 11 사번, 이름, 직급명, 부서명, 근무년수 을 조회하고,
-- 그 결과를 V_EMP_JOB 뷰로 생성하여 저장하세요