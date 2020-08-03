--21장
--6.커서
--반환되는 행의 개수가 여러행일 때 사용.
--FETCH CURSOR
--빠져나오는 조건으로 %NOTFOUND 를 사용한다.
set serveroutput on;
set autoprint on;

create or replace procedure cursor_sample01
is
  vdept dept%rowtype;
  cursor c1
  is
  select * from dept;
begin
  dbms_output.put_line('부서번호 / 부서명 / 지역명');
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

--1)CURSOR와 FOR LOOP
--동작원리는 FOR LOOP을 실행하는 동안 자동 CURSOR가 생성되는 원리이다.
create or replace procedure cursor_sample02
is
  vdept dept%rowtype;
  cursor c1
  is
  select * from dept;
begin
  dbms_output.put_line('부서번호 / 부서명 / 지역명');
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

--문제)부서 번호를 입력받아 해당 부서의 사원번호와 사원이름,급여,입사일,부서이름을 출력하시오
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
  dbms_output.put_line('사원번호 / 사원이름 / 급여 / 입사일 / 부서이름');
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
--FOR문 사용
create or replace procedure deptno_cursor2(vdeptno emp.deptno%type)
is
  cursor c1
  is
  select empno,ename,sal,hiredate,dname from emp,dept 
  where emp.deptno=dept.deptno and vdeptno=emp.deptno;
begin
  dbms_output.put_line('사원번호 / 사원이름 / 급여 / 입사일 / 부서이름');
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

--문제)부서별로,업무별로 그룹을 지어서 부서번호,업무,인원수,급여의 평균,합계
--출력시 부서번호순,업무순으로 출력하시오.
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
  dbms_output.put_line('부서번호 / 업무 / 인원수 / 급여평균 / 급여합계');
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
--FOR문 사용
create or replace procedure deptno_cursor4
is
  cursor c1
  is
  select deptno as vdeptno,job as vjob,count(*) as vcnt,round(avg(sal),2) as vavg,
  sum(sal) as vsum from emp group by deptno,job order by deptno,job;
begin
  dbms_output.put_line('부서번호 / 업무 / 인원수 / 급여평균 / 급여합계');
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

/* 예외 처리부 : 예외 발생시 어떻게 처리할 것인지에 예외처리 내용이 들어간다.
형식)
Exception
    when 예외명1 then
        실행문1
    when 예외명2 then
        실행문2
          :
    when others then
        실행문n
--------------------------------    
사원 이름을 입력받아 해당 사원과 관련된 메시지 출력.
없으면 예외처리후 메시지 출력
*/
create or replace procedure exception_ex01
(irum varchar2)
is
  v_ename emp.ename%type;
begin
  select ename into v_ename
  from emp where ename like irum;
  
  dbms_output.put_line('사원명은'||v_ename||'입니다');
exception
  when no_data_found then
    dbms_output.put_line('해당 사원이 없습니다.');
  when too_many_rows then
    dbms_output.put_line('해당 사원이 두 명 이상입니다.');
end;
/

execute exception_ex01('F%');

select ename from emp where ename like 'Q%';

create or replace procedure exception_ex02
(dno dept.deptno%type)
is
  --사용자 정의 예외
  emp_exist exception;
  --컴파일러가 실행되기 전에 처리하는 전처리기 역할을 수행
  --PRAGMA EXCEPTION_INIT(예외명,예외번호)
  --사용자 정의 예외 처리를 할 때 사용
  --특정 예외번호를 명시해서 컴파일러에 이 예외를 사용한다는 것을 알리는 역할.
  pragma exception_init(emp_exist,-2292);
begin
  delete from dept where deptno=dno;
  commit;
exception
  when emp_exist then
    dbms_output.put_line('해당 부서에 사원이 존재하므로 삭제할 수 없습니다.');
end;
/

execute exception_ex02(10);

/*
empno를 입력 받은 후 emp테이블에서 해당 사원을 지우는 작업을 수행
단, 없는 사원번호를 입력할 경우 '조회한 사원번호는 없습니다'라는 예외 메시지 출력
*/
drop table emp01;
create table emp01 as select * from emp;

create or replace procedure exception_ex03(vempno number)
is
  no_empno exception;
begin
  delete from emp01 where empno=vempno;
  --SQL%NOTFOUND : 결과 집합의 패치 로우 수가 0이면 TRUE,
  --               아니면 FALSE를 반환
  --SQL%FOUND : 결과 집합의 패치 로우 수가 1개 이상이면 TRUE,
  --            아니면 FLASE를 반환
  --SQL%ROWCOUNT : 영향받은 결과 집합의 로우 수 변환,없으면 0을 변환
  if sql%notfound then
    raise no_empno;
  end if;
  dbms_output.put_line('사원번호'||vempno||'사원 삭제 성공');
exception
  when no_empno then
    dbms_output.put_line('조회한 사원번호는 없습니다.');
end;
/

execute exception_ex03(7788);

/*
RAISE_APPLICATION_ERROR 프로시저를 사용하여 사용자가 특정 상황에 발생할 에러를
정의하고 예외 처리부를 사용하지 않고 실행부에서 즉시 예외처리 하는 방식.
사용자가 임의로 지정 가능한 에러번호는 -20000~-20999번 까지 사용가능
-------------------------------------------------------------------------
empno를 입력 받은 후 emp테이블에서 해당 사원을 지우는 작업을 수행.
단, 없는 사원번호를 입력할 경우 '존재하지 않는 사원번호'라는 예외 메시지 출력
*/
create or replace procedure exception_ex04
(vempno number)
is
begin
  delete from emp01 where empno=vempno;
  if sql%notfound then
    raise_application_error(-20001,'존재하지 않는 사원번호');
    end if;
    dbms_output.put_line('사원번호'||vempno||'사원 삭제 성공');
