--15장 시퀀스
--1.시퀀스 개념 이해와 시퀀스 생성
--기본키는 중복된 값을 가질 수 없으므로 항상 유일한 값을 가져야 한다.
--시퀀스는 테이블내의 유일한 숫자를 자동으로 생성하는 자동번호 발생기이다.
--START WITH : 시퀀스 번호의 시작값을 지정. 만약 1부터 시작하려면 START WITH 1이라고 기술하면 된다.
--INCREMENT BY : 번호의 증가치를 지정.1씩 증가하는 시퀀스를 생성하려면 INCREMENT BY 1이라고 기술.
--MAXVALUE n/NOMAXVALUE
--MINVALUE n/NOMINVALUE
--CYCLE/NOCYCLE
--CACHE n/NOCACHE
create sequence dept_deptno_seq increment by 10 start with 10;
--시작 값이 10이고 10씩 증가하는 시퀀스 EMP_SEQ을 생성한다.

--2.시퀀스 관련 데이터 딕셔너리
desc user_sequences;
select sequence_name,min_value,max_value,increment_by,cycle_flag,
last_number from user_sequences;

--3.CURRVAL, NEXTVAL
--CURRVAL : 현재 값을 반환한다.
--NEXTVAL : 현재 시퀀스 값을 다음 값을 반환한다.
--사용할수 있는 경우
--1)서브쿼리가 아닌 SELECT문,2)INSERT문의 SELECT절,3)INSERT문의 VALUE절,4)UPDATE문의 SET절
--사용할수 없는 경우
--1)VIEW의 SELECT절,2)DISTINCT가 있는 SELECT문,3)그룹함수,4)서브쿼리,5)DEFAULT값
select dept_deptno_seq.nextval from dual;
select dept_deptno_seq.currval from dual;

--4.시퀀스 실무에 적용하기
create sequence emp_seq start with 1 increment by 1 maxvalue 100000;
select sequence_name,min_value,max_value,increment_by,cycle_flag,
last_number from user_sequences;
drop table emp01;
create table emp01(empno number(4) primary key,ename varchar(10),hiredate date);
insert into emp01 values(emp_seq.nextval,'JULIA',sysdate);
select * from emp01;
insert into emp01 values(emp_seq.nextval,'ALICE',sysdate);

create table dept_example(deptno number(4) primary key,dname varchar(15),
loc varchar(15));
create sequence dept_example_deptno_seq start with 10 increment by 10 maxvalue 1000000;
insert into dept_example values(dept_example_deptno_seq.nextval,'인사과','서울');
insert into dept_example values(dept_example_deptno_seq.nextval,'경리과','서울');
insert into dept_example values(dept_example_deptno_seq.nextval,'총무과','대전');
insert into dept_example values(dept_example_deptno_seq.nextval,'기술팀','인천');
select * from dept_example;
--시퀀스 제거
drop sequence dept_deptno_seq;
commit;
--5.시퀀스 수정
--ALTER SEQUENCE문 사용
create sequence dept_deptno_seq start with 10 increment by 10 maxvalue 30;
select * from user_sequences;
select dept_deptno_seq.nextval from dual;
select dept_deptno_seq.nextval from dual;
select dept_deptno_seq.nextval from dual;
select dept_deptno_seq.nextval from dual;

alter sequence dept_deptno_seq maxvalue 1000;
select sequence_name,max_value,increment_by,cycle_flag from user_sequences;

select * from emp01;
select max(empno) from emp01;
insert into emp01 values ((select max(empno)+1 from emp01),'MBC',sysdate);
insert into emp01 values ((select max(empno)+1 from emp01),'KBS',sysdate);
commit;

--16장 인덱스
--1.조회를 빠르게 하는 인덱스
--인덱스 사용 이유 : 빠른 검색을 위해서 사용한다.
--인덱스 : SQL명령문의 처리 속도를 향상시키기 위해서 컬럼에 대해 생성하는 오라클 객체.
--장점 : 검색속도가 빠름. 시스템 전체 성능을 향상시킨다.
--단점 : 인덱스를 위한 추가 공간이 필요.인덱스 생성 시간이 걸린다. 데이터 변경작업이 자주일어날
--      경우에는 오히려 성능이 저하된다.
--1)인덱스 정보 조회
--인덱스는 기본 키나 유일 키와 같은 제약 조건을 지정하면 자동으로 생성
create table test(a number(4),b number(4),c char(4), 
constraint test_a_pk primary key(a),constraint test_b_uk unique(b));
select table_name,constraint_type,constraint_name,r_constraint_name
from user_constraints where table_name='TEST';

