-- 20250220_실습2_이름.sql
-- 회원 가입용 테이블 생성(MEMBER_TEST)
-- 컬럼명 : USER_NO(회원번호)
--         USER_ID(회원아이디) -- 중복 금지, NULL값 허용 안함
--         USER_PWD(회원비밀번호) -- NULL값 허용 안함
--         PNO(주민등록번호) -- 중복금지, NULL값 허용 안함
--         GENDER(성별) -- '남' 혹은 '여'로 입력
--         PHONE(연락처)
--         ADDRESS(주소)
--         STATUS(탈퇴여부) -- NOT NULL, 'Y' 혹은 'N'으로 입력
-- 각 컬럼에 제약조건 이름 부여
-- 각 컬럼별로 코멘트 생성
-- 3명 이상 회원 정보 INSERT

use hr;

drop table if exists member_test;

create table member_test (
	user_no int auto_increment comment '회원번호',
		constraint pk_member_user_no
			primary key (user_no),
	user_id varchar(100) comment '회원 아이디',		
		constraint unique_member_user_id
			unique (user_id),
		constraint not_null_member_test_user_id
			check (user_id is not null),
	user_pwd varchar(100) comment '회원 비밀번호',		
		constraint not_null_member_test_user_pwd
			check (user_pwd is not null),
	pno int comment '주민등록번호',		
		constraint unique_member_test_pno
			unique (pno),
		constraint not_null_member_test_pno
			check (pno is not null),
	gender varchar(10) comment '성별',		
		constraint check_member_test_gender
			check (gender in ('남', '여')),
	phone int comment '연락처',		
	address varchar (200) comment '주소',		
	status varchar (10) comment '탈퇴여부'
		constraint not_null_member_test_status
			check (status is not null),
		constraint check_member_test_status
			check (status in ('y', 'n'))	
);


describe member_test;

select * from member_test;

delete 
from member_test;

insert into member_test(user_id, user_pwd, pno, gender, phone, address, status)
values('id1', 1234, 12341234, '남', 12341234, '우리집', 'y'),
	  ('id2', 1234, 56785678, '여', 12341234, null, 'n'),
	  ('id3', 1234, 43214321, '남', null, '너네집', 'y');

commit;