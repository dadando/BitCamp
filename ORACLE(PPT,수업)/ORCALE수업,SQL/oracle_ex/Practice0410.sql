select ename,hiredate,to_date(19810220,'YYYYMMDD'),
to_char(to_date(19810220,'YYYYMMDD'),'YYYY/MM/DD')
from emp where hiredate = to_date(19810220,'YYYYMMDD');
-- decode �Լ�
select ename,deptno,
decode(deptno,10,'MBC',20,'KBS','SBS')
as dname from emp;

select job from emp;
select ename,job,decode(job,'CLERK','����','SALESMAN','�������','MANAGER','������',
'ANALYST','�м���','PRESIDENT','��ǥ') as job from emp;

select empno,ename,job,sal,
decode(job,'ANALYST',sal*1.05,'SALESMAN',sal*1.1,'MANAGER',sal*1.15,'CLERK',sal*1.2,sal)
as UPSAL from emp;
-- CASE �Լ�
select ename,deptno,case when deptno = 10 then 'ACCOUNTING' 
when deptno =20 then 'REASEARCH' when deptno =30 then 'SALES' 
when DEPTNO =40 then 'OPERATIONS' end as dname from emp;

select ename,deptno,case deptno when 10 then 'ACCOUNTING' when 20 then 'REASEARCH'
when 30 then 'SALES' when 40 then 'OPERATIONS' end as dname from emp;

select ename,deptno,case deptno when 10 then 'MBC' when 20 then 'KBS'
else 'SBS' end as dname from emp;

-- group by �׷��Լ�
select * from emp;
select * from dept;
select * from emp,dept;
select deptno from emp group by deptno;
select deptno, round(avg(sal),2) from emp group by deptno order by deptno;
select deptno, max(sal),min(sal) from emp group by deptno;
select deptno,count(*),count(comm) from emp group by deptno order by deptno;
--HAVING ����
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
select employee.ename || ' �� �Ŵ����� ' || manager.ename || '�Դϴ�.'
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
DROP TABLE DEPT01; --TABLE ����
CREATE TABLE DEPT01( DEPTNO NUMBER(2) , DNAME VARCHAR2(14)); -- ���̺� ����
INSERT INTO DEPT01 VALUES(10, 'ACCOUNTING'); -- �����
INSERT INTO DEPT01 VALUES(20, 'RESEARCH'); -- �����

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

--���� ����
select dname from emp,dept where emp.deptno = dept.deptno and ename='SCOTT';
select dname from dept 
where deptno = (select deptno from emp where ename = 'SCOTT');
--������ ��������
select ename,deptno from emp 
where deptno = (select deptno from emp where ename = 'SCOTT') and ename <> 'SCOTT';
-- (=) JOIN ���
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

--�������� �׷��Լ�
select ename, sal from emp where sal > (select avg(sal) from emp);

--���� �� ���� ����(IN ������)
select ename,sal,deptno from emp 
where deptno in(select distinct deptno from emp where sal>=3000);

select empno,ename,sal,deptno from emp 
where sal in(select max(sal) from emp group by deptno);

select deptno,dname,loc from 
dept where deptno in(select deptno from emp where job ='MANAGER');
--���� �� ���� ���� (ALL ������)
select ename,sal from emp where sal > all(select sal from emp where deptno =30);

select ename,sal,job from emp 
where sal >= all(select sal from emp where job = 'SALESMAN')and job <> 'SALESMAN';

--���� �� ���� ���� (ANY ������)
select ename, sal from emp 
where sal > any ( select sal from emp where deptno = 30);

select ename,sal,job from emp 
where sal > any(select sal from emp where job = 'SALESMAN') and job <> 'SALESMAN';

