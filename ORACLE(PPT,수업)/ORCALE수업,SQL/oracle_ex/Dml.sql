--���� ���ν���
--���⳯¥ : sysdate/ �ݳ����� : sysdate+3
--�����=> �����������̺� ���Ⱑ�ɻ��� N ���� ����
create or replace procedure borrow_book
    (vbookno book_borrow.bookno%type,
     vmembno book_borrow.membno%type)
is
begin
    insert into book_borrow(brownum,bookno,membno,lendingdate,due_date)
    values(book_br_seq.nextval,vbookno,vmembno,sysdate,sysdate+3);
    update book_info set bstate='N' where bookno=vbookno;
end;
/
--�ݳ� ���ν���
--�ݳ��� �������� ���̺� ���Ⱑ�� ���� => Y�� ����
--�ݳ���¥ : sysdate
--����/�ݳ� ������̺�� ����
--����ݳ����̺� �ش� �� ����
--������̺��� ��ü���� ���� �� ȸ������ ���̺� ��üȽ�� 1����
create or replace procedure return_book
    (vbookno book_borrow.bookno%type)
is
    vdue_date manage_borrow.due_date%type;
    vmembno manage_borrow.membno%type;
begin
    update book_info set bstate='Y' where bookno=vbookno;
    update book_borrow set returndate = sysdate where bookno=vbookno;
    insert into manage_borrow select * from book_borrow where bookno=vbookno;
    delete from book_borrow where bookno=vbookno;
    
    select due_date,membno into vdue_date,vmembno from manage_borrow where bookno=vbookno;
    if(vdue_date < sysdate) 
    then update book_member 
    set overdue = overdue+1 
    where vmembno = book_member.membno;
    end if;
end;
/
select * from book_info;
select * from book_member;
/*��Ŭ�������� ���� SQL��
--ȸ������ �޼ҵ�
--�Է�
String sql = "insert into book_member(membno,memname,memdate,phone,email,addr) "
				+ "values('A_'||to_char(sysdate,'yymmdd')||'_'||to_char(member_membno_seq.nextval),"
				+ "?,sysdate,?,?,?)";
--���
String sql1 = "select count(*) from book_member";
String sql2 = "select * from book_member order by membno";

--��ȸ
--(1)ȸ����ȣ�� ��ȸ�ϱ�
String sql = "select * from book_member where membno=?";
--(2)ȸ���̸����� ��ȸ�ϱ�
String sql = "select * from book_member where memname=?";
--����
String sql = "update book_member set phone=?,email=?,"
				+ "addr=? where membno=?";
--����
String sql = "delete from book_member where membno=?";
--������ȸ��
--(1)����ϱ�
String sql1 = "select count(*) from book_member where overdue>10"; 
String sql2 = "select * from book_member where overdue>10";
--(2)Ǯ���ֱ�(ȸ����ȣ���)
String sql = "update book_member set overdue=0 where membno=?";
--ȸ����ȣ�Է��ϸ� ���� �������� �������� ���
String sql1 = "select count(*) from book_borrow where membno=?";
String sql2 = "select * from book_borrow where membno=? order by lendingdate";
*/
/*��������
--�Է�
String sql = "insert into book_info(bookno,bname,bookpart,writer) "
				+ "values('B_'||to_char(sysdate,'yymmdd')||'_'||to_char(book_bookno_seq.nextval)"
				+ ",?,?,?)";
--���
String sql1 = "select count(*) from book_info";
String sql2 = "select * from book_info order by bookno";
--��ȸ
--(1)������ȣ�� ��ȸ�ϱ�
String sql = "select * from Book_Info where bookno=?";
--(2)�����̸����� ��ȸ�ϱ�
String sql1 = "select count(*) from book_info where bname like ?";
String sql2 = "select * from book_info where bname like ? order by bookno";
--����
--(1)���������� �����ϱ�
String sql = "update book_info set bookpart=?,writer=? "
				+ "where bookno=?";
--(2)����Ǹ� ������¸� Y or N���� �����ϱ�
String sql = "update book_info set bstate=? where bookno=?";
--����
String sql = "delete from Book_Info where bookno=?";
*/
/*����ݳ� �޼ҵ�
--�����ϱ�
--���Ⱑ������ üũ(1.������ ���Ⱑ�ɻ���,2.ȸ���� ��üȽ��)
String sql = "select bstate from book_info where bookno=?";
String sql1 = "select overdue from book_member where membno=?";
--���Ⱑ���ϸ� �����ϱ�
cstmt=con.prepareCall("{call borrow_book(?,?)}");
--�ݳ��ϱ�
cstmt=con.prepareCall("{call return_book(?)}");
--����뿩���� ���� ���
String sql1 = "select count(*) from book_borrow";
String sql2 = "select * from book_borrow order by brownum";
*/
/*������̺�޼ҵ�
--��ȸ (�ݳ��� �������� �������)
String sql1 = "select count(*) from manage_borrow";
String sql2 = "select * from manage_borrow order by mgrownum";
--������̺� ������ �ʱ�ȭ(��Ŭ������ �ڵ� Ŀ�Լ����������Ƿ� DELETE�� ���)
String sql1 = "select count(*) from manage_borrow";
String sql2 = "delete from manage_borrow";
*/