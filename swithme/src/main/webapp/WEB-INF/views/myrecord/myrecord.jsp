<link
	href="${pageContext.request.contextPath}/resources/css/myrecord/myrecord.css"
	rel="stylesheet">
<jsp:include page="/WEB-INF/views/common/links_file.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!--부트스트랩  -->
<jsp:include page="/WEB-INF/views/common/common_function.jsp" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<!-- jQuery 선언 -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<!-- 풀캘린더 CDN -->
<script
	src="
https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js
"></script>
<script>
	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');
		var calendar = new FullCalendar.Calendar(calendarEl, {
			initialView : 'dayGridMonth'
		});
		calendar.render();
	});
</script>
<!--chart.js CDN  -->

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


<title>SWITH.ME</title>
</head>
<body>
	<div class="wrapper">
		<div class="wrap-header">
			<header>
				<%@include file="/WEB-INF/views/basic/header.jsp"%>
				<div class="bn">
					<div class="nav2-wrap">
						<ul>
							<li><a class="active"
								href="${pageContext.request.contextPath}/myrecord">나의기록</a></li>
							<li><a href="${pageContext.request.contextPath}/group">그룹</a></li>
							<li><a href="#">랭킹</a></li>
							<li><a href="${pageContext.request.contextPath}/board">커뮤니티</a></li>
							<li><a href="#">시험달력</a></li>
						</ul>
					</div>
				</div>
				<div class="hrline">
					<hr>
				</div>
			</header>
		</div>
		<c:choose>
			<c:when test="${empty loginInfo }">
				<div class="wrap-welcome">
					<div class="check-login">
						<button type="button" class="btn join"
							onclick="location.href='${pageContext.request.contextPath}/join'">회원가입</button>
						<button type="button" class="btn login"
							onclick="location.href='${pageContext.request.contextPath}/login'">로그인</button>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="wrap-body">
					<div class="wrap-main">
						<!-- 내가 할 곳 -->
						<div class="timer box">
							<div class="study-info">
								<ul class="sujblsit">
									<li class="mem-id"><p>MEM_ID</p></li>
									<li>
										<div id="today">today</div>
										<div id="currentTime">currentTime</div>

									</li>
									<!-- 과목수에 따라 li 생성후 붙여넣기 -->
									<c:forEach items="${sublist}" var="vo" varStatus="vs">
										<li>
										<c:choose>
												<c:when test="${empty vo.subjectName}">
													<div>
														<p>총 공부시간</p>
													</div>
												</c:when>
												<c:otherwise>
													<div id="subId" class="${vo.subjectName}">${vo.subjectName}</div>
												</c:otherwise>
											</c:choose> <c:choose>
												<c:when test="${empty vo.difftime}">
													<div>
														<p>00:00:00</p>
													</div>
												</c:when>
												<c:otherwise>
													<div>${vo.difftime}</div>
												</c:otherwise>
											</c:choose>
											</li>
									</c:forEach>

								</ul>
								<div class="btnGroup">
									<button type="button" id="start" class="btn start">
										<P>시작</P>
									</button>
									<button type="button" disabled="true" id="stop"
										class="btn stop">
										<p>종료</p>
									</button>
								</div>
							</div>
							<div class="study-countdown-box">
								<div class="study-countdown">
									<div>
										<p id="selSub">과목명</p>
									</div>
									<div>
										<p id="countdown">00:00:00</p>
									</div>
								</div>
							</div>
						</div>
						<div class="subject-modal">
							<!-- TODO 과목 수정 -->
							<div>
								<button type="button" class="btn re-sub btn-primary"
									data-bs-toggle="modal" data-bs-target="#staticBackdrop">
									<p>과목 수정하기</p>
								</button>
								<!-- Modal -->
								<div class="modal fade" id="staticBackdrop"
									data-bs-backdrop="static" data-bs-keyboard="false"
									tabindex="-1" aria-labelledby="staticBackdropLabel"
									aria-hidden="true">
									<div class="modal-dialog modal-dialog-centered">
										<div class="modal-content">
											<div class="modal-header">
												<h1 class="modal-title fs-5" id="staticBackdropLabel">과목
													수정</h1>
												<button type="button" class="btn-close"
													data-bs-dismiss="modal" aria-label="Close"></button>
											</div>
											<div class="modal-body">...</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-bs-dismiss="modal">취소</button>
												<button type="button" class="btn btn-primary">완료</button>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- 과목추가 -->
							<div>
								<!-- Modal -->
								<button type="button" class="btn add-sub" data-bs-toggle="modal"
									data-bs-target="#exampleModal2">
									<p>과목 추가하기</p>
								</button>

								<!-- Modal -->
								<div class="add-sub modal" id="exampleModal2">
									<div class="modal-dialog .modal-dialog-centered">
										<div class="modal-content">
											<div class="btn modal-close" data-bs-dismiss="modal">x</div>
											<!-- controller 추가 -->
											<form id="frm-add">
												<div class="subject ">
													<p class="title">추가할 과목 이름</p>
												</div>
												<div class="add-name">
													<input type="text" name="subName"
														placeholder="     e.g 자바, 파이썬, SQL">
												</div>
												<div class="sub-color">
													<p>과목 색상</p>
													<select name="selectColor">
														<option value="1">핑크</option>
														<option value="2">노랑</option>
														<option value="3">초록</option>
														<option value="4">파랑</option>
														<option value="5">보라</option>
													</select>
												</div>
												<button class="btn" type="button" data-bs-dismiss="modal">
													<p>취소</p>
												</button>
												<button type="submit" class="btn done">
													<p>완료</p>
												</button>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div calss="sub-title">
							<p>출석</p>
						</div>
						<div id='calendar' class="study-calender"></div>
						<div class="statistics-part">
							<div calss="sub-title">
								<p>통계</p>
							</div>
							<canvas id="myChart"></canvas>
							<script>
								var data = {
									labels : [ 'January', 'February', 'March',
											'April', 'May', 'June', 'July' ],
									datasets : [ {
										label : 'My First Dataset',
										backgroundColor : 'rgb(255, 99, 132)',
										borderColor : 'rgb(255, 99, 132)',
										data : [ 0, 10, 5, 2, 20, 30, 45 ]
									} ]
								};

								// 그래프 옵션
								var options = {
									scales : {
										yAxes : [ {
											ticks : {
												beginAtZero : true
											}
										} ]
									}
								};

								// 그래프 생성
								var ctx = document.getElementById('myChart')
										.getContext('2d');
								var myChart = new Chart(ctx, {
									type : 'doughnut',
									data : data,
									options : options
								});
							</script>
						</div>
					</div>
				</div>
			</c:otherwise>
		</c:choose>

	</div>
	<div class="wrap-footer">
		<%@include file="/WEB-INF/views/basic/footer.jsp"%>
	</div>
	<script type="text/javascript">
		$(loadedHandler);
		function loadedHandler() {
			$("#start").on("click", startClickHandler);
			$("#stop").on("click", stopClickHandler);

			$("#today").ready(function() {
				todayHandler();
			});

			$("#currentTime").ready(function() {
				currentTimeHandler();
				setInterval(currentTimeHandler, 1000);
			});

			/* 과목  추가하기 */
			$(".btn.done").on("click", btnAddSubjectClickHandler);
			
		}
		
		 function ready() {
			   alert('DOM이 준비되었습니다!');
				$("#subId").on("click",subIdClickHandler);
		 }
	    document.addEventListener("DOMContentLoaded", ready);
		
		function subIdClickHandler(){
			var tagId = $(this).attr('class');
			alert(tagId);
			
		}
		// 과목 추가하기  
		function btnAddSubjectClickHandler() {
			console.log($("#frm-add").serialize());
			var frm = document.getElementById("frm-add");
			frm.method = "post";
			frm.action = "${pageContext.request.contextPath}/addsubject";
			frm.submit();
		}

		let intervalCountdownID;
		let startTime;
		let endTime;
		let diffMSec;
		let diffMin;
		let diffHour;
		let diffTime;

		// 10보다 작은 값에 0을 붙임
		function addZero(n) {
			return n < 10 ? '0' + n : n;
		}
		// 현재 시간을 리턴
		function getCurrentDate() {
			var currentDate = new Date();
			return currentDate.getFullYear().toString()
					+ addZero(currentDate.getMonth() + 1)
					+ addZero(currentDate.getDate())
					+ addZero(currentDate.getHours())
					+ addZero(currentDate.getMinutes())
					+ addZero(currentDate.getSeconds());
		}

		function startClickHandler() {
			startTime = new Date();
			intervalCountdownID = setInterval(intervalCountdownCb, 1000, "p1",
					"p2");

			//버튼 활성화
			$("#start").attr("disabled", true);
			$("#stop").attr("disabled", false);

		}
		function stopClickHandler() {
			endTime = new Date();

			console.log("멈춰!!!");
			clearInterval(intervalCountdownID);

			//버튼 활성화
			$("#start").attr("disabled", false);
			$("#stop").attr("disabled", true);

			var timeData = {
				startTime : startTime,
				endTime : endTime
			};

			console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
			console.log(startTime);
			console.log(endTime);
			console.log(getCurrentDate());

			$.ajax({
				type : "post",
				url : "${pageContext.request.contextPath}/addrecord.ajax",
				data : timeData,
				error : ajaxErrorHandler,
				success : function(result) {
					console.log("성공");

				}
			});
		}
		/* 시간 계산 setInterval 사용 */
		function intervalCountdownCb() {
			nowTime = new Date();
			/* 
			diffMSec = nowTime.getTime() - startTime.getTime();
			diffHour = Math.floor(diffMSec / (60 * 60 * 1000));
			diffMin = Math.floor(diffMSec / (60 * 1000));
			 */
			diffMSec = nowTime.getTime() - startTime.getTime();
			diffSec = diffMSec / 1000;
			diffHour = Math.floor(diffSec / (60 * 60));
			diffMin = Math.floor(diffSec / 60 - diffHour * 60);
			diffMSec = Math.floor(diffSec - diffMin * 60 - diffHour * 60 * 60);

			if (diffMSec < 10) {
				diffMSec = '0' + diffMSec;
			}
			if (diffHour < 10) {
				diffHour = '0' + diffHour;
			}
			if (diffMin < 10) {
				diffMin = '0' + diffMin;
			}

			diffTime = diffHour + ":" + diffMin + ":" + diffMSec;
			$("#countdown").text(diffTime);

			/* 확인용 */
			console.log(diffHour + ":" + diffMin + ":" + diffMSec);

		}

		/* 날짜 표현하기 */
		function todayHandler() {
			var time = new Date();
			console.log("time : " + time.toDateString());
			var month = time.getMonth() + 1;
			var date = time.getDate();
			var day = time.getUTCDay();
			var day2 = time.getDay();
			var week;
			console.log(typeof 0);
			console.log("getDay : " + day2);

			switch (day2) {
			case 0:
				week = '일요일';
				break;
			case 1:
				week = '월요일';
				break;
			case 2:
				week = '화요일';
				break;
			case 3:
				week = '수요일';
				break;
			case 4:
				week = '목요일';
				break;
			case 5:
				week = '금요일';
				break;
			case 6:
				week = '토요일';
				break;
			}
			var today = month + "월 " + date + "일 " + week;
			$("#today").text(today);

		}

		function currentTimeHandler() {
			var time = new Date();
			var localTime = time.toLocaleTimeString();
			$("#currentTime").text(localTime);

		}

		/* today(); */
	</script>
</body>
</html>