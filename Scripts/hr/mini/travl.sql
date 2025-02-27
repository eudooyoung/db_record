use jdbc;

create database travel_db;
use travel_db;

drop table if exists travel;

create table travel (
	no int auto_increment not null primary key,
	district varchar(50) not null,
	title varchar(512) not null,
	description text,
	address varchar(512),
	phone varchar(256)
);

commit;
