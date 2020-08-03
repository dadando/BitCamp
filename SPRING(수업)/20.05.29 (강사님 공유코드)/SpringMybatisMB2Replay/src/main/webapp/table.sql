create table table_comment(
  cno number not null primary key, 
  bno number not null,   
  content varchar2(2000) not null, 
  writer varchar2(20) not null, 
  reg_date date not null 
);