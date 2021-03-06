--13장 제약조건
--1.무결성 제약 조건의 개념과 종류
--데이터 무결성 제약 조건 : 테이블에 부적절한 자료가 입력되는것을 방지.
--NOT NULL/UNIQUE/PRIMARY KEY(기본키)/FOREIGN KEY(외래키,참조키)/CHECK
--emp 테이블에서 empno는 PK(PRIMARY KEY)이고, deptno는 FK(FOREIGN KEY)이다.
--참조무결성 : 자식테이블의 참조키는 반드시 부모테이블의 기본키에 있어야 된다.
--ex) emp테이블(자식테이블),dept테이블(부모테이블) deptno는 emp에서 참조키,dept에서는 기본키

--2.제약조건 확인하기
--USER_CONSTRAINTS 데이터 딕셔너리 뷰로 제약 조건에 관한 정보를 조회할 수 있다.
DESC USER_CONSTRAINTS;
--CONSTRAINT_TYPE
--P(PRIMARY KEY),R(FOREIGN KEY),U(UNIQUE),C(CHECK, NOT NULL)
select constraint_name, constraint_type,table_name,r_constraint_name from user_constraints;
--USER_CONS_COLUMNS뷰는 제약조건이 지정된 칼럼명을 알려준다.
select * from user_cons_columns;

--3.필수 입력을 위한 NOT NULL제약 조건
--필수 입력을 요구하는 컬럼이 있다면 NULL값이 저장되지 못하도록 제약조건을 설정해야 한다.
--제약조건없는 테이블 생성 예시
drop table emp01;
create table emp01(empno number(4),ename varchar2(10),job varchar2(9),deptno number(2));
insert into emp01 values(null,null,'SALESMAN',30);
select * from emp01;
desc emp01;
--NOT NULL제약조건 설정해서 테이블 생성 예시(컬럼 레벨 방식으로만 정의 가능)
drop table emp02;
create table emp02(empno number(4) not null,ename varchar2(10) not null,
job varchar2(9),deptno number(2));
desc emp02;

--4.유일한 값만 허용하는 UNIQUE제약 조건
--NULL은 값(VALUE)에서 제외되므로 UNIQUE조건을 체크하는 값에서 제외된다.
drop table emp03;
create table emp03(empno number(4) unique,ename varchar2(10) not null,
job varchar2(9),deptno number(2));
desc emp03;

--5.컬럼레벨로 제약조건명을 명시해서 제약조건 설정
--테이블명_칼럼명_제약조건유형
drop table emp04;
create table emp04(empno number(4) constraint emp04_empno_uk unique,
ename varchar2(10) constraint emp04_ename_nn not null,job varchar2(9),deptno number(2));
desc emp04;
select table_name,constraint_name from user_constraints where table_name in('EMP04');

--6.데이터 구분을 위한 PRIMARY KEY제약 조건
drop table emp05;
create table emp05(empno number(4) constraint emp05_empno_pk primary key,
ename varchar2(10) constraint emp05_ename_nn not null,job varchar2(9),deptno number(2));
select * from user_constraints where table_name in('EMP05');

--7.참조 무결성을 위한 FOREIGN KEY 제약 조건
--ERD (Entity Relation Diagram) 개체와 관계 다이어그램
select table_name,constraint_type,constraint_name,r_constraint_name from user_constraints
where table_name in('EMP','DEPT');
select * from user_cons_columns where table_name in('EMP','DEPT');
--R_CONSTRAINT_NAME은 외래키인 경우 어떤 기본키를 참조했는지에 대한 정보를 갖는다.
drop table emp06;
create table emp06(empno number(4) constraint emp06_empno_pk primary key,
ename varchar2(10) constraint emp06_ename_nn not null,job varchar2(9),
deptno number(2) constraint emp06_deptno_fk references dept(deptno));
insert into emp06 values(7566,'JONES','MANAGER',50); --부모테이블의 deptno에 50이 없다.
select * from user_cons_columns where table_name in('EMP06','DEPT');
insert into emp06 values(7566,'JONES','MANAGER',40);
select * from emp06;

--8.CHECK 제약 조건
--입력된 값이 설정된값 이외의 값이면 오류메시지와 함께 명령이 수행되지 못하게 한다.
create table emp07(empno number(4) constraint emp07_empno_pk primary key,
ename varchar2(10) constraint emp07_ename_nn not null,
sal number(7,2) constraint emp07_sal_ck check(sal between 500 and 5000),
gender varchar2(1) constraint emp07_gender_ck check(gender in('M','F')));

--9.DEFAULT 제약 조건
--아무런 값을 입력 하지 않았을 때 디폴트제약의 값이 입력이 된다.
drop table dept01;
create table dept01(deptno number(2) primary key,
dname varchar2(14),loc varchar2(13) default 'SEOUL');
insert into dept01(deptno,dname) values(10,'ACCOUNTING');
select * from dept01;--loc값을 입력안했기 때문에 디폴트제약의 값인 'SEOUL'이 입력됨.

