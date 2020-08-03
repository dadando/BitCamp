--회원 정보 테이블
--회원번호/회원이름/가입날짜/전화번호/이메일/주소
create table book_member(
    membno varchar2(20) constraint book_member_membno_pk primary key,
    memname varchar2(6) constraint book_member_memname_nn not null,
    memdate date,
    phone varchar2(13) constraint book_member_phone_uk unique,
    email varchar2(16),
    addr varchar2(10),
    overdue number default 0
);
--도서 정보 테이블
--도서번호/도서명/도서구분/저자/대출가능상태
create table book_info(
    bookno varchar2(20),
    bname varchar2(20) constraint book_info_bname_nn not null,
    bookpart varchar2(8),
    writer varchar2(8) constraint book_info_writer_nn not null,
    bstate char(1) default 'Y',
    constraint book_info_bookno_pk primary key(bookno),
    constraint book_info_bstate_ck check(bstate in('Y','N'))
);
--도서 대출 테이블
--행번호/도서번호/회원번호/대출날짜/반납예정날짜/반납날짜
--시퀀스 사용하여 행번호를 기본키로 만들어서 사용.
create table book_borrow(
    brownum number,
    bookno varchar2(20) unique,
    membno varchar2(20),
    lendingdate date,
    due_date date,
    returndate date default '19900101',
    constraint book_borrow_brownum_pk primary key(brownum),
    constraint book_borrow_bookno_fk foreign key(bookno) references book_info(bookno),
    constraint book_borrow_membno_fk foreign key(membno) references book_member(membno)
);
--대출/반납기록 관리 테이블
--회원번호/도서번호/대출날짜/반납한날짜
--반납을할때 해당행을 도서대출테이블에서 복사해서 추가하고 도서대출테이블에서 해당행 삭제
create table manage_borrow(
    mgrownum number,
    bookno varchar2(20),
    membno varchar2(20),
    lendingdate date,
    due_date date,
    returndate date,
    constraint manage_borrow_mgrownum_pk primary key(mgrownum)
);
--관리테이블 일련번호 시퀀스
create sequence book_br_seq start with 1 increment by 1 maxvalue 10000 cycle;
--회원테이블 회원번호 시퀀스
create sequence member_membno_seq start with 1 increment by 1 maxvalue 10000;
--도서테이블 도서번호 시퀀스
create sequence book_bookno_seq start with 1 increment by 1 maxvalue 10000;