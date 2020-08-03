desc emp;
select * from emp;
-- 1. emp ���̺��� �ʵ� ����� Ȯ���Ͻÿ�.(�����ȣ�� �̸�)
select empno,ename from emp;
-- 2. ����̸���(��������) �����Ͻÿ�.
select empno,ename from emp order by ename asc;
-- 3. ����̸���(��������) �����Ͻÿ�.
select empno,ename from emp order by ename desc;
-- 4. �޿� ������������ ����̸�(ename), �޿�(sal), �μ��ڵ�(deptno)�� ��ȸ�Ͻÿ�.
select ename,sal,deptno from emp order by sal desc;
-- 5. �μ��ڵ� ��������, �޿� ������������ ����̸�(ename), �޿�(sal), �μ��ڵ�(deptno)�� ��ȸ�Ͻÿ�.
select ename,sal,deptno from emp order by deptno asc,sal desc;
-- 6. �̸�(ename)/�Ի�����(hiredate)/�μ��ڵ�(deptno)�� �μ��ڵ� ��������, 
--    �Ի�����(hiredate) ������������ ��ȸ�Ͻÿ�.
select ename,hiredate,deptno from emp order by deptno asc,hiredate asc;
-- 7. ����(job) Į���� �ߺ������͸� �ϳ����� ��ȸ�Ͻÿ�.
select distinct job from emp;
-- 8. emp���̺��� job ��������, sal ������������ �����ؼ� ename �̸�, job ����, sal �޿� Į�������� 
--    ��Ī�� �ٲ㼭 ��ȸ�Ͻÿ�.
select ename as "�̸�",job as ����,sal "�޿�" from emp order by job asc,sal desc;
-- 9. �޿��� 1000���� ���� 3000���� ���� ���� ��ȸ�ϱ�.(�޿� ��������)
select * from emp where sal > 1000 and sal < 3000 order by sal desc;
-- 10. �޿��� 1000���� �Ǵ� 3000 �̻��� ���� �˻��ϱ�.(�޿� ��������)
select * from emp where sal not between 1000 and 3000 order by sal desc;
-- 11. ����(job)�� MANAGER �Ǵ� SALESMAN�� �������� �̸������� ��ȸ�Ͻÿ�.
select * from emp where job = 'MANAGER' or job = 'SALESMAN' order by ename asc;
select * from emp where job in('MANAGER','SALESMAN') order by ename asc;
-- 12. �μ��ڵ�(deptno)�� 30�� ������ ��ȸ�Ͻÿ�.
select * from emp where deptno = 30;
-- 13. emp ���̺��� �ߺ��� �μ��ڵ带 �Ѱ����� ��ȸ�Ͻÿ�.
select distinct deptno from emp;
-- 14. �μ��ڵ尡 10 �Ǵ� 20 �Ǵ� 30�� ������ ��ȸ�Ͻÿ�.
--     (or, in������ ���� Ȱ���ؼ� ��ȸ)
select * from emp where deptno =10 or deptno=20 or deptno=30;
select * from emp where deptno in(10,20,30);
-- 15. �޿��� 1000~3000�� ������ �޿������� ��ȸ�Ͻÿ�.
--     (and, between������ ���� Ȱ���ؼ� ��ȸ)
select * from emp where sal between 1000 and 3000 order by sal asc;
select * from emp where sal>=1000 and sal<=3000 order by sal asc;
-- 16. �̸��� SCOTT�� ����� ��ȸ�Ͻÿ�.
select * from emp where ename = 'SCOTT';
-- 17. S�� �����ϴ� ����� ��ȸ�Ͻÿ�.
select * from emp where ename like 'S%';
-- 18. ����̸��� 'O' ���Ե� ����̸��� ��ȸ�Ͻÿ�.
select * from emp where ename like '%O%';
-- 19. ������ ������ �̸�, �޿�, Ŀ�̼�, ������ ��ȸ�Ͻÿ�. 
--   (�������ϴ� �� : �޿�(sal)*12����+���ʽ�(comm))
select ename,sal,comm,sal*12+comm as ���� from emp;
-- 20. Ŀ�̼��� null�̸� 0���� �ٲ��� ������ �ٽ� ����ؼ� �̸�, �޿�, Ŀ�̼�, ������ ��ȸ�Ͻÿ�.
select ename,sal,comm,sal*12+nvl(comm,0)as "����" from emp;
-- 21. ����� �޿��� �˻��ؼ� '���������� �޿��� ���Դϴ�'�� ��ȸ�Ͻÿ�.(|| ���տ�����)
select ename || ' �� �޿��� ' || sal || ' �Դϴ� ' from emp;
-- 22. emp���̺��� �Ի���(hiredate)�� 1982�� 1�� 1�� ������ ����� ���� 
--     ����� �̸�(ename), �Ի���, �μ���ȣ(deptno)�� �Ի��ϼ����� ��ȸ�Ͻÿ�.
select ename,hiredate,deptno from emp where hiredate < '1982/1/1' order by hiredate asc;
-- 23. emp���̺��� �μ���ȣ�� 20���̳� 30���� �μ��� ���� ����鿡 ���Ͽ� 
--     �̸�, �����ڵ�(job), �μ���ȣ�� �̸������� ��ȸ�Ͻÿ�.(or, in������ ���� Ȱ���ؼ� ��� ��ȸ)
select ename,job,deptno from emp where deptno in(20,30) order by ename asc;
select ename,job,deptno from emp where deptno=20 or deptno =30 order by ename asc;
-- 24. ������ 3000�̻��� ����� ����Ͻÿ�.
select * from emp where sal*12 >= 3000;
-- 25. emp���� �Ի����ڰ� 82�� ���Ŀ� �Ի��� ����� �̸��� �Ի����ڸ� �Ի����� ������ ����Ͻÿ�.
--     (�Ի����� ��������)
select ename,hiredate from emp where hiredate >= '1982/01/01' order by hiredate asc;
-- 26. emp���� �̸��� S�� ������ ����� �����ȣ�� �̸��� ����Ͻÿ�.
select empno,ename from emp where ename like '%S';
-- 27. emp���� �̸��� �ι�° ���ڿ�  A�� ���� ����� �����ȣ�� �̸��� ����Ͻÿ�.
select empno,ename from emp where ename like '_A%';
-- 28. emp���� �Ŵ����� �����ʴ� ����� �̸��� ����Ͻÿ�.
select ename from emp where mgr is null;
-- 29. emp���� Ŀ�̼��� �޴� ����� �̸��� Ŀ�̼��� ����Ͻÿ�.
select ename,comm from emp where comm is not null and comm <> 0;

