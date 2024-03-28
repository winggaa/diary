<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>


<%
		// 다이어리 폼에서 값 받아오기
	String content = request.getParameter("content");
	String weather = request.getParameter("weather");
	String diaryDate = request.getParameter("diaryDate");
	String title = request.getParameter("title");
	String ck = request.getParameter("ck");

		//디버깅
	System.out.println(content);
	System.out.println(weather);
	System.out.println(diaryDate);
	System.out.println(title);
	System.out.println(ck);
	
	//db 연결
	if(ck.equals("T")){
	String sql1 = "INSERT INTO `diary`.`diary` (`diary_date`, `title`, `weather`, `content`, `update_date`, `create_date`) VALUES (?, ?, ?, ?, NOW(), NOW())";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1, diaryDate);
	stmt1.setString(2, title);
	stmt1.setString(3, weather);
	stmt1.setString(4, content);
	System.out.println(stmt1);
	rs1 = stmt1.executeQuery();
	response.sendRedirect("/diary/diary.jsp?");
	} else {	
	
		response.sendRedirect("/diary/addDiaryForm.jsp??checkDate=");
	}
	
%>