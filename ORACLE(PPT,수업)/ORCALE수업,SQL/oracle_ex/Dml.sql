--대출 프로시저
--대출날짜 : sysdate/ 반납기한 : sysdate+3
--대출시=> 도서정보테이블 대출가능상태 N 으로 변경
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
--반납 프로시저
--반납시 도서정보 테이블 대출가능 상태 => Y로 변경
--반납날짜 : sysdate
--대출/반납 백업테이블로 복사
--대출반납테이블 해당 행 삭제
--백업테이블에서 연체인지 비교한 뒤 회원정보 테이블에 연체횟수 1증가
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
/*이클립스에서 사용된 SQL문
--회원정보 메소드
--입력
String sql = "insert into book_member(membno,memname,memdate,phone,email,addr) "
				+ "values('A_'||to_char(sysdate,'yymmdd')||'_'||to_char(member_membno_seq.nextval),"
				+ "?,sysdate,?,?,?)";
--출력
String sql1 = "select count(*) from book_member";
String sql2 = "select * from book_member order by membno";

--조회
--(1)회원번호로 조회하기
String sql = "select * from book_member where membno=?";
--(2)회원이름으로 조회하기
String sql = "select * from book_member where memname=?";
--수정
String sql = "update book_member set phone=?,email=?,"
				+ "addr=? where membno=?";
--삭제
String sql = "delete from book_member where membno=?";
--사용금지회원
--(1)출력하기
String sql1 = "select count(*) from book_member where overdue>10"; 
String sql2 = "select * from book_member where overdue>10";
--(2)풀어주기(회원번호사용)
String sql = "update book_member set overdue=0 where membno=?";
--회원번호입력하면 현재 대출중인 도서정보 출력
String sql1 = "select count(*) from book_borrow where membno=?";
String sql2 = "select * from book_borrow where membno=? order by lendingdate";
*/
/*도서정보
--입력
String sql = "insert into book_info(bookno,bname,bookpart,writer) "
				+ "values('B_'||to_char(sysdate,'yymmdd')||'_'||to_char(book_bookno_seq.nextval)"
				+ ",?,?,?)";
--출력
String sql1 = "select count(*) from book_info";
String sql2 = "select * from book_info order by bookno";
--조회
--(1)도서번호로 조회하기
String sql = "select * from Book_Info where bookno=?";
--(2)도서이름으로 조회하기
String sql1 = "select count(*) from book_info where bname like ?";
String sql2 = "select * from book_info where bname like ? order by bookno";
--수정
--(1)도서정보를 수정하기
String sql = "update book_info set bookpart=?,writer=? "
				+ "where bookno=?";
--(2)예약되면 대출상태를 Y or N으로 변경하기
String sql = "update book_info set bstate=? where bookno=?";
--삭제
String sql = "delete from Book_Info where bookno=?";
*/
/*대출반납 메소드
--대출하기
--대출가능한지 체크(1.도서의 대출가능상태,2.회원의 연체횟수)
String sql = "select bstate from book_info where bookno=?";
String sql1 = "select overdue from book_member where membno=?";
--대출가능하면 대출하기
cstmt=con.prepareCall("{call borrow_book(?,?)}");
--반납하기
cstmt=con.prepareCall("{call return_book(?)}");
--현재대여중인 도서 출력
String sql1 = "select count(*) from book_borrow";
String sql2 = "select * from book_borrow order by brownum";
*/
/*백업테이블메소드
--조회 (반납된 도서들의 반출장부)
String sql1 = "select count(*) from manage_borrow";
String sql2 = "select * from manage_borrow order by mgrownum";
--백업테이블 데이터 초기화(이클립스가 자동 커밋설정되있으므로 DELETE문 사용)
String sql1 = "select count(*) from manage_borrow";
String sql2 = "delete from manage_borrow";
*/