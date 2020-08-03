--11.1�������� �߰��ϱ�
--ALTER TABLE���
--���̺� ���� ����̴�.
--����
drop table emp01;
create table emp01(empno number(4),ename varchar2(10),
job varchar2(9),deptno number(4));

alter table emp01 add constraint emp01_empno_pk primary key(empno);
alter table emp01 add constraint emp01_deptno_fr foreign key(deptno) references dept(deptno);
select * from user_cons_columns where table_name in('EMP01');
select * from user_tab_columns where table_name in('EMP01');
select * from user_constraints where table_name in('EMP01');

--11.2MODIFY�� NOT NULL�������� �߰�
alter table emp01 modify ename constraint emp01_ename_nn not null;

--11.3�������� �����ϱ�
alter table emp01 drop constraint emp01_empno_pk;
alter table emp01 drop constraint emp01_ename_nn;

--����
drop table sungjuk;
drop table member;
create table member(member_id varchar(4),passwd varchar2(15),gender char(1),emai varchar2(50),
phone char(13),addr varchar2(100));
create table sungjuk(hakbun varchar2(6),irum varchar2(15),
kor number(3),eng number(3),math number(3),tot number(3),avg number(5,2),
grade char(2),member_id varchar2(4));
select * from user_constraints where table_name in('MEMBER');
alter table member add constraint member_id_pk primary key(member_id);
alter table member modify passwd constraint member_passwd_nn not null;
alter table member add constraint member_gender_ck check(gender in('M','F'));
select * from user_constraints where table_name in('SUNGJUK');
alter table sungjuk add constraint sungjuk_hakbun_pk primary key(hakbun);
alter table sungjuk modify irum constraint sungjuk_irum_nn not null;
alter table sungjuk add constraint sungjuk_kor_ck check(kor between 0 and 100);
alter table sungjuk add constraint sungjuk_eng_ck check(eng between 0 and 100);
alter table sungjuk add constraint sungjuk_math_ck check(math between 0 and 100);
alter table sungjuk add constraint sungjuk_tot_ck check(tot between 0 and 300);
alter table sungjuk add constraint sungjuk_avg_ck check(avg between 0.0 and 100.0);
alter table sungjuk add constraint sungjuk_grade_ck check(grade in('��','��','��','��','��'));
alter table sungjuk add constraint sungjuk_id_fk foreign key(member_id) references member(member_id);

--12.���������� ��Ȱ��ȭ�� CASCADE
--���������� ��� ����.
--CASCADE
--����
drop table dept01;
create table dept01(deptno number(2) constraint dept01_deptno_pk primary key,
dname varchar2(14),loc varchar2(13));
drop table emp01;
create table emp01(empno number(4) constraint emp01_empno_pk primary key,
ename varchar2(10) constraint emp01_enmae_nn not null,job varchar2(9),
deptno number(4) constraint emp01_deptno_fk references dept01(deptno));

--12.1���� ������ ��Ȱ��ȭ
--DISABLE CONSTRAINT : ���� ������ �Ͻ� ��Ȱ��ȭ
--ENABLE CONSTRAINT : ��Ȱ��ȭ�� ���� ������ �����Ͽ� �ٽ� Ȱ��ȭ
--����
alter table emp01 disable constraint emp01_deptno_fk;
select constraint_name,constraint_type,table_name,r_constraint_name,status
from user_constraints where table_name='EMP01';

--12.2���� ������ Ȱ��ȭ
alter table emp01 enable constraint emp01_deptno_fk;

--12.3CASCADE �ɼ�
--�θ� ���̺��� ���� ������ ��Ȱ��ȭ�ϸ� �̸� �����ϰ� �ִ� �ڽ����̺��� �������Ǳ���
--���� ��Ȱ��ȭ���� �ִ� �ɼ�.
--���� ���������� �������� Ȱ��ȴ�.
alter table dept01 disable primary key; --���Ӽ��������� ���� ���� �Ұ�
alter table dept01 disable primary key cascade; --�θ�,�ڽ� ���ÿ� ����
select constraint_name,constraint_type,table_name,r_constraint_name,status
from user_constraints where table_name in('DEPT01','EMP01');
alter table dept01 enable constraint dept01_deptno_pk;

