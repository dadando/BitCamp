--ALTER TABLE
--���� ���̺��� ������ �����ϱ� ���� DDL��ɹ�.
--ADD COLUMN : �߰� , ������ ��ġ�� �߰���.
--MODIFY COLUMN : ����
--DROP COLUMN : ����
--ADD ����
alter table emp01 add(job varchar2(9));
desc emp01;
select * from emp02;
alter table emp02 add(job2 varchar2(9));
--DEPT02���̺� ����Ÿ���� �μ���(DMGR) Į���� �߰�
alter table dept02 add(dmgr number(4));
desc dept02;
--MODIFY ���� (�⺻Ű(primary key)�� �������,�����Ͱ� ����� ��������)
desc emp01;
alter table emp01 modify(job varchar2(30));
--DEPT02���̺��� DMGRĮ���� ����Ÿ������ ����
alter table dept02 modify(dmgr varchar2(4));

insert into dept02 values (10,'mbc','seoul','aaa');
select * from dept02;
alter table dept02 modify(dmgr number(4));
--DROP����
alter table emp01 drop column job;
desc emp01;
alter table dept02 drop column dmgr;
desc dept02;
--SET UNUSED �ɼ�
--���̺� ����� ������ ���� ��� �÷��� �����ϴµ� �� ���� �ð��� �ɸ��� ������ �ִ�.
--�÷��� �����ϴ� ���� �ƴ����� �÷��� ����� �������� ������ �� �ִ�.
--�ѹ� UNUSED�� �����ϸ� �ٽ� ������ �Ұ����ϴ�.
--����
select * from emp02;
alter table emp02 set unused(job2);
alter table emp02 drop unused columns;
--�÷� �̸� ���� RENAME column
alter table emp02 rename column deptno to dnum;

--3.���̺� �����ϱ� DROP TABLE
--����
drop table emp01;

--4.���̺��� ��� �ο츦 �����ϴ� TRUNCATE
--���̺��� ���� ���� ���� ������ ���ŵ�(�ѹ� �Ұ���).
truncate table emp02; --���� �Ұ��� ����.
delete from emp03; --�������� ������.
select * from emp03; 
ROLLBACK; --��� ������ ��ɹ� ���.

--5.���̺� ���� �����ϴ� RENAME
--����
rename emp02 to test;

--6.������ ��ųʸ��� ������ ��ųʸ� ��
--�����ͺ��̽� �ڿ��� ȿ�������� �����ϱ� ���� �پ��� ������ �����ϴ� �ý��� ���̺�(DD)
--����ڴ� ������ ��ųʸ��� ������ ���� �����ϰų� �����Ұ���
--�� ���̺��� ���� ��ȸ�� �� ����.
--�����͸� ������ �� �� �ֵ��� ������ ��ųʸ� �並 ����.

--USER_������ ��ųʸ� ��
--�ڽ��� ������ ������ ��ü � ���� ������ ��ȸ
--����
--���̺��� ������ �� �� �ִ� desc��ɾ�
desc user_tables;
--����� Ȯ��
show user;
--����ڰ� ��밡���� ���̺��� �̸� Ȯ��
select table_name from user_tables order by table_name desc;

--ALL_������ ��ųʸ� ��
--����Ŭ������ Ÿ������ ��ü�� ��õ������ ���� �Ұ���.
--������ �����ڰ� ������ �ο��ϸ� ������ ����.
--���� ������ ���� ������ ���̺��� ���� ��ȸ�ϴ� ��.
--����
desc all_tables;
select owner, table_name from all_tables;
select * from dual; --DUAL���̺� ������ �����ϵ��� ������ �ο��Ǿ��ִ� ����.

--DBA_������ ��ųʸ� ��
--DBA�ý��� ������ ���� ����ڸ� ������ �� �ִ�.
select table_name,owner from dba_tables; --������ ��� �����߻�.

