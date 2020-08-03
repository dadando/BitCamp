<%@ page language="java" contentType="text/html; charset=utf-8"%>
<meta charset="utf-8">

<%
String bno = request.getParameter("bno");
%>
<!-- 댓글 처리  추가  시작  -->
    <!--  댓글  -->
    <div>
        <label for="content">comment</label>
        <form name="commentInsertForm">
            <div>
               <input type="hidden" name="bno" value="<%=bno %>"/>
               <input type="text" id="content" name="content" placeholder="내용을 입력하세요.">
               <span>
                    <button type="button" name="commentInsertBtn">등록</button>
               </span>
            </div>
        </form>
    </div>
    
    <div>
        <div class="commentList"></div>
    </div>
</div>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>

$('[name=commentInsertBtn]').click(function(){ //댓글 등록 버튼 클릭시 
    var insertData = $('[name=commentInsertForm]').serialize(); //commentInsertForm의 내용을 가져옴
    commentInsert(insertData); //Insert 함수호출(아래)
});

var bno = <%=bno %>; // 게시판 글내용

//댓글 목록 
function commentList(){
	$.ajax({
        url : '/mb2replay/comment_list.bo',
        type : 'post',
        data : {'bno':bno},
        dataType : 'json',
        contentType : 'application/x-www-form-urlencoded; charset=utf-8',
        success : function(data){
            var a =''; 
            $.each(data, function(key, value){ 
                a += '<div class="commentArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
                a += '<div class="commentInfo'+value.cno+'">'+'댓글번호 : '+value.cno+' / 작성자 : '+value.writer + '&nbsp;&nbsp;';
                a += '<a href="#" onclick="commentUpdateForm('+value.cno+',\''+value.content+'\');">수정</a> ';
                a += '<a href="#" onclick="commentDelete('+value.cno+');">삭제</a> </div>';
                a += '<div class="commentContent'+value.cno+'"> <p> 내용 : '+value.content +'</p>';
                a += '</div></div>';
            });
            
            $(".commentList").html(a);
        },
    	error:function(){
        	alert("ajax통신 실패(list)!!!");
    	}
    });
}
 
//댓글 등록
function commentInsert(insertData){
    $.ajax({
        url : '/mb2replay/comment_insert.bo',
        type : 'POST',
        data : insertData,
        success : function(data){
            if(data == 1) {
                commentList(); //댓글 작성 후 댓글 목록 reload
                $('[name=content]').val('');
            }
        },
    	error:function(){
        	alert("ajax통신 실패(insert)!!!");
    	}
    });
}
 
//댓글 수정 - 댓글 내용 출력을 input 폼으로 변경 
function commentUpdateForm(cno, content){
    var a ='';
    
    a += '<div>';
    a += '<input type="text" name="content_'+cno+'" value="'+content+'"/>';
    a += '<span ><button type="button" onclick="commentUpdate('+cno+');">수정</button> </span>';
    a += '</div>';
    
    $('.commentContent'+cno).html(a);
    
}
 
//댓글 수정
function commentUpdate(cno){
    var updateContent = $('[name=content_'+cno+']').val();
    
    $.ajax({
        url : '/mb2replay/comment_update.bo',
        type : 'post',
        data : {'content' : updateContent, 'cno' : cno},
        success : function(data){
            if(data == 1) commentList(bno); //댓글 수정후 목록 출력 
        },
    	error:function(){
        	alert("ajax통신 실패(update)!!!");
    	}
    });
}
 
//댓글 삭제 
function commentDelete(cno){
    $.ajax({
        url : '/mb2replay/comment_delete.bo?cno='+cno,
        type : 'post',
        success : function(data){
            if(data == 1) 
            	commentList(bno); //댓글 삭제후 목록 출력 
        },
    	error:function(){
        	alert("ajax통신 실패(delete)!!!");
    	}
    });
}
 
$(document).ready(function(){
    commentList(); //페이지 로딩시 댓글 목록 출력 
});

</script> 
<!-- 댓글 처리  추가  끝  -->