--Join,Subquery ����
--1. �޿��� 1000 �̻��� ������� �μ��� ��� �޿��� ����غ����� 
--��, �μ��� ��� �޿��� 2000 �̻��� �μ��� ����Ͻÿ�.
select round(avg(sal),2) as ��ձ޿�,deptno from emp where sal >= 1000 group by deptno having avg(sal)>=2000;
--2. �� �μ��� ���� ����(job)�� �ϴ� ����� �ο����� ���ؼ� 
-- �μ���ȣ, ����(job), �ο����� �μ���ȣ�� ���ؼ� �������� �����ؼ� ����Ͻÿ�.
select deptno,job,count(job) from emp group by deptno,job order by deptno,count(job);
--3. �μ�����, �������� �׷��� ��� �μ���ȣ, ����, �ο���, �޿��� ���, �հ� ���Ͻÿ�.
select deptno,job,count(*),round(avg(sal),2),sum(sal) from emp group by deptno, job order by deptno;
--4. �μ����� ����� ���� 4�� �̻��� ����� �μ���ȣ, �޿��� �հ踦 ���Ͻÿ�.
select deptno, sum(sal) from emp group by deptno having count(*) >= 4;
--5. emp���̺��� ������ SALESMAN�� �ƴ� ����� ���� �μ����� �޿��� ����
--   4000 �̻��� �μ��� ������ ����Ͻÿ�.(�μ���ȣ, �޿��� �հ������ ���)
select deptno,sum(sal) from emp where job <> 'SALESMAN' group by deptno having sum(sal)>=4000 ;
--6. emp���̺��� ��ü �޿��� 5000�� �ʰ��ϴ� �� ������ ���ؼ� ������ ���޿��� �հ踦 ����Ͻÿ�.
--   (�����߿��� CLERK�� ����, ���޿��� �հ�� ��������)
select job,sum(sal) from emp group by job having sum(sal)>5000 and job <>'CLERK' order by sum(sal) desc;
--7. EMP�� DEPT TABLE�� JOIN�Ͽ� �μ� ��ȣ, �μ���, �̸�, �޿��� ����Ͻÿ�.
select emp.deptno,dname,ename,sal from emp,dept where emp.deptno = dept.deptno;
--select deptno,dname,ename,sal from emp inner join dept using(deptno);
--8. �̸��� 'ALLEN'�� ����� �μ����� ����Ͻÿ�.
select dname from emp,dept where emp.deptno = dept.deptno and ename = 'ALLEN';
--select dname from emp e inner join dept d on e.ename = 'ALLEN' and e.deptno = d.deptno;
--9. EMP Table�� �����͸� ����ϵ� �ش����� ���� �����ȣ�� ����� ������ �Բ� ����Ͻÿ�.
select A.ename,B.empno,B.ename from emp A,emp B where A.mgr = B.empno;
--select A.ename,B.empno,B.ename from emp A inner join emp B on A.mgr = B.empno;
--10. 10�� �μ��� �ٹ��ϴ� ����� �����ȣ, �̸�, �μ���, ����, �޿��� �޿��� ���� ������ ����Ͻÿ�.
select empno,ename,dname,loc,sal from emp,dept where emp.deptno =10 and emp.deptno=dept.deptno order by sal desc;
select empno,ename,dname,loc,sal from emp 
inner join dept on emp.deptno = dept.deptno and emp.deptno =10 order by sal desc;
--11. �����ȣ,�μ���ȣ,�μ����� ����ϼ��� ��, ����� �ٹ����� �ʴ� �μ��� ���� ����Ͻÿ�.
select empno,dept.deptno,dname from emp,dept where emp.deptno(+) = dept.deptno;
--select empno,dept.deptno,dname from emp right outer join dept on emp.deptno = dept.deptno;
--12. DEPT Table ���� �����ϴ� �μ��ڵ������� �ش�μ��� �ٹ��ϴ� ����� �������� �ʴ� ����� ����� ����Ͻÿ�.
select * from dept where deptno not in (select distinct deptno from emp);
select * from dept where deptno not in (select deptno from emp group by deptno having count(*) > 0);
--13. 'ALLEN'�� ������ ���� ����� �̸�, �μ���, �޿�, ������ ����Ͻÿ�.
select B.ename,dname,B.sal,B.job from emp A,emp B,dept 
where A.job=B.job and A.ename = 'ALLEN' and A.deptno = dept.deptno and B.ename <> 'ALLEN';
select ename,dname,sal,job from emp,dept 
where emp.deptno = dept.deptno and job = (select job from emp where ename = 'ALLEN') and ename <>'ALLEN';
--14. 'JONES'�� �����ִ� �μ��� ��� ����� �����ȣ, �̸�, �Ի�����, �޿��� ����Ͻÿ�.
select B.empno,B.ename,B.hiredate,B.sal from emp A,emp B 
where A.deptno = B.deptno and A.ename = 'JONES' and B.ename <> 'JONES';
select empno,ename,hiredate,sal from emp where deptno = (select deptno from emp where ename = 'JONES');
--15. ��ü ����� ��� �ӱݺ��� ���� �޴� ����� �����ȣ, �̸�, �μ���, �Ի���, ����, �޿��� ����Ͻÿ�.
select empno,ename,dname,hiredate,loc,sal from emp,dept
where sal > (select avg(sal) from emp) and emp.deptno = dept.deptno order by sal;
select e.empno,e.ename,d.dname,e.hiredate,d.loc,e.sal 
from emp e join dept d on e.deptno = d.deptno and e.sal>(select avg(sal) from emp);
--16. 10�� �μ� ����� �߿��� 20�� �μ��� ����� ���� ������ �ϴ� ����� �����ȣ, �̸�, �μ���, �Ի���, ������ ����Ͻÿ�.
select e.empno,e.ename,d.dname,e.hiredate,d.loc from emp e,dept d 
where e.deptno =10 and job in (select job from emp where deptno=20) and e.deptno = d.deptno;
--17. 10�� �μ� �߿��� 30�� �μ����� ���� ������ �ϴ� ����� �����ȣ, �̸�, �μ���, �Ի�����, ������ ����Ͻÿ�.
select empno,ename,dname,hiredate,loc from emp,dept 
where emp.deptno =10 and job not in (select job from emp where deptno =30) and emp.deptno=dept.deptno;
--18. 'MARTIN'�̳� 'SCOTT'�� �޿��� ���� ����� �����ȣ, �̸�, �޿��� ����Ͻÿ�.
select empno,ename,sal from emp where sal in (select sal from emp where ename in('MARTIN','SCOTT'));
--19. 30�� �μ��� ����߿��� �޿��� ���� ���� �޴� ������� �� ���� �޿��� �޴� ����� �̸��� �޿��� ����Ͻÿ�.
select ename,sal from emp where sal > (select max(sal) from emp where deptno =30);
--20. �μ���ȣ�� 30���� ������� �޿��� ���� �޿����� ���� �޿��� �޴� ����� �̸�, �޿��� ����Ͻÿ�.
select ename,sal from emp where sal > (select min(sal) from emp where deptno = 30);
select ename,sal from emp where sal > any(select sal from emp where deptno = 30);
--21. 'DALLAS' ���� �ٹ��ϴ� ����� �̸�, �μ���ȣ�� ����Ͻÿ�.
select ename,dept.deptno from emp,dept where loc = 'DALLAS' and emp.deptno = dept.deptno;
select ename,deptno from emp where deptno = (select deptno from dept where loc = 'DALLAS');
--22. �޿��� 3000 �̻�޴� ����� �Ҽӵ� �μ��� ������ �μ����� �ٹ��ϴ� ������� �̸��� �޿�, �μ���ȣ�� ����Ͻÿ�.
select ename,sal,deptno from emp where deptno in (select deptno from emp where sal>=3000);
--23. IN �����ڸ� �̿��Ͽ� �μ����� ���� �޿��� ���� �޴� ����� �����ȣ, �� ��, �μ���ȣ�� ����Ͻÿ�.
select empno,sal,deptno from emp where sal in(select max(sal) from emp group by deptno);
--24. 30�� �μ��� ����߿��� �޿��� ���� ���� �޴� ������� �� ���� �޿��� �޴� ����� �̸��� �޿��� ����Ͻÿ�.
select ename,sal from emp where sal > (select max(sal) from emp where deptno =30);