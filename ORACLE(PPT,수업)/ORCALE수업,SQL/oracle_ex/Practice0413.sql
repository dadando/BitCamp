select ROWID, empno,ename from emp;

create table SAM02( year01 interval year(3) to month);
insert into SAM02 values(interval '36' month(3));
select year01,sysdate,sysdate+year01 from sam02;

create table sam03(day01 interval day(3) to second);
insert into sam03 values(interval '100' day(3));
select day01,sysdate,sysdate + day01 from sam03;

create table emp01(empno number(4),ename varchar2(20),sal number(7,2));
drop table dept01;
create table dept01(deptno number(2),dname varchar2(14),loc varchar2(13));

create table emp02 as select * from emp;
select * from emp02;

create table emp03 as select empno, ename from emp;
create table emp04 as select empno,ename,sal from emp;
select * from emp04;

create table emp05 as select * from emp where deptno =10;
select * from emp05;

create table emp06 as select * from emp where 1=0;
select * from emp06;

drop table dept02;
create table dept02 as select * from dept where 1=0;
desc dept02;
select * from dept02;

create table sungjuk(hakbun varchar2(6),name varchar2(6),kor number(3),eng number(3),
math number(3),tot number(3),avg number(5,2),grade varchar2(4));
desc sungjuk;
select * from sungjuk;
