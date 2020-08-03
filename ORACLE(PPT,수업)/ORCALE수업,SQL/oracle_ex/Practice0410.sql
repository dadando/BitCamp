select ename,hiredate,to_date(19810220,'YYYYMMDD'),
to_char(to_date(19810220,'YYYYMMDD'),'YYYY/MM/DD')
from emp where hiredate = to_date(19810220,'YYYYMMDD');
-- decode 함수
select ename,deptno,
decode(deptno,10,'MBC',20,'KBS','SBS')
as dname from emp;

select job from emp;
select ename,job,decode(job,'CLERK','점원','SALESMAN','영업사원','MANAGER','관리자',
'ANALYST','분석가','PRESIDENT','대표') as job from emp;

select empno,ename,job,sal,
decode(job,'ANALYST',sal*1.05,'SALESMAN',sal*1.1,'MANAGER',sal*1.15,'CLERK',sal*1.2,sal)
as UPSAL from emp;
-- CASE 함수
select ename,deptno,case when deptno = 10 then 'ACCOUNTING' 
when deptno =20 then 'REASEARCH' when deptno =30 then 'SALES' 
when DEPTNO =40 then 'OPERATIONS' end as dname from emp;

select ename,deptno,case deptno when 10 then 'ACCOUNTING' when 20 then 'REASEARCH'
when 30 then 'SALES' when 40 then 'OPERATIONS' end as dname from emp;

select ename,deptno,case deptno when 10 then 'MBC' when 20 then 'KBS'
else 'SBS' end as dname from emp;

-- group by 그룹함수
select * from emp;
select * from dept;
select * from emp,dept;
select deptno from emp group by deptno;
select deptno, round(avg(sal),2) from emp group by deptno order by deptno;
select deptno, max(sal),min(sal) from emp group by deptno;
select deptno,count(*),count(comm) from emp group by deptno order by deptno;
--HAVING 조건
select deptno,round(avg(sal),2) from emp group by deptno having avg(sal)>=2000;
select deptno,max(sal),min(sal) from emp group by deptno having max(sal)>=2900;
-- JOIN CROSS JOIN
select E.ename,E.deptno,D.deptno,D.dname from EMP E,DEPT D;
-- EQUI JOIN
select * from EMP,DEPT where EMP.deptno = dept.deptno;
select ename,dname from emp,dept where emp.deptno=dept.deptno and ename = 'SCOTT';
select E.ename,E.sal from emp E,dept D where D.deptno = E.deptno and loc = 'NEW YORK';
select ename,hiredate from emp E,dept D where E.deptno = D.deptno and dname = 'ACCOUNTING';
select * from emp;
select * from dept;

select ename,dname from emp E,dept D 
where E.job = 'MANAGER' and E.deptno = D.deptno order by dname;
-- NON-EQUI JOIN
select * from salgrade;
select ename,sal,grade from emp,salgrade where sal >= losal and sal <= hisal;
-- SEIF JOIN
select A.ename,B.ename,A.mgr,B.empno from emp A,emp B where A.mgr = B.empno;
select A.ename,B.ename from emp A,emp B where A.mgr = B.empno and A.ename = 'SMITH';

select A.ename,A.job from emp A,emp B where A.mgr = B.empno and B.ename='KING';
select A.ename,B.ename from emp A,emp B 
where A.ename = 'SCOTT' and A.deptno = B.deptno and B.ename <> 'SCOTT';
--OUTER JOIN
select employee.ename || ' 의 매니저는 ' || manager.ename || '입니다.'
from emp employee, emp manager where employee.mgr = manager.empno(+);

select E.ename, D.deptno, D.dname from emp E,dept D
where E.deptno(+) = D.deptno order by deptno;
--ANSI Join
select * from emp cross join dept;
select * from emp,dept;
--ANSI Inner Join
select ename,dname from emp 
inner join dept on emp.deptno = dept.deptno where ename = 'SCOTT';