end;
/

execute exception_ex04(7788);
select * from emp01;
rollback;

/*
어떤 에러가 발생했는지 확인하기 위해 SQLCODE와 SQLERRM을 사용
------------------------------------------------------------
사용자로부터 empno를 입력받아서 해당 empno와 ename을 화면에 출력하는 코드.
단,사용자가 없는 empno를 입력할 경우 발생하는 Error code와 Error내용을
밝히기 위해 SQLCODE와 SQLERRM을 사용
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
  dbms_output.put_line('사원번호'||vempno||'의 이름은'||v_ename||'입니다.');
exception
  --어느예외에도 속하지 않는 기타 예외를 뜻하며 가장 마지막에 기술되고 when에만 사용한다.
  when others then
    v_code:=sqlcode;
    v_errm:=substr(sqlerrm,1,100);
    dbms_output.put_line('에러코드(Error Code) : '||v_code||'-'||v_errm);
end;
/

execute exception_ex05(7788);

--22장 패키지와 트리거
--1.패키지
--프로시저를 보다 효율적으로 관리하기 위해 사용
--선언부와 몸체부로 구성.
--선언부를 먼저 정의하고 몸체부를 정의.
--사용 : execute 패키지명.프로시저명
--선언부
create or replace package exam_pack is
  function cal_bonus(vempno in emp.empno%type)
    return number;
  procedure cursor_sample02;
end;
/
--몸체부
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
    dbms_output.put_line('부서번호 / 부서명 / 지역명');
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

--2.DBMS_OUTPUT패키지
--오라클에서 제공해주는 패키지
--패키지에 대한 정보를 출력(관리자 계정에서 확인해야됨)
conn system/manager
desc dba_objects
select object_name
from dba_objects
where object_type='PACKAGE' and object_name like 'DBMS_%' order by object_name;

--3.트리거
--특정 테이블이 변경되면 다른 테이블이 자동으로 변경되도록 하기 위해서 사용.
--FOR EACH ROW에 의해 문장레벨 트리거와 행 레벨 트리거로 나뉜다.
--없으면 문장레벨 트리거, 있으면 행 레벨 트리거.
create or replace trigger trg_01
after insert on emp01
begin
  dbms_output.put_line('신입사원이 입사했습니다.');
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
  dbms_output.put_line('신입사원이 퇴사했습니다.');
end;
/
--2개의 행이 삭제되었지만 메시지는 한번만 실행된다.(문장레벨 트리거이기 때문)
--2개의 행이 삭제될때 메시지가 2번나오게하려면 FOR EACH ROW를 사용해서
--행레벨 트리거로 만들면된다.
delete from emp01 where empno=1111;
--연습
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

insert into emp01 values(2,'전수빈','프로그래머');
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
--트리거 삭제
drop trigger trg_03;

--4.예제를 통한 트리거의 적용
create table 상품(
    상품코드 char(6) primary key,
    상품명 varchar2(12) not null,
    제조사 varchar2(12),
    소비자가격 number(8),
    재고수량 number default 0
    );
create table 입고(
    입고번호 number(6) primary key,
    상품코드 char(6) references 상품(상품코드),
    입고일자 date default sysdate,
    입고수량 number(6),
    입고단가 number(8),
    입고금액 number(8)
    );
insert into 상품(상품코드, 상품명, 제조사, 소비자가격)
    values('A00001','세탁기','LG',500);
insert into 상품(상품코드, 상품명, 제조사, 소비자가격)
    values('A00002','컴퓨터','LG',700);
insert into 상품(상품코드, 상품명, 제조사, 소비자가격)
    values('A00003','냉장고','삼성',600);
--입고 트리거
create or replace trigger trg_04
    after insert on 입고 for each row
begin
    update 상품
    set 재고수량 = 재고수량+ :new.입고수량
    where 상품코드 = :new.상품코드;
end;
/
--입고가 되면 조건에 맞는 재고수량이 갱신된다. +:new.입고수량
insert into 입고(입고번호,상품코드,입고수량,입고단가,입고금액)
    values(1,'A00001',5,320,1600);
select * from 입고;
select * from 상품;
--갱신 트리거
create or replace trigger trg03
    after update on 입고 for each row
begin
    update 상품
    set 재고수량 = 재고수량 +(-:old.입고수량+:new.입고수량)
    where 상품코드 = :new.상품코드;
end;
/
insert into 입고(입고번호,상품코드,입고수량,입고단가,입고금액)
    values(2,'A00002',10,300,3000);
insert into 입고(입고번호,상품코드,입고수량,입고단가,입고금액)
    values(3,'A00003',3,220,660);
--insert한 입고수량을 지우고 갱신된 입고수량을 상품에 더해준다.
update 입고 set 입고수량 =10,입고금액 =2200 where 입고번호=3;
select * from 입고 order by 입고번호;
select * from 상품;

--삭제트리거
create or replace trigger trg04
    after delete on 입고 for each row
begin
    update 상품
    set 재고수량 = 재고수량 - :old.입고수량
    where 상품코드 = :old.상품코드;
end;
/
delete 입고 where 입고번호=3;
select * from 입고 order by 입고번호;
select * from 상품;