--14�� ���� ���̺��� ��
--1. ���� ����
--���������� �����͸� �����ϰ� ���� �ʴ�.
--��� �̹� �����ϰ� �ִ� ���̺� ���������� �����ϵ��� �Ѵ�.
create table dept_copy as select * from dept;
create table emp_copy as select * from emp;
select * from dept_copy;
select * from emp_copy;

--2)�� �����ϱ�
--CREATE VIEW 
--CREATE OR REPLACE VIEW : �䰡 ������ �����ǰ� �����ϴ��� ���������ʰ� ���ο� ������ ��� ����
--FORCE : �⺻���̺��� ���� ���ο� ������� �並 ����
--WITH CHECK OPTION : ������������ UPDATE �Ǵ� INSERT�� �����ϴ�.
--WITH READ ONLY : SELECT�� �����ϰ� �Ѵ�.
--scott������ �� ���������� ���� ������ ������ �־��ְ� �����ؾ��Ѵ�.
create view emp_view30 as select empno,ename,deptno from emp_copy where deptno=30;
select * from emp_view30;
desc emp_view30;

create view emp_view20 as select empno,ename,deptno,mgr from emp_copy where deptno=20;
select * from emp_view20;

--2.���� ���α����� USER_VIEWS ������ ��ųʸ�
--����� �������� TEXT �÷��� ����Ǿ� �ִ�.
select view_name,text from user_views;
--�信 ���� �߰�
--������ ���� ���� ���̺��� ���ԵǾ��ִ�.
--�並 ���� ������� ���� ���̺��� ���������� ������.
insert into emp_view30 values(1111,'AAAA',30);
select * from emp_view30;
select * from emp_copy;
alter table emp_copy add constraint emp_copy_empno_pk primary key(empno);
alter table emp_copy modify job constraint emp_copy_job_nn not null;
select * from user_constraints where table_name ='EMP_COPY';
alter table emp_copy drop constraint emp_copy_job_nn; 

select * from emp_copy,dept_copy where emp_copy.deptno=dept_copy.deptno;

--3.�並 ����ϴ� ����
--������ �ܼ�ȭ��ų �� �ִ�.
--���ȿ� �����ϴ�.

--4.���� ����
--�ܼ���/���պ�
--�ܼ��� : �ϳ��� ���̺�� ����,�׷� �Լ� ���X,DISTINCT��� X,DML����
--���պ� : �������� ���̺�� ����,�׷��Լ� ���O,DISTINCT��� O,DML�Ұ���
--1)�ܼ���
insert into emp_view30 values(8000,'ANGEL',30);
select * from emp_view30;
select * from emp_copy;
--�ܼ����� Į���� ��Ī �ο��ϱ�
--��Ī�� �ο��� ���� �ο��� ��Ī�� ����ؾ��Ѵ�.
create or replace view emp_view(�����ȣ,�����,�޿�,�μ���ȣ)
as select empno,ename,sal,deptno from emp_copy;
select * from emp_view where �μ���ȣ=30;
--�׷��Լ��� ����� �ܼ���(��Ī �ʿ�)
create or replace view view_sal as select deptno,sum(sal) as "SalSum",
avg(sal) as "SalAvg" from emp_copy group by deptno order by deptno;
select * from view_sal;
--��������� �����(��Ī�� �ʿ� sal*12=>sal)
create or replace view view_sal(empno,ename,deptno,sal) 
as select empno,ename,deptno,sal*12 from emp_copy;
select * from view_sal;

create or replace view view_sal(empno,ename,sal)
as select empno,ename,sal from emp_copy;

--2)���պ�
create view emp_view_dept
as select e.empno,e.ename,e.sal,e.deptno,d.dname,d.loc from emp E,dept D
where e.deptno = d.deptno order by empno desc;
select * from emp_view_dept;

create or replace view sal_view(dname,max_sal,min_sal)
as select dname,max(sal),min(sal) from emp,dept where emp.deptno=dept.deptno 
group by dname;
select * from sal_view;

--5.�� ������ �پ��� �ɼ�
--�並 �����ص� �並 ������ ���� ���̺��� ������ �����Ϳ��� ���� ������ ���� �ʴ´�.
drop view view_sal;
select * from view_sal;
select * from user_views;

