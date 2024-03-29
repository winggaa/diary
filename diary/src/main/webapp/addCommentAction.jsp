<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
   String memo = request.getParameter("memo");
   String diaryDate = request.getParameter("diaryDate");
   System.out.println(diaryDate +"<--diaryDate"); 
   
   Class.forName("org.mariadb.jdbc.Driver");
   ResultSet rs1 = null;
   Connection conn = null;
   conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
   
   String sql1 = "insert into comment(diary_date,memo,update_date,create_date) values(?,?,now(),now()) ";
   PreparedStatement stmt1 = null;
   stmt1 = conn.prepareStatement(sql1);
   stmt1.setString(1,diaryDate);
   stmt1.setString(2,memo);
   
    int row = stmt1.executeUpdate();
   
   	response.sendRedirect("./diaryOne.jsp?diaryDate="+diaryDate); 
   
   %>
   