--연습
--member테이블 
--member_id varchar2(4) 기본키
--passwd varchar2(15) not null
--gender char(1) 남:M 여:F
--email varchar2(50)
--phone char(13)
--addr varchar2(100)
--sungjuk테이블
--hakbun 기본키
--irum 
--kor 0~100
--eng 0~100
--math 0~100
--tot 0~300
--avg 0.0~300
--grade 수,우,미,양,가
--member_id 외래키
create table member(
member_id varchar2(4) constraint member_id_pk primary key,
passwd varchar2(15) constraint member_passwd_nn not null,
gender char(1) constraint member_gender_ck check(gender in('M','F')),
email varchar2(50),phone char(13),addr varchar2(100));

create table sungjuk(
hakbun varchar2(6) constraint sungjuk_hakbun_pk primary key,
irum varchar2(15) constraint sungjuk_irum_nn not null,
kor number(3) constraint sungjuk_kor_ck check(kor between 0 and 100),
eng number(3) constraint sungjuk_eng_ck check(eng between 0 and 100),
math number(3) constraint sungjuk_math_ck check(math between 0 and 100),
tot number(3) constraint sungjuk_tot_ck check(tot between 0 and 300),
avg number(5,2) constraint sungjuk_avg_ck check(avg between 0.0 and 100.0),
grade char(2) constraint sungjuk_grade_ck check(grade in('수','우','미','양','가')),
member_id varchar2(4) constraint sungjuk_id_fk references member(member_id));
--테이블 구조 확인하는 뷰
desc member;
desc sungjuk;
select * from user_cons_columns where table_name in('MEMBER','SUNGJUK');
select * from user_constraints where table_name in('MEMBER','SUNGJUK');
select * from user_tab_columns where table_name in('MEMBER','SUNGJUK');

--10.테이블 레벨 방식으로 제약조건 지정
--복학키로 기본키를 지정할 경우
--ALTER TABLE로 제약 조건을 추가할 때
--테이블 레벨 방식에서 NOT NULL조건은 지정할 수 없다.
--DEFAULT조건도 마찬가지 컬럼 레벨방식으로 지정해야 한다.
create table emp01(empno number(4) primary key,ename varchar2(10) not null,
job varchar2(9) unique,deptno number(4) references dept(deptno));

create table emp02(empno number(4),ename varchar2(10) not null,
job varchar2(9),deptno number(4),primary key(empno),unique(job),
foreign key(deptno) references dept(deptno));

create table emp03(empno number(4) constraint emp03_ename_nn not null,
ename varchar2(10),job varchar2(9),deptno number(4),
constraint emp03_empno_pk primary key(empno),
constraint emp03_job_uk unique(job),
constraint emp03_deptno_fk foreign key(deptno) references dept(deptno));
--복합키를 기본키로 지정하는 방법
create table member01(name varchar2(10),address varchar2(30),hphone varchar2(16),
constraint member01_combo_pk primary key(name,hphone));
select * from user_cons_columns where table_name in('MEMBER01');
select * from user_constraints where table_name in('MEMBER01');
select * from user_tab_columns where table_name in('MEMBER01');

--연습2
drop table sungjuk; --자식클래스를 먼저 삭제한뒤,
drop table member;  --부모클래스를 삭제해야 된다.

create table member(
member_id varchar2(4),passwd varchar2(15) constraint member_passwd_nn not null,
gender char(1),email varchar2(50),phone char(13),addr varchar2(100),
constraint member_id_pk primary key(member_id),
constraint member_gender_ck check(gender in('M','F')));

create table sungjuk(
hakbun varchar2(6),irum varchar2(15) constraint sungjuk_irum_nn not null,
kor number(3),eng number(3),math number(3),tot number(3),avg number(5,2),
grade char(2),member_id varchar2(4),
constraint sungjuk_hakbun_pk primary key(hakbun),
constraint sungjuk_kor_ck check(kor between 0 and 100),
constraint sungjuk_eng_ck check(eng between 0 and 100),
constraint sungjuk_math_ck check(math between 0 and 100),
constraint sungjuk_tot_ck check(tot between 0 and 300),
constraint sungjuk_avg_ck check(avg between 0.0 and 100.0),
constraint sungjuk_grade_ck check(grade in('수','우','미','양','가')),
constraint sungjuk_id_fk foreign key(member_id) references member(member_id));

desc member;
insert into member
values('M001','1234','M','M001@aaa.com','010-0000-0000','서울시');
select * from member;
insert into member
values('M002','12345','F','M002@aaa.com','010-1111-0000','안양시');
select * from member;
delete member where member_id in('M002');