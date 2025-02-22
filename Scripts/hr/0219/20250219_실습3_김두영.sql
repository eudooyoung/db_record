use hr;

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