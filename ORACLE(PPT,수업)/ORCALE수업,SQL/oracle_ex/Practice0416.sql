--13�� ��������
--1.���Ἲ ���� ������ ����� ����
--������ ���Ἲ ���� ���� : ���̺� �������� �ڷᰡ �ԷµǴ°��� ����.
--NOT NULL/UNIQUE/PRIMARY KEY(�⺻Ű)/FOREIGN KEY(�ܷ�Ű,����Ű)/CHECK
--emp ���̺��� empno�� PK(PRIMARY KEY)�̰�, deptno�� FK(FOREIGN KEY)�̴�.
--�������Ἲ : �ڽ����̺��� ����Ű�� �ݵ�� �θ����̺��� �⺻Ű�� �־�� �ȴ�.
--ex) emp���̺�(�ڽ����̺�),dept���̺�(�θ����̺�) deptno�� emp���� ����Ű,dept������ �⺻Ű

--2.�������� Ȯ���ϱ�
--USER_CONSTRAINTS ������ ��ųʸ� ��� ���� ���ǿ� ���� ������ ��ȸ�� �� �ִ�.
DESC USER_CONSTRAINTS;
--CONSTRAINT_TYPE
--P(PRIMARY KEY),R(FOREIGN KEY),U(UNIQUE),C(CHECK, NOT NULL)
select constraint_name, constraint_type,table_name,r_constraint_name from user_constraints;
--USER_CONS_COLUMNS��� ���������� ������ Į������ �˷��ش�.
select * from user_cons_columns;

--3.�ʼ� �Է��� ���� NOT NULL���� ����
--�ʼ� �Է��� �䱸�ϴ� �÷��� �ִٸ� NULL���� ������� ���ϵ��� ���������� �����ؾ� �Ѵ�.
--�������Ǿ��� ���̺� ���� ����
drop table emp01;
create table emp01(empno number(4),ename varchar2(10),job varchar2(9),deptno number(2));
insert into emp01 values(null,null,'SALESMAN',30);
select * from emp01;
desc emp01;
--NOT NULL�������� �����ؼ� ���̺� ���� ����(�÷� ���� ������θ� ���� ����)
drop table emp02;
create table emp02(empno number(4) not null,ename varchar2(10) not null,
job varchar2(9),deptno number(2));
desc emp02;

--4.������ ���� ����ϴ� UNIQUE���� ����
--NULL�� ��(VALUE)���� ���ܵǹǷ� UNIQUE������ üũ�ϴ� ������ ���ܵȴ�.
drop table emp03;
create table emp03(empno number(4) unique,ename varchar2(10) not null,
job varchar2(9),deptno number(2));
desc emp03;

--5.�÷������� �������Ǹ��� ����ؼ� �������� ����
--���̺��_Į����_������������
drop table emp04;
create table emp04(empno number(4) constraint emp04_empno_uk unique,
ename varchar2(10) constraint emp04_ename_nn not null,job varchar2(9),deptno number(2));
desc emp04;
select table_name,constraint_name from user_constraints where table_name in('EMP04');

--6.������ ������ ���� PRIMARY KEY���� ����
drop table emp05;
create table emp05(empno number(4) constraint emp05_empno_pk primary key,
ename varchar2(10) constraint emp05_ename_nn not null,job varchar2(9),deptno number(2));
select * from user_constraints where table_name in('EMP05');

--7.���� ���Ἲ�� ���� FOREIGN KEY ���� ����
--ERD (Entity Relation Diagram) ��ü�� ���� ���̾�׷�
select table_name,constraint_type,constraint_name,r_constraint_name from user_constraints
where table_name in('EMP','DEPT');
select * from user_cons_columns where table_name in('EMP','DEPT');
--R_CONSTRAINT_NAME�� �ܷ�Ű�� ��� � �⺻Ű�� �����ߴ����� ���� ������ ���´�.
drop table emp06;
create table emp06(empno number(4) constraint emp06_empno_pk primary key,
ename varchar2(10) constraint emp06_ename_nn not null,job varchar2(9),
deptno number(2) constraint emp06_deptno_fk references dept(deptno));
insert into emp06 values(7566,'JONES','MANAGER',50); --�θ����̺��� deptno�� 50�� ����.
select * from user_cons_columns where table_name in('EMP06','DEPT');
insert into emp06 values(7566,'JONES','MANAGER',40);
select * from emp06;

--8.CHECK ���� ����
--�Էµ� ���� �����Ȱ� �̿��� ���̸� �����޽����� �Բ� ����� ������� ���ϰ� �Ѵ�.
create table emp07(empno number(4) constraint emp07_empno_pk primary key,
ename varchar2(10) constraint emp07_ename_nn not null,
sal number(7,2) constraint emp07_sal_ck check(sal between 500 and 5000),
gender varchar2(1) constraint emp07_gender_ck check(gender in('M','F')));

