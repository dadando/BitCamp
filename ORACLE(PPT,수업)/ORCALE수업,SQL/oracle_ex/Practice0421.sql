--18장 데이터베이스 롤 권한 제어
--1.롤이란(role)
--사용자에게 효율적으로 권한을 부여할 수 있도록 여러 권한을 묶어 놓은 것
--사용자 관리를 간편하고 효율적으로 할 수 있다.

--2.롤의 종류
--사전정의된 롤/사용자가 정의한 롤
--1)사전 정의된 롤
--(1)CONNECT롤
--ALTER SESSION/CREATE CLUSTER/CREATE DATABASE LINK/CREATE SEQUENCE/CREATE SESSION
--CREATE SYNONYM/CREATE TABLE/CREATE VIEW
--(2)RESOURCE롤
--CREATE CLUSTER/CREATE PROCEDURE/CREATE SEQUENCE/CREATE TABLE/CREATE TRIGGER
--(3)DBA롤
--시스템관리에 필요한 모든 권한을 가진다.
create user user04 identified by tiger;
grant connect,resource to user04;
conn user04/tiger

--2)롤 관련 데이터 딕셔너리
select * from dict where table_name like '%ROLE%';
--ORLE_SYS_PRIVS : 롤에 부여된 시스템 권한 정보
--ROLE_TAB_PRIVS : 롤에 부여된 테이블 관련 권한 정보
--USER_ROLE_PRIVS : 접근 가능한 롤 정보
--USER_TAB_PRIVS_MADE : 사용자 소유의 오브젝트 권한 정보
--USER_TAB_PRIVS_RECD : 사용자에게 부여된 오브젝트 권한 정보
--USER_COL_PRIVS_MADE : 사용자 소유의 칼럼에 부여된 오브젝트 권한 정보
--USER_COL_PRIVS_RECD : 사용자에게 부여된 특정 칼럼에 대한 오브젝트 권한 정보
select * from user_role_privs;
create user kbs identified by pass;
grant connect,resource to kbs;
select * from user_role_privs;

--3.사용자 롤 정의
--CREATE ROLE명령어 사용해서 롤을 생성한다.
--롤을 생성한 뒤 롤에게 권한을 부여한다.
--롤을 생성할 때는 관리자에서 생성해야한다.
create role mrole; --SYSTEM
--시스템 권한을 부여할때에는 관리자에서 부여해야한다.
grant create session,create table,create view to mrole; --SYSTEM
--사용자에게 롤을 부여한다.
grant mrole to user05;
--객체 권한은 객체에서 부여해야한다.
grant select on emp to mrole02; --SCOTT
--생성된 롤을 사용자에게 부여할때에는 다시 관리자에서
grant mrole02 to user05;
--emp조회
select * from scott.emp; --emp앞에 한정자를 꼭 붙여야 한다.
select * from user_role_privs; --MROLE,MROLE02를 확인할 수 있다.

--4.롤 회수하기
--관리자에서 실행해야 한다.
revoke mrole from user05; --user05에게서 mrole 회수.
drop role morle02; --롤 제거.
select * from user_role_privs; --mrole은 존재, mrole02는 삭제됨.

--5.롤의 장점
--롤에 권한을 부여함으로서 작업을 간소화할 수 있다.
create role def_role; --롤 생성
grant create session,create table to def_role; --롤에게 시스템 권한 부여 (SYSTEM)
grant update,delete,select on emp to def_role; --롤에게 객체 권한 부여 (SCOTT)
create user usera1 identified by a1234;
create user usera2 identified by a1234;
create user usera3 identified by a1234; --사용자 3개 생성 (SYSTEM)
grant def_role to usera1;
grant def_role to usera2;
grant def_role to usera3; --사용자들에게 롤 부여(SYSTEM)
select * from role_sys_privs where role='DEF_ROLE'; --시스템 권한에 대한 정보
select * from role_tab_privs where role='DEF_ROLE'; --객체 권한에 대한 정보

select * from user_role_privs;
select * from user_tab_privs_made; --SCOTT이 부여한 권한 (취소가능)
revoke update,delete on emp from def_role; --def_role에 부여한 update,delete권한 회수

revoke create table from def_role; --create table권한 회수(SYSTEM)

--20장 PLSQL기초
--1.PL/SQL구조
--SQL에 없는 기능이 제공된다.
--변수 선언/비교 처리/반복 처리
--DECLARE~BEGIN~EXCEPTION~END 순서를 갖는다.
--선언부(DECLARE SECTION) : 모든 변수나 상수를 선언하는 부분
--실행부(EXECUTABLE) : 절차적 형식으로 로직을 기술할 수 있는 부분.BEGIN으로 시작한다.
--예외 처리(EXCEPTION) : EXCEPTION으로 시작.
set serveroutput on; --화면출력 환경변수 on으로 변환 (디폴트는 OFF)
begin --시작
dbms_output.put_line('Hello World!'); --패키지_프로시저.함수
end; --끝
/ --커서를 슬래시에 놓고 실행해야 된다.

--2.변수선언과 대입문
--변수명 다음 자료형을 기술(자바와 반대)
--identifier : 변수명
--CONSTANT : final과 같은 의미
--datatype : 자료형을 기술
--NOT NULL : 값을 반드시 포함하도록 변수를 제약한다.
--Expression : 표현식

declare
vempno number(4);
vename varchar2(10);
begin
vempno := 7788;
vename := 'SCOTT';
dbms_output.put_line('사번/이름');
dbms_output.put_line('----------');
dbms_output.put_line(vempno || ' / ' || vename);
end;
/

