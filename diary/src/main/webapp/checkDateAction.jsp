<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<% 
	// 인증 분기 코드 == login on
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
	
	// 날짜값 받아오기
	String checkDate = request.getParameter("checkDate");
	System.out.println(checkDate);
	/*
	if(checkDate.equals("null")){
		checkDate = null;
	} */
	
	String sql2 =  "select diary_date diaryDate from diary where diary_date=?";
	//결과가 있으면 안됨 -- 있으면 이미 이날짜에 일기가 있다는 의미 -> 이날짜로는 입력불가능해야함.
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1,checkDate);
	
	System.out.println(stmt2);
	rs2 = stmt2.executeQuery();
	if(rs2.next()){
		// 이날짜 일기 기록 불가능 (이미존재)
		response.sendRedirect("/diary/addDiaryForm.jsp?checkDate="+checkDate+"&ck=F");
	} 
	else {
		// 이날짜 일기 기록가능
		response.sendRedirect("/diary/addDiaryForm.jsp?checkDate="+checkDate+"&ck=T");
	}
%>