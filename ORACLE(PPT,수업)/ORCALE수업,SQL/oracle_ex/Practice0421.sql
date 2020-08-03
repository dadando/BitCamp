--18�� �����ͺ��̽� �� ���� ����
--1.���̶�(role)
--����ڿ��� ȿ�������� ������ �ο��� �� �ֵ��� ���� ������ ���� ���� ��
--����� ������ �����ϰ� ȿ�������� �� �� �ִ�.

--2.���� ����
--�������ǵ� ��/����ڰ� ������ ��
--1)���� ���ǵ� ��
--(1)CONNECT��
--ALTER SESSION/CREATE CLUSTER/CREATE DATABASE LINK/CREATE SEQUENCE/CREATE SESSION
--CREATE SYNONYM/CREATE TABLE/CREATE VIEW
--(2)RESOURCE��
--CREATE CLUSTER/CREATE PROCEDURE/CREATE SEQUENCE/CREATE TABLE/CREATE TRIGGER
--(3)DBA��
--�ý��۰����� �ʿ��� ��� ������ ������.
create user user04 identified by tiger;
grant connect,resource to user04;
conn user04/tiger

--2)�� ���� ������ ��ųʸ�
select * from dict where table_name like '%ROLE%';
--ORLE_SYS_PRIVS : �ѿ� �ο��� �ý��� ���� ����
--ROLE_TAB_PRIVS : �ѿ� �ο��� ���̺� ���� ���� ����
--USER_ROLE_PRIVS : ���� ������ �� ����
--USER_TAB_PRIVS_MADE : ����� ������ ������Ʈ ���� ����
--USER_TAB_PRIVS_RECD : ����ڿ��� �ο��� ������Ʈ ���� ����
--USER_COL_PRIVS_MADE : ����� ������ Į���� �ο��� ������Ʈ ���� ����
--USER_COL_PRIVS_RECD : ����ڿ��� �ο��� Ư�� Į���� ���� ������Ʈ ���� ����
select * from user_role_privs;
create user kbs identified by pass;
grant connect,resource to kbs;
select * from user_role_privs;

--3.����� �� ����
--CREATE ROLE��ɾ� ����ؼ� ���� �����Ѵ�.
--���� ������ �� �ѿ��� ������ �ο��Ѵ�.
--���� ������ ���� �����ڿ��� �����ؾ��Ѵ�.
create role mrole; --SYSTEM
--�ý��� ������ �ο��Ҷ����� �����ڿ��� �ο��ؾ��Ѵ�.
grant create session,create table,create view to mrole; --SYSTEM
--����ڿ��� ���� �ο��Ѵ�.
grant mrole to user05;
--��ü ������ ��ü���� �ο��ؾ��Ѵ�.
grant select on emp to mrole02; --SCOTT
--������ ���� ����ڿ��� �ο��Ҷ����� �ٽ� �����ڿ���
grant mrole02 to user05;
--emp��ȸ
select * from scott.emp; --emp�տ� �����ڸ� �� �ٿ��� �Ѵ�.
select * from user_role_privs; --MROLE,MROLE02�� Ȯ���� �� �ִ�.

--4.�� ȸ���ϱ�
--�����ڿ��� �����ؾ� �Ѵ�.
revoke mrole from user05; --user05���Լ� mrole ȸ��.
drop role morle02; --�� ����.
select * from user_role_privs; --mrole�� ����, mrole02�� ������.

--5.���� ����
--�ѿ� ������ �ο������μ� �۾��� ����ȭ�� �� �ִ�.
create role def_role; --�� ����
grant create session,create table to def_role; --�ѿ��� �ý��� ���� �ο� (SYSTEM)
grant update,delete,select on emp to def_role; --�ѿ��� ��ü ���� �ο� (SCOTT)
create user usera1 identified by a1234;
create user usera2 identified by a1234;
create user usera3 identified by a1234; --����� 3�� ���� (SYSTEM)
grant def_role to usera1;
grant def_role to usera2;
grant def_role to usera3; --����ڵ鿡�� �� �ο�(SYSTEM)
select * from role_sys_privs where role='DEF_ROLE'; --�ý��� ���ѿ� ���� ����
select * from role_tab_privs where role='DEF_ROLE'; --��ü ���ѿ� ���� ����

