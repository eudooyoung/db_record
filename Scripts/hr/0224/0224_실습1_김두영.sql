use hr;

create table students (
	student_no int primary key auto_increment,
	student_name varchar(100) not null,
	student_addr varchar(100) not null,
	student_dept varchar(100) not null,
		constraint fk_student_dept
			foreign key (student_dept) references dept (dept_name)
);

insert into students (student_name, student_addr, student_dept) values ('김지영', '서울시', '철학과' );
insert into students (student_name, student_addr, student_dept) values ('박진', '부산시', '컴퓨터학과' );
insert into students (student_name, student_addr, student_dept) values ('정희', '광주시', '컴퓨터학과' );
insert into students (student_name, student_addr, student_dept) values ('임경철', '대전시', '철학과' );

create table depts (
	dept_name varchar(100) primary key,
	dept_office varchar(100) unique not null 
);

insert into depts (dept_name, dept_office) values ('컴퓨터학과', '공학 101');
insert into depts (dept_name, dept_office) values ('철학과', '인문 101');

create table lectures (
	lecture_name varchar(100) primary key,
	lecture_room varchar(100) not null
);

insert into lectures (lecture_name, lecture_room) values ('데이터베이스', '공학 110');
insert into lectures (lecture_name, lecture_room) values ('서양철학사', '인문 110');
insert into lectures (lecture_name, lecture_room) values ('자바', '공학 111');
insert into lectures (lecture_name, lecture_room) values ('동양 철학사', '인문 111');

create table student_grades (
	student_no int not null,
	constraint fk_grades_student_no
		foreign key (student_no) references students (student_no),
	lecture_name varchar(100) not null,
	constraint fk_grades_lecture_name
		foreign key (lecture_name) references lectures (lecture_name),
	grade decimal(2,1) not null
);


insert into student_grades (student_no, lecture_name, grade) values (1, '동양철학사', 4.0);
insert into student_grades (student_no, lecture_name, grade) values (1, '서양철학사', 4.5);
insert into student_grades (student_no, lecture_name, grade) values (2, '데이터베이스', 3.5);
insert into student_grades (student_no, lecture_name, grade) values (3, '자바', 4.5);

commit;

select *
from students a
join depts b on a.student_dept = b.dept_name
join student_grades c on a.student_no = c.student_no;