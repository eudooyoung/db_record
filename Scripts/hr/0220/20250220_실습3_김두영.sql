use hr;

-- 1. ------------------------------------
create table depart (
	id int auto_increment,
		constraint pk_depart_id primary key (id),
	name varchar(100),
		constraint required_depart_name check (name is not null),
	instructor varchar(100),
		constraint required_depart_instructor check (instructor is not null)
);

insert into depart (name, instructor)
values('수학과', '박지원 교수'), ('전자공학', '임정현 교수');

select * from depart;

-- 2. ------------------------------------
create table student (
	id int auto_increment,
		constraint pk_student_id primary key (id),
	name varchar(100),
		constraint required_student_name check (name is not null),
	depart_id int,
		constraint fk_student_depart_id foreign key (depart_id) references depart (id)
);

insert into student (name, depart_id)
	  values('김두영', 1), ('김지영', 2);

drop table if exists student, depart;

select * from student;

-- 3. ------------------------------------
create table subject (
	id int auto_increment,
 		constraint pk_subject_id primary key (id),
	title varchar(100),
		constraint required_subject_title check (title is not null),
	depart_id int,
		constraint fk_subject_depart_id foreign key (depart_id) references depart (id)
);

insert into subject (title, depart_id)
		values ('이산수학' , 1),
			   ('전자공학개론', 2);

select * from subject;

commit;