select emp.ename,dept.dname from emp
inner join dept using (deptno);
select emp.ename,dept.dname from emp natural join dept;

create table mbc ( a char(5),b char(10),c char(10));
create table kbs ( a char(5),b char(10),d char(10));

insert into mbc values ('a1','b1','c1');
insert into mbc values ('a2','b2','c2');
insert into mbc values ('a3','b4','c3');

insert into kbs values ('a1','b1','d1');
insert into kbs values ('a2','b4','d2');
insert into kbs values ('a5','b5','d3');

select * from mbc inner join kbs using (a);
select * from mbc inner join kbs using (b);
select * from mbc inner join kbs using (a, b);
select * from mbc natural join kbs;

drop table mbc;
drop table kbs;

--ANSI OUTER JOIN
DROP TABLE DEPT01; --TABLE 삭제
CREATE TABLE DEPT01( DEPTNO NUMBER(2) , DNAME VARCHAR2(14)); -- 테이블 설정
INSERT INTO DEPT01 VALUES(10, 'ACCOUNTING'); -- 행삽입
INSERT INTO DEPT01 VALUES(20, 'RESEARCH'); -- 행삽입

select * from dept01;

DROP TABLE DEPT02;
CREATE TABLE DEPT02( DEPTNO NUMBER(2), DNAME VARCHAR2(14));
INSERT INTO DEPT02 VALUES(10, 'ACCOUNTING');
INSERT INTO DEPT02 VALUES(30, 'SALES');
SELECT * FROM DEPT02;

select * from dept02;

select * from dept01 left outer join dept02 on dept01.deptno = dept02.deptno;
select * from dept01 right outer join dept02 on dept01.deptno = dept02.deptno;
select * from dept01 full outer join dept02 on dept01.deptno = dept02.deptno;

--서브 쿼리
select dname from emp,dept where emp.deptno = dept.deptno and ename='SCOTT';
select dname from dept 
where deptno = (select deptno from emp where ename = 'SCOTT');
--단일행 서브쿼리
select ename,deptno from emp 
where deptno = (select deptno from emp where ename = 'SCOTT') and ename <> 'SCOTT';
-- (=) JOIN 방식
select A.ename,A.deptno from emp A,emp B 
where A.deptno = B.deptno and B.ename = 'SCOTT' and A.ename <> 'SCOTT';

select * from emp
where job = (select job from emp where ename ='SCOTT') and ename <> 'SCOTT';
select B.* from emp A, emp B 
where B.job = A.job and A.ename = 'SCOTT' and B.ename <> 'SCOTT';

select ename,sal from emp 
where sal >= (select sal from emp where ename = 'SCOTT') and ename <> 'SCOTT';

select ename,deptno from emp 
where deptno = (select deptno from dept where loc = 'DALLAS');

select ename,sal from emp 
where deptno = (select deptno from dept where dname = 'SALES');

select ename,sal from emp 
where mgr = (select empno from emp where ename = 'KING');

--서브쿼리 그룹함수
select ename, sal from emp where sal > (select avg(sal) from emp);

--다중 행 서브 쿼리(IN 연산자)
select ename,sal,deptno from emp 
where deptno in(select distinct deptno from emp where sal>=3000);

select empno,ename,sal,deptno from emp 
where sal in(select max(sal) from emp group by deptno);

select deptno,dname,loc from 
dept where deptno in(select deptno from emp where job ='MANAGER');
--다중 행 서브 쿼리 (ALL 연산자)
select ename,sal from emp where sal > all(select sal from emp where deptno =30);

select ename,sal,job from emp 
where sal >= all(select sal from emp where job = 'SALESMAN')and job <> 'SALESMAN';

--다중 행 서브 쿼리 (ANY 연산자)
select ename, sal from emp 
where sal > any ( select sal from emp where deptno = 30);

