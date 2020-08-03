/*20�� PLSQL����
  3.���ù�
  �⺻ ������ ��� ������� ������ ������� ���������� ����ȴ�.
  IF���� ������ �����ؼ� ���������� ���� ������ ���������� �����ϱ� ������
  ���ù��̶�� �Ѵ�.
  1) IF-THEN-END IF
  IF condition THEN statements;
  END IF;
*/
set serveroutput on;
declare
  vempno number(4);
  vename varchar2(20);
  vdeptno emp.deptno%type;
  vdname varchar2(20) := null;
begin
  select empno,ename,deptno into vempno, vename,vdeptno from emp
  where empno=7788;
  if(vdeptno=10) then vdname :='ACCOUNTING';
  end if;
  if(vdeptno=20) then vdname :='RESARCH';
  end if;
  if(vdeptno=30) then vdname :='SALES';
  end if;
  if(vdeptno=40) then vdname :='OPERATIONS';
  end if;
  
  dbms_output.put_line('���   �̸�   �μ���');
  dbms_output.put_line(vempno||'  '||Vename||'  '||vdname);
end;
/

--�������(�޿�*12+Ŀ�̼�)
set serveroutput on;
declare
--%ROWTYPE�Ӽ����� �ο� ��ü�� ������ �� �ִ� ���۷��� ���� ����
  vemp emp%rowtype;
  annsal number(7,2);
begin
  dbms_output.put_line('���/�̸�/����');
  dbms_output.put_line('----------------');
  --SCOTT����� ��ü ������ �ο� ������ ���� VEMP�� �����Ѵ�.
  select * into vemp from emp where ename='SCOTT';
  --Ŀ�̼��� NULL�� ��� 0���� �����ؾ� �ùٸ� ���� ���
  if (vemp.comm is null) then vemp.comm :=0;
  end if;
  
  --��Į�� ������ ������ ����� ����� �����Ѵ�.
  annsal := vemp.sal*12+vemp.comm;
  --��� ���
  dbms_output.put_line(vemp.empno||'/'||vemp.ename||'/'||annsal);
end;
/

--2)IF~THEN~ELSE~END IF
set serveroutput on;
declare
  vemp emp%rowtype;
  annsal number(7,2);
begin
  select * into vemp from emp where ename='SCOTT';
  if(vemp.comm is null) then --Ŀ�̼��� NULL�̸�
      annsal:=vemp.sal*12;    --�޿�*12�� ���
    else              --Ŀ�̼��� NULL�� �ƴϸ�
      annsal:=vemp.sal*12+vemp.comm; --�޿�*12+COMM���
    end if;
  dbms_output.put_line('���/�̸�/����');
  dbms_output.put_line('----------------');  
  dbms_output.put_line(vemp.empno||'/'||vemp.ename||'/'||annsal);
end;
/

--3)IF~THEN~ELSIF~ELSE~END IF
set serveroutput on;
declare
  vemp emp%rowtype;
  vdname varchar2(14);
begin
  dbms_output.put_line('���/�̸�/�μ���');
  dbms_output.put_line('-----------------');
  
  select * into vemp from emp where ename='SCOTT';
  if(vemp.deptno=10) then
    vdname:='ACCOUNTING';
  elsif(vemp.deptno=20) then
    vdname:='RESARCH';
  elsif(vemp.deptno=30) then
    vdname:='SALES';
  else
    vdname:='OPERATIONS';
  end if;
  
  dbms_output.put_line(vemp.empno||'/'||vemp.ename||'/'||vdname);
end;
/

--4.�ݺ���
--1)BASIC LOOP��
--�⺻LOOP�� LOOP�� ���� ��� �ѹ��� ������ ����ȴ�.
--END LOOP�� ������ �׿� ¦�� �̷�� LOOP�� �ǵ��� ����.
--������ ������������ EXIT;�� ������ �ȴ�.
set serveroutput on;
declare
  n number:=1;
begin
  loop
    dbms_output.put_line(n);
    n:=n+1;
--  exit when n>5; �� �Ʒ� IF���� �����ϰ� �۵��Ѵ�.
    if n>5 then
      exit;
    end if;
  end loop;
end;
/

set serveroutput on;
declare
  n number:=0;
  tot number:=0;
begin
  loop
    n:=n+1;
    tot:=tot + n;
    exit when n >=10;
  end loop;
  dbms_output.put_line('1���� 10���� ��: '||tot);