select * from user_role_privs;
select * from user_tab_privs_made; --SCOTT�� �ο��� ���� (��Ұ���)
revoke update,delete on emp from def_role; --def_role�� �ο��� update,delete���� ȸ��

revoke create table from def_role; --create table���� ȸ��(SYSTEM)

--20�� PLSQL����
--1.PL/SQL����
--SQL�� ���� ����� �����ȴ�.
--���� ����/�� ó��/�ݺ� ó��
--DECLARE~BEGIN~EXCEPTION~END ������ ���´�.
--�����(DECLARE SECTION) : ��� ������ ����� �����ϴ� �κ�
--�����(EXECUTABLE) : ������ �������� ������ ����� �� �ִ� �κ�.BEGIN���� �����Ѵ�.
--���� ó��(EXCEPTION) : EXCEPTION���� ����.
set serveroutput on; --ȭ����� ȯ�溯�� on���� ��ȯ (����Ʈ�� OFF)
begin --����
dbms_output.put_line('Hello World!'); --��Ű��_���ν���.�Լ�
end; --��
/ --Ŀ���� �����ÿ� ���� �����ؾ� �ȴ�.

--2.��������� ���Թ�
--������ ���� �ڷ����� ���(�ڹٿ� �ݴ�)
--identifier : ������
--CONSTANT : final�� ���� �ǹ�
--datatype : �ڷ����� ���
--NOT NULL : ���� �ݵ�� �����ϵ��� ������ �����Ѵ�.
--Expression : ǥ����

declare
vempno number(4);
vename varchar2(10);
begin
vempno := 7788;
vename := 'SCOTT';
dbms_output.put_line('���/�̸�');
dbms_output.put_line('----------');
dbms_output.put_line(vempno || ' / ' || vename);
end;
/

--2)��Į�� ����/���۷��� ����
--��Į�� : ���� = NUMBER, ���� = VARCHAR2
--���۷��� : ���̺� ����Ǿ��ִ� �÷��� ���. 
--%TYPE�� ����ؼ� �ش��÷��� �ڷ���,ũ�⸦ �����ؼ� ���
--���� : ���۷��� ���� ������ ������ �ʿ䰡 ���� ������ �ִ�.
--%ROWTYPE : �� ������ ����.�÷���� ������Ÿ�԰� LENGTH�� �״�� ������ �� �ִ�.
--���� : ���̺��� �÷��� ������ ������������ �𸣴��� ������ �� �ִ�.

--3)PLSQL���� SELECT��
--�����ͺ��̽����� ������ ������ �ʿ䰡 ������ �Ǵ� ����� ������ ������ �ʿ䰡 ������
--���ǵ� ���� ������ �Ҵ��Ű�� ���ؼ� SELECT���� ����Ѵ�.
--INTO���� �Բ� ����Ѵ�.
--�����ʹ� ������ 1���� �ٷ� �� �ִ�.(������ ���)
select empno,ename into vempno,vename from emp where ename='SCOTT';

set serveroutput on;
declare --%TYPE �Ӽ����� �÷� ���� ���۷��� ���� ����
vempno emp.empno%type;
vename emp.ename%type;
begin
dbms_output.put_line('��� / �̸�');
dbms_output.put_line('------------');
select empno,ename into vempno,vename from emp where ename='SCOTT';
dbms_output.put_line(vempno || '/' || vename); --���۷��� ������ ����� ���� ����Ѵ�.
end;
/

