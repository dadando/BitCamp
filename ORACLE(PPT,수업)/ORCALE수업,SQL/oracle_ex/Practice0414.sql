--ALTER TABLE
--기존 테이블의 구조를 변경하기 위한 DDL명령문.
--ADD COLUMN : 추가 , 마지막 위치에 추가됨.
--MODIFY COLUMN : 수정
--DROP COLUMN : 삭제
--ADD 예제
alter table emp01 add(job varchar2(9));
desc emp01;
select * from emp02;
alter table emp02 add(job2 varchar2(9));
--DEPT02테이블에 숫자타입의 부서장(DMGR) 칼럼을 추가
alter table dept02 add(dmgr number(4));
desc dept02;
--MODIFY 예제 (기본키(primary key)도 상관없음,데이터가 없어야 수정가능)
desc emp01;
alter table emp01 modify(job varchar2(30));
--DEPT02테이블의 DMGR칼럼을 문자타입으로 변경
alter table dept02 modify(dmgr varchar2(4));

insert into dept02 values (10,'mbc','seoul','aaa');
select * from dept02;
alter table dept02 modify(dmgr number(4));
--DROP예제
alter table emp01 drop column job;
desc emp01;
alter table dept02 drop column dmgr;
desc dept02;
--SET UNUSED 옵션
--테이블에 저장된 내용이 많을 경우 컬럼을 삭제하는데 꽤 오랜 시간이 걸리는 문제가 있다.
--컬럼을 삭제하는 것은 아니지만 컬럼의 사용을 논리적으로 제한할 수 있다.
--한번 UNUSED로 지정하면 다시 복구는 불가능하다.
--예제
select * from emp02;
alter table emp02 set unused(job2);
alter table emp02 drop unused columns;
--컬럼 이름 변경 RENAME column
alter table emp02 rename column deptno to dnum;

--3.테이블 삭제하기 DROP TABLE
--예제
drop table emp01;

--4.테이블의 모든 로우를 제거하는 TRUNCATE
--테이블은 남고 안의 값은 완전히 제거됨(롤백 불가능).
truncate table emp02; --복구 불가능 삭제.
delete from emp03; --복구가능 삭제문.
select * from emp03; 
ROLLBACK; --방금 실행한 명령문 취소.

--5.테이블 명을 변경하는 RENAME
--예제
rename emp02 to test;

--6.데이터 딕셔너리와 데이터 딕셔너리 뷰
--데이터베이스 자원을 효율적으로 관리하기 위한 다양한 정보를 저장하는 시스템 테이블(DD)
--사용자는 데이터 딕셔너리의 내용을 직접 수정하거나 삭제불가능
--원 테이블은 직접 조회할 수 없다.
--데이터를 산출해 줄 수 있도록 데이터 딕셔너리 뷰를 제공.

--USER_데이터 딕셔너리 뷰
--자신의 계정이 소유한 객체 등에 관한 정보를 조회
--예제
--테이블의 구조를 볼 수 있는 desc명령어
desc user_tables;
--사용자 확인
show user;
--사용자가 사용가능한 테이블의 이름 확인
select table_name from user_tables order by table_name desc;

--ALL_데이터 딕셔너리 뷰
--오라클에서는 타계정의 객체는 원천적으로 접근 불가능.
--하지만 소유자가 권한을 부여하면 접근이 가능.
--현재 계정이 접근 가능한 테이블의 정보 조회하는 뷰.
--예제
desc all_tables;
select owner, table_name from all_tables;
select * from dual; --DUAL테이블에 접근이 가능하도록 권한이 부여되어있는 상태.

--DBA_데이터 딕셔너리 뷰
--DBA시스템 권한을 가진 사용자만 접근할 수 있다.
select table_name,owner from dba_tables; --권한이 없어서 오류발생.

--10장 테이블의 내용 추가,수정,삭제하는 DML
--1. 테이블에 새로운 행 추가.
--테이블의 구조만 복사
drop table dept01;
create table dept01 as select * from dept where 1=0;
select * from dept01;
desc dept01;
--빈 테이블에 데이터 추가
insert into dept01(deptno,dname,loc) values(10,'ACCOUNTING','NEW YORK');
insert into dept01(dname,deptno,loc) values('MBC',10,'SEOUL');
insert into dept01 values(30,'SBS','BUSAN');
insert into dept01(deptno,dname) values (40,'KBS');--LOC는 NULL처리
--예제
desc sam01;
create table sam01(empno number(4),ename varchar2(10),job varchar2(9),sal number(7,2));
insert into sam01(empno,ename,job,sal) values(1000,'APPLE','POLICE',10000);
insert into sam01 values(1010,'BANANA','NURSE',15000);
insert into sam01 (empno,ename,job,sal) values (1020,'ORANGE','DOCTOR',25000);
select * from sam01;
--NULL값 삽입 (NOT NULL로 표기된 컬럼은 NULL값 처리 불가능.)
desc sam01;
insert into sam01 values(1030,'VERY','',25000);
insert into sam01 values(1040,'CAT',null,2000);
--서브쿼리로 데이터 삽입
drop table dept02;
create table dept02 as select * from dept where 1=0;
insert into dept02 select * from dept;
select * from dept02;
insert into dept02(loc) select dname from dept where deptno =20;
--컬럼 이름은 중요하지않고 데이터 타입이 중요하다.

