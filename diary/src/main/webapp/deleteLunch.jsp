<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
   String checkVoteDate = request.getParameter("checkVoteDate");
   System.out.println(checkVoteDate +"<--checkVoteDate"); 
   
   Class.forName("org.mariadb.jdbc.Driver");
   ResultSet rs1 = null;
   Connection conn = null;
   conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
   
   String sql2 = "delete from lunch where lunch_date=?";
   PreparedStatement stmt1 = null;
   stmt1 = conn.prepareStatement(sql2);
   stmt1.setString(1,checkVoteDate);
   
    int row = stmt1.executeUpdate();
   
   	response.sendRedirect("./lunchOne.jsp?"); 
   
   %>
   