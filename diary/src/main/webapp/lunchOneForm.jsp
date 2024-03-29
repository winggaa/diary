<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%

// 로그인 (인증)

Class.forName("org.mariadb.jdbc.Driver");
Connection conn = null;
conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");


	String loginMember = (String)(session.getAttribute("loginMember"));

if(loginMember == null 	){
	
	String errMsg= URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저 해주세요", "utf-8");
	response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg); // 겟방식으로 보낼수 있음.
	return; // 코드 진행을 끝내는 문법 ex)== 메서드 끝낼때 return 사용
}
%>

<% 
String checkVoteDate = request.getParameter("checkVoteDate");
String sql2 ="select * from lunch where lunch_date = ?";
PreparedStatement stmt2 = null;
ResultSet rs2 = null;
stmt2 = conn.prepareStatement(sql2);
System.out.println(stmt2);
stmt2.setString(1, checkVoteDate);
rs2 = stmt2.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	
</head>
<body style=background-image:url(/diary/img/img4.jpg);background-repeat:no-repeat;background-attachment:fixed;background-size:100%100%; class="opacity-100" >
<div class="container">
<div class="row">
		<div class="col mt-5 bg-white border shadow p-3 mb-5 bg-body-tertiary rounded">
	<%while(rs2.next()){
	
		%>
			
			<table class="table table-hover table-bordered">
			<tr>
				<td><%=rs2.getString("menu")%></td>
			</tr>
			<tr>
				<td><%=rs2.getString("lunch_date")%></td>
			</tr>
			
			<tr>
			<td><%=rs2.getString("update_date")%></td>
			</tr>
			
			<tr>
			<td><%=rs2.getString("create_date")%></td>
			</tr>
			<%} %>
			</table>
			
			<a href="/diary/deleteLunch.jsp?checkVoteDate=<%=checkVoteDate%>">삭제버튼</a>
		</div>				
</div>
</div>


</body>
</html>