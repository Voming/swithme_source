<link href="<%=request.getContextPath()%>/resources/css/basic/reset.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/basic/core.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/basic/layout.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/basic/footer.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/basic/header.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/board/boardwrite.css" rel="stylesheet">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <div class="wrapper">
        <div class="wrap-header">
           <%@include file="/WEB-INF/views/basic/header.jsp"%>
        </div>
        
        <div class="wrap-body">
        	<div class="boardwrite">
        		<p>게시글 작성</p>
        	</div>
        	<form id="form-write" method="post" action="insert.no">
			
					<ul class="write">
						<li>
							<div><p>제목</p></div>
							<div><input type="text" name="title" placeholder="제목을 입력하시오." required></div>
						</li>
						<li>
							<div class="txt-content"><p>내용</p></div>
							<div><textarea name="content" cols="80" rows="25" placeholder="내용을 입력하시오." required></textarea></div>
						</li>	
						
					</ul>		
				
				<div class="btn">
					<div><button type="button" class="btn write">등록</button></div>
					<div><button type="button" class="btn esc">취소</button></div>
					<div><button type="button" class="btn board">목록</button></div>
				</div>
			</form>	    		
        </div>
	</div>

    <div class="wrap-footer">
      <%@include file="/WEB-INF/views/basic/footer.jsp"%>
    </div>
</body>
</html>