select username,default_tablespace from dba_users
where username in('SYS','SYSTEM','HR','SCOTT');

select username,default_tablespace from user_users;
select tablespace_name,username,bytes,max_bytes from dba_ts_quotas;

select tablespace_name,bytes,max_bytes from user_ts_quotas;

select * from role_tab_privs where role='DEF_ROLE';
select * from role_SYS_privs where role='DEF_ROLE';

desc dba_objects;
select object_name
from dba_objects
where object_type='PACKAGE' and object_name like 'DBMS_%' order by object_name;