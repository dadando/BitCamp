--ȸ�� ���� ���̺�
--ȸ����ȣ/ȸ���̸�/���Գ�¥/��ȭ��ȣ/�̸���/�ּ�
create table book_member(
    membno varchar2(20) constraint book_member_membno_pk primary key,
    memname varchar2(6) constraint book_member_memname_nn not null,
    memdate date,
    phone varchar2(13) constraint book_member_phone_uk unique,
    email varchar2(16),
    addr varchar2(10),
    overdue number default 0
);
--���� ���� ���̺�
--������ȣ/������/��������/����/���Ⱑ�ɻ���
create table book_info(
    bookno varchar2(20),
    bname varchar2(20) constraint book_info_bname_nn not null,
    bookpart varchar2(8),
    writer varchar2(8) constraint book_info_writer_nn not null,
    bstate char(1) default 'Y',
    constraint book_info_bookno_pk primary key(bookno),
    constraint book_info_bstate_ck check(bstate in('Y','N'))
);
--���� ���� ���̺�
--���ȣ/������ȣ/ȸ����ȣ/���⳯¥/�ݳ�������¥/�ݳ���¥
--������ ����Ͽ� ���ȣ�� �⺻Ű�� ���� ���.
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
--����/�ݳ���� ���� ���̺�
--ȸ����ȣ/������ȣ/���⳯¥/�ݳ��ѳ�¥
--�ݳ����Ҷ� �ش����� �����������̺��� �����ؼ� �߰��ϰ� �����������̺��� �ش��� ����
create table manage_borrow(
    mgrownum number,
    bookno varchar2(20),
    membno varchar2(20),
    lendingdate date,
    due_date date,
    returndate date,
    constraint manage_borrow_mgrownum_pk primary key(mgrownum)
);
--�������̺� �Ϸù�ȣ ������
create sequence book_br_seq start with 1 increment by 1 maxvalue 10000 cycle;
--ȸ�����̺� ȸ����ȣ ������
create sequence member_membno_seq start with 1 increment by 1 maxvalue 10000;
--�������̺� ������ȣ ������
create sequence book_bookno_seq start with 1 increment by 1 maxvalue 10000;