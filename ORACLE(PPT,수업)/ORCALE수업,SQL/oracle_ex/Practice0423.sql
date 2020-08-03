--21��
--6.Ŀ��
--��ȯ�Ǵ� ���� ������ �������� �� ���.
--FETCH CURSOR
--���������� �������� %NOTFOUND �� ����Ѵ�.
set serveroutput on;
set autoprint on;

create or replace procedure cursor_sample01
is
  vdept dept%rowtype;
  cursor c1
  is
  select * from dept;
begin
  dbms_output.put_line('�μ���ȣ / �μ��� / ������');
  dbms_output.put_line('--------------------------');
  
  open c1;
  loop
    fetch c1 into vdept.deptno,vdept.dname,vdept.loc;
    exit when c1%notfound;
    dbms_output.put_line(vdept.deptno||' / '
                       || vdept.dname ||' / '
                       || vdept.loc);
  end loop;
  close c1;
end;
/
execute cursor_sample01; 

--1)CURSOR�� FOR LOOP
--���ۿ����� FOR LOOP�� �����ϴ� ���� �ڵ� CURSOR�� �����Ǵ� �����̴�.
create or replace procedure cursor_sample02
is
  vdept dept%rowtype;
  cursor c1
  is
  select * from dept;
begin
  dbms_output.put_line('�μ���ȣ / �μ��� / ������');
  dbms_output.put_line('---------------------------');
  for vdept in c1 loop
    exit when c1%notfound;
--for vdept in(select * from dept) loop
    dbms_output.put_line(vdept.deptno||' / '||
                    vdept.dname||' / '||
                    vdept.loc);
  end loop;
end;
/
execute cursor_sample02;

--����)�μ� ��ȣ�� �Է¹޾� �ش� �μ��� �����ȣ�� ����̸�,�޿�,�Ի���,�μ��̸��� ����Ͻÿ�
--ex) deptno_cursor1(10)
create or replace procedure deptno_cursor1(vdeptno emp.deptno%type)
is
  vemp emp%rowtype;
  vdept dept%rowtype;
  cursor c1
  is
  select empno,ename,sal,hiredate,dname from emp,dept 
  where emp.deptno=dept.deptno and vdeptno=emp.deptno;
begin
  dbms_output.put_line('�����ȣ / ����̸� / �޿� / �Ի��� / �μ��̸�');
  dbms_output.put_line('--------------------------------------------');
  open c1;
  loop
    fetch c1 into vemp.empno,vemp.ename,vemp.sal,vemp.hiredate,vdept.dname;
    exit when c1%notfound;
    dbms_output.put_line(vemp.empno
        ||' / '||vemp.ename
        ||' / '||vemp.sal
        ||' / '||vemp.hiredate
        ||' / '||vdept.dname
        );
  end loop;
  close c1;
end;
/
execute deptno_cursor2(30);
--FOR�� ���
create or replace procedure deptno_cursor2(vdeptno emp.deptno%type)
is
  cursor c1
  is
  select empno,ename,sal,hiredate,dname from emp,dept 
  where emp.deptno=dept.deptno and vdeptno=emp.deptno;
begin
  dbms_output.put_line('�����ȣ / ����̸� / �޿� / �Ի��� / �μ��̸�');
  dbms_output.put_line('--------------------------------------------');
  for table_record in c1 loop
    dbms_output.put_line(table_record.empno
        ||' / '||table_record.ename
        ||' / '||table_record.sal
        ||' / '||table_record.hiredate
        ||' / '||table_record.dname
        );
  end loop;
end;
/

execute deptno_cursor2(30);

--����)�μ�����,�������� �׷��� ��� �μ���ȣ,����,�ο���,�޿��� ���,�հ�
--��½� �μ���ȣ��,���������� ����Ͻÿ�.
create or replace procedure deptno_cursor3
is
  type emp_record_type is record(
    vdeptno emp.deptno%type,
    vjob emp.job%type,
    vcnt number,
    vavg number(7,2),
    vsum number);
  emp_record emp_record_type;
  cursor c1
  is
  select deptno,job,count(*),round(avg(sal),2),sum(sal) 
  from emp group by deptno,job order by deptno,job;