end;
/
--5�� ����ϱ�
set serveroutput on;
declare
  dan number :=5;
  i number :=0;
begin
  loop
    i:=i+1;
    dbms_output.put_line(dan ||'*'|| i ||'='||dan*i);
    exit when i=9;
  end loop;
end;
/

--2)FOR LOOP��
--�ݺ��Ǵ� Ƚ���� ������ �ݺ����� ó���ϱ⿡ �����ϴ�.
--����ġ�� �ڵ� 1�̵ȴ�. 1�� ����.(������ ���)
--lower_bound : �ϴ� �ٿ�� ��
--upper_bound : ��� �ٿ�� ��
set serveroutput on;
declare
begin
  for n in 1..5 loop
    dbms_output.put_line(n);
  end loop;
end;
/
--REVERSE
declare
begin
  for n in reverse 1..5 loop
    dbms_output.put_line(n);
  end loop;
end;
/

set serveroutput on;
declare
  vdept dept%rowtype;
begin
  dbms_output.put_line('�μ���ȣ/�μ���/������');
  dbms_output.put_line('----------------------');
  --����CNT�� 1���� 1�������ϴٰ� 4�� �����ϸ� �ݺ������� �����.
  for cnt in 1..4 loop
    select * into vdept from dept where deptno=10*cnt;
    dbms_output.put_line(vdept.deptno||'/'||vdept.dname||'/'||vdept.loc);
  end loop;
end;
/

--3)WHILE LOOP��
--���̸� LOOP�� ���� �����̸� LOOP���� �������´�.
set serveroutput on;
declare
  n number :=1;
begin
  while n<=5 loop
    dbms_output.put_line(n);
    n:=n+1;
  end loop;
end;
/

set serveroutput on;
declare
  v_cnt number:=1;
  v_str varchar2(10) := null;
begin
  while v_cnt<=5 loop
    v_str:=v_str||'*';
    dbms_output.put_line(v_str);
    v_cnt:=v_cnt+1;
  end loop;
end;
/

/*21�� ���� ���ν���,�Լ�,Ŀ��
  1.���� ���ν���
  ����ڰ� ���� PLSQL���� �����ͺ��̽��� ����.
  �����ϰ� ȣ�⸸�ؼ� ����� �� �ִ�.
  ���ɵ� ���ǰ� ȣȯ�� ������ �ذ�ȴ�.
  ���� : DROP PROCEDURE ���ν����̸�
  OR REPLACE�ɼ� : �����ϰ� ���Ӱ� ����
  [MODE]
  IN : �����͸� ���� ������
  OUT : ����� ����� �޾ư� ��
  INOUT : �ΰ��� ������ ��� ���
*/
--���� ���ν��� �����ϱ�
drop table emp01;
create table emp01 as select * from emp;
create or replace procedure del_all
is
begin
  delete from emp01;
end;
/
--EXECUTE ��ɾ�� ����
execute del_all;
select * from emp01;

--1)���� ���ν����� ���� ���� ���Ǳ�
--������ �߻��� ��� "SHOW ERROR"��ɾ �����Ͽ� Ȯ���� �� �ִ�.

--2.���� ���ν��� ��ȸ�ϱ�
desc user_source; --user (SCOTT)�� ���� ��.
select * from user_source;

--3.���� ���ν����� �Ű� ����
create or replace procedure
del_ename(vename emp01.ename%type)
is
begin
delete from emp01 where ename=vename;
end;
/

execute del_ename('SMITH');
select * from emp01;

--4.IN,OUT,INOUT �Ű� ����
--1)IN�Ű�����
--���ν��� ȣ��� �Ѱ��� ���� �޾ƿö� ���. ��������

--2)OUT�Ű�����
--���ν����� ���� ��� ���� ���� ���ؼ� ���
create or replace procedure sel_empno
(vempno in emp.empno%type,
 vename out emp.ename%type,
 vsal out emp.sal%type,
 vjob out emp.job%type
)
is
begin
  select ename,sal,job into vename,vsal,vjob from emp
  where empno=vempno;
end;
/
--VAR �Ǵ� VARIABLE�� ���� ���ε庯���� ����.
variable var_ename varchar2(15);
variable var_sal number;
var var_job varchar2(9);
--7788 => IN�� ���, :���ε庯�� => OUT�� ���
execute sel_empno(7788, :var_ename, :var_sal, :var_job);
print var_ename;
set autoprint on;  --�⺻���� OFF�� �����Ǿ�����.
--ON���� �����س��� ������ execute���� ���ุ�ǰ� ��µ����ʴ´�.