--6.�� ������ ���Ǵ� �پ��� �ɼ�
--1)�� ������ ���� OR REPLACE �ɼ�
select * from user_views;
select * from emp_view30;

create or replace view emp_view30
as select empno,ename,sal,comm,deptno
from emp_copy where deptno=30;

select * from emp_view20;
create or replace view emp_view20(emp_no,emp_name,dept_no,manager)
as select empno,ename,deptno,mgr from emp_copy where deptno=20;

--2)�⺻ ���̺� ���� �並 �����ϱ� ���� FORCE �ɼ�
--NOFORCE�ɼ� : FORCE�ɼǰ� �ݴ�� ����, �⺻���̺��� �ݵ�� �־�� �Ѵ�.
--Ư���� ������ ������ ����Ʈ�� NOFORCE�ɼ��� ������ ������ �����Ѵ�.
--����Ʈ�� NOFORCE�ɼ��� ����Ȱ��
create or replace view employees_view
as select empno,ename,deptno from employees where deptno=30;
--FORCE�ɼ�(������ �߻������� ��� ������)
create or replace force view notable_view
as select empno,ename,deptno from employees where deptno=30;

--3)���� �÷� �� ���� ���ϰ� �ϴ� WITH CHECK OPTION (�߿�!)
--�����Ҷ� ����� WHERE�� ����(�÷�)�� �ǵ��� ���ϰ� �Ѵ�.
--���� �������� WHERE���� �߰��Ͽ� �⺻���̺��� Ư�� ���ǿ� �����ϴ� �ุ����
--������ �並 ������ �� �ִ�.
select * from emp_view30;
commit;
--WITH CHECK OPTION�����Ѱ��
--�� �並 ���� ������ �����ϴ�.
update emp_view30 set deptno=20 where sal>=1200;
rollback;
--WITH CHECK OPTION�� ����Ѱ��
--�� �並 ���ؼ��� �μ���ȣ�� ������ �� ����.
create or replace view view_chk30
as select empno,ename,sal,comm,deptno from emp_copy
where deptno=30 with check option;
update view_chk30 set deptno=20 where sal>=1200;
select * from view_chk30;

--4)�並 ���� �⺻���̺� ���� ���� WITH READ ONLY�ɼ�
--�б� ���� (SELECT�� ���� DML ��� �Ұ���)
--WITH READ ONLY�ɼ��� �������� ���� VIEW_CHK30 ��
update view_chk30 set comm=1000;
--WITH READ ONLY�ɼ��� �����Ͽ� �並 ����
create or replace view view_read30
as select empno,ename,sal,comm,deptno from emp_copy
where deptno=30 with read only;
select * from view_read30;
--WITH READ ONLY�ɼǿ� ���� select�� ������ DML���� �����߻�
update view_read30 set comm=2000;

--7.�ζ��� ��(�߿�!)
--�Խ��ǿ� ����.(�ֽű� ����)
select rownum,empno,ename,hiredate from emp;

select empno,ename,hiredate from emp order by hiredate;
select rownum,num,empno,ename,hiredate from 
(select rownum as num,empno,ename,hiredate from emp) where num>=6 and num<=10;
--�Ի����� ���� ��� 5���� ���
--���ο� �並 ������ ���
create or replace view view_hire 
as select empno,ename,hiredate from emp order by hiredate;
select rownum,empno,ename,hiredate from view_hire;
select rownum,empno,ename,hiredate from view_hire where rownum<=5;
--�ζ��� �並 ����� ���
--1��~5��
select rownum,empno,ename,hiredate from
(select empno,ename,hiredate from emp order by hiredate) where rownum<=5;
--6��~10��
select * from (select rownum num,empno,ename,hiredate from
(select empno,ename,hiredate from emp order by hiredate))
where num >=6 and num <=10;

--����(�ζ��κ�)
select * from
(select rownum ranking,empno,ename,sal from
(select empno,ename,sal from emp order by sal desc)) where ranking<=3;

--����(�ζ��κ�2)
select * from
(select rownum ranking,empno,ename,sal from
(select empno,ename,sal from emp order by sal desc)) where ranking between 6 and 10;

--����(����)
create or replace view sal_top5_view
as select empno,ename,sal from emp order by sal desc;
select * from (select rownum ranking,empno,ename,sal from
(select * from sal_top5_view)) where ranking between 6 and 10;