begin
  dbms_output.put_line('�μ���ȣ / ���� / �ο��� / �޿���� / �޿��հ�');
  dbms_output.put_line('--------------------------------------------');
  open c1;
  loop
    fetch c1 into emp_record;
    exit when c1%notfound;
    dbms_output.put_line(emp_record.vdeptno
            ||' / '||emp_record.vjob
            ||' / '||emp_record.vcnt
            ||' / '||emp_record.vavg
            ||' / '||emp_record.vsum);
  end loop;
  close c1;
end;
/

execute deptno_cursor3;
--FOR�� ���
create or replace procedure deptno_cursor4
is
  cursor c1
  is
  select deptno as vdeptno,job as vjob,count(*) as vcnt,round(avg(sal),2) as vavg,
  sum(sal) as vsum from emp group by deptno,job order by deptno,job;
begin
  dbms_output.put_line('�μ���ȣ / ���� / �ο��� / �޿���� / �޿��հ�');
  dbms_output.put_line('--------------------------------------------');
  for emp_record in c1 loop
    dbms_output.put_line(emp_record.vdeptno
            ||' / '||emp_record.vjob
            ||' / '||emp_record.vcnt
            ||' / '||emp_record.vavg
            ||' / '||emp_record.vsum);
  end loop;
end;
/
execute deptno_cursor4;

/* ���� ó���� : ���� �߻��� ��� ó���� �������� ����ó�� ������ ����.
����)
Exception
    when ���ܸ�1 then
        ���๮1
    when ���ܸ�2 then
        ���๮2
          :
    when others then
        ���๮n
--------------------------------    
��� �̸��� �Է¹޾� �ش� ����� ���õ� �޽��� ���.
������ ����ó���� �޽��� ���
*/
create or replace procedure exception_ex01
(irum varchar2)
is
  v_ename emp.ename%type;
begin
  select ename into v_ename
  from emp where ename like irum;
  
  dbms_output.put_line('�������'||v_ename||'�Դϴ�');
exception
  when no_data_found then
    dbms_output.put_line('�ش� ����� �����ϴ�.');
  when too_many_rows then
    dbms_output.put_line('�ش� ����� �� �� �̻��Դϴ�.');
end;
/

execute exception_ex01('F%');

select ename from emp where ename like 'Q%';

create or replace procedure exception_ex02
(dno dept.deptno%type)
is
  --����� ���� ����
  emp_exist exception;
  --�����Ϸ��� ����Ǳ� ���� ó���ϴ� ��ó���� ������ ����
  --PRAGMA EXCEPTION_INIT(���ܸ�,���ܹ�ȣ)
  --����� ���� ���� ó���� �� �� ���
  --Ư�� ���ܹ�ȣ�� ����ؼ� �����Ϸ��� �� ���ܸ� ����Ѵٴ� ���� �˸��� ����.
  pragma exception_init(emp_exist,-2292);
begin
  delete from dept where deptno=dno;
  commit;
exception
  when emp_exist then
    dbms_output.put_line('�ش� �μ��� ����� �����ϹǷ� ������ �� �����ϴ�.');
end;
/

execute exception_ex02(10);

/*
empno�� �Է� ���� �� emp���̺��� �ش� ����� ����� �۾��� ����
��, ���� �����ȣ�� �Է��� ��� '��ȸ�� �����ȣ�� �����ϴ�'��� ���� �޽��� ���
*/
drop table emp01;
create table emp01 as select * from emp;

create or replace procedure exception_ex03(vempno number)
is
  no_empno exception;
begin
  delete from emp01 where empno=vempno;
  --SQL%NOTFOUND : ��� ������ ��ġ �ο� ���� 0�̸� TRUE,
  --               �ƴϸ� FALSE�� ��ȯ
  --SQL%FOUND : ��� ������ ��ġ �ο� ���� 1�� �̻��̸� TRUE,
  --            �ƴϸ� FLASE�� ��ȯ
  --SQL%ROWCOUNT : ������� ��� ������ �ο� �� ��ȯ,������ 0�� ��ȯ
  if sql%notfound then
    raise no_empno;
  end if;
  dbms_output.put_line('�����ȣ'||vempno||'��� ���� ����');
exception
  when no_empno then
    dbms_output.put_line('��ȸ�� �����ȣ�� �����ϴ�.');
end;
/

execute exception_ex03(7788);