--10�� ���̺��� ���� �߰�,����,�����ϴ� DML
--1. ���̺� ���ο� �� �߰�.
--���̺��� ������ ����
drop table dept01;
create table dept01 as select * from dept where 1=0;
select * from dept01;
desc dept01;
--�� ���̺� ������ �߰�
insert into dept01(deptno,dname,loc) values(10,'ACCOUNTING','NEW YORK');
insert into dept01(dname,deptno,loc) values('MBC',10,'SEOUL');
insert into dept01 values(30,'SBS','BUSAN');
insert into dept01(deptno,dname) values (40,'KBS');--LOC�� NULLó��
--����
desc sam01;
create table sam01(empno number(4),ename varchar2(10),job varchar2(9),sal number(7,2));
insert into sam01(empno,ename,job,sal) values(1000,'APPLE','POLICE',10000);
insert into sam01 values(1010,'BANANA','NURSE',15000);
insert into sam01 (empno,ename,job,sal) values (1020,'ORANGE','DOCTOR',25000);
select * from sam01;
--NULL�� ���� (NOT NULL�� ǥ��� �÷��� NULL�� ó�� �Ұ���.)
desc sam01;
insert into sam01 values(1030,'VERY','',25000);
insert into sam01 values(1040,'CAT',null,2000);
--���������� ������ ����
drop table dept02;
create table dept02 as select * from dept where 1=0;
insert into dept02 select * from dept;
select * from dept02;
insert into dept02(loc) select dname from dept where deptno =20;
--�÷� �̸��� �߿������ʰ� ������ Ÿ���� �߿��ϴ�.

--����
desc sam01;
select * from sam01;
insert into sam01 select empno,ename,job,sal from emp where deptno=10;

--2.���� ���̺� ���� �� �Է��ϱ�
--INSERT ALL���� ����ϸ� ���� ������ ����� ���Ǿ��� �������̺� ���ÿ� �Է°���.
--����
create table emp_hir as select empno, ename, hiredate from emp where 1=0;
desc emp_hir;
create table emp_mgr as select empno, ename, mgr from emp where 1=0;
desc emp_mgr;

insert all 
into emp_hir values(empno,ename,hiredate)
into emp_mgr values(empno,ename,mgr) 
select empno,ename,hiredate,mgr from emp where deptno=20;

select * from emp_hir;
select * from emp_mgr;

--INSERT ALL��ɹ��� WHEN��(����)�� �߰��ؼ� ���ǿ� �´� �ุ �����Ͽ� �߰�
create table emp_hir02 as select * from emp_hir where 1=0;
create table emp_sal as select empno,ename,sal from emp where 1=0;

insert all
when hiredate>'1982/01/01' then into emp_hir02 values(empno,ename,hiredate)
when sal>2000 then into emp_sal values(empno,ename,sal)
select empno,ename,hiredate,sal from emp;
select * from emp_hir02;
select * from emp_sal;
select * from emp where hiredate>'1982/01/01';
select * from emp where sal>2000;
--����
create table sales(sales_id number(4),week_id number(4),
mon_sales number(8,2),tue_sales number(8,2),wed_sales number(8,2),thu_sales number(8,2),
fri_sales number(8,2));
desc sales;
create table sales_data(sales_id number(4),week_id number(4),daily_id number(4),
sales number(8,2));
insert into sales values (1001,1,200,100,300,400,500);
insert into sales values (1002,2,100,300,200,500,350);

insert all
into sales_data values(sales_id, week_id,1,mon_sales)
into sales_data values(sales_id, week_id,2,tue_sales)
into sales_data values(sales_id, week_id,3,wed_sales)
into sales_data values(sales_id, week_id,4,thu_sales)
into sales_data values(sales_id, week_id,5,fri_sales)
select sales_id,week_id,mon_sales,tue_sales,wed_sales,thu_sales,fri_sales from sales;

--3.���̺��� ������ �����ϱ� ���� UPDATE��
--where ���� ������� ���� ���� ���̺� �ִ� ��� ���� �����ȴ�.
create table emp01 as select * from emp;
select * from emp01;
update emp01 set deptno=20;
select * from emp01;
update emp01 set sal=sal*1.1;
select * from emp01;
update emp01 set hiredate = sysdate;
select * from emp01;
--where���� �߰��Ͽ� ���ǿ� ���� ����
drop table emp01;
create table emp01 as select * from emp;
update emp01 set deptno =30 where deptno =10;
update emp01 set sal = sal*1.1 where sal>= 3000;
update emp01 set hiredate = sysdate where substr(hiredate,1,2) ='87';
select * from emp01;
--����
select * from sam01;
update sam01 set sal = sal-5000 where sal>=10000;
--���̺��� 2���ǻ��� Į�� �� ����
select * from emp01;
update emp01 set deptno = 20,job = 'MANAGER' where ename = 'SCOTT';
update emp01 set hiredate = sysdate,sal=50,comm=4000 where ename='SCOTT';
--���� ������ �̿��� ������ ����
update dept01 set loc=(select loc from dept01 where deptno=40)where deptno = 20;
select * from dept01;
--����
drop table sam02;
create table sam02 as select ename,sal,hiredate,deptno from emp;
desc sam02;
update sam02 set sal = sal+1000 where deptno=(select deptno from dept where loc = 'DALLAS');
select * from sam02;
--���������� �̿��� �ѹ��� 2���� �÷� �� �����ϱ�
update dept01 set (dname,loc) = (select dname,loc from dept where deptno=40) where deptno=20;
select * from dept01;
select * from sam02;
update sam02 set (sal,hiredate) = (select sal,hiredate from emp where ename='KING');

