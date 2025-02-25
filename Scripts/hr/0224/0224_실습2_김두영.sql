use hr;

create table tbl_user (
	user_id int auto_increment,
		constraint pk_user_id
			primary key (user_id),
	user_nickname varchar(50),
		constraint uniq_user_nickname
			unique (user_nickname),
		constraint not_null_user_nickname
			check (user_nickname is not null),
	user_pwd varchar(50),
		constraint not_null_user_pwd
			check (user_pwd is not null),	
	user_status char(2),
		constraint not_null_user_status
			check (user_status is not null)
);

create table tbl_board (
	post_id int auto_increment,
		constraint pk_post_id
			primary key (post_id),
	post_title varchar(50),
		constraint not_null_post_title
			check (post_title is not null),
	post_content varchar (300),
		constraint not_null_post_content
			check (post_content is not null),
	post_date timestamp default (current_timestamp),
	post_writer int,
		constraint fk_post_writer
			foreign key (post_writer) references tbl_user (user_id)
);

create table tbl_reply (
	reply_id int auto_increment,
	reply_content varchar (150) not null,
	reply_writer int,
	constraint pk_reply_id primary key (reply_id),
	constraint fk_reply_writer foreign key (reply_writer) references tbl_user (user_id)
);

commit;