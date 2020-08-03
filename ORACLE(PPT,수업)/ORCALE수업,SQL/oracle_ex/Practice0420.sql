--15�� ������
--1.������ ���� ���ؿ� ������ ����
--�⺻Ű�� �ߺ��� ���� ���� �� �����Ƿ� �׻� ������ ���� ������ �Ѵ�.
--�������� ���̺��� ������ ���ڸ� �ڵ����� �����ϴ� �ڵ���ȣ �߻����̴�.
--START WITH : ������ ��ȣ�� ���۰��� ����. ���� 1���� �����Ϸ��� START WITH 1�̶�� ����ϸ� �ȴ�.
--INCREMENT BY : ��ȣ�� ����ġ�� ����.1�� �����ϴ� �������� �����Ϸ��� INCREMENT BY 1�̶�� ���.
--MAXVALUE n/NOMAXVALUE
--MINVALUE n/NOMINVALUE
--CYCLE/NOCYCLE
--CACHE n/NOCACHE
create sequence dept_deptno_seq increment by 10 start with 10;
--���� ���� 10�̰� 10�� �����ϴ� ������ EMP_SEQ�� �����Ѵ�.

--2.������ ���� ������ ��ųʸ�
desc user_sequences;
select sequence_name,min_value,max_value,increment_by,cycle_flag,
last_number from user_sequences;

--3.CURRVAL, NEXTVAL
--CURRVAL : ���� ���� ��ȯ�Ѵ�.
--NEXTVAL : ���� ������ ���� ���� ���� ��ȯ�Ѵ�.
--����Ҽ� �ִ� ���
--1)���������� �ƴ� SELECT��,2)INSERT���� SELECT��,3)INSERT���� VALUE��,4)UPDATE���� SET��
--����Ҽ� ���� ���
--1)VIEW�� SELECT��,2)DISTINCT�� �ִ� SELECT��,3)�׷��Լ�,4)��������,5)DEFAULT��
select dept_deptno_seq.nextval from dual;
select dept_deptno_seq.currval from dual;

--4.������ �ǹ��� �����ϱ�
create sequence emp_seq start with 1 increment by 1 maxvalue 100000;
select sequence_name,min_value,max_value,increment_by,cycle_flag,
last_number from user_sequences;
drop table emp01;
create table emp01(empno number(4) primary key,ename varchar(10),hiredate date);
insert into emp01 values(emp_seq.nextval,'JULIA',sysdate);
select * from emp01;
insert into emp01 values(emp_seq.nextval,'ALICE',sysdate);

create table dept_example(deptno number(4) primary key,dname varchar(15),
loc varchar(15));
create sequence dept_example_deptno_seq start with 10 increment by 10 maxvalue 1000000;
insert into dept_example values(dept_example_deptno_seq.nextval,'�λ��','����');
insert into dept_example values(dept_example_deptno_seq.nextval,'�渮��','����');
insert into dept_example values(dept_example_deptno_seq.nextval,'�ѹ���','����');
insert into dept_example values(dept_example_deptno_seq.nextval,'�����','��õ');
select * from dept_example;
--������ ����
drop sequence dept_deptno_seq;
commit;
--5.������ ����
--ALTER SEQUENCE�� ���
create sequence dept_deptno_seq start with 10 increment by 10 maxvalue 30;
select * from user_sequences;
select dept_deptno_seq.nextval from dual;
select dept_deptno_seq.nextval from dual;
select dept_deptno_seq.nextval from dual;
select dept_deptno_seq.nextval from dual;

alter sequence dept_deptno_seq maxvalue 1000;
select sequence_name,max_value,increment_by,cycle_flag from user_sequences;

select * from emp01;
select max(empno) from emp01;
insert into emp01 values ((select max(empno)+1 from emp01),'MBC',sysdate);
insert into emp01 values ((select max(empno)+1 from emp01),'KBS',sysdate);
commit;

--16�� �ε���
--1.��ȸ�� ������ �ϴ� �ε���
--�ε��� ��� ���� : ���� �˻��� ���ؼ� ����Ѵ�.
--�ε��� : SQL��ɹ��� ó�� �ӵ��� ����Ű�� ���ؼ� �÷��� ���� �����ϴ� ����Ŭ ��ü.
--���� : �˻��ӵ��� ����. �ý��� ��ü ������ ����Ų��.
--���� : �ε����� ���� �߰� ������ �ʿ�.�ε��� ���� �ð��� �ɸ���. ������ �����۾��� �����Ͼ
--      ��쿡�� ������ ������ ���ϵȴ�.
--1)�ε��� ���� ��ȸ
--�ε����� �⺻ Ű�� ���� Ű�� ���� ���� ������ �����ϸ� �ڵ����� ����
create table test(a number(4),b number(4),c char(4), 
constraint test_a_pk primary key(a),constraint test_b_uk unique(b));
select table_name,constraint_type,constraint_name,r_constraint_name
from user_constraints where table_name='TEST';

select index_name,table_name,column_name from user_ind_columns
where table_name in('EMP','DEPT','TEST');
--2)��ȸ �ӵ� ���ϱ�
--EMP�� �����ؼ� EMP01�� ���鶧 EMP01�� ���������� ���簡 �����ʾƼ� �ε����� �������� �ʴ´�.
drop table emp01;
create table emp01 as select * from emp;
select table_name,index_name,column_name from user_ind_columns
where table_name in('EMP','EMP01');
--�������������� INSERT ���� ������ �ݺ��Ѵ�.
--���� �����Ͱ� ����ִ� ���̺��� �̿��ؼ� ��ȸ �ӵ� ��
insert into emp01 select * from emp01;
insert into emp01 (empno,ename) values (1111,'SYJ');
set timing on;
select distinct empno,ename from emp01 where ename='SYJ';
delete emp01;
drop table emp01;
--2.�ε��� �����ϱ�
--CREATE INDEX��ɾ� ���
create index idx_emp01_ename on emp01(ename);
select distinct empno,ename from emp01 where ename='SYJ';

