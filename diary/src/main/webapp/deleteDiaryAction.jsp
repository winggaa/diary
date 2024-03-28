<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>

<%/*

	String diaryDate = request.getParameter("diaryDate");	

	String sql1 = "delete from diary where diary_date=?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1, diaryDate);
	int row = stmt1.executeUpdate();
   	System.out.println(row);
   	response.sendRedirect("./diary.jsp?checkDate="+diaryDate); 
   	*/
%>
   
   <%
   String diaryDate = request.getParameter("diaryDate");
   System.out.println(diaryDate +"<--diaryDate"); 
   
   Class.forName("org.mariadb.jdbc.Driver");
   ResultSet rs1 = null;
   Connection conn = null;
   conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
   
   String sql2 = "delete from diary where diary_date=?";
   PreparedStatement stmt1 = null;
   stmt1 = conn.prepareStatement(sql2);
   stmt1.setString(1,diaryDate);
   
    int row = stmt1.executeUpdate();
   
   	response.sendRedirect("./diary.jsp?checkDate="+diaryDate); 
   
   %>
   