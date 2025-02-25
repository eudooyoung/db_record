use scott;

start transaction;
select * from testtbl2  where id = 1 for update;

update testtbl2 
set username = '이유'
where id = 1;

commit;