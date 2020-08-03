desc emp;
select * from emp;
-- 1. emp 테이블의 필드 목록을 확인하시오.(사원번호와 이름)
select empno,ename from emp;
-- 2. 사원이름순(오름차순) 정렬하시오.
select empno,ename from emp order by ename asc;
-- 3. 사원이름순(내림차순) 정렬하시오.
select empno,ename from emp order by ename desc;
-- 4. 급여 내림차순으로 사원이름(ename), 급여(sal), 부서코드(deptno)를 조회하시오.
select ename,sal,deptno from emp order by sal desc;
-- 5. 부서코드 오름차순, 급여 내림차순으로 사원이름(ename), 급여(sal), 부서코드(deptno)를 조회하시오.
select ename,sal,deptno from emp order by deptno asc,sal desc;
-- 6. 이름(ename)/입사일자(hiredate)/부서코드(deptno)를 부서코드 오름차순, 
--    입사일자(hiredate) 오름차순으로 조회하시오.
select ename,hiredate,deptno from emp order by deptno asc,hiredate asc;
-- 7. 직급(job) 칼럼의 중복데이터를 하나씩만 조회하시오.
select distinct job from emp;
-- 8. emp테이블의 job 오름차순, sal 내림차순으로 정렬해서 ename 이름, job 직급, sal 급여 칼럼명으로 
--    별칭을 바꿔서 조회하시오.
select ename as "이름",job as 직급,sal "급여" from emp order by job asc,sal desc;
-- 9. 급여가 1000보다 많고 3000보다 작은 직원 조회하기.(급여 내림차순)
select * from emp where sal > 1000 and sal < 3000 order by sal desc;
-- 10. 급여가 1000이하 또는 3000 이상의 직원 검색하기.(급여 내림차순)
select * from emp where sal not between 1000 and 3000 order by sal desc;
-- 11. 직급(job)이 MANAGER 또는 SALESMAN인 직원들을 이름순으로 조회하시오.
select * from emp where job = 'MANAGER' or job = 'SALESMAN' order by ename asc;
select * from emp where job in('MANAGER','SALESMAN') order by ename asc;
-- 12. 부서코드(deptno)가 30인 직원을 조회하시오.
select * from emp where deptno = 30;
-- 13. emp 테이블에서 중복된 부서코드를 한개씩만 조회하시오.
select distinct deptno from emp;
-- 14. 부서코드가 10 또는 20 또는 30인 직원을 조회하시오.
--     (or, in연산자 각각 활용해서 조회)
select * from emp where deptno =10 or deptno=20 or deptno=30;
select * from emp where deptno in(10,20,30);
-- 15. 급여가 1000~3000인 직원을 급여순으로 조회하시오.
--     (and, between연산자 각각 활용해서 조회)
select * from emp where sal between 1000 and 3000 order by sal asc;
select * from emp where sal>=1000 and sal<=3000 order by sal asc;
-- 16. 이름이 SCOTT인 사원을 조회하시오.
select * from emp where ename = 'SCOTT';
-- 17. S로 시작하는 사원을 조회하시오.
select * from emp where ename like 'S%';
-- 18. 사원이름에 'O' 포함된 사원이름을 조회하시오.
select * from emp where ename like '%O%';
-- 19. 연봉을 구한후 이름, 급여, 커미션, 연봉을 조회하시오. 
--   (연봉구하는 식 : 급여(sal)*12개월+보너스(comm))
select ename,sal,comm,sal*12+comm as 연봉 from emp;
-- 20. 커미션이 null이면 0으로 바꾼후 연봉을 다시 계산해서 이름, 급여, 커미션, 연봉을 조회하시오.
select ename,sal,comm,sal*12+nvl(comm,0)as "연봉" from emp;
-- 21. 사원의 급여를 검색해서 '누구누구의 급여는 얼마입니다'로 조회하시오.(|| 결합연산자)
select ename || ' 의 급여는 ' || sal || ' 입니다 ' from emp;
-- 22. emp테이블에서 입사일(hiredate)이 1982년 1월 1일 이전인 사원에 대해 
--     사원의 이름(ename), 입사일, 부서번호(deptno)를 입사일순으로 조회하시오.
select ename,hiredate,deptno from emp where hiredate < '1982/1/1' order by hiredate asc;
-- 23. emp테이블에서 부서번호가 20번이나 30번인 부서에 속한 사원들에 대하여 
--     이름, 직업코드(job), 부서번호를 이름순으로 조회하시오.(or, in연산자 각각 활용해서 모두 조회)
select ename,job,deptno from emp where deptno in(20,30) order by ename asc;
select ename,job,deptno from emp where deptno=20 or deptno =30 order by ename asc;
-- 24. 연봉이 3000이상인 사원을 출력하시오.
select * from emp where sal*12 >= 3000;
-- 25. emp에서 입사일자가 82년 이후에 입사한 사람의 이름과 입사일자를 입사일자 순으로 출력하시오.
--     (입사일자 오름차순)
select ename,hiredate from emp where hiredate >= '1982/01/01' order by hiredate asc;
-- 26. emp에서 이름이 S로 끝나는 사원의 사원번호와 이름을 출력하시오.
select empno,ename from emp where ename like '%S';
-- 27. emp에서 이름의 두번째 글자에  A가 들어가는 사원의 사원번호와 이름을 출력하시오.
select empno,ename from emp where ename like '_A%';
-- 28. emp에서 매니저를 갖지않는 사원의 이름을 출력하시오.
select ename from emp where mgr is null;
-- 29. emp에서 커미션을 받는 사원의 이름과 커미션을 출력하시오.
select ename,comm from emp where comm is not null and comm <> 0;

