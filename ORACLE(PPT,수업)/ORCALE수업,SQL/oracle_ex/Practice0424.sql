--JDBC프로그래밍
create table goodsinfo(
    code char(5) primary key,
    name varchar2(30) not null,
    price number(8) not null,
    maker varchar2(20)
    );
insert into goodsinfo(code,name,price,maker)
    values('10001','디지털TV',350000,'LG');
insert into goodsinfo(code,name,price,maker)
    values('10002','DVD플레이어',250000,'LG');
insert into goodsinfo(code,name,price,maker)
    values('10003','디지털카메라',210000,'삼성');
insert into goodsinfo(code,name,price,maker)
    values('10004','전자사전',180000,'아이리버');
insert into goodsinfo(code,name,price,maker)
    values('10005','벽걸이에어컨',400000,'삼성');

select * from goodsinfo;

commit;

create table member(
    hakbun char(4) primary key,
    name varchar2(10),
    addr varchar2(10),
    phone char(13)
);
commit;
select * from member;
desc member;
commit;
rollback;
update member set name = '맥주스',addr='강남구' where hakbun='A004';

create or replace procedure call_select(
    v_member_cursor out sys_refcursor)
is
begin
    open v_member_cursor
    for
    select * from member order by hakbun;
end;
/

create or replace procedure call_search(
    vhakbun in out varchar2,
    vname out varchar2,
    vaddr out varchar2,
    vphone out varchar2)
is
begin
    select hakbun,name,addr,phone
    into vhakbun,vname,vaddr,vphone
    from member
    where hakbun = vhakbun;
end;
/
select * from user_procedures where object_name = 'CALL_SEARCH';
select * from member;

create or replace procedure call_insert(
    hakbun member.hakbun%type,
    name member.name%type,
    addr member.addr%type,
    phone member.phone%type)
is
begin
    insert into member values(hakbun,name,addr,phone);
end;
/
commit;

create or replace procedure call_update(
    p_hakbun member.hakbun%type,
    p_addr member.addr%type,
    p_phone member.phone%type)
is
begin
    update member set addr=p_addr,phone=p_phone
    where hakbun=p_hakbun;
end;
/
select * from member;

create or replace procedure call_delete(
    p_hakbun member.hakbun%type)
is
begin
    delete from member
    where hakbun=p_hakbun;
end;
/
commit;

create table sungjuk (
    hakbun varchar2(4) primary key, 
    irum varchar2(15),
    kor number(3),
    eng number(3),
    math number(3),
    tot number(3),
    avg number(5, 2),
    grade varchar2(4)
);

select * from sungjuk;

create table sawon (
    sabun varchar2(4) primary key,
    deptname varchar2(15),
    irum varchar2(10),
    gender varchar2(2),
    email varchar2(50)
);

desc sawon;
select * from sawon;
COMMIT;