--9.DEFAULT ���� ����
--�ƹ��� ���� �Է� ���� �ʾ��� �� ����Ʈ������ ���� �Է��� �ȴ�.
drop table dept01;
create table dept01(deptno number(2) primary key,
dname varchar2(14),loc varchar2(13) default 'SEOUL');
insert into dept01(deptno,dname) values(10,'ACCOUNTING');
select * from dept01;--loc���� �Է¾��߱� ������ ����Ʈ������ ���� 'SEOUL'�� �Էµ�.

--����
--member���̺� 
--member_id varchar2(4) �⺻Ű
--passwd varchar2(15) not null
--gender char(1) ��:M ��:F
--email varchar2(50)
--phone char(13)
--addr varchar2(100)
--sungjuk���̺�
--hakbun �⺻Ű
--irum 
--kor 0~100
--eng 0~100
--math 0~100
--tot 0~300
--avg 0.0~300
--grade ��,��,��,��,��
--member_id �ܷ�Ű
create table member(
member_id varchar2(4) constraint member_id_pk primary key,
passwd varchar2(15) constraint member_passwd_nn not null,
gender char(1) constraint member_gender_ck check(gender in('M','F')),
email varchar2(50),phone char(13),addr varchar2(100));

create table sungjuk(
hakbun varchar2(6) constraint sungjuk_hakbun_pk primary key,
irum varchar2(15) constraint sungjuk_irum_nn not null,
kor number(3) constraint sungjuk_kor_ck check(kor between 0 and 100),
eng number(3) constraint sungjuk_eng_ck check(eng between 0 and 100),
math number(3) constraint sungjuk_math_ck check(math between 0 and 100),
tot number(3) constraint sungjuk_tot_ck check(tot between 0 and 300),
avg number(5,2) constraint sungjuk_avg_ck check(avg between 0.0 and 100.0),
grade char(2) constraint sungjuk_grade_ck check(grade in('��','��','��','��','��')),
member_id varchar2(4) constraint sungjuk_id_fk references member(member_id));
--���̺� ���� Ȯ���ϴ� ��
desc member;
desc sungjuk;
select * from user_cons_columns where table_name in('MEMBER','SUNGJUK');
select * from user_constraints where table_name in('MEMBER','SUNGJUK');
select * from user_tab_columns where table_name in('MEMBER','SUNGJUK');

--10.���̺� ���� ������� �������� ����
--����Ű�� �⺻Ű�� ������ ���
--ALTER TABLE�� ���� ������ �߰��� ��
--���̺� ���� ��Ŀ��� NOT NULL������ ������ �� ����.
--DEFAULT���ǵ� �������� �÷� ����������� �����ؾ� �Ѵ�.
create table emp01(empno number(4) primary key,ename varchar2(10) not null,
job varchar2(9) unique,deptno number(4) references dept(deptno));

create table emp02(empno number(4),ename varchar2(10) not null,
job varchar2(9),deptno number(4),primary key(empno),unique(job),
foreign key(deptno) references dept(deptno));

create table emp03(empno number(4) constraint emp03_ename_nn not null,
ename varchar2(10),job varchar2(9),deptno number(4),
constraint emp03_empno_pk primary key(empno),
constraint emp03_job_uk unique(job),
constraint emp03_deptno_fk foreign key(deptno) references dept(deptno));
--����Ű�� �⺻Ű�� �����ϴ� ���
create table member01(name varchar2(10),address varchar2(30),hphone varchar2(16),
constraint member01_combo_pk primary key(name,hphone));
select * from user_cons_columns where table_name in('MEMBER01');
select * from user_constraints where table_name in('MEMBER01');
select * from user_tab_columns where table_name in('MEMBER01');

--����2
drop table sungjuk; --�ڽ�Ŭ������ ���� �����ѵ�,
drop table member;  --�θ�Ŭ������ �����ؾ� �ȴ�.

create table member(
member_id varchar2(4),passwd varchar2(15) constraint member_passwd_nn not null,
gender char(1),email varchar2(50),phone char(13),addr varchar2(100),
constraint member_id_pk primary key(member_id),
constraint member_gender_ck check(gender in('M','F')));

create table sungjuk(
hakbun varchar2(6),irum varchar2(15) constraint sungjuk_irum_nn not null,
kor number(3),eng number(3),math number(3),tot number(3),avg number(5,2),
grade char(2),member_id varchar2(4),
constraint sungjuk_hakbun_pk primary key(hakbun),
constraint sungjuk_kor_ck check(kor between 0 and 100),
constraint sungjuk_eng_ck check(eng between 0 and 100),
constraint sungjuk_math_ck check(math between 0 and 100),
constraint sungjuk_tot_ck check(tot between 0 and 300),
constraint sungjuk_avg_ck check(avg between 0.0 and 100.0),
constraint sungjuk_grade_ck check(grade in('��','��','��','��','��')),
constraint sungjuk_id_fk foreign key(member_id) references member(member_id));

desc member;
insert into member
values('M001','1234','M','M001@aaa.com','010-0000-0000','�����');
select * from member;
insert into member
values('M002','12345','F','M002@aaa.com','010-1111-0000','�Ⱦ��');
select * from member;
delete member where member_id in('M002');