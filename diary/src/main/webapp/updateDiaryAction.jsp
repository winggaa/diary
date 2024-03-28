<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
String content = request.getParameter("content");
String weather = request.getParameter("weather");
String diaryDate = request.getParameter("diaryDate");
String title = request.getParameter("title");


System.out.println(content +" 수정내용");
System.out.println(weather+ " 수정날씨");
System.out.println(diaryDate+"날짜는 수정안됨");
System.out.println(title+"수정제목");

//db 연결
	String sql1 ="UPDATE diary . diary SET title=? , weather=? , content=? , update_date= now() WHERE diary_date=?";
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1, title);
	stmt1.setString(2, weather);
	stmt1.setString(3, content);
	stmt1.setString(4, diaryDate);
	System.out.println(stmt1);
	rs1 = stmt1.executeQuery();
	
	response.sendRedirect("/diary/diaryOne.jsp?diaryDate="+diaryDate);
	
	

%>