select ename,sal,job from emp 
where sal > any(select sal from emp where job = 'SALESMAN') and job <> 'SALESMAN';

--Join,Subquery 예제
--1. 급여가 1000 이상인 사원들의 부서별 평균 급여를 출력해보세요 
--단, 부서별 평균 급여가 2000 이상인 부서만 출력하시오.
select round(avg(sal),2) as 평균급여,deptno from emp where sal >= 1000 group by deptno having avg(sal)>=2000;
--2. 각 부서별 같은 업무(job)를 하는 사람의 인원수를 구해서 
-- 부서번호, 업무(job), 인원수를 부서번호에 대해서 오름차순 정렬해서 출력하시오.
select deptno,job,count(job) from emp group by deptno,job order by deptno,count(job);
--3. 부서별로, 업무별로 그룹을 지어서 부서번호, 업무, 인원수, 급여의 평균, 합계 구하시오.
select deptno,job,count(*),round(avg(sal),2),sum(sal) from emp group by deptno, job order by deptno;
--4. 부서별로 사원의 수가 4명 이상인 사원의 부서번호, 급여의 합계를 구하시오.
select deptno, sum(sal) from emp group by deptno having count(*) >= 4;
--5. emp테이블에서 직급이 SALESMAN이 아닌 사원에 대한 부서별로 급여의 합이
--   4000 이상인 부서의 정보를 출력하시오.(부서번호, 급여의 합계순으로 출력)
select deptno,sum(sal) from emp where job <> 'SALESMAN' group by deptno having sum(sal)>=4000 ;
--6. emp테이블에서 전체 급여가 5000을 초과하는 각 업무에 대해서 업무와 월급여의 합계를 출력하시오.
--   (업무중에서 CLERK는 제외, 월급여의 합계로 내림차순)
select job,sum(sal) from emp group by job having sum(sal)>5000 and job <>'CLERK' order by sum(sal) desc;
--7. EMP와 DEPT TABLE을 JOIN하여 부서 번호, 부서명, 이름, 급여를 출력하시오.
select emp.deptno,dname,ename,sal from emp,dept where emp.deptno = dept.deptno;
--select deptno,dname,ename,sal from emp inner join dept using(deptno);
--8. 이름이 'ALLEN'인 사원의 부서명을 출력하시오.
select dname from emp,dept where emp.deptno = dept.deptno and ename = 'ALLEN';
--select dname from emp e inner join dept d on e.ename = 'ALLEN' and e.deptno = d.deptno;
--9. EMP Table의 데이터를 출력하되 해당사원에 대한 상관번호와 상관의 성명을 함께 출력하시오.
select A.ename,B.empno,B.ename from emp A,emp B where A.mgr = B.empno;
--select A.ename,B.empno,B.ename from emp A inner join emp B on A.mgr = B.empno;
--10. 10번 부서에 근무하는 사원의 사원번호, 이름, 부서명, 지역, 급여를 급여가 많은 순으로 출력하시오.
select empno,ename,dname,loc,sal from emp,dept where emp.deptno =10 and emp.deptno=dept.deptno order by sal desc;
select empno,ename,dname,loc,sal from emp 
inner join dept on emp.deptno = dept.deptno and emp.deptno =10 order by sal desc;
--11. 사원번호,부서번호,부서명을 출력하세요 단, 사원이 근무하지 않는 부서명도 같이 출력하시오.
select empno,dept.deptno,dname from emp,dept where emp.deptno(+) = dept.deptno;
--select empno,dept.deptno,dname from emp right outer join dept on emp.deptno = dept.deptno;
--12. DEPT Table 에는 존재하는 부서코드이지만 해당부서에 근무하는 사람이 존재하지 않는 경우의 결과를 출력하시오.
select * from dept where deptno not in (select distinct deptno from emp);
select * from dept where deptno not in (select deptno from emp group by deptno having count(*) > 0);
--13. 'ALLEN'의 직무와 같은 사람의 이름, 부서명, 급여, 직무를 출력하시오.
select B.ename,dname,B.sal,B.job from emp A,emp B,dept 
where A.job=B.job and A.ename = 'ALLEN' and A.deptno = dept.deptno and B.ename <> 'ALLEN';
select ename,dname,sal,job from emp,dept 
where emp.deptno = dept.deptno and job = (select job from emp where ename = 'ALLEN') and ename <>'ALLEN';
--14. 'JONES'가 속해있는 부서의 모든 사람의 사원번호, 이름, 입사일자, 급여를 출력하시오.
select B.empno,B.ename,B.hiredate,B.sal from emp A,emp B 
where A.deptno = B.deptno and A.ename = 'JONES' and B.ename <> 'JONES';
select empno,ename,hiredate,sal from emp where deptno = (select deptno from emp where ename = 'JONES');
--15. 전체 사원의 평균 임금보다 많이 받는 사원의 사원번호, 이름, 부서명, 입사일, 지역, 급여를 출력하시오.
select empno,ename,dname,hiredate,loc,sal from emp,dept
where sal > (select avg(sal) from emp) and emp.deptno = dept.deptno order by sal;
select e.empno,e.ename,d.dname,e.hiredate,d.loc,e.sal 
from emp e join dept d on e.deptno = d.deptno and e.sal>(select avg(sal) from emp);
--16. 10번 부서 사람들 중에서 20번 부서의 사원과 같은 업무를 하는 사원의 사원번호, 이름, 부서명, 입사일, 지역을 출력하시오.
select e.empno,e.ename,d.dname,e.hiredate,d.loc from emp e,dept d 
where e.deptno =10 and job in (select job from emp where deptno=20) and e.deptno = d.deptno;
--17. 10번 부서 중에서 30번 부서에는 없는 업무를 하는 사원의 사원번호, 이름, 부서명, 입사일자, 지역을 출력하시오.
select empno,ename,dname,hiredate,loc from emp,dept 
where emp.deptno =10 and job not in (select job from emp where deptno =30) and emp.deptno=dept.deptno;
--18. 'MARTIN'이나 'SCOTT'의 급여와 같은 사원의 사원번호, 이름, 급여를 출력하시오.
select empno,ename,sal from emp where sal in (select sal from emp where ename in('MARTIN','SCOTT'));
--19. 30번 부서의 사원중에서 급여를 가장 많이 받는 사원보다 더 많은 급여를 받는 사원의 이름과 급여를 출력하시오.
select ename,sal from emp where sal > (select max(sal) from emp where deptno =30);
--20. 부서번호가 30번인 사원들의 급여중 최저 급여보다 높은 급여를 받는 사원의 이름, 급여를 출력하시오.
select ename,sal from emp where sal > (select min(sal) from emp where deptno = 30);
select ename,sal from emp where sal > any(select sal from emp where deptno = 30);
--21. 'DALLAS' 에서 근무하는 사원의 이름, 부서번호를 출력하시오.
select ename,dept.deptno from emp,dept where loc = 'DALLAS' and emp.deptno = dept.deptno;
select ename,deptno from emp where deptno = (select deptno from dept where loc = 'DALLAS');
--22. 급여를 3000 이상받는 사원이 소속된 부서와 동일한 부서에서 근무하는 사원들의 이름과 급여, 부서번호를 출력하시오.
select ename,sal,deptno from emp where deptno in (select deptno from emp where sal>=3000);
--23. IN 연산자를 이용하여 부서별로 가장 급여를 많이 받는 사원의 사원번호, 급 여, 부서번호를 출력하시오.
select empno,sal,deptno from emp where sal in(select max(sal) from emp group by deptno);
--24. 30번 부서의 사원중에서 급여를 가장 많이 받는 사원보다 더 많은 급여를 받는 사원의 이름과 급여를 출력하시오.
select ename,sal from emp where sal > (select max(sal) from emp where deptno =30);