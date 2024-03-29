<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
   String commentNo = request.getParameter("commentNo");
   String diaryDate = request.getParameter("diaryDate");
   System.out.println(diaryDate +"<--diaryDate"); 
   
   Class.forName("org.mariadb.jdbc.Driver");
   ResultSet rs1 = null;
   Connection conn = null;
   conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
   
   String sql1 = "delete from comment where comment_key= ? ";
   PreparedStatement stmt1 = null;
   stmt1 = conn.prepareStatement(sql1);
   stmt1.setString(1,commentNo);
   
    int row = stmt1.executeUpdate();
   
   	response.sendRedirect("./diaryOne.jsp?diaryDate="+diaryDate); 
   
   %>
   