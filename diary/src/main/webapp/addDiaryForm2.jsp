<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>

<%
//인증 분기 코드 == login on
	String sql1 = "select my_session mySession from login";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();	
	
	String mySession = null;
	if(rs1.next()){
		mySession = rs1.getString("mySession");
	}
	if(mySession.equals("OFF")){
		String errMsg= URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저 해주세요", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg); // 겟방식으로 보낼수 있음.
		return; // 코드 진행을 끝내는 문법 ex)== 메서드 끝낼때 return 사용
	} 
%>

<%
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
<body>

	<div class="container">
	<div class="row">
	
	<div class="mt-5 col-3 bg-white border shadow bg-body-tertiary rounded" style="text-align:center;">
<!--  	checkDate : <%=checkDate %><br>
	ck: <%=ck%>  --> 
	<h1 class="mt-2">일기쓰기</h1>
	<form method="post" action="/diary/checkDateAction.jsp">
		<div>
			<input type="date" name="checkDate" value="<%=checkDate%>" class=" mb-2">	
			
		</div>
		<div class="d-grid gap-2 col-6 mx-auto"><button type="submit" class="btn btn-primary">날짜중복확인</button></div>
			<span><%=msg%></span>

	</form>
	
	</div>
	<div class="mt-5 col-8 bg-white border shadow bg-body-tertiary rounded">
		
	
	
	<form method="post" action="/diary/addDiaryAction.jsp">
		<div class="mt-5">
			<%
				if(ck.equals("T")){
					
			%>	
					<input type="text" name="diaryDate" value="<%=checkDate%>" readonly="readonly">
			<%
				} else {
			%>
					<input type="text" name="diaryDate" value="" readonly="readonly">
			<%
				}
			%>
		</div>
		
		
		
	<div class="input-group mb-3">
  	<input type="text" class="form-control" placeholder="날짜" name="diaryDate" >
  	<span class="input-group-text"></span>
  	<input type="text" class="form-control" placeholder="title" name="title">
	</div>
		
		<div>
			<select name="weather">
				<option value="맑음">맑음</option>
				<option value="흐림">흐림</option>
				<option value="비">비</option>
				<option value="눈">눈</option>
				
			</select>
		</div>
	
		<div class="form-floating">
  		<textarea class="form-control" placeholder="Leave a comment here" id="content" style="height: 100px"></textarea>
  		<label for="floatingTextarea2	">내용</label>
		</div>
		
		<input type="hidden" name="ck" value="<%=ck%>">
		
		<div>
			<button type="submit">일기등록</button>
		</div>
	</form>
	<div class="col-1"></div>
		</div>
	</div>
	</div>
</body>
</html>