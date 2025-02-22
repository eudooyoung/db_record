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

commit;