--4.���̺� ���ʿ��� ���� �����ϱ� ���� DELETE��
--Ư�� ���� �����ϱ� ���� WHERE���� �̿��Ͽ� ��������
--WHERE���� ������� ������ ��� ���� ������.
delete from dept01;
delete from dept01 where deptno=30;
select * from dept01;
--����
select * from sam01;
delete from sam01 where job is null;

--���������� �̿��� ������ ����
select * from emp01;
delete from emp01 where deptno = (select deptno from dept where dname='SALES');
select * from sam02;
delete from sam02 where deptno =(select deptno from dept where dname='RESEARCH');

--5.���̺��� �պ��ϴ� MERGE
--MERGE�� �պ��̶� �ǹ��̹Ƿ� ������ ���� �ΰ��� ���̺��� �ϳ��� ��ġ�� ���
--����� �����ϰ� �Ǹ� ������ �����ϴ� ���� �ִٸ� ���ο� ������ ����(UPDATE)�ǰ�,
--�������� ������ ���ο� ������ �߰�(INSERT)�ȴ�.
drop table emp01;
drop table emp02;
select * from emp01;
select * from emp02;
create table emp01 as select * from emp;
create table emp02 as select * from emp where job='MANAGER';
update emp02 set job='TEST';
insert into emp02 values(8000,'SYJ','TOP',7566,'2009/01/12',1200,10,20);

merge into emp01 using emp02 on(emp01.empno=emp02.empno)
when matched then update set
emp01.ename = emp02.ename,emp01.job=emp02.job,emp01.mgr=emp02.mgr,
emp01.hiredate=emp02.hiredate,emp01.sal=emp02.sal,emp01.comm=emp02.comm,emp01.deptno=emp02.deptno
when not matched then insert values
(emp02.empno,emp02.ename,emp02.job,emp02.mgr,emp02.hiredate,emp02.sal,emp02.comm,emp02.deptno);

--11��
--1.Ʈ�����(Transaction)
--�����ͺ��̽����� Ʈ������� ������ó���� �Ѵ���.
--�ϳ��� Ʈ������� ALL-OR-Nothing ������� ó��.
--�ϳ��� ��ɾ�� �߸��Ǹ� ��ü�� ����Ѵ�.
--Ʈ������� ���������� ������ Ŀ�����ĺ��� ���ο� Ŀ�Խ������� ����� ��� DML��ɵ��� �ǹ�
--2.COMMIT/ROLLBACK
--�۾��� ���������� ó���ǵ��� �ϱ� ���ؼ� COMMIT�����,
--�۾��� ����ϱ� ���ؼ��� ROLLBACK������� �����ؾ� �Ѵ�.
--DDL����� ����Ǹ� COMMIT�� �ڵ����� ����ȴ�.
--DML����� COMMIT�� �ڵ�������� �ʴ´�.
--DDL(�ڷ� ���� ���) : Create,Drop,Alter,Grant,Revoke
--DML(�ڷ� ó�� ���) : ����,����,����,����,�Ϸ�,��Ű
--����
commit;
select * from dept01;
delete from dept01;
rollback;

select * from dept01;
delete from dept01 where deptno=20;
commit;
rollback;
--3.Ʈ������� �۰� �����ϴ� SAVEPOINT
--����� SAVEPOINT�� ROLLBACK TO SAVEPOINT ���� ����Ͽ� ǥ���� ������ ROLLBACK�� �� �ִ�.
--����
select * from dept01;
delete from dept01 where deptno=40;
commit;
delete from dept01 where deptno=30;
savepoint c1;
delete from dept01 where deptno=20;
savepoint c2;
delete from dept01 where deptno=10;
rollback to c2;
select * from dept01;
rollback to c1;
select * from dept01;
rollback;
select * from dept01;