select index_name,table_name,column_name from user_ind_columns
where table_name in('EMP','DEPT','TEST');
--2)조회 속도 비교하기
--EMP를 복사해서 EMP01을 만들때 EMP01에 제약조건은 복사가 되지않아서 인덱스가 생성되지 않는다.
drop table emp01;
create table emp01 as select * from emp;
select table_name,index_name,column_name from user_ind_columns
where table_name in('EMP','EMP01');
--서브쿼리문으로 INSERT 문을 여러번 반복한다.
--많은 데이터가 담겨있는 테이블을 이용해서 조회 속도 비교
insert into emp01 select * from emp01;
insert into emp01 (empno,ename) values (1111,'SYJ');
set timing on;
select distinct empno,ename from emp01 where ename='SYJ';
delete emp01;
drop table emp01;
--2.인덱스 생성하기
--CREATE INDEX명령어 사용
create index idx_emp01_ename on emp01(ename);
select distinct empno,ename from emp01 where ename='SYJ';

--3.인덱스 제거하기
drop index idx_emp01_ename;

--4.인덱스 종류
--1)고유 인덱스
--유일한 값을 갖는 컬럼에 대해서 생성하는 인덱스
--2)비고유 인덱스
--중복된 데이터를 갖는 컬럼에 대해서 생성하는 인덱스
create table dept01 as select * from dept where 1=0;
insert into dept01 values(10,'인사과','서울');
insert into dept01 values(20,'총무과','대전');
insert into dept01 values(30,'교육팀','대전');
create unique index idx_dept01_deptno on dept01(deptno);
--중복된 데이터를 갖는 컬럼에 대해서는 고유 인덱스를 생성할수 없다
create unique index idx_dept01_loc on dept01(loc);
--중복된 데이터를 갖는 컬럼에 대해서는 비고유 인덱스는 생성할 수 있다.
create index idx_dept01_loc on dept01(loc);
--3)단일 인덱스
--한개의 컬럼으로 구성한 인덱스
--4)결합 인덱스
--두개 이상의 컬럼으로 인덱스를 구성하는 것
--검색할때 인덱스를 구성한 컬럼들을 모두 사용해서 검색해야 한다.
create index idx_dept01_com on dept01(deptno,dname);
select index_name,column_name from user_ind_columns where table_name='DEPT01';
--5)함수 기반 인덱스
--수식이나 함수를 적용하여 인덱스를 만듬. ex)SAL*12로 인덱스를 만듬.
create index idx_emp01_annsal on emp01(sal*12);
select index_name,column_name from user_ind_columns where table_name='EMP01';

--17장 사용자 관리
--1.데이터베이스 보안을 위한 권한
--데이터가 외부에 노출되지 않도록 보안을 해야한다.
--1)권한의 역할과 종류
--시스템권한과 객체권한
--시스템권한 : 사용자의 생성과 제거,DB접근 및 각종 객체를 생성할 수 있는 권한 등..
--CREATE USER : 사용자 생성 권한
--DROP USER : 사용자 삭제 권한
--DROP ANY TABLE : 임의의 테이블 삭제 권한
--QUERY REWRITE : 함수 기반 인덱스 생성 권한
--BACKUP ANY TABLE : 임의의 테이블 백업 권한
--데이터베이스를 관리하는 권한
--CREATE SESSION : 데이터베이스에 접속할 수 있는 권한
--CREATE TABLE : 테이블 생성 권한
--CREATE VIEW : 뷰 생성 권한
--CREATE SEQUENCE : 시퀀스 생성 권한
--CREATE PROCEDURE : 함수 생성 권한
--객체 권한 : 객체를 조작할 수 있는 권한

--2.사용자 생성
--CREATE USER명령어 사용
--사용자의 생성은 사용자의 이름과 암호를 지정하여 생성한다.
--사용자를 생성하기 위해서 권한이 필요하다.

--3.권한 부여하는 GRANT명령어
--사용자에게 시스템 권한 부여하는 명령어
conn system/manager
create user user01 identified by tiger;
grant create session to user01;
conn user01/tiger;

select username,default_tablespace from user_users;

--1)WITH ADMIN OPTION
--사용자에게 시스템권한을 옵션과 함께 부여하면 사용자는 부여받은 시스템 권한을
--다른 사용자에게 부여할 수 있는 권한도 함께 부여받는다.
create user user02 identified by tiger;
grant create session to user02 with admin option;
--USER02는 다른 사용자에게 create session권한을 부여할 수 있는 권한을 부여받는다.

--4.객체 권한
--객체별로 DML문을 사용할 수 있는 권한을 설정하는 것.
--특정 객체를 조회하거나 사용할때 그 객체의 본주인을 같이 기술해야 된다.

--1)스키마 (SCHEMA)
--객체를 소유한 사용자명을 의미한다.
--테이블의 구조를 명세해놓은 것

--2)사용자에게 부여된 권한 조회
conn user01/tiger select * from user_tab_privs_made; --user01사용자가 부여한 권한을 살펴봄
select * from user_tab_privs_recd;--user01사용자에게 부여된 권한을 살펴봄

--3)사용자에게서 권한을 뺏기 위한 REVOKE 명령어
--REVOKE명령어다음 철회하고자하는 객체권한 다음 ON 다음 해당 테이블명 from 해당 사용자 기술.

--4)WITH GRANT OPTION
--객체에 접근할 권한을 부여받으면서 그권한을 다른 사용자에게 부여할 수 있는 권한도 받는다.