/*
RAISE_APPLICATION_ERROR ���ν����� ����Ͽ� ����ڰ� Ư�� ��Ȳ�� �߻��� ������
�����ϰ� ���� ó���θ� ������� �ʰ� ����ο��� ��� ����ó�� �ϴ� ���.
����ڰ� ���Ƿ� ���� ������ ������ȣ�� -20000~-20999�� ���� ��밡��
-------------------------------------------------------------------------
empno�� �Է� ���� �� emp���̺��� �ش� ����� ����� �۾��� ����.
��, ���� �����ȣ�� �Է��� ��� '�������� �ʴ� �����ȣ'��� ���� �޽��� ���
*/
create or replace procedure exception_ex04
(vempno number)
is
begin
  delete from emp01 where empno=vempno;
  if sql%notfound then
    raise_application_error(-20001,'�������� �ʴ� �����ȣ');
    end if;
    dbms_output.put_line('�����ȣ'||vempno||'��� ���� ����');
end;
/

execute exception_ex04(7788);
select * from emp01;
rollback;

/*
� ������ �߻��ߴ��� Ȯ���ϱ� ���� SQLCODE�� SQLERRM�� ���
------------------------------------------------------------
����ڷκ��� empno�� �Է¹޾Ƽ� �ش� empno�� ename�� ȭ�鿡 ����ϴ� �ڵ�.
��,����ڰ� ���� empno�� �Է��� ��� �߻��ϴ� Error code�� Error������
������ ���� SQLCODE�� SQLERRM�� ���
*/
create or replace procedure exception_ex05
(vempno number)
is
  v_ename emp.ename%type;
  v_code number;
  v_errm varchar2(100);
begin
  select ename into v_ename 
  from emp01
  where empno=vempno;
  dbms_output.put_line('�����ȣ'||vempno||'�� �̸���'||v_ename||'�Դϴ�.');
exception
  --������ܿ��� ������ �ʴ� ��Ÿ ���ܸ� ���ϸ� ���� �������� ����ǰ� when���� ����Ѵ�.
  when others then
    v_code:=sqlcode;
    v_errm:=substr(sqlerrm,1,100);
    dbms_output.put_line('�����ڵ�(Error Code) : '||v_code||'-'||v_errm);
end;
/

execute exception_ex05(7788);

--22�� ��Ű���� Ʈ����
--1.��Ű��
--���ν����� ���� ȿ�������� �����ϱ� ���� ���
--����ο� ��ü�η� ����.
--����θ� ���� �����ϰ� ��ü�θ� ����.
--��� : execute ��Ű����.���ν�����
--�����
create or replace package exam_pack is
  function cal_bonus(vempno in emp.empno%type)
    return number;
  procedure cursor_sample02;
end;
/
--��ü��
create or replace package body exam_pack is
  function cal_bonus(vempno in emp.empno%type)
    return number
  is
    vsal number(7,2);
  begin
    select sal into vsal from emp where empno=vempno;
    return (vsal*200);
  end;
  procedure cursor_sample02
  is
    vdept dept%rowtype;
    cursor c1
    is
    select * from dept;
  begin
    dbms_output.put_line('�μ���ȣ / �μ��� / ������');
    dbms_output.put_line('--------------------------');
    for vdept in c1 loop
      exit when c1%notfound;
      dbms_output.put_line(vdept.deptno||' / '||vdept.dname||' / '||
                            vdept.loc);
    end loop;
  end;
end;
/

var var_res number;
execute :var_res:=exam_pack.cal_bonus(7788);
execute exam_pack.cursor_sample02;

--2.DBMS_OUTPUT��Ű��
--����Ŭ���� �������ִ� ��Ű��
--��Ű���� ���� ������ ���(������ �������� Ȯ���ؾߵ�)
conn system/manager
desc dba_objects
select object_name
from dba_objects
where object_type='PACKAGE' and object_name like 'DBMS_%' order by object_name;

--3.Ʈ����
--Ư�� ���̺��� ����Ǹ� �ٸ� ���̺��� �ڵ����� ����ǵ��� �ϱ� ���ؼ� ���.
--FOR EACH ROW�� ���� ���巹�� Ʈ���ſ� �� ���� Ʈ���ŷ� ������.
--������ ���巹�� Ʈ����, ������ �� ���� Ʈ����.
create or replace trigger trg_01
after insert on emp01
begin
  dbms_output.put_line('���Ի���� �Ի��߽��ϴ�.');
end;
/

drop table emp01;
create table emp01 as select empno,ename from emp;
select * from emp01;

