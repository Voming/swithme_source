<!-- reset.css -->
<link
	href="${pageContext.request.contextPath}/resources/css/basic/reset.css"
	rel="stylesheet">
<!-- 레이아웃 설정 -->
<link
	href="${pageContext.request.contextPath}/resources/css/basic/core.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/basic/layout.css"
	rel="stylesheet">

<link
	href="${pageContext.request.contextPath}/resources/css/basic/header.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/basic/footer.css"
	rel="stylesheet">
<!-- 그룹 만들기 레이아웃 -->
<link
	href="${pageContext.request.contextPath}/resources/css/group/groupcreate.css"
	rel="stylesheet">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SWITH.ME</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
	<script>
$(loadedHandler);

function loadedHandler() {
	$(".btn.open").on("click", btnOpenClickHandler);
	$(".btn.create").on("click", btnCreateClickHandler);
}
function btnOpenClickHandler(){
	if($(this).val() == "open"){
		$(".dpwd").hide();

		$(".dpwd").remove();
	}else {
		var htmlVal = `<div class="dpwd"><p>비밀번호</p>
			<input type="text" name="groupPwd" placeholder="숫자로 된 비밀번호를 입력하세요" required /></div>`;
		
		$(".wrap-open").after(htmlVal);  
	}	
	var isOpen = $('input[type=radio]:checked').val();
	console.log(isOpen);
}

function btnCreateClickHandler(){
	console.log("들어옴");
	if ($("[name=groupName]").val().trim().length == 0) {
		alert("빈칸만 입력할 수 없습니다. 그룹명을 작성해주세요");
		return;
	}
	if ($("[name=groupPwd]").length > 0){
		if ($("[name=groupPwd]").val().trim().length == 0) {
			alert("빈칸만 입력할 수 없습니다. 비밀번호를 작성해주세요");
			return;
		} 
	}

	var frm = document.getElementsByClassName("frm-create");
	console.log(frm[0]);
	frm[0].method = "post"; //content길이가 길 예정 한글 3, 영문자 1 바이트
	frm[0].action = "${pageContext.request.contextPath}/group/create";
	frm[0].enctype = "multipart/form-data";   //form 태그 내부에 input type="file"이 있다면 
	frm[0].submit(); //값을 보내야 controller에서 인식함
}

</script>
	<div class="wrapper">
		<div class="wrap-header">
			<header>
				<%@include file="/WEB-INF/views/basic/header.jsp"%>
				<div class="bn">
					<div class="nav2-wrap">
						<ul>
							<li><a href="${pageContext.request.contextPath}/myrecord">나의기록</a></li>
							<li><a class="active"
								href="${pageContext.request.contextPath}/group">그룹</a></li>
							<li><a href="#">랭킹</a></li>
							<li><a href="${pageContext.request.contextPath}/board">커뮤니티</a></li>
							<li><a
								href="${pageContext.request.contextPath}/testcalendar">시험달력</a></li>
						</ul>
					</div>
				</div>
				<div class="hrline">
					<hr>
					[[${loginInfo}]]
				</div>
			</header>
		</div>
		<div class="wrap-body">
			<div class="wrap-create">
				<div class="gname">
					<P>그룹 만들기</P>
				</div>
				<div>
					<form class="frm-create">
						<div><p>그룹명</p>
							<input type="text" name="groupName" placeholder="그룹명을 입력하세요" required />
						</div>
						<div class="wrap-open">
							<label>공개</label> 
							<input type="radio" name="groupOpen" value="open" class="btn open" checked="checked"> 
							<label>비공개</label>
							<input type="radio" name="groupOpen" value="close" class="btn open">
						</div>
						<div>
							<p>그룹 설명</p>
							<textarea rows="20" name="groupExp" placeholder="그룹 설명을 입력하세요(ex. 공부 목적, 규칙 등)"></textarea>
						</div>
						<div>
							<p>그룹 대표 이미지</p>
							<input type="file" name="uploadfile" required />
						</div>	
						<div class="wbtn">
							<button type="button" class="btn create">그룹 만들기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="wrap-footer">
		<%@include file="/WEB-INF/views/basic/footer.jsp"%>
	</div>
</body>
</html>