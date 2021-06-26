<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">

.ck.ck-editor {
	max-width: 97%;
} 
.ck-editor__editable {
	min-height: 250px;
}
.ck-content .image>figcaption{
	min-height: 25px;
}
.body-container{
	margin-top: 130px;
}
.table-content tr > td:nth-child(1) {
	width: 100px;
	text-align: center;
	background: #eee;
}
.table-content tr > td:nth-child(2) {
	padding-left: 10px;
}
.table-content input[type=text], .table-content input[type=file], .table-content textarea {
	width: 97%;
}
.btn {
	color:#333;
	font-weight: 500;
	border:1px solid #ccc;
	background-color:#fff;
	text-align:center;
	vertical-align: middle;
	padding:6px 13px;
	border-radius: 3px;
	font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
	cursor: pointer;
}
.btn:active, .btn:focus, .btn:hover {
	background-color:#e6e6e6;
	border-color: #adadad;
	color: #333;
}
.btn[disabled], fieldset[disabled] .btn {
	pointer-events: none;
	cursor: not-allowed;
	filter: alpha(opacity=65);
	-webkit-box-shadow: none;
	box-shadow: none;
	opacity: .65;
}

.btn-dark {
    background: #424951;
	border:1px solid #2f3741;
    color:#fff;
}
.btn-dark:hover, .btn-dark:active, .btn-dark:focus {
    background: #333;
   	border:1px solid #222;
   	color:#fff;
}

.boxTF {
	border:1px solid #999;
	padding:5px 5px 5px;
	border-radius:4px;
	background-color:#fff;
	font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
	vertical-align: middle;
}
.boxTF[readonly] {
	background-color:#eeeeee;
	/* border: none;*/
}
.body-container {
	display: block;
	padding-top: 10px;
}

.body-title {
    color: #424951;
    padding-top: 10px;
    padding-bottom: 5px;
    margin: 0 0 25px 0;
    border-bottom: 1px solid #ddd;
}
.body-title h2 {
    font-size: 23px;
    min-width: 300px;
    font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
    font-weight: bold;
    margin: 0 0 -5px 0;
    padding-bottom: 5px;
    display: inline-block;
    border-bottom: 3px solid #424951;
    
}
.table-content tr > td:nth-child(1) {
	background-color: #afb42b;
}
.selectDate{
	width:95%;
}
</style>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/vendor/ckeditor5/build/ckeditor.js"></script>
<script type="text/javascript">
    function sendOk() {
        var f = document.auctionForm;

    	var str = f.subject.value;
        if(!str) {
            alert("제목을 입력하세요. ");
            f.subject.focus();
            return;
        }
        
        str = window.editor.getData(); // 값 가져오기
        if(! str) {
        	alert("내용을 입력하세요. ");
        	window.editor.focus();
        	return;
        }
        f.content.value = str;

    	f.action="${pageContext.request.contextPath}/auction/${mode}";
        f.submit();
    }
</script>

<div class="container body-container">
	<div class="body-title">
		<h2> 공동구매 글쓰기 </h2>
	</div>
	
	<div class="body-main">
		<form name="auctionForm" method="post">
		<table class="table table-border table-content">
			<tr> 
				<td>작성자</td>
				<td> 
					${sessionScope.member.userName}
				</td>
			</tr>
			<tr>
				<td>제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
				<td> 
					<input type="text" name="subject" maxlength="100" class="boxTF" value="${dto.subject}">
				</td>
			</tr>
			<tr>
				<td>가&nbsp;&nbsp;&nbsp;&nbsp;격</td>
				<td> 
					<input type="text" name="price" class="boxTF" value="${dto.price}">
				</td>
			</tr>
			
			<tr>
				<td>시&nbsp;작&nbsp;일</td>
				<td class="selectDate table-content"> 
					<input type="date" name="startDate" class="boxTF" value="${dto.startDate}" style="width:97%;">
				</td>
			</tr>
			
			<tr>
				<td>종&nbsp;료&nbsp;일</td>
				<td class="selectDate table-content"> 
					<input type="date" name="endDate" class="boxTF" value="${dto.endDate}" style="width:97%;">
				</td>
			</tr>
			
			<tr> 
				<td valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
				<td valign="top"> 
					<div id="editor">${dto.content}</div>
					<input type="hidden" name="content">
				</td>
			</tr>
		</table>	
		
		<table class="table">
			<tr> 
				<td align="center">
					<button type="button" onclick="sendOk();" class="btn btn-dark">${mode=='update'?'수정완료':'등록하기'}</button>
					<button type="reset" class="btn">다시입력</button>
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/auction/list';">${mode=='update'?'수정취소':'등록취소'}</button>
						<c:if test="${mode=='update'}">
							<input type="hidden" name="num" value="${dto.num}">
							<input type="hidden" name="page" value="${page}">
						</c:if>
				</td>
			</tr>
		</table>
		
		</form>
	</div>
	
<script type="text/javascript">
ClassicEditor
.create( document.querySelector( '#editor' ), {
	toolbar: {
		items: [
			'heading', '|',
			'bold', 'italic', 'link', 'alignment', 'bulletedList', 'numberedList', '|',
			'outdent', 'indent', '|',
			'imageUpload', 'blockQuote', 'insertTable', 'mediaEmbed', 'htmlEmbed', 'undo', 'redo'
		]
	},
	image: {
		toolbar: [
            'imageStyle:full',
            'imageStyle:side',
            '|',
            'imageTextAlternative'
        ],

        // The default value.
        styles: [
            'full',
            'side'
        ]
	},
	language: 'ko',
	ckfinder : {
		uploadUrl : '${pageContext.request.contextPath}/acimage/upload' // 업로드 URL. POST로 감
	}
} )
.then( editor => {
	window.editor = editor;
} )
.catch( error => {
	console.error( error );
} );

</script>
	
</div>