select lengthb('Oracle'),lengthb('오라클') from dual;
select substr('Welcome to Oracle',4,3) from dual;
select '19' || substr(hiredate,1,2) || '년 ' || substr(hiredate,4,2) || '월'as "입사" from emp;
select * from emp where substr(hiredate,4,2) = '09';

select * from emp where substr(hiredate,1,2) = '87';
select * from emp where substr(ename,-1,1) = 'E';

select substr('웰컴투오라클',3,4),substrb('웰컴투오라클',3,4) from dual;

select instr('WELCOME TO ORACLE','O') from dual;
select instr('WELCOME TO ORACLE','O',6,2) from dual;
select instr('데이터베이스','이',3,1),instrb('데이터베이스','이',3,1) from dual;

select RPAD('Oracle',20,'#') from dual;
select LTRIM('   Oracle   ') from dual;
select RTRIM('   Oracle   ') from dual;
select TRIM('   Oracle   ') from dual;
select TRIM('a' from 'aaaaOracleaaaa') from dual;

select sysdate-1 as 어제, sysdate as 오늘, sysdate+1 as 내일 from dual;

select sysdate-hiredate as 근무일수 from emp;
select hiredate, trunc(hiredate,'MONTH') from emp;
select ename,sysdate,hiredate,months_between(sysdate,hiredate) from emp;
select ename,hiredate,add_months(hiredate,6) from emp;
select sysdate,next_day(sysdate,'수요일') from dual;
select hiredate,last_day(hiredate) from emp;

select sysdate, to_char(sysdate,'YYYY-MM-DD amhh:mi:ss day') from dual;

select ename,sal,to_char (sal,'L999,999') from emp;

select to_char(123456,'000000000'),to_char(123456,'999,999,999') from dual;
select ename,hiredate from emp where hiredate = to_date('19810220','YYYYMMDD');

select trunc(sysdate-to_date('2008/01/01','YYYY/MM/DD')) from dual;
select to_number('20,000','99,999') - to_number('10,000','99,999') from dual;

select empno,ename,nvl(to_char(mgr),'C E O') as MANAGER from emp where mgr is null;
select * from emp;