--4)PLSQL���̺�
--�ο쿡 ���� �迭ó�� �׼����ϱ� ���� �⺻Ű�� ����Ѵ�.
--�迭�� �����ϰ� BINARY_INTEGER(������)���������� 
--�⺻Ű�� ��Ҹ� �����ϴ� ��Į��Ǵ� ���ڵ��÷��� �����ؾ� �Ѵ�.
--���� �̵��� �������� �����Ӱ� ������ �� �ִ�.
set serveroutput on;
declare --���̺� Ÿ���� ����
type ename_table_type is table of emp.ename%type index by binary_integer;
type job_table_type is table of emp.job%type index by binary_integer;
ename_table ename_table_type; --���̺� Ÿ������ ���� ����
job_table job_table_type;
i binary_integer := 0;

begin --EMP ���̺��� ����̸��� ������ ����
for K in(select ename,job from emp) loop 
--�ఴü�� K��ü�� ����ȴ�.(��,���⼭�� 2��(ename,job�÷��� ����)
i := i+1; --�ε��� ����
ename_table(i) := K.ename; --����̸���
job_table(i) := K.job;  --������ ����
end loop;
for J in 1..i loop --���̺� ����� ������ ���
dbms_output.put_line(rpad(ename_table(J),12)||' / '||rpad(job_table(J),9));
--12�ڸ��� ������ Ȯ���ؼ� ���������, 9�ڸ� ���� Ȯ���ؼ� ������ ��� (������ ������)
end loop;
end;
/

--%ROWTYPE����
SET SERVEROUTPUT ON;
DESC EMP;
DECLARE
--���̺� Ÿ���� ����
TYPE EMP_TABLE_TYPE IS TABLE OF EMP%ROWTYPE INDEX BY BINARY_INTEGER;
EMP_TABLE EMP_TABLE_TYPE;
--���̺� Ÿ������ ���� ����
I BINARY_INTEGER := 0;

BEGIN
--EMP ���̺��� ����̸��� ������ ����
FOR K IN(SELECT * FROM EMP)LOOP
I := I+1;
EMP_TABLE(I).EMPNO := K.EMPNO;
EMP_TABLE(I).ENAME := K.ENAME;
EMP_TABLE(I).JOB := K.JOB;
EMP_TABLE(I).MGR := K.MGR;
EMP_TABLE(I).HIREDATE := K.HIREDATE;
EMP_TABLE(I).SAL := K.SAL;
EMP_TABLE(I).COMM := K.COMM;
EMP_TABLE(I).DEPTNO := K.DEPTNO;
END LOOP;

--���̺� ����� ������ ���
FOR J IN 1..I LOOP
DBMS_OUTPUT.PUT_LINE(LPAD(EMP_TABLE(J).EMPNO,6)
||' / '|| LPAD(EMP_TABLE(J).ENAME,8)
||' / '|| LPAD(EMP_TABLE(J).JOB,10)
||' / '|| LPAD(EMP_TABLE(J).MGR,6)
||' / '|| LPAD(EMP_TABLE(J).HIREDATE,10)
||' / '|| LPAD(EMP_TABLE(J).SAL,6)
||' / '|| LPAD(EMP_TABLE(J).COMM,6)
||' / '|| LPAD(EMP_TABLE(J).DEPTNO,4));
END LOOP;
END;
/

--����
set serveroutput on;
select * from dept;

declare
type deptno_table_type is table of dept.deptno%type index by binary_integer;
type dname_table_type is table of dept.dname%type index by binary_integer;
deptno_table deptno_table_type;
dname_table dname_table_type;

i binary_integer := 0;

begin
for k in(select deptno,dname from dept) loop
i:=i+1;
deptno_table(i) := k.deptno;
dname_table(i) := k.dname;
end loop;

for j in 1..i loop
dbms_output.put_line(rpad(deptno_table(j),4) || ' / ' || rpad(dname_table(j),10));
end loop;
end;
/

--������ �Է� for���� ��� for�� ��ħ.
declare
type deptno_table_type is table of dept.deptno%type index by binary_integer;
type dname_table_type is table of dept.dname%type index by binary_integer;
deptno_table deptno_table_type;
dname_table dname_table_type;

i binary_integer := 0;

begin
for k in(select deptno,dname from dept) loop
i:=i+1;
deptno_table(i) := k.deptno;
dname_table(i) := k.dname;
dbms_output.put_line(rpad(deptno_table(i),4) || ' / ' || rpad(dname_table(i),10));
end loop;
end;
/

--����2--
declare
    type empno_table_type is table of emp.empno%type index by binary_integer;
    type ename_table_type is table of emp.ename%type index by binary_integer;
    type hiredate_table_type is table of emp.hiredate%type index by binary_integer;
    type sal_table_type is table of emp.sal%type index by binary_integer;
    type deptno_table_type is table of emp.deptno%type index by binary_integer;
    type dname_table_type is table of dept.dname%type index by binary_integer;

    empno_table empno_table_type;
    ename_table ename_table_type;
    hiredate_table hiredate_table_type;
    sal_table sal_table_type;
    deptno_table deptno_table_type;
    dname_table dname_table_type;

    i binary_integer :=0;

begin
    for k in(select empno,ename,hiredate,sal,emp.deptno,dname 
            from emp,dept where emp.deptno = dept.deptno order by dname) loop
      i := i+1;
      empno_table(i) := k.empno;
      ename_table(i) := k.ename;
      hiredate_table(i) := k.hiredate;
      sal_table(i) := k.sal;
      deptno_table(i) := k.deptno;
      dname_table(i) := k.dname;
    end loop;

    dbms_output.put_line('�����ȣ / ����̸� / �Ի�⵵    / �޿�    / �μ���ȣ / �μ���');
    for j in 1..i loop
      dbms_output.put_line(rpad(empno_table(j),6) 
      || ' / ' || rpad(ename_table(j),8)
      || ' / ' || rpad(hiredate_table(j),10) 
      || ' / ' || rpad(sal_table(j),6)
      || ' / ' || rpad(deptno_table(j),7) 
      || ' / ' || rpad(dname_table(j),10)
      );
    end loop;
end;
/

--����
declare
  begin
    dbms_output.put_line('�μ��� / ��ձ޿�');
    for k in(select deptno,round(avg(sal),2) as sal_Avg 
    from emp group by deptno order by deptno) loop
    dbms_output.put_line(rpad(k.deptno,4) || '    '||rpad(k.sal_Avg,8));
  end loop;
end;
/

--5)PLSQL RECORD TYPE
--���̺��� ROW�� �о�� �� ����.
set serveroutput on
declare
  --���ڵ� Ÿ���� ����
  type emp_record_type is record(
    v_empno emp.empno%type,v_ename emp.ename%type,
    v_job emp.job%type,v_deptno emp.deptno%type);
  --���ڵ�� ���� ����
  emp_record emp_record_type;