--3.�ε��� �����ϱ�
drop index idx_emp01_ename;

--4.�ε��� ����
--1)���� �ε���
--������ ���� ���� �÷��� ���ؼ� �����ϴ� �ε���
--2)����� �ε���
--�ߺ��� �����͸� ���� �÷��� ���ؼ� �����ϴ� �ε���
create table dept01 as select * from dept where 1=0;
insert into dept01 values(10,'�λ��','����');
insert into dept01 values(20,'�ѹ���','����');
insert into dept01 values(30,'������','����');
create unique index idx_dept01_deptno on dept01(deptno);
--�ߺ��� �����͸� ���� �÷��� ���ؼ��� ���� �ε����� �����Ҽ� ����
create unique index idx_dept01_loc on dept01(loc);
--�ߺ��� �����͸� ���� �÷��� ���ؼ��� ����� �ε����� ������ �� �ִ�.
create index idx_dept01_loc on dept01(loc);
--3)���� �ε���
--�Ѱ��� �÷����� ������ �ε���
--4)���� �ε���
--�ΰ� �̻��� �÷����� �ε����� �����ϴ� ��
--�˻��Ҷ� �ε����� ������ �÷����� ��� ����ؼ� �˻��ؾ� �Ѵ�.
create index idx_dept01_com on dept01(deptno,dname);
select index_name,column_name from user_ind_columns where table_name='DEPT01';
--5)�Լ� ��� �ε���
--�����̳� �Լ��� �����Ͽ� �ε����� ����. ex)SAL*12�� �ε����� ����.
create index idx_emp01_annsal on emp01(sal*12);
select index_name,column_name from user_ind_columns where table_name='EMP01';

--17�� ����� ����
--1.�����ͺ��̽� ������ ���� ����
--�����Ͱ� �ܺο� ������� �ʵ��� ������ �ؾ��Ѵ�.
--1)������ ���Ұ� ����
--�ý��۱��Ѱ� ��ü����
--�ý��۱��� : ������� ������ ����,DB���� �� ���� ��ü�� ������ �� �ִ� ���� ��..
--CREATE USER : ����� ���� ����
--DROP USER : ����� ���� ����
--DROP ANY TABLE : ������ ���̺� ���� ����
--QUERY REWRITE : �Լ� ��� �ε��� ���� ����
--BACKUP ANY TABLE : ������ ���̺� ��� ����
--�����ͺ��̽��� �����ϴ� ����
--CREATE SESSION : �����ͺ��̽��� ������ �� �ִ� ����
--CREATE TABLE : ���̺� ���� ����
--CREATE VIEW : �� ���� ����
--CREATE SEQUENCE : ������ ���� ����
--CREATE PROCEDURE : �Լ� ���� ����
--��ü ���� : ��ü�� ������ �� �ִ� ����

--2.����� ����
--CREATE USER��ɾ� ���
--������� ������ ������� �̸��� ��ȣ�� �����Ͽ� �����Ѵ�.
--����ڸ� �����ϱ� ���ؼ� ������ �ʿ��ϴ�.

--3.���� �ο��ϴ� GRANT��ɾ�
--����ڿ��� �ý��� ���� �ο��ϴ� ��ɾ�
conn system/manager
create user user01 identified by tiger;
grant create session to user01;
conn user01/tiger;

select username,default_tablespace from user_users;

--1)WITH ADMIN OPTION
--����ڿ��� �ý��۱����� �ɼǰ� �Բ� �ο��ϸ� ����ڴ� �ο����� �ý��� ������
--�ٸ� ����ڿ��� �ο��� �� �ִ� ���ѵ� �Բ� �ο��޴´�.
create user user02 identified by tiger;
grant create session to user02 with admin option;
--USER02�� �ٸ� ����ڿ��� create session������ �ο��� �� �ִ� ������ �ο��޴´�.

--4.��ü ����
--��ü���� DML���� ����� �� �ִ� ������ �����ϴ� ��.
--Ư�� ��ü�� ��ȸ�ϰų� ����Ҷ� �� ��ü�� �������� ���� ����ؾ� �ȴ�.

--1)��Ű�� (SCHEMA)
--��ü�� ������ ����ڸ��� �ǹ��Ѵ�.
--���̺��� ������ ���س��� ��

--2)����ڿ��� �ο��� ���� ��ȸ
conn user01/tiger select * from user_tab_privs_made; --user01����ڰ� �ο��� ������ ���캽
select * from user_tab_privs_recd;--user01����ڿ��� �ο��� ������ ���캽

--3)����ڿ��Լ� ������ ���� ���� REVOKE ��ɾ�
--REVOKE��ɾ���� öȸ�ϰ����ϴ� ��ü���� ���� ON ���� �ش� ���̺�� from �ش� ����� ���.

--4)WITH GRANT OPTION
--��ü�� ������ ������ �ο������鼭 �ױ����� �ٸ� ����ڿ��� �ο��� �� �ִ� ���ѵ� �޴´�.

