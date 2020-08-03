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