begin
  --SCOTT ����� ������ ���ڵ� ������ ����
  select empno,ename,job,deptno into emp_record from emp where ename = UPPER('SCOTT');
  --���ڵ� ������ ����� ��� ������ ���
  dbms_output.put_line('�����ȣ : ' || to_char(emp_record.v_empno));
  dbms_output.put_line('��    �� : ' || emp_record.v_ename);
  dbms_output.put_line('������ : ' || emp_record.v_job);
  dbms_output.put_line('�μ���ȣ : ' || to_char(emp_record.v_deptno));
end;
/
--����
declare
  type emp_record_type is record(
    v_empno emp.empno%type,
    v_ename emp.ename%type,v_job emp.job%type,
    v_sal emp.sal%type,v_deptno emp.deptno%type,
    v_dname dept.dname%type);
    
  emp_record emp_record_type;
begin
  select empno,ename,job,sal,emp.deptno,dname into emp_record
  from emp,dept where emp.deptno = dept.deptno and ename = 'SCOTT';
  dbms_output.put_line('�����ȣ: ' || to_char(emp_record.v_empno));
  dbms_output.put_line('��   ��: ' || emp_record.v_ename);
  dbms_output.put_line('������: ' || emp_record.v_job);
  dbms_output.put_line('��   ��: ' || to_char(emp_record.v_sal));
  dbms_output.put_line('�μ���ȣ: ' || to_char(emp_record.v_deptno));
  dbms_output.put_line('�� �� ��: ' || emp_record.v_dname);
end;
/
  