insert into emp01 values(1111,'MBC');
insert into emp01 values(1111,'KBS');

create or replace trigger trg_001
after delete on emp01 for each row
begin
  dbms_output.put_line('���Ի���� ����߽��ϴ�.');
end;
/
--2���� ���� �����Ǿ����� �޽����� �ѹ��� ����ȴ�.(���巹�� Ʈ�����̱� ����)
--2���� ���� �����ɶ� �޽����� 2���������Ϸ��� FOR EACH ROW�� ����ؼ�
--�෹�� Ʈ���ŷ� �����ȴ�.
delete from emp01 where empno=1111;
--����
drop table emp01;
create table emp01(
    empno number(4) primary key,
    ename varchar2(10),
    job varchar2(15)
);
--------------------------------
create table sal01(
    salno number(4) primary key,
    sal number(7,2),
    empno number(4) references emp01(empno)
);

create sequence SAL01_salno_seq;

create or replace trigger trg_02
after insert on emp01 for each row
begin
  insert into sal01 values(
    sal01_salno_seq.nextval,100,:new.empno);
end;
/

insert into emp01 values(2,'������','���α׷���');
select * from emp01;
select * from sal01;

select * from user_triggers;

create or replace trigger trg_03
after delete on emp01 for each row
begin
  delete from sal01 where empno=:old.empno;
end;
/

delete from emp01 where empno=2;  
--Ʈ���� ����
drop trigger trg_03;

--4.������ ���� Ʈ������ ����
create table ��ǰ(
    ��ǰ�ڵ� char(6) primary key,
    ��ǰ�� varchar2(12) not null,
    ������ varchar2(12),
    �Һ��ڰ��� number(8),
    ������ number default 0
    );
create table �԰�(
    �԰��ȣ number(6) primary key,
    ��ǰ�ڵ� char(6) references ��ǰ(��ǰ�ڵ�),
    �԰����� date default sysdate,
    �԰���� number(6),
    �԰�ܰ� number(8),
    �԰�ݾ� number(8)
    );
insert into ��ǰ(��ǰ�ڵ�, ��ǰ��, ������, �Һ��ڰ���)
    values('A00001','��Ź��','LG',500);
insert into ��ǰ(��ǰ�ڵ�, ��ǰ��, ������, �Һ��ڰ���)
    values('A00002','��ǻ��','LG',700);
insert into ��ǰ(��ǰ�ڵ�, ��ǰ��, ������, �Һ��ڰ���)
    values('A00003','�����','�Ｚ',600);
--�԰� Ʈ����
create or replace trigger trg_04
    after insert on �԰� for each row
begin
    update ��ǰ
    set ������ = ������+ :new.�԰����
    where ��ǰ�ڵ� = :new.��ǰ�ڵ�;
end;
/
--�԰� �Ǹ� ���ǿ� �´� �������� ���ŵȴ�. +:new.�԰����
insert into �԰�(�԰��ȣ,��ǰ�ڵ�,�԰����,�԰�ܰ�,�԰�ݾ�)
    values(1,'A00001',5,320,1600);
select * from �԰�;
select * from ��ǰ;
--���� Ʈ����
create or replace trigger trg03
    after update on �԰� for each row
begin
    update ��ǰ
    set ������ = ������ +(-:old.�԰����+:new.�԰����)
    where ��ǰ�ڵ� = :new.��ǰ�ڵ�;
end;
/
insert into �԰�(�԰��ȣ,��ǰ�ڵ�,�԰����,�԰�ܰ�,�԰�ݾ�)
    values(2,'A00002',10,300,3000);
insert into �԰�(�԰��ȣ,��ǰ�ڵ�,�԰����,�԰�ܰ�,�԰�ݾ�)
    values(3,'A00003',3,220,660);
--insert�� �԰������ ����� ���ŵ� �԰������ ��ǰ�� �����ش�.
update �԰� set �԰���� =10,�԰�ݾ� =2200 where �԰��ȣ=3;
select * from �԰� order by �԰��ȣ;
select * from ��ǰ;

--����Ʈ����
create or replace trigger trg04
    after delete on �԰� for each row
begin
    update ��ǰ
    set ������ = ������ - :old.�԰����
    where ��ǰ�ڵ� = :old.��ǰ�ڵ�;
end;
/
delete �԰� where �԰��ȣ=3;
select * from �԰� order by �԰��ȣ;
select * from ��ǰ;