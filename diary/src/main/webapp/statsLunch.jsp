<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
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
	/*
	SELECT menu,COUNT(*) FROM lunch
	WHERE year(lunch_date) = 2024 
	GROUP BY menu ORDER BY COUNT(*) DESC;
	*/
	String sql2 = "select menu, count(*) cnt from lunch  group by menu";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	rs2 = stmt2.executeQuery();
%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<h1>statsLunch</h1>
	<%
	int maxHeight = 300;
	double totalCnt = 0;
	while(rs2.next()){
		totalCnt = totalCnt + rs2.getInt("cnt");
		
	}
	rs2.beforeFirst();
	%>
	<div>
		전체 투표수 : <%=(int)totalCnt %>
	</div>

	<table border="1" style="width: 400px">
		<tr>
		
			<% 
			String[] c = {"#FF0000", "#000000", "#FFE400", "#1DDB16", "#0054FF"};
			int i = 0;
			while(rs2.next()){
				int h = (int)(maxHeight * (rs2.getInt("cnt")/totalCnt));	
			%>
		
			<td style="vertical-align:bottom;">
				<div style= "height:<%=h%>px; background-color:<%=c[i]%>;text-align: center">
				<%=rs2.getInt("cnt")%>
				</div>
			</td>
		<%
			i = i+1;
			System.out.println(i +"<-- i");
			} rs2.beforeFirst();
		%>
			</tr>
			<tr>
			<%
				while(rs2.next()){
			%>
			<td><%=rs2.getString("menu") %></td>
			<%		
				}
			%>
		</tr>
		
		
	</table>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</body>
</html>