--예제
desc sam01;
select * from sam01;
insert into sam01 select empno,ename,job,sal from emp where deptno=10;

--2.다중 테이블에 다중 행 입력하기
--INSERT ALL문을 사용하면 서브 쿼리의 결과를 조건없이 여러테이블에 동시에 입력가능.
--예제
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

--INSERT ALL명령문에 WHEN절(조건)을 추가해서 조건에 맞는 행만 추출하여 추가
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
--예제
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

--3.테이블의 내용을 수정하기 위한 UPDATE문
--where 절을 사용하지 않을 경우는 테이블에 있는 모든 행이 수정된다.
create table emp01 as select * from emp;
select * from emp01;
update emp01 set deptno=20;
select * from emp01;
update emp01 set sal=sal*1.1;
select * from emp01;
update emp01 set hiredate = sysdate;
select * from emp01;
--where문을 추가하여 조건에 맞춰 수정
drop table emp01;
create table emp01 as select * from emp;
update emp01 set deptno =30 where deptno =10;
update emp01 set sal = sal*1.1 where sal>= 3000;
update emp01 set hiredate = sysdate where substr(hiredate,1,2) ='87';
select * from emp01;
--예제
select * from sam01;
update sam01 set sal = sal-5000 where sal>=10000;
--테이블에서 2개의상의 칼럼 값 변경
select * from emp01;
update emp01 set deptno = 20,job = 'MANAGER' where ename = 'SCOTT';
update emp01 set hiredate = sysdate,sal=50,comm=4000 where ename='SCOTT';
--서브 쿼리를 이용한 데이터 수정
update dept01 set loc=(select loc from dept01 where deptno=40)where deptno = 20;
select * from dept01;
--예제
drop table sam02;
create table sam02 as select ename,sal,hiredate,deptno from emp;
desc sam02;
update sam02 set sal = sal+1000 where deptno=(select deptno from dept where loc = 'DALLAS');
select * from sam02;
--서브쿼리를 이용해 한번에 2개의 컬럼 값 변경하기
update dept01 set (dname,loc) = (select dname,loc from dept where deptno=40) where deptno=20;
select * from dept01;
select * from sam02;
update sam02 set (sal,hiredate) = (select sal,hiredate from emp where ename='KING');

--4.테이블에 불필요한 행을 삭제하기 위한 DELETE문
--특정 행을 삭제하기 위해 WHERE절을 이용하여 조건지정
--WHERE문을 사용하지 않으면 모든 행이 삭제됨.
delete from dept01;
delete from dept01 where deptno=30;
select * from dept01;
--예제
select * from sam01;
delete from sam01 where job is null;

--서브쿼리를 이용한 데이터 삭제
select * from emp01;
delete from emp01 where deptno = (select deptno from dept where dname='SALES');
select * from sam02;
delete from sam02 where deptno =(select deptno from dept where dname='RESEARCH');

--5.테이블을 합병하는 MERGE
--MERGE는 합병이란 의미이므로 구조가 같은 두개의 테이블을 하나로 합치는 기능
--명령을 수행하게 되면 기존에 존재하는 행이 있다면 새로운 값으로 갱신(UPDATE)되고,
--존재하지 않으면 새로운 행으로 추가(INSERT)된다.
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

--11장
--1.트랜잭션(Transaction)
--데이터베이스에서 트랜잭션은 데이터처리의 한단위.
--하나의 트랜잭션은 ALL-OR-Nothing 방식으로 처리.
--하나의 명령어라도 잘못되면 전체를 취소한다.
--트랜잭션은 마지막으로 실행한 커밋이후부터 새로운 커밋시점까지 수행된 모든 DML명령들을 의미
--2.COMMIT/ROLLBACK
--작업이 성공적으로 처리되도록 하기 위해서 COMMIT명령을,
--작업을 취소하기 위해서는 ROLLBACK명령으로 종료해야 한다.
--DDL명령이 실행되면 COMMIT이 자동으로 실행된다.
--DML명령은 COMMIT이 자동실행되지 않는다.
--DDL(자료 정의 언어) : Create,Drop,Alter,Grant,Revoke
--DML(자료 처리 언어) : 선택,삽입,갱신,삭제,완료,복키
--예제
commit;
select * from dept01;
delete from dept01;
rollback;

select * from dept01;
delete from dept01 where deptno=20;
commit;
rollback;
--3.트랜잭션을 작게 분할하는 SAVEPOINT
--저장된 SAVEPOINT는 ROLLBACK TO SAVEPOINT 문을 사용하여 표시한 곳까지 ROLLBACK할 수 있다.
--예제
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