--���� ������ �μ��� ���޹޾� ���������� ū������ ������ ���.
--execute gugudan_proc(8, 5)
set serveroutput on;
create or replace procedure gugudan_proc
( num number,
  num2 number)
is
begin
  if(num>num2) then
    for k in num2..num loop
      dbms_output.put_line('***'||k||'��***');
      for i in 1..9 loop
        dbms_output.put_line(k||'*'||i||'='||k*i);
      end loop;
    end loop;
  elsif(num2>num) then
    for k in num..num2 loop
      dbms_output.put_line('***'||k||'��***');
      for i in 1..9 loop
        dbms_output.put_line(k||'*'||i||'='||k*i);
      end loop;
    end loop;
  end if;
end;
/

execute gugudan_proc(7,4);

--����) �μ� ��ȣ�� �Է¹޾� �ش� �μ��� �����ȣ�� ����̸�,�޿�,�Ի��� �μ��̸��� ���
--detpno_proc(10) or deptno_proc(20)
create or replace procedure deptno_proc
(vdeptno in emp.deptno%type)
is
begin
  dbms_output.put_line('�����ȣ / ����̸� / �޿� / �Ի��� / �μ���');
  for emp_record in(select empno,ename,sal,hiredate,dname
      from emp,dept where vdeptno=emp.deptno and emp.deptno=dept.deptno) loop
         dbms_output.put_line(emp_record.empno
            ||' '||emp_record.ename
            ||' '||emp_record.sal
            ||' '||emp_record.hiredate
            ||' '||emp_record.dname);
   end loop;
end;
/

set autoprint on;
execute deptno_proc(10);

--����)�μ� ��ȣ�� �Է¹޾� �ش� �μ��� �ο����� ��ȯ�Ͻÿ�.
--ex) deptno_count_proc(10,���ε� ����)
create or replace procedure deptno_count_proc
( vdeptno in emp.deptno%type,
  vcount out number)
is
begin
  select count(*) into vcount from emp
  where vdeptno=deptno;
end;
/
variable var_cnt number;
execute deptno_count_proc(30,:var_cnt);

--5.���� �Լ� ����
--�Լ��� ���� ����� �ǵ��� ���� �� �ִ�.
--����� �ǵ��� �ޱ� ���ؼ� �Լ��� �ǵ��� �ް� �Ǵ� �ڷ����� 
--�ǵ��� ���� ���� ����ؾ� �Ѵ�.
create or replace function cal_bonus
( vempno in emp.empno%type)
  return number
is
  vsal number(7,2);
begin
  select sal into vsal from emp where vempno=empno;
  return(vsal * 200);
end;
/
variable var_res number;
execute :var_res := cal_bonus(7788);

--����) �μ���ȣ�� �Է¹޾� �ش� �μ��� �ο����� ��ȯ�Ͻÿ�.
--ex)deptno_count_func(10)
create or replace function deptno_count_func
  ( vdeptno in emp.deptno%type)
  return number
is
  vcnt number;
begin
  select count(*) into vcnt from emp where vdeptno=deptno;
  return vcnt;
end;
/
var var_cnt number;
execute :var_cnt:=deptno_count_func(30);

--����)�����ȣ�� �Է¹޾� �ش� ����� Ŀ�̼��� �����ϴ� ������ ��ȯ�Ͻÿ�
--ex) SAL12_func(7788)
create or replace function SAL12_func
  ( vempno emp.empno%type)
  return number
is
  vsal number;
begin
  select (sal*12+nvl(comm,0)) into vsal from emp where empno=vempno;
  return vsal;
end;
/
variable var_sal number;
execute :var_sal:=SAL12_func(7788);
 
select * from emp;

--����) �̸�/�Ի�����/�μ��ڵ带 �μ��ڵ� ��������,�Ի����� ������������ ��ȸ�Ͻÿ�.
create or replace procedure emp_proc
is
begin
  dbms_output.put_line('����̸� / �Ի��� / �μ���ȣ');
  for k in(select ename,hiredate,deptno 
           from emp order by deptno,hiredate) loop
    dbms_output.put_line(k.ename 
            ||' / '|| k.hiredate ||' / '|| k.deptno);
  end loop;
end;
/

execute emp_proc;