select lengthb('Oracle'),lengthb('����Ŭ') from dual;
select substr('Welcome to Oracle',4,3) from dual;
select '19' || substr(hiredate,1,2) || '�� ' || substr(hiredate,4,2) || '��'as "�Ի�" from emp;
select * from emp where substr(hiredate,4,2) = '09';

select * from emp where substr(hiredate,1,2) = '87';
select * from emp where substr(ename,-1,1) = 'E';

select substr('����������Ŭ',3,4),substrb('����������Ŭ',3,4) from dual;

select instr('WELCOME TO ORACLE','O') from dual;
select instr('WELCOME TO ORACLE','O',6,2) from dual;
select instr('�����ͺ��̽�','��',3,1),instrb('�����ͺ��̽�','��',3,1) from dual;

select RPAD('Oracle',20,'#') from dual;
select LTRIM('   Oracle   ') from dual;
select RTRIM('   Oracle   ') from dual;
select TRIM('   Oracle   ') from dual;
select TRIM('a' from 'aaaaOracleaaaa') from dual;

select sysdate-1 as ����, sysdate as ����, sysdate+1 as ���� from dual;

select sysdate-hiredate as �ٹ��ϼ� from emp;
select hiredate, trunc(hiredate,'MONTH') from emp;
select ename,sysdate,hiredate,months_between(sysdate,hiredate) from emp;
select ename,hiredate,add_months(hiredate,6) from emp;
select sysdate,next_day(sysdate,'������') from dual;
select hiredate,last_day(hiredate) from emp;

select sysdate, to_char(sysdate,'YYYY-MM-DD amhh:mi:ss day') from dual;

select ename,sal,to_char (sal,'L999,999') from emp;

select to_char(123456,'000000000'),to_char(123456,'999,999,999') from dual;
select ename,hiredate from emp where hiredate = to_date('19810220','YYYYMMDD');

select trunc(sysdate-to_date('2008/01/01','YYYY/MM/DD')) from dual;
select to_number('20,000','99,999') - to_number('10,000','99,999') from dual;

select empno,ename,nvl(to_char(mgr),'C E O') as MANAGER from emp where mgr is null;
select * from emp;

