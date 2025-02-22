use hr;

select *
from member;

drop table if exists reply, board, member;

create table member (
	ID int auto_increment primary key,
	PW varchar(100),
	NAME varchar(100) unique,
	TEL varchar(100)
);

create table board (
	NO int auto_increment,
	TITLE varchar(100),
	CONTENT varchar(100),
	WRITER varchar(100),
	constraint
		primary key pk_board_NO (NO),
	constraint fk_board_WRITER
		foreign key (WRITER) references member (NAME)
);

create table reply (
	ID int auto_increment,
	ORIID int,
	CONTENT varchar(100),
	WRITER varchar(100),
	constraint
		primary key pk_reply_ID (ID),
	constraint fk_reply_WRITER
		foreign key (WRITER) references member (NAME),
	constraint fk_reply_ORIID
		foreign key (ORIID) references board (NO)
);

alter table member
add unique (NAME);

select *
from board;

select *
from member;

-- 널빼고 컬럼지정해서 넣는 방식 확인
insert into member(PW, NAME, TEL)
			values('1234', '김두영', '12341234'),
				  ('5678', '김진영', '56785678'),
				  ('4321', '김세영', '43214321');

insert into board(TITLE, CONTENT, WRITER)
			values('첫번째 제목', '안녕', WRITER),
				     ('두번째', '안녕2', '김두영'),
				     ('세번째', '안녕3', '김세영');

delete
from board
where NO between 7 and 9;

insert into reply(ORIID, CONTENT, WRITER)
			values(5, 're: 안녕1', '김두영'),
	     		  (4, 're: 안녕2', '김진영'),
	     		  (6, 're: 안녕3', '김세영');

commit;