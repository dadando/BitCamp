/*20장 PLSQL기초
  3.선택문
  기본 적으로 모든 문장들은 나열된 순서대로 순차적으로 수행된다.
  IF문은 조건을 제시해서 만족한지에 따라 문장을 선택적으로 수행하기 때문에
  선택문이라고 한다.
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
  
  dbms_output.put_line('사번   이름   부서명');
  dbms_output.put_line(vempno||'  '||Vename||'  '||vdname);
end;
/

--연봉계산(급여*12+커미션)
set serveroutput on;
declare
--%ROWTYPE속성으로 로우 전체를 저장할 수 있는 레퍼런스 변수 선언
  vemp emp%rowtype;
  annsal number(7,2);
begin
  dbms_output.put_line('사번/이름/연봉');
  dbms_output.put_line('----------------');
  --SCOTT사원의 전체 정보를 로우 단위로 얻어와 VEMP에 저장한다.
  select * into vemp from emp where ename='SCOTT';
  --커미션이 NULL일 경우 0으로 변경해야 올바른 연봉 계산
  if (vemp.comm is null) then vemp.comm :=0;
  end if;
  
  --스칼라 변수에 연봉을 계산할 결과를 저장한다.
  annsal := vemp.sal*12+vemp.comm;
  --결과 출력
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
  if(vemp.comm is null) then --커미션이 NULL이면
      annsal:=vemp.sal*12;    --급여*12만 계산
    else              --커미션이 NULL이 아니면
      annsal:=vemp.sal*12+vemp.comm; --급여*12+COMM계산
    end if;
  dbms_output.put_line('사번/이름/연봉');
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
  dbms_output.put_line('사번/이름/부서명');
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

--4.반복문
--1)BASIC LOOP문
--기본LOOP는 LOOP에 들어갈때 적어도 한번은 문장이 실행된다.
--END LOOP를 만나면 그와 짝을 이루는 LOOP로 되돌아 간다.
--루프를 빠져나가려면 EXIT;를 만나야 된다.
set serveroutput on;
declare
  n number:=1;
begin
  loop
    dbms_output.put_line(n);
    n:=n+1;
--  exit when n>5; 와 아래 IF문과 동일하게 작동한다.
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
  dbms_output.put_line('1부터 10까지 합: '||tot);
end;
/
--5단 출력하기
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

--2)FOR LOOP문
--반복되는 횟수가 정해진 반복문을 처리하기에 용이하다.
--증감치는 자동 1이된다. 1은 고정.(정수를 사용)
--lower_bound : 하단 바운드 값
--upper_bound : 상단 바운드 값
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
  dbms_output.put_line('부서번호/부서명/지역명');
  dbms_output.put_line('----------------------');
  --변수CNT는 1부터 1씩증가하다가 4에 도달하면 반복문에서 벗어난다.
  for cnt in 1..4 loop
    select * into vdept from dept where deptno=10*cnt;
    dbms_output.put_line(vdept.deptno||'/'||vdept.dname||'/'||vdept.loc);
  end loop;
end;
/

--3)WHILE LOOP문
--참이면 LOOP문 실행 거짓이면 LOOP문을 빠져나온다.
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

/*21장 저장 프로시저,함수,커서
  1.저장 프로시저
  사용자가 만든 PLSQL문을 데이터베이스에 저장.
  간단하게 호출만해서 사용할 수 있다.
  성능도 향상되고 호환성 문제도 해결된다.
  제거 : DROP PROCEDURE 프로시저이름
  OR REPLACE옵션 : 삭제하고 새롭게 생성
  [MODE]
  IN : 데이터를 전달 받을때
  OUT : 수행된 결과를 받아갈 때
  INOUT : 두가지 목적에 모두 사용
*/
--저장 프로시저 생성하기
drop table emp01;
create table emp01 as select * from emp;
create or replace procedure del_all
is
begin
  delete from emp01;
end;
/
--EXECUTE 명령어로 실행
execute del_all;
select * from emp01;

--1)저장 프로시저의 오류 원인 살피기
--오류가 발생할 경우 "SHOW ERROR"명령어를 수행하여 확인할 수 있다.

--2.저장 프로시저 조회하기
desc user_source; --user (SCOTT)이 만든 것.
select * from user_source;

--3.저장 프로시저의 매개 변수
create or replace procedure
del_ename(vename emp01.ename%type)
is
begin
delete from emp01 where ename=vename;
end;
/

execute del_ename('SMITH');
select * from emp01;

--4.IN,OUT,INOUT 매개 변수
--1)IN매개변수
--프로시저 호출시 넘겨준 값을 받아올때 사용. 생략가능

--2)OUT매개변수
--프로시저에 구한 결과 값을 얻어내기 위해서 사용
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
--VAR 또는 VARIABLE을 통해 바인드변수를 생성.
variable var_ename varchar2(15);
variable var_sal number;
var var_job varchar2(9);
--7788 => IN에 사용, :바인드변수 => OUT에 사용
execute sel_empno(7788, :var_ename, :var_sal, :var_job);
print var_ename;
set autoprint on;  --기본값은 OFF로 설정되어있음.
--ON으로 설정해놓지 않으면 execute문이 실행만되고 출력되진않는다.

--연습 임의의 두수를 전달받아 작은수에서 큰수까지 구구단 출력.
--execute gugudan_proc(8, 5)
set serveroutput on;
create or replace procedure gugudan_proc
( num number,
  num2 number)
is
begin
  if(num>num2) then
    for k in num2..num loop
      dbms_output.put_line('***'||k||'단***');
      for i in 1..9 loop
        dbms_output.put_line(k||'*'||i||'='||k*i);
      end loop;
    end loop;
  elsif(num2>num) then
    for k in num..num2 loop
      dbms_output.put_line('***'||k||'단***');
      for i in 1..9 loop
        dbms_output.put_line(k||'*'||i||'='||k*i);
      end loop;
    end loop;
  end if;
end;
/

execute gugudan_proc(7,4);

--문제) 부서 번호를 입력받아 해당 부서의 사원번호와 사원이름,급여,입사일 부서이름을 출력
--detpno_proc(10) or deptno_proc(20)
create or replace procedure deptno_proc
(vdeptno in emp.deptno%type)
is
begin
  dbms_output.put_line('사원번호 / 사원이름 / 급여 / 입사일 / 부서명');
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

--문제)부서 번호를 입력받아 해당 부서의 인원수를 반환하시오.
--ex) deptno_count_proc(10,바인드 변수)
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

--5.저장 함수 생성
--함수는 실행 결과를 되돌려 받을 수 있다.
--결과를 되돌려 받기 위해서 함수가 되돌려 받게 되는 자료형과 
--되돌려 받을 값을 기술해야 한다.
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

--문제) 부서번호를 입력받아 해당 부서의 인원수를 반환하시오.
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

--문제)사원번호를 입력받아 해당 사원의 커미션을 포함하는 연봉을 반환하시오
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

--문제) 이름/입사일자/부서코드를 부서코드 오름차순,입사일자 오름차순으로 조회하시오.
create or replace procedure emp_proc
is
begin
  dbms_output.put_line('사원이름 / 입사일 / 부서번호');
  for k in(select ename,hiredate,deptno 
           from emp order by deptno,hiredate) loop
    dbms_output.put_line(k.ename 
            ||' / '|| k.hiredate ||' / '|| k.deptno);
  end loop;
end;
/

execute emp_proc;

