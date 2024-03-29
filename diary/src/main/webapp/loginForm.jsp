<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
  /* 
	// 0. 로그인(인증) 분기 db 버전 
	// diary.login.my_session => 'ON' => redirect("diary.jsp")
	String sql1 = "select my_session mySession from login";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	String mySession = null;
	if(rs1.next()) {
		mySession = rs1.getString("mySession");
	}
	if(mySession.equals("ON")) {
		response.sendRedirect("/diary/diary.jsp");
		return; // 코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return사용
	}
	
	*/
	// 0-1) 로그인(인증) 분기 session사용으로 변경
	// 로그인 성공시 세션에 loginMember라는 변수를 만들고 값으로 로그인 아이디를 저장
	String loginMember = (String)(session.getAttribute("loginMember"));
	
	//사용되는 api
	// session.getAttribute(String) : 변수이름으로 변수값을 반환하는 메서드
	// session.getAttribute() 찾는 변수가 없으면 null 값을 반환한다
	// null이면 로그아웃상태이고, null이 아니면 로그인 상태
	// System.out.println(loginMember + "<-- 로그인멤버");
	
	if(loginMember != null) {
		response.sendRedirect("/diary/loginAction.jsp");
	}
	// 1. 요청값 분석 
	String errMsg = request.getParameter("errMsg");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>

	<div class="container" >
		<div class="row">
			<div class=col-2></div>
		<div class="mt-5 col-3 bg-white border shadow bg-body-tertiary rounded" style="height: 675px; text-align: center;">
			
			<h1 class="mt-5" style="height: 200px;">Diary</h1>		
			<form method="post" action="/diary/loginAction.jsp">
			
			<div class="mb-3 bg-body-tertiary rounded"><input type="text" name="memberId" placeholder="login" class="form-control border-success"></div>
			<div><input type="password" name="memberPw" placeholder="비밀번호" class="mb-3 form-control border-success"></div>
			<div class="d-grid gap-2 col-6 mx-auto"><button type="submit" class="btn btn-primary">로그인</button></div>
			<div>
		<%
			if(errMsg != null) {
		%>
				<%=errMsg%>
		<%		
			}
		%>
			</div>
		</div> 
			
			
			
			         
			<div class="mt-5 col-6 opacity-75 border-start-0 shadow" style=background-image:url(/diary/img/img4.jpg);background-repeat:no-repeat;background-size:100%100%;></div>
			<div class=col-1></div>
	
		</form>
	
	
	
		
	</div>
</div>


</body>
</html>