--2)스칼라 변수/레퍼런스 변수
--스칼라 : 숫자 = NUMBER, 문자 = VARCHAR2
--레퍼런스 : 테이블에 저장되어있는 컬럼을 사용. 
--%TYPE을 사용해서 해당컬럼의 자료형,크기를 참조해서 사용
--장점 : 레퍼런스 변수 선언을 수정할 필요가 없는 장점이 있다.
--%ROWTYPE : 행 단위로 참조.컬럼명과 데이터타입과 LENGTH를 그대로 가져올 수 있다.
--장점 : 테이블의 컬럼의 개수와 데이터형식을 모르더라도 지정할 수 있다.

--3)PLSQL에서 SELECT문
--데이터베이스에서 정보를 추출할 필요가 있을때 또는 변경된 내용을 적용할 필요가 있을때
--질의된 값을 변수에 할당시키기 위해서 SELECT문을 사용한다.
--INTO절과 함께 사용한다.
--데이터는 오로지 1개만 다룰 수 있다.(단일행 결과)
select empno,ename into vempno,vename from emp where ename='SCOTT';

set serveroutput on;
declare --%TYPE 속성으로 컬럼 단위 레퍼런스 변수 선언
vempno emp.empno%type;
vename emp.ename%type;
begin
dbms_output.put_line('사번 / 이름');
dbms_output.put_line('------------');
select empno,ename into vempno,vename from emp where ename='SCOTT';
dbms_output.put_line(vempno || '/' || vename); --레퍼런스 변수에 저장된 값을 출력한다.
end;
/

--4)PLSQL테이블
--로우에 대해 배열처럼 액세스하기 위해 기본키를 사용한다.
--배열과 유사하고 BINARY_INTEGER(정수형)데이터형의 
--기본키와 요소를 저장하는 스칼라또는 레코드컬럼을 포함해야 한다.
--또한 이들은 동적으로 자유롭게 증가할 수 있다.
set serveroutput on;
declare --테이블 타입을 정의
type ename_table_type is table of emp.ename%type index by binary_integer;
type job_table_type is table of emp.job%type index by binary_integer;
ename_table ename_table_type; --테이블 타입으로 변수 선언
job_table job_table_type;
i binary_integer := 0;

begin --EMP 테이블에서 사원이름과 직급을 얻어옴
for K in(select ename,job from emp) loop 
--행객체가 K객체에 저장된다.(즉,여기서는 2개(ename,job컬럼이 저장)
i := i+1; --인덱스 증가
ename_table(i) := K.ename; --사원이름과
job_table(i) := K.job;  --직급을 저장
end loop;
for J in 1..i loop --테이블에 저장된 내용을 출력
dbms_output.put_line(rpad(ename_table(J),12)||' / '||rpad(job_table(J),9));
--12자리의 공간을 확보해서 오른쪽출력, 9자리 공간 확보해서 오른쪽 출력 (공백이 오른쪽)
end loop;
end;
/

--%ROWTYPE버전
SET SERVEROUTPUT ON;
DESC EMP;
DECLARE
--테이블 타입을 정의
TYPE EMP_TABLE_TYPE IS TABLE OF EMP%ROWTYPE INDEX BY BINARY_INTEGER;
EMP_TABLE EMP_TABLE_TYPE;
--테이블 타입으로 변수 선언
I BINARY_INTEGER := 0;

BEGIN
--EMP 테이블에서 사원이름과 직급을 얻어옴
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

--테이블에 저장된 내용을 출력
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

--연습
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

--데이터 입력 for문과 출력 for문 합침.
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

--연습2--
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

    dbms_output.put_line('사원번호 / 사원이름 / 입사년도    / 급여    / 부서번호 / 부서명');
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

--연습
declare
  begin
    dbms_output.put_line('부서명 / 평균급여');
    for k in(select deptno,round(avg(sal),2) as sal_Avg 
    from emp group by deptno order by deptno) loop
    dbms_output.put_line(rpad(k.deptno,4) || '    '||rpad(k.sal_Avg,8));
  end loop;
end;
/

--5)PLSQL RECORD TYPE
--테이블의 ROW을 읽어올 때 편리함.
set serveroutput on
declare
  --레코드 타입을 정의
  type emp_record_type is record(
    v_empno emp.empno%type,v_ename emp.ename%type,
    v_job emp.job%type,v_deptno emp.deptno%type);
  --레코드로 변수 선언
  emp_record emp_record_type;
begin
  --SCOTT 사원의 정보를 레코드 변수에 저장
  select empno,ename,job,deptno into emp_record from emp where ename = UPPER('SCOTT');
  --레코드 변수에 저장된 사원 정보를 출력
  dbms_output.put_line('사원번호 : ' || to_char(emp_record.v_empno));
  dbms_output.put_line('이    름 : ' || emp_record.v_ename);
  dbms_output.put_line('담당업무 : ' || emp_record.v_job);
  dbms_output.put_line('부서번호 : ' || to_char(emp_record.v_deptno));
end;
/
--연습
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
  dbms_output.put_line('사원번호: ' || to_char(emp_record.v_empno));
  dbms_output.put_line('이   름: ' || emp_record.v_ename);
  dbms_output.put_line('담당업무: ' || emp_record.v_job);
  dbms_output.put_line('급   여: ' || to_char(emp_record.v_sal));
  dbms_output.put_line('부서번호: ' || to_char(emp_record.v_deptno));
  dbms_output.put_line('부 서 명: ' || emp_record.v_dname);
end;
/
  


