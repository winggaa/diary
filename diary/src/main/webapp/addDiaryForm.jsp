<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import = "java.util.*" %>


<%
//인증 분기 코드 == login on
	
String loginMember = (String)(session.getAttribute("loginMember"));
	
	if(loginMember == null 	){
		
	String errMsg= URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저 해주세요", "utf-8");
	response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg); // 겟방식으로 보낼수 있음.
	return; // 코드 진행을 끝내는 문법 ex)== 메서드 끝낼때 return 사용
	}
	
	
	
%>

<%
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");

	String checkDate = request.getParameter("checkDate");
	// null 값을 공백으로 바꿈.
	if(checkDate == null){
		checkDate = "";
	}
	String ck = request.getParameter("ck");
	if (ck == null) {
		ck = "";
	}
	String msg = "";
	
		if(ck.equals("T")){
			msg = "입력가능한 날자입니다.";
		} else if(ck.equals("F")){
			msg = "다른 일기가 이미 존재하고 있습니다.";
		}
	
%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<title>addDiaryForm</title>
</head>
<body style=background-image:url(/diary/img/img4.jpg);background-repeat:no-repeat;background-attachment:fixed;background-size:100%100%; class="opacity-100" >

	<div class="container">
	<div class="row">
	
	<div class="mt-5 col-3 bg-white border shadow bg-body-tertiary rounded" style="text-align:center;">
<!--  	checkDate : <%=checkDate %><br>
	ck: <%=ck%>  --> 
	<h1 class="mt-2">일기작성</h1>
	<form method="post" action="/diary/checkDateAction.jsp" style ="margin-top: 370px">
		<div>
			<input type="date" name="checkDate" value="<%=checkDate%>" class=" mb-2">	
			
		</div>
		
		
		<div class="d-grid gap-2 col-6 mx-auto "><button type="submit" class="btn btn-primary" >날짜중복확인</button></div>
			<span><%=msg%></span>

	</form>
	
	</div>
	<div class="mt-5 col-8 bg-white border shadow bg-body-tertiary rounded" >
		
	
	<div class="d-flex justify-content-end mt-3">
				<a href="./diary.jsp"><button type="button" class="btn-close" aria-label="Close"></button></a>
				</div>
	<form method="post" action="/diary/addDiaryAction.jsp">	
		<div class="mt-5">
			<%
				if(ck.equals("T")){
					
			%>	
					<div class="input-group mb-3">
				  	<input type="text" class="form-control" placeholder="날짜" name="diaryDate" value="<%=checkDate%>" readonly="readonly">
  					<span class="input-group-text"></span>
  					<input type="text" class="form-control" placeholder="제목" name="title">
					</div>
			<%
				} else {
			%>
					<div class="input-group mb-3">
  					<input type="text" class="form-control" placeholder="날짜" name="diaryDate" value="<%=checkDate%>" readonly="readonly">
  					<span class="input-group-text"></span>
  					<input type="text" class="form-control" placeholder="title" name="title">
	</div>
			<%
				}
			%>
		</div>
		
		
		<div>
			<input type="radio" name="feeling" value="&#128512;">&#128512;
			<input type="radio" name="feeling" value="&#128545;">&#128545;
			<input type="radio" name="feeling" value="&#128547;">&#128547;
			<input type="radio" name="feeling" value="&#128561;">&#128561;
			<input type="radio" name="feeling" value="&#128565;">&#128565;
			<input type="radio" name="feeling" value="&#128567">&#128564;
		</div>	
	
		
		<div>
			<select name="weather" class="form-select mb-2">
				<option value="맑음">맑음</option>
				<option value="흐림">흐림</option>
				<option value="비">비</option>
				<option value="눈">눈</option>
				
			</select>
		</div>
	
		<div class="form-floating">
  		<textarea class="form-control" name="content" style="height: 300px"></textarea>
  		<label for="floatingTextarea2">내용</label>
		</div>

		<input type="hidden" name="ck" value="<%=ck%>">
		<div class="mt-3 mb-3" >
			<button type="submit">일기등록</button>
		</div>
	</form>
	<div class="col-1"></div>
		</div>
	</div>
	</div>
</body>
</html>